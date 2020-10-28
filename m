Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD3C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6014D21D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Av8vzV7z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6014D21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrUz-0006wK-Ap
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXrTn-0005U1-Eo
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXrTj-00041K-6h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 15:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603914685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k/92f4AT9yx2rbyRXfdaw8sh3TZzzcXnpLJs1izq5Wg=;
 b=Av8vzV7zL8+f6dZDXtD5I/ycvVLoALP8qiCsPGQI0nKsGcylFsZ/bJBYG2FKdLxLHNuZuR
 uPSUgi9Zs4nFXiCAEDHlG+JsezjSvl/kd0gSwyRQRe/ZDbSsCuHHCKQ2U0St2Ndl+nSUi0
 tIoeuedpYZeer1VMlTXMn/J0Z3tPP7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-tW3I0_SbPkKTseq7oFvxTA-1; Wed, 28 Oct 2020 15:51:21 -0400
X-MC-Unique: tW3I0_SbPkKTseq7oFvxTA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21AC880B713;
 Wed, 28 Oct 2020 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73837100238E;
 Wed, 28 Oct 2020 19:51:15 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:51:13 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 03/15] python: add VERSION file
Message-ID: <20201028195113.GG2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-4-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-4-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
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

--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:43PM -0400, John Snow wrote:
> Python infrastructure as it exists today is not capable reliably of
> single-sourcing a package version from a parent directory. The authors
> of pip are working to correct this, but as of today this is not possible
> to my knowledge.
>=20
> The problem is that when using pip to build and install a python
> package, it copies files over to a temporary directory and performs its
> build there. This loses access to any information in the parent
> directory, including git itself.
>=20
> Further, Python versions have a standard (PEP 440) that may or may not
> follow QEMU's versioning. In general, it does; but naturally QEMU does
> not follow PEP 440. To avoid any automatically-generated conflict, a
> manual version file is preferred.
>=20
>=20
> I am proposing:
>=20
> - Python tooling follows the QEMU version, indirectly, but with a major
>   version of 0 to indicate that the API is not expected to be
>   stable. This would mean version 0.5.2.0, 0.5.1.1, 0.5.3.0, etc.
>=20
> - In the event that a Python package needs to be updated independently
>   of the QEMU version, a pre-release alpha version should be preferred,
>   but *only* after inclusion to the qemu development or stable branches.
>=20
>   e.g. 0.5.2.0a1, 0.5.2.0a2, and so on should be preferred prior to
>   5.2.0's release.
>=20
> - The Python core tooling makes absolutely no version compatibility
>   checks or constraints. It *may* work with releases of QEMU from the
>   past or future, but it is not required to.
>=20
>   i.e., "qemu.machine" will always remain in lock-step with QEMU.
>=20
> - We reserve the right to split the qemu package into independently
>   versioned subpackages at a later date. This might allow for us to
>   begin versioning QMP independently from QEMU at a later date, if
>   we so choose.
>=20
>=20
> Implement this versioning scheme by adding a VERSION file and setting it
> to 0.5.2.0a1.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

I'd rather have the version to be sync'd with QEMU, but, I understand
this is a more conservative approach that can maybe evolve into that.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Zy7EACgkQZX6NM6Xy
CfOmpA/8D0rOmnJB1gYecSJ5sRzOf3PSgJlHs2jySOatRyO6Y3GS8m4iYL2iJzfm
GNhEVjB/A6q6eJrb5PpY++xoyF90goZ5uaAlRf9WJ1ANbYmQtNAcZOoK3VSbW6+i
ve1d3Xo7d3Lhb6a5l9O25cjA7A/MbJ/t8Froqm1+GrZN2r5Tc8C5MgFevmkpivj8
bsUUQ/Jc/RAnqdKcUn/1XF5gr81kSWLDg+oTf+lCfJ9TeFB4GjmjYuPCCmxfWf2T
8eiAal1c0R3IiE7spf1UTICA0YpO66nWo+KPHt+u77DaT10IQwbCi+830Ws1bsBy
Gkre+xvmOAyAgRFMsOtEoXy1dbdAQiwIJ3syGKFKpK1SK3N88f8Vlrr1H3MKyFma
7seUfR94lftHypg8A+2B80wrYLwIrOpv5uL+oAyQ2mC7fIS/qUuk9AxH8hF8Ix6q
YFSrhxzvAFkb89AySLlRq4S9he8ib/R2y8Hp+AsjhPJtioFADpgT01zHO6vo4lVL
0WLlMg01ka8YfVufILCYP6yrZiLa9RcRf1a6NU5vAm9Q9Nr7OUutMLJQpUIoYIc7
XSkUiEmR1kb2zuyx1hMnBwPrenEbIVlQ0C7392ZkxzP95K6Ecd+LCbEKW/UJoLtr
pE2zABe+v/GZxwIn9J3lg/DvXI5GdYfTnAj6+6JEQohU0UoIbU8=
=gU0I
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--


