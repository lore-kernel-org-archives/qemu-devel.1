Received: from eggs.gnu.org ([209.51.188.92]:45180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSjc-0007Rx-Pp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkSjb-0000oO-SP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:52 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkSjb-0000lj-Lc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:54:51 -0500
Received: by mail-ot1-x343.google.com with SMTP id s13so14142008otq.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 03:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20181226034254.17842-1-richard.henderson@linaro.org>
	<20190116235009.tl4gcv53e62npecl@function>
	<d79f1118-38ed-16fc-0233-0c41570d6d8c@redhat.com>
	<CAFEAcA9moCfRCHkivgU7Qesi3xeD=8u8+0WScM84f-dcwyYfrw@mail.gmail.com>
	<CAJ+F1CK9Bkw0ULs5j2n9v_py1DRqLFgPGaHXBBvdWBb-eBDcvg@mail.gmail.com>
	<CAJ+F1C+PX8d+py3q=CZAND+TkgatXjAQPNP-NXZkz+NBChmZXQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+PX8d+py3q=CZAND+TkgatXjAQPNP-NXZkz+NBChmZXQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 11:54:38 +0000
Message-ID: <CAFEAcA99Hwg29UETpecKYrvVLM_xPV4wecr1ecgz2pAYmwuFfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>, Richard Henderson <richard.henderson@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 18 Jan 2019 at 11:37, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> The GStreamer solution is also quite readable.
> https://gitlab.freedesktop.org/gstreamer/gstreamer/blob/master/gst/gstuti=
ls.h#L165

It has the disadvantage that you can never legitimately
set GST_HAVE_UNALIGNED_ACCESS (because it is always
undefined-behaviour by the C standard) and the slow-path
versions are slow-and-clunky. Using malloc like the QEMU
approach has the advantage of telling the compiler
what you're doing so it can emit the optimal code on
systems where it works.

thanks
-- PMM
