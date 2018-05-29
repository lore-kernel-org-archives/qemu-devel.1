Received: from eggs.gnu.org ([2001:4830:134:3::10]:44027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj6Q-0005zN-AZ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj6P-00008h-G4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:10 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNj6P-00008E-BW
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:12:09 -0400
Received: by mail-ot0-x244.google.com with SMTP id 77-v6so18059012otd.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:12:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529180813.2647-1-programmingkidx@gmail.com>
References: <20180529180813.2647-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 19:11:48 +0100
Message-ID: <CAFEAcA-E10Fp7MjgFpSoMTWyn5Wf0OTvSLWJC2LKnZJBT+-Gqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: Suppress
 NSFileHandlingPanelOKButton depreciation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 May 2018 at 19:08, John Arbuckle <programmingkidx@gmail.com> wrote:
> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
> would rather you use NSModalResponseOK, which was introduced in OS 10.9.
> Use the recommended new constant name, with a backward compatibility
> define if we're building on an older OSX.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 110b393..c9473f0 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -79,6 +79,13 @@
>  #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
>  #define NSWindowStyleMaskTitled         NSTitledWindowMask
>  #endif
> +/* 10.13 deprecates NSFileHandlingPanelOKButton in favor of
> + * NSModalResponseOK, which was introduced in 10.9. Define
> + * it for older versions.
> + */
> +#if !defined MAC_OS_X_VERSION_10_9 || MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
> +#define NSModalResponseOK NSFileHandlingPanelOKButton
> +#endif

We should just define MAC_OS_X_VERSION_10_9 if it's not
defined, the same way we do for the 10_5/10_6/10_10/10_12
constants. I'll respin my patch.

thanks
-- PMM
