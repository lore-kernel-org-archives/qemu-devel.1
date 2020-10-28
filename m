Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB01DC55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3017724764
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOrwQ62+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3017724764
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn9g-0005qN-7D
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXn6Q-0001z1-5G
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXn6M-0005PQ-L1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kxQlW3TheMmjVFdLnfMHYp9/JS+E4zQjjdu0bwN6TU0=;
 b=NOrwQ62+D842d0MBI2pCPS4rft82sACOSFinT9GzVlRHEWcOb4iXFJagk6k3NQsZw0hLM3
 BWbfeHDx+sSxHZ9boDN/vM4pB2+gXNfIipVFGptYAmvYcTUj/DG8M7vD1DArL2u7TbDba9
 ulLovNP9WbSg62OYMybBcxYUOaJRyeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-gy4YbwnYMfWuA1IhhLIOXQ-1; Wed, 28 Oct 2020 11:10:57 -0400
X-MC-Unique: gy4YbwnYMfWuA1IhhLIOXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6227F809DC9;
 Wed, 28 Oct 2020 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C80595B4BA;
 Wed, 28 Oct 2020 15:10:50 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:10:49 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 02/15] python: add qemu package installer
Message-ID: <20201028151049.GC2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-3-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-3-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3siQDZowHQqNOShm"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3siQDZowHQqNOShm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:42PM -0400, John Snow wrote:
> Add setup.cfg and setup.py, necessary for installing a package via
> pip. Add a rst document explaining the basics of what this package is
> for and who to contact for more information. This document will be used
> as the landing page for the package on PyPI.
>=20
> I am not yet using a pyproject.toml style package manifest, because
> using pyproject.toml (and PEP-517) style packages means that pip is not
> able to install in "editable" or "develop" mode, which I consider
> necessary for the development of this package.
>=20
> Use a light-weight setup.py instead.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/PACKAGE.rst | 26 ++++++++++++++++++++++++++
>  python/setup.cfg   | 18 ++++++++++++++++++
>  python/setup.py    | 23 +++++++++++++++++++++++
>  3 files changed, 67 insertions(+)
>  create mode 100644 python/PACKAGE.rst
>  create mode 100755 python/setup.cfg
>  create mode 100755 python/setup.py
>=20
> diff --git a/python/PACKAGE.rst b/python/PACKAGE.rst
> new file mode 100644
> index 0000000000..b82f32f489
> --- /dev/null
> +++ b/python/PACKAGE.rst
> @@ -0,0 +1,26 @@
> +QEMU Python Tooling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This package provides QEMU tooling used by the QEMU project to build,
> +configure, and test QEMU. It is not a fully-fledged SDK and it is subjec=
t
> +to change at any time.
> +
> +Usage
> +-----
> +
> +The ``qemu.qmp`` subpackage provides a library for communicating with
> +QMP servers. The ``qemu.machine`` subpackage offers rudimentary
> +facilities for launching and managing QEMU processes. Refer to each
> +pacakge's documentation

Typo here: s/pacakge/package/

> +(``>>> help(qemu.qmp)``, ``>>> help(qemu.machine)``)
> +for more information.
> +
> +Contributing
> +------------
> +
> +This package is maintained by John Snow <jsnow@redhat.com> as part of
> +the QEMU source tree. Contributions are welcome and follow the `QEMU
> +patch submission process
> +<https://wiki.qemu.org/Contribute/SubmitAPatch>`_. There is a `Gitlab

Git*L*ab.  Given that we're also under a company named with two words,
better given them that :)

> +mirror <https://gitlab.com/jsnow/qemu/-/tree/python>`_, but
> +contributions must be sent to the list for inclusion.

IMO it's not clear if this branch/mirror is your development work, a
staging area, etc.

