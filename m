Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF203C56202
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279AD206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBYGQkGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279AD206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXtqs-00065X-I1
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXtpr-0005V9-Qq
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXtpm-00008n-8f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603923740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqhuxkV8eTk0bg8J3CYz3TrDkcrIkOFQRqx2YfiB49Y=;
 b=HBYGQkGGaF3YcbZI8jCFntyi4kh2Oq599kyFCLmvgJ/ZfqmUEp0kPgKhJCPudEt1wdr1qP
 1PFSBITfKkt5XCcdoLDWhzX0GEnA04t0bJPK5ZkKqEzfwQEcnAK7tNmEG8Scq6xgG9K9mo
 tkHm491oFMMWe4Bjy++wyLwPygbLq5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-PZ-LSx8YPiareAzDNQv2mQ-1; Wed, 28 Oct 2020 18:22:18 -0400
X-MC-Unique: PZ-LSx8YPiareAzDNQv2mQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB3571007464;
 Wed, 28 Oct 2020 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13D2A19D7C;
 Wed, 28 Oct 2020 22:22:11 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:22:10 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 05/15] python: Add pipenv support
Message-ID: <20201028222210.GI2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-6-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-6-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:45PM -0400, John Snow wrote:
> pipenv is a tool used for managing virtual environments with pinned,
> explicit dependencies. It is used for precisely recreating python
> virtual environments.
>=20
> pipenv uses two files to do this:
>=20
> (1) Pipfile, which is similar in purpose and scope to what setup.py
> lists. It specifies the requisite minimum to get a functional
> environment for using this package.
>=20
> (2) Pipfile.lock, which is similar in purpose to `pip freeze >
> requirements.txt`. It specifies a canonical virtual environment used for
> deployment or testing. This ensures that all users have repeatable
> results.
>=20
> The primary benefit of using this tool is to ensure repeatable CI
> results with a known set of packages. Although I endeavor to support as
> many versions as I can, the fluid nature of the Python toolchain often
> means tailoring code for fairly specific versions.
>=20
> Note that pipenv is *not* required to install or use this module; this is
> purely for the sake of repeatable testing by CI or developers.
>=20
> Here, a "blank" pipfile is added with no dependencies, but specifies
> Python 3.6 for the virtual environment.
>=20
> Pipfile will specify our version minimums, while Pipfile.lock specifies
> an exact loudout of packages that were known to operate correctly. This
> latter file provides the real value for easy setup of container images
> and CI environments.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z7w8ACgkQZX6NM6Xy
CfOUEA/8CZoSk4SZjbB92Jgf0QOKdWiaO34yaGBQfZChpYEedltkBjxbheVHQyE2
c789nTdGF1rsWi2/dchETjzTbFzqDb3mpre9PDdIAgm1jWlV/hynvjyzayoHHI/T
PtCHiAuj0GAGnP0cV2kQmOkOp5OuEBTCAuVo0bZ0mP4+SjCUHyrNS5mTUIvhXaHg
k/I8IKZ04dw8zFIXlQxNLVnGrM4c+TQbbtGmkuqTyiUiHUZo1ig6bozBU0I7JjZb
/bKw/9TfKbo3xGm0iNGcNVsVqib0MlTEs3xlbAXTI9Ak3c7uxwHbxEv4IrKHSUJP
Y/SmeX3OM701K8c7UtjvgBS3MP2HoFqu6v4K+gjfiV9hmMzWpu1f4t9KFifXrBnH
1R4yv6LG1Nj676+e9e8PIa+H0XW6vfHNupjGXOCtJrtyPARM+h3ckQsXjb//Y0fj
Hjvo55OWDPhS5FSuvvOohDQNCJA3oKsD3OHGKgcRrenhXxlYLBRXSJUXiqZXCJAS
K57kx80y9vdtEf6oQ45+VzZKOjNq5VbP+OoSpX5U1r/q9TthQcLq0zrNugF0x6Nv
7V3bfeCErAztq1LKsdmB9I6n0j0hNYZJVHxFUnGU0+LwgKzbQF3XbRx8ZM49yJ1u
N83kxAOk+Z91ryoHFQRONhQdW3Wf+5Hk0QCsk5OOAH6Wq0KilMk=
=FrR1
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--


