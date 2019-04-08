Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F37C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:55:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8270D20880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 08:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8270D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDQ3X-0004cq-Sh
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 04:55:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDQ2q-0004LQ-6H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hDQ2p-0007wu-2I
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:54:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hDQ2o-0007wJ-Nh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 04:54:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09B3A3082B4C;
	Mon,  8 Apr 2019 08:46:57 +0000 (UTC)
Received: from work-vm (ovpn-117-240.ams2.redhat.com [10.36.117.240])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AE9B1091EEB;
	Mon,  8 Apr 2019 08:46:55 +0000 (UTC)
Date: Mon, 8 Apr 2019 09:46:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190408084653.GB2687@work-vm>
References: <20190405184648.17029-1-dgilbert@redhat.com>
	<20190405212501.cdg4u3m7ihldcop4@function>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405212501.cdg4u3m7ihldcop4@function>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 08 Apr 2019 08:46:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408084653.g21IlJQR_yMtHk6O2BXwzO3AMBzCnuWDGbX2Egh1YA4@z>

* Samuel Thibault (samuel.thibault@gnu.org) wrote:
> Hello,
>=20
> Dr. David Alan Gilbert (git), le ven. 05 avril 2019 19:46:48 +0100, a e=
crit:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Gcc 9 needs some convincing that sopreprbuf really is going to fill
> > in iov in the call from soreadbuf, even though the failure case
> > shouldn't happen; so swing the check around initialising the fields.
>=20
> While I can understand that setting iov[0].iov_len may help a compiler,
> I don't see why moving if (len <=3D 0) return 0; down?

The original errors are:
/home/dgilbert/git/qemu/slirp/src/socket.c: In function =E2=80=98soread=E2=
=80=99:
/home/dgilbert/git/qemu/slirp/src/socket.c:188:7: error: =E2=80=98iov.iov=
_base=E2=80=99 may be used uninitialized in this function [-Werror=3Dmayb=
e-uninitialized]
  188 |  nn =3D recv(so->s, iov[0].iov_base, iov[0].iov_len,0);
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/dgilbert/git/qemu/slirp/src/socket.c:188:7: error: =E2=80=98iov.iov=
_len=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe=
-uninitialized]
/home/dgilbert/git/qemu/slirp/src/socket.c:232:5: error: =E2=80=98n=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitial=
ized]
  232 |  if (n =3D=3D 2 && nn =3D=3D iov[0].iov_len) {
      |     ^
/home/dgilbert/git/qemu/slirp/src/socket.c:234:19: error: =E2=80=98*((voi=
d *)&iov+16).iov_len=E2=80=99 may be used uninitialized in this function =
[-Werror=3Dmaybe-uninitialized]

(and a few more along the same idea).
So the problem is actually in soread not sopreprbuf itself.

'soread' has the comment:

        /*
         * No need to check if there's enough room to read.
         * soread wouldn't have been called if there weren't
         */
        sopreprbuf(so, iov, &n);

the compiler doesn't realise that, and is moaning about the case
where the if (len <=3D0) return happens and the following=20
code tries to use iov.

Dave

> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  slirp/src/socket.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/slirp/src/socket.c b/slirp/src/socket.c
> > index 4a3c935e25..4a2222a95f 100644
> > --- a/slirp/src/socket.c
> > +++ b/slirp/src/socket.c
> > @@ -113,12 +113,14 @@ size_t sopreprbuf(struct socket *so, struct iov=
ec *iov, int *np)
> >  	DEBUG_CALL("sopreprbuf");
> >  	DEBUG_ARG("so =3D %p", so);
> > =20
> > -	if (len <=3D 0)
> > -		return 0;
> > -
> >  	iov[0].iov_base =3D sb->sb_wptr;
> > +        iov[0].iov_len =3D 0;
> >          iov[1].iov_base =3D NULL;
> >          iov[1].iov_len =3D 0;
> > +
> > +	if (len <=3D 0)
> > +		return 0;
> > +
> >  	if (sb->sb_wptr < sb->sb_rptr) {
> >  		iov[0].iov_len =3D sb->sb_rptr - sb->sb_wptr;
> >  		/* Should never succeed, but... */
> > --=20
> > 2.21.0
> >=20
>=20
> --=20
> Samuel
>  FYLG> Tiens, vl=C3=A0 une URL qui va bien :
>  FYLG> ftp://127.0.0.1/WaReZ/NiouZeS/WinDoZe/NeWSMoNGeR/SuPeR
>  c'est gentil sauf que l'adresse ne fonctionne pas sa me fais une erreu=
r
>  -+- Furtif in Guide du Neuneu Usenet : <MODE CERVEAU OFF> -+-
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