> diff --git a/python/setup.cfg b/python/setup.cfg
> new file mode 100755
> index 0000000000..12b99a796e
> --- /dev/null
> +++ b/python/setup.cfg
> @@ -0,0 +1,18 @@
> +[metadata]
> +name =3D qemu
> +maintainer =3D QEMU Developer Team
> +maintainer_email =3D qemu-devel@nongnu.org
> +url =3D https://www.qemu.org/
> +download_url =3D https://www.qemu.org/download/
> +description =3D QEMU Python Build, Debug and SDK tooling.
> +long_description =3D file:PACKAGE.rst
> +long_description_content_type =3D text/x-rst
> +classifiers =3D
> +    Development Status :: 3 - Alpha
> +    License :: OSI Approved :: GNU General Public License v2 (GPLv2)
> +    Natural Language :: English
> +    Operating System :: OS Independent
> +

I know the sky is the limit, but I miss the Python version classifier,
at least:

  Programming Language :: Python :: 3 :: Only

And optionally those:

  Programming Language :: Python :: 3.6
  Programming Language :: Python :: 3.7
  Programming Language :: Python :: 3.8
  Programming Language :: Python :: 3.9

Although it may be a good idea to add them along test jobs on those
specific Python versions.

> +[options]
> +python_requires =3D >=3D 3.6
> +packages =3D find_namespace:
> diff --git a/python/setup.py b/python/setup.py
> new file mode 100755
> index 0000000000..e93d0075d1
> --- /dev/null
> +++ b/python/setup.py
> @@ -0,0 +1,23 @@
> +#!/usr/bin/env python3
> +"""
> +QEMU tooling installer script
> +Copyright (c) 2020 John Snow for Red Hat, Inc.
> +"""
> +
> +import setuptools
> +import pkg_resources
> +
> +
> +def main():
> +    """
> +    QEMU tooling installer
> +    """
> +
> +    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadat=
a-1babbe54c108
> +    pkg_resources.require('setuptools>=3D39.2')

Getting back to the "test jobs on those specific Python versions" I
was really anxious that environments with Python 3.6 will fail to
have such a "recent" setuptools version.

CentOS 8 has that specific version, while Ubuntu 18.04 has version
39.0.  Ubuntu 20.04 has a recent enough version though.  Given that
all GitLab CI moved to 20.04, this should be safe.

- Cleber.

> +
> +    setuptools.setup()
> +
> +
> +if __name__ =3D=3D '__main__':
> +    main()
> --=20
> 2.26.2
>=20

--3siQDZowHQqNOShm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+ZifUACgkQZX6NM6Xy
CfOnQxAAmn0UkGvz8oTvPECoChJuIFhgMJR05TBwNzTg//+F77MB2F+eJ5ze0fcq
tD1jC4ckuKe5GIE+5/BCjR+Jl068vmY/PT38anVDdPEv1LEclp8F8dXtjvcV0OI1
uIwvs3CcgZgg1t3rvNLkQIynhy0XPJQPU8xbSgv+oTLx5FKzmIQvdQyDKESQNPk7
CLW6cRg4/dETsehBUT+JJCL/S+lz4OwQFUPiOu1UZZPxhM1td6Lrs4xguCcq3gfm
IqrzoD4Ltlc4DLwE1trCxJhgryGFXJDquhFbM6ffSPt1CQJ21XDNpEPo6pbDQ7XL
Tud2bg2taH8nObIEDzdeKrSgDp0ggbyqNjAkwoqNaSMQUhvTvVeULQ0QvyhRHlNU
mIltk+No2zI6NrXCyebxupwuVLMynLEIhNFKVUpVBS1Pbrsw1bU+5lvwdZEyaCfg
tRuVW8O7q2/YFHIHRfk+bc/dkWYl6wtZ6yC6f2gN5a2rHBXaba6pylbgBuDofRV0
4ucTOLoVdLOZekv8ffnhRZxCWdIoV+O5fR1WxhorIW8Ahkw3P2eOCB7xz8htL6dh
HNTUQ/YueOyMlJwBBOsKgVSx+bCyu8cY4bio6Xsmsv+/GCTihoJQuvcKIlW+qKLK
P+ICFwwz3dlVOZwOYQplUn0DBjz78GJUB+2UxRLuTvpzF75RQ3U=
=Q7D4
-----END PGP SIGNATURE-----

--3siQDZowHQqNOShm--


