Received: from eggs.gnu.org ([209.51.188.92]:43684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJDut-0005vH-OU
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hJDus-0005Kw-Kz
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hJDus-0005E5-CO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:10:10 -0400
Received: by mail-ot1-x343.google.com with SMTP id m10so15500911otp.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 02:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190423222005.246981-1-ek@google.com>
In-Reply-To: <20190423222005.246981-1-ek@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Apr 2019 10:09:56 +0100
Message-ID: <CAFEAcA_C4BQgYmZrzFZ_bwWVWcfcV1NF_PWp1wHsvqB9iPu0kQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Erik Kline <ek@google.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, ek@loon.com

On Tue, 23 Apr 2019 at 23:28, Erik Kline via Qemu-devel
<qemu-devel@nongnu.org> wrote:
>
> Signed-off-by: Erik Kline <ek@google.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1814352
> ---
>  linux-user/ioctls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index ae8951625f..37501f575c 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -178,7 +178,7 @@
>  #endif /* CONFIG_USBFS */
>
>    IOCTL(SIOCATMARK, IOC_R, MK_PTR(TYPE_INT))
> -  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(TYPE_INT))
> +  IOCTL(SIOCGIFNAME, IOC_RW, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
>    IOCTL(SIOCGIFFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>    IOCTL(SIOCSIFFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
>    IOCTL(SIOCGIFADDR, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
> --
> 2.21.0.593.g511ec345e18-goog
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
