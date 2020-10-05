Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0044C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 23:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52B9207F7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 23:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmTPhaNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52B9207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPZZg-0002E9-7J
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPZYZ-0001RX-9F
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 19:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kPZYV-00040Q-RT
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 19:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601939165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xH6Cjd3ozMg8M3huafiliKmVqKDDCmx1PePMrN0UTo8=;
 b=TmTPhaNJWOXlwCIlglpmKGEZlK+gPhzAVUkto63VQxMbv1HJjWMgpQ9Az3LpyIdTeWxOHj
 Ga5U3zSUV0Rq4MRq5v02z+zItSknTCfa5my0xJlQmJHGk9GmtecT7x9YMiXGTiFljdnoE+
 Q2e6sBouziaJOB622jHjb+vyQ7mEnJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-wtVbSDNcPtW5ScyZHa4gWg-1; Mon, 05 Oct 2020 19:06:02 -0400
X-MC-Unique: wtVbSDNcPtW5ScyZHa4gWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B943D801AE3
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 23:06:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1662560E1C;
 Mon,  5 Oct 2020 23:06:00 +0000 (UTC)
Date: Mon, 5 Oct 2020 19:05:59 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 00/36] qapi: static typing conversion, pt1
Message-ID: <20201005230559.GA240186@localhost.localdomain>
References: <20201005195158.2348217-1-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201005195158.2348217-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 03:51:22PM -0400, John Snow wrote:
> Hi, this series adds static type hints to the QAPI module.
> This is part one!
>=20
> Part 1: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt1
> Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt6
>=20
> - Requires Python 3.6+
> - Requires mypy 0.770 or newer (for type analysis only)
> - Requires pylint 2.6.0 or newer (for lint checking only)
>=20
> In general, this series tackles the cleanup of one individual QAPI
> module at a time. Once it passes pylint or mypy checks, those checks are
> enabled for that file.
>=20
> Type hints are added in patches that add *only* type hints and change no
> other behavior. Any necessary changes to behavior to accommodate typing
> are split out into their own tiny patches.
>=20
> Notes:
>=20
> - After patch 07, `isort -c` should pass 100% on this and every
>   future commit.
>

FIY, I went on to replicate/validate your testing, and I ran on
patches 07 an later:

  isort --check-only --settings-path ./scripts/qapi/.isort.cfg --recursive =
./scripts/qapi

With success.

> - After patch 08, `flake8 qapi/` should pass 100% on this and every
>   future commit.
>

Here on patches 08 an later, I've run:

  flake8 ./scripts/qapi

And starting on patch 24 ("qapi/source.py: add type hint annotations")
it complained about:

  /scripts/qapi/source.py:44:31: F821 undefined name 'T'

> - After patch 09, `pylint --rcfile=3Dqapi/pylintrc qapi/` should pass 100=
%
>   on this and every future commit.
>

Here I ran on patches 09 and later:

  pylint --rcfile=3D./scripts/qapi/pylintrc ./scripts/qapi/

And all succeeded.

> - After patch 18, `mypy --config-file=3Dqapi/mypy.ini qapi/` should pass
>   100% on this and every future commit.
>

Here I ran on patches 18 and later:

  mypy --config-file=3D./scripts/qapi/mypy.ini ./scripts/qapi/

And all succeeded.

- Cleber.

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl97ptQACgkQZX6NM6Xy
CfMXOxAAkzIYcfhdKDfPA1E0mo5UUXYCKXPTCWek/yd3x4tri6d70kR+oMsOg0rO
+yIyqPywmL3AELon2h+0c8BwCY0uYcc+oeKxvJllJ4GLPAJiBX/Mra4UqdWqRRxF
68sOf307b4e2ZCWbe4byAnClx5H/UWoZCty1sQJjgq9hkYLSCZoNkfgxoBwPczCH
AEPtN3a7hQx5w8lHlhDJp5DkxScCyj5hUkD9wFVacZcTQbk2pLRbBJxiFV7zIvHl
bbjc/fDDr+jn8E9a5TMSyXZZ1Fhl+9/7Id017wko9o8lNTNrnaQHdbJPMuKsKmYm
TtUsKfgQkUWUaLKdBdL0SiD88u77gWBZBJtFnGpLM0RpwYjCWeSmQOamhdT3vJi9
RRTuzrJLpux2CrcJMdevpHfoUy9fMWYQkY6qS0Gmf013x5NTQaeoSx69RCbMyHGN
DX+GvgzFzd5yJiKZOT7If/r+5HNtJBHuQmv3cuHJtoQqmB87csNwYwevRwadoyLt
QFXoELZMITavc1JOHAvH5Hyy8huCjz7U0rI2fwHBdEDYmoZJiJOn86Yloyh+jwKf
p1vd7lVTtMnyfNM7MxLqnBu7kgxkdzKGIyZsV+FgxQqO23E6lQbWKo1+N+Wlws3v
vw0S6Z/c425K1K3VUtVZ7f7R7ub4jkOWrkF5i25wsPgjjsWjBhU=
=+YBb
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


