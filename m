Received: from eggs.gnu.org ([209.51.188.92]:47199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3PEr-0001Sg-89
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1h3PEp-0007ng-Lg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:01:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1h3PEp-0007mA-87
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:01:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id f65so61683wma.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CKBRNdLPb_wOLhURdUJd-j1RHY2toKSTEhCBt_zs4Xk1w@mail.gmail.com>
	<e942cdab-fe1b-fdf4-3b9f-da16a4afa953@kaod.org>
In-Reply-To: <e942cdab-fe1b-fdf4-3b9f-da16a4afa953@kaod.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 11 Mar 2019 19:01:10 +0100
Message-ID: <CAJ+F1C+hFfsa5gcSdttTP5J+uyDvNdYJWrm9OJM26+Zc1ZQkew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, gwshan@linux.vnet.ibm.com
Cc: QEMU <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi C=C3=A9dric, Gavin,

On Mon, Mar 11, 2019 at 4:23 PM C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 2/13/19 12:03 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > As we are trying to move slirp/ in a standalone project, which
> > eventually could be installed as a shared library, we need to clear
> > the license.
> >
> > slirp is supposed to be 3-Clause BSD license (according to
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2f5f89963186d42a7ded2=
53bc6cf5b32abb45cec)
> > but it seems to be effectively a 2-Clause BSD (the third clause is not
> > in COPYRIGHT)
> >
> > However, there are two units that are GPL-2:
> >
> > - dhcpv6.c, dhcpv6.h:
> >   The code was contributed by Thomas Huth <thuth@redhat.com>
> >
> > $ git shortlog -nes slirp/dhcpv6.{c,h}
> >      6  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >      1  Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >      1  Thomas Huth <thuth@redhat.com>
> >      1  Yuval Shaia <yuval.shaia@oracle.com>
> >
> > - ncsi.c, ncsi-pkt.h:
> >   The code was contributed by C=C3=A9dric Le Goater <clg@kaod.org>
> >
> > $ git shortlog -nes slirp/ncsi.c slirp/ncsi-pkt.h
> >      5  Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >      4  C=C3=A9dric Le Goater <clg@kaod.org>
> >
> > Could you reply that you have no objection in relicensing those files
> > are 3-Clause BSD?
>
> Fine for me. You can change the license of slirp/ncsi.c and
> slirp/ncsi-pkt.hto a 3-Clause BSD.

I noticed that ncsi-pkt.h has "Copyright Gavin Shan, IBM Corporation 2016"

I suppose Gavin should also give his agreement to relicense the file.


Gavin, could you reply that you have no objection in relicensing
ncsi-pkt.h as 3-Clause BSD?


Thanks

>
> Thanks,
>
> C.
>
> > After "[Qemu-devel] [PATCH 0/7] slirp: make it a standalone project",
> > the vmstate subset that I adapted would also need to be relicensed.
> > There are more contributors here, I am not sure how it should be
> > handled. Any idea?
> >
> > thanks
> >
>


--=20
Marc-Andr=C3=A9 Lureau
