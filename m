Received: from eggs.gnu.org ([209.51.188.92]:49296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokgA-0006ZM-33
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokg9-0006IB-E7
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokg9-0006Gd-8g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:53:01 -0500
Date: Wed, 30 Jan 2019 08:52:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190130075252.b5l2g5flvg54uw6d@sirius.home.kraxel.org>
References: <20190129150029.29829-1-philmd@redhat.com>
	<20190129150029.29829-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129150029.29829-5-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] configure: Let SDL support be
 optional on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Brad Smith <brad@comstyle.com>

  Hi,

>      sdl)
>      if test "$sdl" = "no"; then
> -        error_exit "sdl not found or disabled, can not use sdl audio driver"
> +        echo "WARNING: SDL not found or disabled, can not use sdl audio driver"
> +        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/sdl *//g')

Not needed any more.

> +if test -z "$audio_drv_list"; then
> +    audio_drv_list="none"
> +fi

That puts "none" into the list of audio drivers.  I don't think we
should do that.  If you want prettify the output in case audio_drv_list
is empty, then just fix the output code.

cheers,
  Gerd
