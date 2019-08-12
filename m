Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6413C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B146920684
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 13:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bBJGZ3/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B146920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxAnl-00006A-W8
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 09:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57918)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmS-0006fp-QZ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hxAmR-00005K-Dg
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 09:54:36 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47087 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hxAmL-0008Qd-C0; Mon, 12 Aug 2019 09:54:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 466cld5WCgz9sPL; Mon, 12 Aug 2019 23:54:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1565618061;
 bh=WgEiA2bYSoYo1c+YVtUVqwKW3af/hSyQnnzpCRq/SrA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bBJGZ3/t7i/EZwLzbf4eb7ls2oRUoKmE+xRciukNM6aDtGvfoSuL0ijgw5h5kZwYi
 HrWkq8g4sEHrnXWxh/wtZ+XRZUz4IXug91xrFQC4fPf9KzcFmKB9L0QIQKiHCCFeSq
 yjLJuX0SRMoHxUZpFLLKIIBAI3A4TfAlEc2/vHD0=
Date: Mon, 12 Aug 2019 20:36:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190812103633.GL3947@umbus.fritz.box>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
 <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
 <20190808064810.GE5465@umbus.fritz.box>
 <4fa2ecbe-d81e-5285-822e-28f984aed77c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
In-Reply-To: <4fa2ecbe-d81e-5285-822e-28f984aed77c@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, jsnow@redhat.com, rth@twiddle.net,
 Damien Hedde <damien.hedde@greensocs.com>, berrange@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2019 at 01:39:46PM +0200, C=E9dric Le Goater wrote:
>=20
> >>> So.. is this change in the device_reset() signature really necessary?
> >>> Even if there are compelling reasons to handle warm reset in the new
> >>> API, that doesn't been you need to change device_reset() itself from
> >>> its established meaning of a cold (i.e. as per power cycle) reset.
> >>> Warm resets are generally called in rather more specific circumstances
> >>> (often under guest software direction) so it seems likely that users
> >>> would want to engage with the new reset API directly.  Or we could
> >>> just create a device_warm_reset() wrapper.  That would also avoid the
> >>> bare boolean parameter, which is not great for readability (you have
> >>> to look up the signature to have any idea what it means).
> >>
> >> I've added device_reset_cold/warm wrapper functions to avoid having to
> >> pass the boolean parameter. it seems I forgot to use them in qdev.c
> >> I suppose, like you said, we could live with
> >> + no function with the boolean parameter
> >> + device_reset doing cold reset
> >> + device_reset_warm (or device_warm_reset) for the warm version
> >=20
> > Ok, good.
> >=20
> > I'm afraid the whole series still makes me pretty uncomfortable,
> > though, since the whole "warm reset" concept still seems way to vague
> > to me.
>=20
> Isn't the reset after the CAS negotiation sequence between the hypervisor
> and the pseries machine some sort of warm reset driven by SW ?

Yes.. and?  The fact that something as messy as CAS can come under the
category of warm reset only re-inforces that what a warm reset is
isn't really well defined.

[That said, in the case of CAS, I'd really like it if we can change
things to avoid the pseudo-reset and just rewrite the dt instead.
The sorta-reboot causes us problems with -no-reboot and with disabling
the SLOF autoboot flag]

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1RQTEACgkQbDjKyiDZ
s5KUyxAAu2TiBsf0j9fE+XbZL0oHDdf3cZwxK+R8IIX+KPxmoWrx3uWJ0eYKKj2y
K2hO9fJQvJPxfs615SuVOy684MkEGldNyItKe/2kVaBS78H17hTFQDKmEVp9uZgx
gO5Z1CcBeVRcPTqUvSBn87ZpaehcmD0ZZDacFus3giMeReQz/nbhH78sAnLmrPdY
Yblmeq/7+kSbMhFtSh7g7tPtoK4OepkNfhVTWogeX9TymuGsS5+NiQZUPPNlCxnC
JtLlhLskFe24JMA5rt8IC/E6KPEvwr6ieR0Hdk4PeGBeI4BfqlZzAwcOrVyuy0x4
C3aQtq6XuVyKLAXdENyb5C+tY7r6Yo/ZwjOpC/byFprsCN/E0qamx1RU6uaadvIz
zTgzYKVpwY7H/hmVQgWUzD2ucJ6tv3umN5/cqc4CFurfEOuKw/3+ypN0hsT9P0ro
QJfv//NsrpbXZ5yqebszEfla9bxVMR8Zk/osMIvtpdx+2XKezRh8C75K82umpwwy
bTd1oibYJ8dsOK644hjb9f7ctWz9CuLa+H1moS40VZa49ny1gW6wW8E1euUCFwdH
n1J+uHkNHT4/ifrLN00kIFV/t7CNHk9HuXjFE5etWnQcAKlQjWpDjwpbxUGI1w5Y
U/m1uRsXBPgA72cGHp1DJvdAaeZ0outw4GjbFE+QM1nd16izQG8=
=56Xh
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--

