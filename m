Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC1C206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC1C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxtFn-00085l-9U
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 09:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1hxtFB-0007f5-Gf
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:23:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hxtFA-00031e-01
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hxtF9-000316-7C
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 09:23:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4EDFA30ADBA9
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 13:23:10 +0000 (UTC)
Received: from localhost (ovpn-116-118.ams2.redhat.com [10.36.116.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 671631001DE4;
 Wed, 14 Aug 2019 13:23:07 +0000 (UTC)
Date: Wed, 14 Aug 2019 14:23:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190814132306.GF23970@stefanha-x1.localdomain>
References: <20190813133042.11683-1-stefanha@redhat.com>
 <39b21ab6-bf1b-69c1-bbea-fb6f1b637132@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <39b21ab6-bf1b-69c1-bbea-fb6f1b637132@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 14 Aug 2019 13:23:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] usb: reword -usb command-line option and
 mention xHCI
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 07:54:16PM +0200, Thomas Huth wrote:
> On 8/13/19 3:30 PM, Stefan Hajnoczi wrote:
> > The -usb section of the man page is not very clear on what exactly -usb
> > does and fails to mention xHCI as a modern alternative (-device
> > nec-usb-xhci).
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  qemu-options.hx | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 9621e934c0..7d11c016d1 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1436,12 +1436,15 @@ STEXI
> >  ETEXI
> > =20
> >  DEF("usb", 0, QEMU_OPTION_usb,
> > -    "-usb            enable the USB driver (if it is not used by defau=
lt yet)\n",
> > +    "-usb            enable on-board USB host controller (if not enabl=
ed by default)\n",
> >      QEMU_ARCH_ALL)
> >  STEXI
> >  @item -usb
> >  @findex -usb
> > -Enable the USB driver (if it is not used by default yet).
> > +Enable USB emulation on machine types with an on-board USB host contro=
ller (if
> > +not enabled by default).  Note that on-board USB host controllers may =
not
> > +support USB 3.0.  In this case -device nec-usb-xhci can be used instea=
d on
>=20
> Should we maybe rather recommend qemu-xhci instead?

I think nec-usb-xhci is preferred because there are Windows drivers.
IIRC qemu-xhci works under Linux but not under Windows (just because the
PCI Vendor/Device ID aren't covered by any driver).

Gerd: Can you confirm this?

Stefan

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1UCzoACgkQnKSrs4Gr
c8gSGAf+OM4nZ+KCaJhbYb3wuuLIuMeoklRqdFjt/+Qe32qMTSRbqkQ19570Fepr
VfpF5LFEIftUkNDNoxgRBDdBFMYLUKgbSeH7JTLPHp8tivn8+qphilAtHozMIGh7
87e3haaLihMJ+qBinYU4Rrwq4sD/55Winv9voBw4s+EPH8eGyMeIdbc2K/F4o3qV
RhkxAeT4Dy32iff7JEXVnFXymHPYokchgjJfXWd4n1WNMpp4C6bDpj2u6w8F2FT3
gOTJ4coWv9uVNRRRWbNtX6UHqDBAeHxCUif8zO1a4ta9MiwZXQJZXZs61s+dzpMf
d1AH74BXaevnwTPe/AKEmNtkn+7JRQ==
=zG9w
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--

