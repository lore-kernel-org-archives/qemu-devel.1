Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D3C33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9451822522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 04:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EGHRL+T+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9451822522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itkmn-000247-Mb
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 23:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1itklT-0001D1-9e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1itklS-0000Rb-4g
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 23:03:43 -0500
Received: from ozlabs.org ([203.11.71.1]:48593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1itklR-0000Pl-1F; Mon, 20 Jan 2020 23:03:42 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 481vzC6XQCz9sNx; Tue, 21 Jan 2020 15:03:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1579579415;
 bh=21vHYx1m/HdKjVRYxSR1WkV0mkn6qnZQS6xNRKkBQRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EGHRL+T+3Ypnta290HRopgah5XH1NWzzx8rb3xqqz268yVKbdo1WhgauYL2zPfXIv
 /cnlojeRfMRQwF9SmeMq6f6wUTk7SnI6fGVp9z3OamqNTrEq7z/mToraLSmYyVudmn
 /IeRLgiH6Tb5eX/naOmdb6MdxHGToFME7aZjTb24=
Date: Tue, 21 Jan 2020 15:02:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v8 4/6] tpm_spapr: Support suspend and resume
Message-ID: <20200121040213.GD265522@umbus.fritz.box>
References: <20200108161012.1821385-1-stefanb@linux.ibm.com>
 <20200108161012.1821385-5-stefanb@linux.ibm.com>
 <CAJ+F1CJLKnhWW5kz=C5f9EJd=h-_b46ST_qOpwe1zDBjNU76mw@mail.gmail.com>
 <9307b42f-3149-2cea-fbc9-28110ebc481b@linux.ibm.com>
 <CAJ+F1CKbiNZvzdexR6+=0bNTLT4bO0xEsvotRJYoDJ4h+rUYQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKbiNZvzdexR6+=0bNTLT4bO0xEsvotRJYoDJ4h+rUYQA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2020 at 05:46:21PM +0400, Marc-Andr=E9 Lureau wrote:
> On Fri, Jan 17, 2020 at 5:41 PM Stefan Berger <stefanb@linux.ibm.com> wro=
te:
> >
> > On 1/17/20 8:31 AM, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >
> > > On Wed, Jan 8, 2020 at 8:14 PM Stefan Berger <stefanb@linux.ibm.com> =
wrote:
> > >> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > >>
> > >> Extend the tpm_spapr frontend with VM suspend and resume support.
> > >>
> > >> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > >> ---
> > >>   hw/tpm/tpm_spapr.c  | 67 +++++++++++++++++++++++++++++++++++++++++=
+++-
> > >>   hw/tpm/trace-events |  2 ++
> > >>   2 files changed, 68 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> > >> index ab184fbb82..cf5c7851e7 100644
> > >> --- a/hw/tpm/tpm_spapr.c
> > >> +++ b/hw/tpm/tpm_spapr.c
> > >> @@ -76,6 +76,9 @@ typedef struct {
> > >>
> > >>       unsigned char buffer[TPM_SPAPR_BUFFER_MAX];
> > >>
> > >> +    uint32_t numbytes; /* number of bytes in suspend_buffer */
> > >> +    unsigned char *suspend_buffer;
> > > Why do you need a copy suspend_buffer? Why not use and save buffer[] =
directly?
> >
> >
> > This addresses David's comment:
> >
> > "Transferring the whole 4kiB buffer unconditionally when it mostly
> > won't have anything useful in it doesn't seem like a great idea."
> >
> > https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg02601.html
>=20
> Oh ok.. (well really I don't think 4k (usually compressed) will really
> matter much in multi-gigabytes streams ;)

Probably not - though it is in the downtime portion of the stream.

But more to the point you can still make the size / whether you send
conditional on numbytes without having a whole separate buffer for it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4md8UACgkQbDjKyiDZ
s5KLJA//bJmLj0J8EyBFnds0fnk4KO4C1VDRZxkRPf7kCrRriz1NYZoETuhd+ZM2
WODtIyuOTSslris91doi8kWlRosiZO9uCmzB33ji64zvNKHYiiA6rTIHkAK7O3We
B8HOnVYAubp3zebGheW7SDvPWL/g/N6AOG/utMAOoXhLKOjJAoYVs8XrN2Gjd1uM
a45iAL8UStBRt4SCQfRtvsLeYtAZQkk8CeqoHlMKXLh7B4XexPKDG21yhHo+9yvx
JnpctdhQOZOY029zVmOShEZBAgr3QeaF0WFvFyyh5keYs2+H26HXNSuXtBCuBPXB
HcPPq0TfiY66Ba1T5vy7Qvp9Lczh9Oaxw/E1Q01i3FohwTyoFsl79Ov4e83cXU2Z
0p2LPGEqlsyjWFndOy/G3fawDgu9sUDA7jvI3/WjQy0kw2K2WVfKr6EXKHcqehR+
3aXvwS53wgvrGh/JPMf7NXwAKSmtzYbje9rgex6BO/YOCN8zHwHsiMYdfgf/Oz6u
fRzr9uqAUOelp+Jezr9zXci2P/fxBavMz3lq0NPJup9UFQrDE7Mm527prAvZ/xW7
+lJ5xxaIfBSBdGu6yC1/JgIogesEEiGkh4TCKMRY1uhJb8sI0SXMWU1qlsggzpnd
3gMVOQrOZzTVYCUpD/v84fC845XHAUzC0mWW+StAe/KF5YhZHMY=
=ajAu
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--

