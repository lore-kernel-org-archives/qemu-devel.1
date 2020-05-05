Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCDC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C65121841
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjbLpsfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C65121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzJx-0002gd-76
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVzIy-0002Ci-Me
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:16:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVzIx-000108-2y
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588691776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+vjJ5uUlIeycqA6uC1SXakUGZgDBDKS1O7W73EHIxQ=;
 b=EjbLpsfB6xLk01Lkf0pZKdMnU2xWHoX/RDVUEFvWFLGuF92OW3fJIzpF76vIs1sQkrQ62n
 FSewQ9gfHxOq9gi9qbxqVI7Uw+yYrRy94CXVYGkzr3+81r7aha/dJq/DeIXcG1gxkNpuBC
 5nguasiY8XWjG0oh77ifuW05H03uWJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-OJQFx_nJPW23UKs2mFcrqA-1; Tue, 05 May 2020 11:15:58 -0400
X-MC-Unique: OJQFx_nJPW23UKs2mFcrqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C87872FF2;
 Tue,  5 May 2020 15:15:57 +0000 (UTC)
Received: from localhost (ovpn-113-143.ams2.redhat.com [10.36.113.143])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4FAA10021B3;
 Tue,  5 May 2020 15:15:55 +0000 (UTC)
Date: Tue, 5 May 2020 14:55:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Publishing Python Packages
Message-ID: <20200505135507.GB381978@stefanha-x1.localdomain>
References: <209027fc-7287-f21c-ee72-10574e7eed85@redhat.com>
MIME-Version: 1.0
In-Reply-To: <209027fc-7287-f21c-ee72-10574e7eed85@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 04:05:18PM -0400, John Snow wrote:
> Hi!
>=20
> It keeps coming up in review or in bugs that it would be nice to ship
> certain python scripts or modules outside of QEMU for easy consumption
> as dev tooling, light debugging SDKs, or other various tasks. We keep
> avoiding the question as a diversion.
>=20
> Let's investigate this seriously, but let's keep the scope small. Let's
> look at shipping what's in python/qemu/ for starters, as a beta package
> -- to explore the space and see what changes are necessary.
>=20
> Let me start by saying that I have reserved the "qemu" package on
> PyPI.org -- I have done so in good faith in order to have a public
> discussion about the right way to factor this package -- and can
> abdicate my ownership of this package at any point to Peter Maydell,
> Eduardo Habkost, etc.
>=20
> (There is also a conflict resolution process outlined by PEP 541, which
> should ensure that I won't be able to maliciously withhold this package
> space.)
>=20
> Here's the package: https://pypi.org/project/qemu/
>=20
> The only way to 'reserve' a package on pypi is to actually just create
> one, so this is a blank package with nothing in it, versioned as low as
> you can.
>=20
> (This blank release can be deleted later, but we can never re-release a
> v0.0.0a1 package.)
>=20
> I'm working on a patchset to "demo" an installable version of what
> exists in python/qemu/ right now, but a lot of project structure,
> versioning, and layout will have to be debated with a careful list of
> pros/cons.
>=20
> So, for the moment, I am not committing to anything, but am looking
> forward to some discussion on the forthcoming patches.

Great, packaging the QEMUMachine and QMP classes would be a useful first
step. These are probably the packages that most users want. It might
even be useful to add libvirt support to the QMP class so that scripts
can either use QEMU directly or libvirt.

A little bit of cleanup may be required, I haven't checked the state of
the code.

Stefan

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6xcDsACgkQnKSrs4Gr
c8gfJQgAtPFRI6SCf4ZeRRm1xgAacFZfKoZPbPlNHXVPmdisR+/9kA+CeRouhYDn
fYbQT0LD6JTPaJ45WFYKr7KTfFNYndcPz2stqAa4um/g4LYADB2ykrut3j9sIKS0
4zFDK7xjuAdPiy/RnsM6gqwbbgTy3CpwnVE4wy/gi3tf/Ne4zab5cgxvaLkvd3g5
PgoNz/naWOvAmyML2kdV6/tAHu+lOtxHvdVKChVrTzxujiWANnNcMlYIP9960yVF
iT1YreNMiU5Kh1uYl/QbQVkDIAKumjjlY3hfY/Rj4Lv6O87iZX2qOa7AU+KYL0cd
rJuUT6pj8hdM9IZe9DM4QKVV8veg6w==
=Os96
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--


