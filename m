Received: from eggs.gnu.org ([209.51.188.92]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs7yI-0003ol-3a
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gs7yH-0006zL-DU
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:21:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gs7yH-0006yB-6x
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 10:21:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so3751624wmc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 07:21:40 -0800 (PST)
References: <20190208132112.31493-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <726bc5ed-9d62-30b1-1783-7f6c6fb3b75e@redhat.com>
Date: Fri, 8 Feb 2019 16:21:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190208132112.31493-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Make -Waddress-of-packed-member
 warnings be errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/8/19 2:21 PM, Peter Maydell wrote:
> We have now managed to eradicate all the places in the codebase
> that triggered clang's -Waddress-of-packed-member warning. Remove
> the compiler flag that exempted it from our usual -Werror policy.
> This will prevent any new problematic code being added in future.

Yay!

> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configure b/configure
> index fbd0825488c..50ac5d90f2e 100755
> --- a/configure
> +++ b/configure
> @@ -1881,7 +1881,6 @@ gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
>  gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
>  gcc_flags="-Wno-string-plus-int $gcc_flags"
> -gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
>  # Note that we do not add -Werror to gcc_flags here, because that would
>  # enable it for all configure tests. If a configure test failed due
>  # to -Werror this would just silently disable some features,
> 
