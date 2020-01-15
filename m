Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FF7C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4431222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h88ojm9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4431222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irgaO-0005ef-TM
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irgZf-0005E1-B8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:11:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irgZb-0001R7-5o
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:10:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irgZb-0001QY-1v
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579086653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vZEFcVkpE6zNPF15RcPk6i1UUIW+4YrDQbh5A5oXRGQ=;
 b=h88ojm9ieWQ/XEES/krlyGROEmVmXgnIwsKvQlX+sHL3zXSnJLvQBWndfrAfipJ9/eaj3o
 Vlp2ZX2vYdvSTkj3gHIBnrAbIVvU/YiCk1t8MEpg0IxvvrG59DwHSCOEOKVDWuS2Lbe1Fb
 ynI1bta94uHiSYf4iXODDgxLJ8ZnoSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-fHUbvdkwNbOx31uzxjNMJA-1; Wed, 15 Jan 2020 06:10:45 -0500
X-MC-Unique: fHUbvdkwNbOx31uzxjNMJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47382107ACFC;
 Wed, 15 Jan 2020 11:10:44 +0000 (UTC)
Received: from localhost (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A042360BE2;
 Wed, 15 Jan 2020 11:10:43 +0000 (UTC)
Date: Wed, 15 Jan 2020 11:10:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
Message-ID: <20200115111042.GA163546@stefanha-x1.localdomain>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 12:11:34PM +0100, Thomas Huth wrote:
> On 13/01/2020 11.35, Alex Benn=E9e wrote:
> > ..and extemporise a little about their state.
> >=20
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > ---
> >  documentation.md | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/documentation.md b/documentation.md
> > index f4ef9f4..55d5db6 100644
> > --- a/documentation.md
> > +++ b/documentation.md
> > @@ -3,9 +3,12 @@ title: QEMU documentation
> >  permalink: /documentation/
> >  ---
> > =20
> > -The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be =
read online, courtesy of Stefan Weil.
> > -More documentation is found in the <a href=3D"https://git.qemu.org/?p=
=3Dqemu.git;a=3Dtree;f=3Ddocs;hb=3Dmaster">`docs`</a>
> > -directory of the QEMU git tree.
> > +The [QEMU user manual](https://qemu.weilnetz.de/qemu-doc.html) can be
> > +read online, courtesy of Stefan Weil. There is a partial set of
> > +[developer documentation](https://qemu.readthedocs.io/en/latest/)
> > +which is generated from the QEMU git tree. The process of converting
> > +the rest of the [`docs`](https://git.qemu.org/?p=3Dqemu.git;a=3Dtree;f=
=3Ddocs;hb=3Dmaster)
> > +directory is ongoing.
>=20
> This has a conflict with Stefan's patch to point to our documentation on
> www.qemu.org now instead:
>=20
>  https://patchwork.kernel.org/patch/11234545/
>=20
> ... Stefan, looks like the index.html page is still not there yet,
> although your other patch that includes index.html.in in the sources is
> in the repository now? What's the status here?

The qemu.git/master docs are built nightly here (index.html is now
visible!):
https://www.qemu.org/docs/master/

qemu.org's docs are more useful at the moment since they include the
user documentation in addition to the developer documentation.

It's good that we got ownership of the readthedocs.org account for QEMU.
I don't know if rtd will be capable of building QEMU's hodgepodge of
different documentation systems.  It supports Sphinx and Mkdocs but
that's not enough.

Can we redirect readthedocs to qemu.org?

Stefan

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4e8zIACgkQnKSrs4Gr
c8hvXQf+LDEpEODbEAxEyFAtQpmM64mNWucz1cVKCM4a9Y2tLWOea2Jp5iESWAPf
sO+kXN7hsroqbdxkKs+dcB3xYsZInWxg+tqBMF721HnTqoSfXReIvm5J3TIXcicF
AyGHfINsB3T7Di7BPeUrxvRPlOtTxOL2gnLkvzN8HgmXocdJqi+Ldfp4e5+U/Iui
H9120ySh1/rL65K7HddeJykjCI7LQrqNUw0iCGprIAD0LXacf4UcN7zDBozZvuKP
/YhkBJX5p0C3IVicoygbRdeqOfs0AAWQ31iehUX875GZW2IlHnfsfKDdTTFQkuUc
CpkrvehZWnaEF3WSBLGaQ2nhRIj43g==
=SM5O
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


