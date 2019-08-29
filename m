Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A2DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F01422CED
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Z6QfzmCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F01422CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3946-0002AA-7n
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 21:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i391i-0000zy-Mz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:15:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i391h-0000ux-3m
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 21:15:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55759)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i391f-0000u3-Ol; Wed, 28 Aug 2019 21:15:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46Jl5V597nz9sML; Thu, 29 Aug 2019 11:14:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1567041294;
 bh=NkcIJMIORNQSjsG7YZnmxFjgoeQpc21HXdXc0FAg2pw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z6QfzmCLEGIzEpIsOT7shIiPVZB6duFI68+a+vyTueCVuS3FIt9UDsZGn2+T7+fHk
 bhNtMAz8jpUw80TeokI7kbn9E0ge2yKAGUPWNMiGa6dhURpXwq9A/MNNDkIiswXRk1
 HhbLlcUf8IvQO9r3at9xkVhvsg72ctRQtmQ6XK9U=
Date: Thu, 29 Aug 2019 10:00:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190829000022.GD16342@umbus.fritz.box>
References: <20190827065650.107319-1-aik@ozlabs.ru>
 <20190828004634.GB16825@umbus.fritz.box>
 <20190828021237.GD16825@umbus.fritz.box>
 <2ee9df47-1536-f2e3-9892-b4868ec359c2@ozlabs.ru>
 <20190828055740.GG16825@umbus.fritz.box>
 <20190828115014.0364baa1@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline
In-Reply-To: <20190828115014.0364baa1@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [GIT PULL for qemu-pseries] spapr:
 Render full FDT on ibm, client-architecture-support
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 11:50:14AM +0200, Greg Kurz wrote:
> On Wed, 28 Aug 2019 15:57:40 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Aug 28, 2019 at 01:27:35PM +1000, Alexey Kardashevskiy wrote:
> > >=20
> > >=20
> > > On 28/08/2019 12:12, David Gibson wrote:
> > > > On Wed, Aug 28, 2019 at 10:46:34AM +1000, David Gibson wrote:
> > > > > On Tue, Aug 27, 2019 at 04:56:50PM +1000, Alexey Kardashevskiy wr=
ote:
> > > > > > The following changes since commit d6bb8b27204eaa58f1da948b6545=
4e3a598ab2a4:
> > > > > >=20
> > > > > >    pseries: Update SLOF firmware image (2019-08-27 16:47:04 +10=
00)
> > > > > >=20
> > > > > > are available in the Git repository at:
> > > > > >=20
> > > > > >    git@github.com:aik/qemu.git tags/qemu-slof-20190827
> > > > > >=20
> > > > > > for you to fetch changes up to da9960a5aaa25d27c9798c3d94c7b4c2=
d8af31ac:
> > > > > >=20
> > > > > >    spapr: Render full FDT on ibm,client-architecture-support (2=
019-08-27 16:47:46 +1000)
> > > > > >=20
> > > > > > ----------------------------------------------------------------
> > > > > > Alexey Kardashevskiy (1):
> > > > > >        spapr: Render full FDT on ibm,client-architecture-support
> > > > > >=20
> > > > > >   hw/ppc/spapr.c | 90 +++++++----------------------------------=
-----------------
> > > > > >   1 file changed, 10 insertions(+), 80 deletions(-)
> > > > > >=20
> > > > > >=20
> > > > > > *** Note: this is not for master, this is for pseries
> > > > > >=20
> > > > >=20
> > > > > Merged, thanks.
> > > >=20
> > > > Urgh.  And the qemu change is now un-merged.  Alas, as soon as we h=
ad
> > > > a CAS reboot for XIVE the guest didn't boot on the second attempt.
> > > > Haven't had a chance to investigate yet.
> > >=20
> > > QEMU command line, guest kernel version? I'd give it a try.
> >=20
> > RHEL8.1 in guest and host, booting via GRUB into a XIVE capable
> > kernel.
> >=20
> > I've now been able to investigate, dumping the dtb at H_UPDATE_DT
> > time.
>=20
> FWIW I sent a patch to do just that some times ago:
>=20
> https://patchwork.ozlabs.org/patch/1095705/

Yeah, I know.  I didn't like adding yet another option as a permanent
fixture.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl1nFZYACgkQbDjKyiDZ
s5I45RAAxJTlY2bAg/hTIZrFT59xP4DSHL0ixXIhQL/SQgOHQGJ/i5T7QlCoI1rn
qdy88prnH9inoQd2AzJwqseuzsPTFjbFDpTcxPnSctvBMW/x/9+zDUnGRbndqwKG
+4qx7s5tKHcogHlLn+2iv+8DQU2PRnZU5vvkaIskptoOJc6zqgGvopH7hx2QfOEr
AZfPuP38Fuvy4Hb39fldzeeeEGwX0czbUI+xdfui9KSxFCALmU4qD9m6kSVG4kyP
QkDzGR7ipkW4Vf4Ikcb4/QqkXy2AoTgIduOpFZhqgNhSjgY2yYnXh84QRwW7rEIZ
/bOegGp1so/hAM/OVdw4moxFTdUx6mzDsQXX9EdrvPuRDgwtfQA2fd4pm5JcdR5V
KBZTvS3TKCm0aBtj2DJW3cLn+dd+1YMY03yx/Qp8PiBH1P3XOpZO8enUGTm0qaxt
Fsk2yszM1b85/cJV8JRIrUHPgBBnXMP6c+bZEWWxgQGJcCyvibzXjuhEa5yWb1yF
fjfSK5igapA8Gpab1/2R9NknNIySx4zpLRLr8XIQOlqu5ahDtXozTJCUbylFT+QX
GynvReyoLszmsUvIMWzYgL2evQMgcgNXPRHADZo8Ayd+XJ4UwsQ37lbxN/3dETfi
If+oh1mkr54BGtulWvFGCIq29Pd7KG0bW0h3jdhVhOc2RF15tew=
=CCmY
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

