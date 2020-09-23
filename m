Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F64BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A64221F0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnY2DM+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A64221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4gO-0004Sr-HY
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL4fL-0003ZY-QK
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL4fJ-0003Ih-7n
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600867111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5knlosvTuaEdE9yJcpsrQ5bVDt2eTxTmxMtJjB6OVGc=;
 b=XnY2DM+MMaXm/dYwwDTvyJtwfmX64JkmeJ586CeLdlTDZ3XJU9dBZazVD5JQXOj5AlRVS/
 tlQz8hCdK7VT8Cm8Bcmg9DkcdktwX+8e1XfShvW63U8pGyA7aJf5HS+fl314iqOdZWEphf
 Oi0meEmpL8p15zyhjQKojcCN7ZYxuZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-728WDcjcMg2a1eYVGV8Gvg-1; Wed, 23 Sep 2020 09:18:29 -0400
X-MC-Unique: 728WDcjcMg2a1eYVGV8Gvg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057211084C84;
 Wed, 23 Sep 2020 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 128321002C03;
 Wed, 23 Sep 2020 13:18:26 +0000 (UTC)
Date: Wed, 23 Sep 2020 09:18:25 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 04/38] qapi: Prefer explicit relative imports
Message-ID: <20200923131825.GD191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:27PM -0400, John Snow wrote:
> All of the QAPI include statements are changed to be package-aware, as
> explicit relative imports.
>=20
> A quirk of Python packages is that the name of the package exists only
> *outside* of the package. This means that to a module inside of the qapi
> folder, there is inherently no such thing as the "qapi" package. The
> reason these imports work is because the "qapi" package exists in the
> context of the caller -- the execution shim, where sys.path includes a
> directory that has a 'qapi' folder in it.
>=20
> When we write "from qapi import sibling", we are NOT referencing the fold=
er
> 'qapi', but rather "any package named qapi in sys.path". If you should
> so happen to have a 'qapi' package in your path, it will use *that*
> package.
>=20
> When we write "from .sibling import foo", we always reference explicitly
> our sibling module; guaranteeing consistency in *where* we are importing
> these modules from.
>=20
> This can be useful when working with virtual environments and packages
> in development mode. In development mode, a package is installed as a
> series of symlinks that forwards to your same source files. The problem
> arises because code quality checkers will follow "import qapi.x" to the
> "installed" version instead of the sibling file and -- even though they
> are the same file -- they have different module paths, and this causes
> cyclic import problems, false positive type mismatch errors, and more.
>=20
> It can also be useful when dealing with hierarchical packages, e.g. if
> we allow qemu.core.qmp, qemu.qapi.parser, etc.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/commands.py   |  4 ++--
>  scripts/qapi/doc.py        |  2 +-
>  scripts/qapi/events.py     |  8 ++++----
>  scripts/qapi/expr.py       |  4 ++--
>  scripts/qapi/gen.py        |  4 ++--
>  scripts/qapi/introspect.py |  8 ++++----
>  scripts/qapi/main.py       | 16 ++++++++--------
>  scripts/qapi/parser.py     |  4 ++--
>  scripts/qapi/schema.py     |  8 ++++----
>  scripts/qapi/types.py      |  6 +++---
>  scripts/qapi/visit.py      |  6 +++---
>  11 files changed, 35 insertions(+), 35 deletions(-)
>

Relative imports are a source of heated debates, but when properly
used in a self contained module like here, they are very posititive
IMO.

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rSx4ACgkQZX6NM6Xy
CfPVoRAAxzG3qQ1StmdzTajjZRZ3wHhcC1oGjDJdbdVz96DVlqF1tKn2mziVPly5
LnerHWAgABO3G1fTcHFr8jmX5/T4qPyVnSEVRy+39fMd5uRIJFTRQ6JZvHRUDxQC
v7JifAhDC5AyGIJDaj+TbD7NrQV0VaZgBpQ6wZkKDLH4xXJ9q9SOSx3TeWoUiIIm
1pMv+lWmc1Cq3sjvdvRuiqeG9FPGivProqQ+PMJgXlqFbbegqhEM1CjbgVw/OVUw
qNqpzA+D0PjtfIMWdj0cJBtEI5M9ztNtOauTd+eXHvN8WTmAqaSRc+W7g7aHTu9h
PCvnlw/lnx2+Ho3zL0Yr2lot38MDFKsJsGtJD84WRbGjiSwftbM7L/O7UGUUMEoa
RQr/dysnLyF5G3ok6h/tlXWVF5l4dJb8niS8Ox0XZehoDBerdUIchtc1qwWHLs6T
cOemlg2deyvW8HiC8U1Qk1xISIcpc/71qi3rFzBRnobvhRoSR6dt09EsTjZ+Mv9a
RPtI2sXEkJMXt52qIVoqRK4qjeLCgb82JVmdo2fwy/07l+BxVI+6VtyuJbbnQKjg
shQbOEBogND/1jr6yqrTWksantzWX18w8ak6gAZ7GTenkffcvaR+pnQ4SyIO9H5E
0FfmDvhy2K1d3SuFHUq2qN8NfpmXPz5HTgoDlBhVUrRHh+8cFMg=
=gFDO
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--


