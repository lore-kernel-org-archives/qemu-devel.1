Received: from eggs.gnu.org ([209.51.188.92]:52503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd6k-000490-LG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmd6j-0003tO-VN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmd6j-0003rP-N6
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:23:41 -0500
Date: Thu, 24 Jan 2019 12:23:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124112336.oviomaisnaglg22e@sirius.home.kraxel.org>
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124011554.25418-4-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] configure: Let SDL support be
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
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>

>      sdl)
>      if test "$sdl" = "no"; then
> -        error_exit "sdl not found or disabled, can not use sdl audio driver"
> +        echo "WARN: sdl not found or disabled, can not use sdl audio driver"
> +        audio_drv_list=$(echo "$audio_drv_list" | sed -e 's/sdl *//g')

Busy tackling that in a separate patch series (audio: rework driver
probing)

>      fi
>      ;;
>  
> @@ -3408,6 +3409,9 @@ for drv in $audio_drv_list; do
>      ;;
>      esac
>  done
> +if test -z "$audio_drv_list"; then
> +    audio_drv_list="none"
> +fi

Not needed, "none" is used as fallback even without this.

The other tree patches look fine to me, I'll go queue them up.

cheers,
  Gerd
