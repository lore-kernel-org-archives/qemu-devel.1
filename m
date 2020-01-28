Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC533C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 777EB2467E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHdM/UHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777EB2467E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMtk-0005ic-Md
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwMt2-0004sk-5z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwMt0-00080s-Nn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:10:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwMt0-00080A-Ij
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580202618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KMsrPHuQXWl4h5lrHc5XPZoATUBxwU5WESqf0e3NciM=;
 b=NHdM/UHJG/QAu2AKX1yGpx/RY0ju2HJ3PSAiv4nmDJcn8xSTT6wAbvYYa8hafrMqh0KDVk
 uvNEzJ6Rwsna3o9JG+re3Mrm3VF2VOmy4m/BQ9wF/isDBCNnmORB+TX6IG4UsvK+K1YyNk
 mlucEjn43ztazXyEnvtiOLWGQbo7dxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-u4w-AZ5SMjyA6HwykH34Jw-1; Tue, 28 Jan 2020 04:10:10 -0500
X-MC-Unique: u4w-AZ5SMjyA6HwykH34Jw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6164A477;
 Tue, 28 Jan 2020 09:10:09 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E69AD5DA7E;
 Tue, 28 Jan 2020 09:10:08 +0000 (UTC)
Date: Tue, 28 Jan 2020 10:10:07 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Message-ID: <20200128091007.lh5re4neqhhqmr7x@dritchie>
References: <20200107125401.18126-1-n54@gmx.com>
MIME-Version: 1.0
In-Reply-To: <20200107125401.18126-1-n54@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xwy6kgosuuap3tb6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--xwy6kgosuuap3tb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 01:53:57PM +0100, Kamil Rytarowski wrote:
> Hello QEMU Community!
>=20
> Over the past year the NetBSD team has been working hard on a new user-mo=
de API
> for our hypervisor that will be released as part of the upcoming NetBSD 9=
.0.
> This new API adds user-mode capabilities to create and manage virtual mac=
hines,
> configure memory mappings for guest machines, and create and control exec=
ution
> of virtual processors.
>=20
> With this new API we are now able to bring our hypervisor to the QEMU
> community! The following patches implement the NetBSD Virtual Machine Mon=
itor
> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>=20
> When compiling QEMU for x86_64 passing the --enable-nvmm flag will compil=
e the
> accelerator for use. At runtime using the '-accel nvmm' should see a
> significant performance improvement over emulation, much like when using =
'hax'
> on NetBSD.
>=20
> The documentation for this new API is visible at https://man.netbsd.org u=
nder
> the libnvmm(3) and nvmm(4) pages.
>=20
> NVMM was designed and implemented by Maxime Villard.
>=20
> Thank you for your feedback.

Thank you for working on this, it's nice to see that QEMU will gain
HW-assisted acceleration on NetBSD 9.0. A couple things:

 - Are you and/or Maxime willing to step up as maintainers for the
   NVMM support in QEMU?

 - In the next version of the patch series, please use
   "scripts/get_maintainer.pl" to get the list of people you need to
   CC for the patch series.

Thanks,
Sergio.

--xwy6kgosuuap3tb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4v+m4ACgkQ9GknjS8M
AjVYew/9HAHzFMkbpAskhomfLQ1+JHuw4rV4ABi4ESFLWnXtpUl26sBzANWAisDI
CgWhep9ZwDgZ30LE3pHdSdHl4zoi57rcuNgEQyySUIB/aLb6Cx+GT+BruLDBhADi
TYc6abIG2W5LuNJ7xrJoH9TwsiCdT5NLLdvMOOK2EqyThqxJGpLtakEGJrsyZBUt
VJTFnXXdmbd/R4FhN40HSpIdieS4z/qQyYjk2muQTSYsRVxLHur3qFtuENSsKUVG
yjczvl8myhbWBW2n96NoX5BG8pOOdHo0bmHB4pVCtljGMz946gqJMN01GIp1YeWs
Lj8zl+wGhVn4MLTZDwzoOFg6iwRi2PtyGBzWZaCxhUQ7/Ov2VXVheYU14AaloAg2
/EBsbbIL1RoKjGlqd6xBRQmVzAEKX281huzdc5BxoNTFJ5RleWg+YkDRs2EfrbtM
6TDm/hwVfYwYjSaIz0YlAeDEnQ6vIFGmGu2fl85UVuFtj6X1mwvnIeQK9/wVnkQL
Pe92lkNAkOzj87yEGoZfmyRa5djuSp7TXvx9GL+sTCMb2A3C3hDFKqbneBHlE/J2
BNfvrI/jlyRRB+L6W0DGArz8tA53weUxMy1Eb06/B8BPUTHh33qpge1LJBJ62BYb
AFihMDBb52qlG6z057LpqT25xK+jOoNCQvUIaG/PmBK0eIFChnE=
=IPxg
-----END PGP SIGNATURE-----

--xwy6kgosuuap3tb6--


