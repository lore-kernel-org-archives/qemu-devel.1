Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D32C3B194
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4959822314
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 03:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gYZ0C/di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4959822314
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2RaZ-00058l-HW
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 22:24:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j2RZr-0004IS-LU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j2RZq-0008LL-48
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:39 -0500
Received: from ozlabs.org ([203.11.71.1]:57555)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1j2RZp-0008C3-6i
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 22:23:38 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48Jdxw6Ph9z9sRQ; Fri, 14 Feb 2020 14:23:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1581650612;
 bh=mITNkH86hrSsroXCNXhiFNfRMe2x8EH7T4vLWRvEd0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gYZ0C/dicQwVInHKhzm03SZdeBgqGzMrPYiggJmuk0aXflsJ18Eu7pxWdzVqdtSr2
 syAy/wOs7+POMSoytsWyLHBnVMhRz0a2BiJHNqf4AzZjpOl6MpRTBAnn4PV8NDLBui
 HaypQnWxKKjiki51VOTjk2C9X3owRdt++rTGaXz4=
Date: Fri, 14 Feb 2020 13:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: VW ELF loader
Message-ID: <20200214023055.GM124369@umbus.fritz.box>
References: <de7e4d34-eb63-904c-3475-7feee154c72c@ozlabs.ru>
 <8420784f-b4c7-9864-8534-b94dbc5f74ff@redhat.com>
 <20200205055851.GH60221@umbus.fritz.box>
 <73105e0b-c0a0-009f-aeba-fec818d3088c@redhat.com>
 <23090d06-320e-91b5-f73e-c17e065fcad8@ozlabs.ru>
 <dbea9886-04d8-f9fe-f79d-31d8abe76615@redhat.com>
 <274037e5-9bd5-8507-4b4b-067a86225787@ozlabs.ru>
 <9539866e-b3ca-cf29-5a05-164480f89075@ozlabs.ru>
 <2dea0786-5e4b-bda0-5ca8-fdcb3a4f3e50@redhat.com>
 <662013b2-6452-81c1-30c6-d9f0184f9eb0@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <662013b2-6452-81c1-30c6-d9f0184f9eb0@ozlabs.ru>
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
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Cornelia Huck <conny@cornelia-huck.de>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 11:01:26AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 13/02/2020 21:17, Paolo Bonzini wrote:
> > On 13/02/20 02:43, Alexey Kardashevskiy wrote:
> >>
> >> Ok. So, I have made a small firmware which does OF CI, loads GRUB and
> >> instantiates RTAS:
> >> https://github.com/aik/of1275
> >> Quite raw but gives the idea.
> >>
> >> It does not contain drivers and still relies on QEMU to hook an OF path
> >> to a backend. Is this a showstopper and without drivers it is no go? T=
hanks,
> >=20
> > Yes, it's really the drivers.  Something like netboot wouldn't work for
> > example.
> >=20
> > I don't have a problem with relying on QEMU for opening and closing OF
> > paths, but I really believe that read/write on ihandles should be done
> > within the firmware and not QEMU.
>=20
> Moving read/write to the firmware is not a problem but there is a little
> mix up here :)
>=20
> An ihandle is open from a path and nothing there suggests drivers, it is
> up to the ihandle's "read" method what happens next.
>=20
> If we do PCI drivers in the firmware, then the entire ihandle (=3D=3D
> "opened instance of a phandle") business goes to the firmware and we are
> slowly bringing the existing mess back again.

Right, even setting aside the specifics of how ihandles are managed,
having the device tree in qemu but device handling in firmware seems
like an even more complex interaction between qemu and firmware pieces
of the environment, which is what we've been trying to avoid here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5GBl8ACgkQbDjKyiDZ
s5LEpRAAhqfRXcp0FuSD6aTQ/hkc1nAR80rqz/qF5d1E3sUW0gCP5LYtaLg5029D
KwOJyb/veueNs2cro1v2dA7EE08gCmguUpG7G3qMJuTnQFsOM+z4WSz9Fqd3j2z+
aVQMFdEIrStqGdIAQkcNMEBE4sXd+MT8I/+rBncBDgsMXanq0CDHBh2vImhBbh/K
fIvcJ9MqJHc8VO3hh6bWRcxHa/iP+hOX7AvfRy/RliRufnHgw3gIdZNEh9aIMZoY
S2IiwPIvSIr1qqcI3uvQuwdbTM5/0sABGb6Q8kqb7ALZIT/ubobZHnZSdDlHFwg7
oS6knIRwQd/yLPeK27/26gQD6yRIvdxFV65iAk/dthfc//SeCchNS1kjy8fEGTEH
HF41wl2iEFC+D7IpfTMg0d2qosmtuhjJW7MeYwSxwEwzjoXs0STA5Zza0JiT21pN
dYENjTr60QpmxORZRwsm5vnHgj0Uy2qX5s3U+kj22nFAWh0zJXOHZiqz5P8N5L1K
81z5679iQXy6TrUnsYiZl8a6+HrhUfoLxHl1PuLZSFTnzAAoiLEZyBefw+V7LdTP
ZGYxvPnXVhD3uV+O+maqYdI5av+F5nWJAJrLiN3ofEZ1bEPAxeXPI3upVCKRYv+e
2XlNyDVPt/WDpwfHxW2tUijnpMVAcUoBu+N10nOHuOY6Xp/3zVE=
=Sobr
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--

