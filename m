Received: from eggs.gnu.org ([209.51.188.92]:42203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3MwA-0005vg-8k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h3Mm9-0007SI-5P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:23:40 -0400
Received: from 13.mo4.mail-out.ovh.net ([178.33.251.8]:56491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h3Mm6-0007RU-HI
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:23:36 -0400
Received: from player763.ha.ovh.net (unknown [10.109.159.222])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B6F261DDF4C
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 16:23:31 +0100 (CET)
References: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e942cdab-fe1b-fdf4-3b9f-da16a4afa953@kaod.org>
Date: Mon, 11 Mar 2019 16:23:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Clearing slirp/ license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 2/13/19 12:03 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> As we are trying to move slirp/ in a standalone project, which
> eventually could be installed as a shared library, we need to clear
> the license.
>=20
> slirp is supposed to be 3-Clause BSD license (according to
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2f5f89963186d42a7ded2=
53bc6cf5b32abb45cec)
> but it seems to be effectively a 2-Clause BSD (the third clause is not
> in COPYRIGHT)
>=20
> However, there are two units that are GPL-2:
>=20
> - dhcpv6.c, dhcpv6.h:
>   The code was contributed by Thomas Huth <thuth@redhat.com>
>=20
> $ git shortlog -nes slirp/dhcpv6.{c,h}
>      6  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>      1  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>      1  Thomas Huth <thuth@redhat.com>
>      1  Yuval Shaia <yuval.shaia@oracle.com>
>=20
> - ncsi.c, ncsi-pkt.h:
>   The code was contributed by C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> $ git shortlog -nes slirp/ncsi.c slirp/ncsi-pkt.h
>      5  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>      4  C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Could you reply that you have no objection in relicensing those files
> are 3-Clause BSD?

Fine for me. You can change the license of slirp/ncsi.c and=20
slirp/ncsi-pkt.hto a 3-Clause BSD.

Thanks,

C.=20

> After "[Qemu-devel] [PATCH 0/7] slirp: make it a standalone project",
> the vmstate subset that I adapted would also need to be relicensed.
> There are more contributors here, I am not sure how it should be
> handled. Any idea?
>=20
> thanks
>=20
