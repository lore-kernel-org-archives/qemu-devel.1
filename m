Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebRpk-0007Qz-RN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebRpf-0004fW-TU
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:03:24 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:45012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebRpf-0004f3-Ok
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:03:19 -0500
Received: by mail-oi0-x22f.google.com with SMTP id g128so10643917oib.11
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:03:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CK+QmRt6MgWphsY0ydyGTjTZfxPQ7t3bRNDREm5DRn8TQ@mail.gmail.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<CAJ+F1CK+QmRt6MgWphsY0ydyGTjTZfxPQ7t3bRNDREm5DRn8TQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:02:57 +0000
Message-ID: <CAFEAcA-qNNGYZNhunw=avDWzoSt-rAZcfhdgSELrYMAC=wWyNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 13:50, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Interesting, looks like a bug in gcc ubsan that doesn't happen with
> recent versions (related to
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D80550 but probably a
> different bug). Adding a cast is enough:
>
> -#define FIMD_WINCON_BUF2_STAT       ((0 << 21) | (1 << 31))
> +#define FIMD_WINCON_BUF2_STAT       (uint32_t)((0 << 21) | (1 << 31))
>
> It looks like there are no other cases like this

Rather than casting it's probably simpler to use "1U" to get that shift
to be the right type.

thanks
-- PMM
