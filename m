Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C090C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0E024724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1/HBOe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0E024724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXtfJ-0003rc-Kp
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXtZO-0002Td-Au
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44026)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXtZL-0006HL-B7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603922721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2eQQYmaunyts0zzxsk8nGRaDD/EXMlUZ0KVursFhNOE=;
 b=I1/HBOe8lPzscI2bA6vTypDwTvchn+vomDfK/jgGXevpnqRxVbh2BsU/PwhHt0S25f66mF
 mErbILuDRvJik/OTxnQGTeqLXNB7CXIzG9iHvhVWrETC/egPx4RLkUNVKDuB7d09NGq5zF
 V8yKjD7fYC0M098GSG2aezy9WeQGPVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-Ap_aeQVhNe2cQAIy4NjAwA-1; Wed, 28 Oct 2020 18:05:17 -0400
X-MC-Unique: Ap_aeQVhNe2cQAIy4NjAwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E27758030DE;
 Wed, 28 Oct 2020 22:05:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 563845D9EF;
 Wed, 28 Oct 2020 22:05:11 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:05:09 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 04/15] python: add directory structure README.rst files
Message-ID: <20201028220509.GH2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
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

--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:44PM -0400, John Snow wrote:
> Add short readmes to python/, python/qemu/, python/qemu/machine, and
> python/qemu/machine that explain the directory hierarchy. These readmes
> are visible when browsing the source on e.g. gitlab/github and are
> designed to help new developers/users quickly make sense of the source
> tree.
>=20
> They are not designed for inclusion in a published manual.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/README.rst              | 27 +++++++++++++++++++++++++++
>  python/qemu/README.rst         |  8 ++++++++
>  python/qemu/machine/README.rst |  9 +++++++++
>  python/qemu/qmp/README.rst     |  9 +++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 python/README.rst
>  create mode 100644 python/qemu/README.rst
>  create mode 100644 python/qemu/machine/README.rst
>  create mode 100644 python/qemu/qmp/README.rst
>=20
> diff --git a/python/README.rst b/python/README.rst
> new file mode 100644
> index 0000000000..ff40e4c931
> --- /dev/null
> +++ b/python/README.rst
> @@ -0,0 +1,27 @@
> +QEMU Python Tooling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This directory houses Python tooling used by the QEMU project to build,
> +configure, and test QEMU. It is organized by namespace (``qemu``), and
> +then by package (``qemu/machine``, ``qemu/qmp``).
> +
> +``setup.py`` is used by ``pip`` to install this tooling to the current
> +environment. You will generally invoke it by doing one of the following:
> +
> +1. ``pip3 install .`` will install these packages to your current
> +   environment. If you are inside a virtual environment, they will
> +   install there. If you are not, it will attempt to install to the
> +   global environment, which is not recommended.
> +
> +2. ``pip3 install --user .`` will install these packages to your user's
> +   local python packages. If you are inside of a virtual environment,
> +   this will fail.
> +
> +If you amend the ``-e`` argument, pip will install in "editable" mode;
> +which installs a version of the package that uses symlinks to these
> +files, such that the package always reflects the latest version in your
> +git tree.
> +

It actually uses *egg-link* files, which are not what people will
understand by "symlinks".

> +See `Installing packages using pip and virtual environments
> +<https://packaging.python.org/guides/installing-using-pip-and-virtual-en=
vironments/>`_
> +for more information.
> diff --git a/python/qemu/README.rst b/python/qemu/README.rst
> new file mode 100644
> index 0000000000..31209c80a5
> --- /dev/null
> +++ b/python/qemu/README.rst
> @@ -0,0 +1,8 @@
> +QEMU Python Namespace
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This directory serves as the root of a `Python PEP 420 implicit
> +namespace package <<https://www.python.org/dev/peps/pep-0420/>`_.
> +
> +Each directory below is assumed to be an installable Python package that
> +is available under the ``qemu.<package>`` namespace.
> diff --git a/python/qemu/machine/README.rst b/python/qemu/machine/README.=
rst
> new file mode 100644
> index 0000000000..73ad23c501
> --- /dev/null
> +++ b/python/qemu/machine/README.rst
> @@ -0,0 +1,9 @@
> +qemu.machine Package
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This package provides core utilities used for testing and debugging
> +QEMU. It is used by the iotests, vm tests, and several other utilities
> +in the ./scripts directory. It is not a fully-fledged SDK and it is
> +subject to change at any time.
> +

I'm not sure if you intend to list all test types that use this, but
the acceptance tests also do use them.

- Cleber.

--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z6xMACgkQZX6NM6Xy
CfPudA/8D/RfPTOD1900XV3miQshFGXzuYeXKFwKw5Rygw5vmH3f78krlx7wx7a9
l1aYGT/32vSeJbrFCEKhQM5QnqM/i7aJEjwDQomV9mCn2IxnRTRXv89fkNHIpl5k
lhdCsZz08bEKOxo3q0Mhvq5v6VsspZDK/02Xl1CJkT3tL/opiz64lQefQsNOA5w1
dkyUiC97dDx6PcPC32eEoUrzVvRt5nf93mP9iVO5rNXzIRcLMufoZvJga3Mf53xI
nSiJuNEGHfWa6pUR5eUInUCRNF2i0Ji4dccYoebsyeV0Yt1dCzsR+T1GHNddnfEq
ApLPW3DldHZ6T2d0YglIjEOIei166/ivWlMPs4sNIpWo8EADX05Lk6m+SNcVceUI
yXJTwowSk6cDwjdJDEA8KvZthwZ/UmRqh+TUUOklJpFfSUWz9B6AbutzkX4/5GKj
KkaNoO8DmuoNoFHNV+ILaK4xAupW5qisJGNVatzR7Adj6A7LICl0Pv0AsE/ebqWD
+EopkvPvlDMyV4TpfR+v833KdZPsg3+fX4/AVFTjASlI0atDyqZtk6oNpvCWzel2
F3juG0/b7o8boOOsJvOxPWiN9k57ar51kjmjZM6h6ckLEhOu5g7DVSy+EhOEmuQQ
gy5i2/DKEyr73W2A3NB6dBzNHY0TD0UnaNZikZhG6NtgI+te4xc=
=dIkL
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--


