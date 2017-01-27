Received: from eggs.gnu.org ([2001:4830:134:3::10]:50230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9jp-0000Yj-0Y
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX9jo-0006Sr-6n
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:01 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:34409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX9jo-0006Sg-2s
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 11:51:00 -0500
Received: by mail-ua0-x232.google.com with SMTP id 35so209149697uak.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 08:50:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485534415-20887-1-git-send-email-mst@redhat.com>
References: <1485534415-20887-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 16:50:38 +0000
Message-ID: <CAFEAcA8nM2LEz+MVv2sDkzOMW4k459CQFyxN=wiPc=at0XfUgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/3] arm: better stub version for
 MISMATCH_CHECK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 27 January 2017 at 16:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> stub version of MISMATCH_CHECK is empty so it's easy to misuse for
> people not building kvm on arm.  Use QEMU_BUILD_BUG_ON similar to the
> non-stub version to make it easier to catch bugs.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  target/arm/kvm-consts.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
> index a2c9518..06b6c92 100644
> --- a/target/arm/kvm-consts.h
> +++ b/target/arm/kvm-consts.h
> @@ -21,7 +21,9 @@
>  #define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(X != Y)
>
>  #else
> -#define MISMATCH_CHECK(X, Y)
> +
> +#define MISMATCH_CHECK(X, Y) QEMU_BUILD_BUG_ON(0)
> +
>  #endif
>
>  #define CP_REG_SIZE_SHIFT 52

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
