Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56E9C31E49
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8427F208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 01:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VdApZ/3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8427F208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46626 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbbN5-0004qA-SB
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 21:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbL1-0003Hp-5X
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hbbKz-0003Pj-QF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:07 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36263 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1hbbKx-0003F3-2z
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 21:49:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Q3Rt3Vlwz9sDB; Fri, 14 Jun 2019 11:48:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560476938;
 bh=pGNly4E5BqUrZ5zyFscDy9L92k//EyEyxp4jPEehBkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VdApZ/3HUrcnnwm8Mh2ypkEuSdU917WKlzdP4j27gTFcW7FQlSkJC9+uqgs80/KIP
 ChLo1UXzqwAmsIQWvsi8Z8RpmUpATsg2zQ5qM4OZuRIllufSSnaq0Xm/dyr4WbIg2o
 a6EcT7xUnOhlFEZUbCWtaC1kPcpuJHuiZbxYT1lk=
Date: Fri, 14 Jun 2019 11:40:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190614014056.GD11158@umbus.fritz.box>
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
 <20190613060728.26955-3-david@gibson.dropbear.id.au>
 <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rqzD5py0kzyFAOWN"
Content-Disposition: inline
In-Reply-To: <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host
 arch correctly
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
Cc: arikalo@wavecomp.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 aurelien@aurel32.net, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rqzD5py0kzyFAOWN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 11:01:19AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 6/13/19 8:07 AM, David Gibson wrote:
> > ppc64 and ppc64le are different archs from the host kernel point of view
> > and are advertised as such in uname.  But these cover the same set of C=
PUs,
> > just in different endianness modes.  qemu-system-ppc64 handles both mod=
es,
> > so make sure we select the correct binary when running on ppc64le host
> > architecture.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  tests/acceptance/avocado_qemu/__init__.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> > index 2b236a1cf0..0ba9c536f4 100644
> > --- a/tests/acceptance/avocado_qemu/__init__.py
> > +++ b/tests/acceptance/avocado_qemu/__init__.py
> > @@ -39,6 +39,8 @@ def pick_default_qemu_bin(arch=3DNone):
> >      """
> >      if arch is None:
> >          arch =3D os.uname()[4]
> > +        if arch =3D=3D 'ppc64le':
> > +            arch =3D 'ppc64'
>=20
> I prefer the generic patch from Cleber:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03418.html
> (I guess remember another version with a json file)

I hadn't seen that, that does indeed look better.

>=20
> >      qemu_bin_relative_path =3D os.path.join("%s-softmmu" % arch,
> >                                            "qemu-system-%s" % arch)
> >      if is_readable_executable_file(qemu_bin_relative_path):
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rqzD5py0kzyFAOWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0C+ygACgkQbDjKyiDZ
s5JOJxAA4PN6GpnyfgDnFo1vjG1LeQZjRESrXMbos8GMw/Ipr6kZDlvoHe402wxz
DjLh8hqWiRFWbOPvv+n5GD0S9DodmzUHuVl4Y0nfLXZPzKIlcdKc+SA3qIhv4KyQ
nA6KnrpSV15N5c1gUSfysiG2UJfi1Tjd6aiayJqTbP53AtsB1G6udGt3oRc54O4J
xFb413y0dPhksQXFa9tKu901qoWIv6gTwHKKVZflGWEJrSjXMJEycHtlZBr2EOeF
KhbPbZtY2bJuwiYP4Ra5ke8OTkoBoAT3ae5vrC9I+ipNnvHAXCd0lRxf4OFNiVcU
MVrFpDOfZxhaBOuUmj7MQTI1+pPQ4DsMKy7JxfLY9F+8IFu3v34S5spPsPp5VOBh
7lKvKmK8zkKVMG3mZBjT4E1mA8+/2IOeESP6zhkdMKKSx7D5n+4mS1ZAmBMdIvWp
OLx7YCMTXZ3IkQ8SznUGxYZfE5bZxjlcTRG6MOnrwjiRu4m+fQQFwth0m+u6o8dv
Hi35II98RB8Aj3umkNpaLrMT/joJKSGjIeHF2fpuYHtoMTDP6wjDvKvmYHelwSA8
BKAOfu7AUv62H0AIJ/Qqlb2Ilq+GsMMpeV/PZP2vT7aZ4kN/FKn24CpbF9JdUgnj
qkWY95ALw8mrKz6eITrge7ZPzAvax6UBmg6n+j7zsaJy0l+KRXo=
=6d3a
-----END PGP SIGNATURE-----

--rqzD5py0kzyFAOWN--

