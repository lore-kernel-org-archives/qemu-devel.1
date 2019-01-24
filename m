Received: from eggs.gnu.org ([209.51.188.92]:56914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmdQn-0002wZ-Ql
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmdQi-0007oQ-LY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:44:22 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:34608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmdQh-0007jm-4T
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:44:20 -0500
Received: by mail-oi1-x22b.google.com with SMTP id r62so4598618oie.1
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-4-philmd@redhat.com>
In-Reply-To: <20190124011554.25418-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 11:44:05 +0000
Message-ID: <CAFEAcA_TStmpdC0UH+_s5aqheh81_gwNsW07Nw0f0zbEcxXQZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Gerd Hoffmann <kraxel@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>

On Thu, 24 Jan 2019 at 01:16, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> --- a/configure
> +++ b/configure
> @@ -3379,7 +3379,8 @@ for drv in $audio_drv_list; do
>
>      sdl)
>      if test "$sdl" =3D "no"; then
> -        error_exit "sdl not found or disabled, can not use sdl audio dri=
ver"
> +        echo "WARN: sdl not found or disabled, can not use sdl audio dri=
ver"
> +        audio_drv_list=3D$(echo "$audio_drv_list" | sed -e 's/sdl *//g')

"WARNING:" is what configure mostly uses (though sometimes
also "warning:" and in one case "WARN:")...

thanks
-- PMM
