Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FDFC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCB92084D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONxYPAxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCB92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriTj-0003yb-2z
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iriRy-0002NP-6S
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iriRx-0003pr-3l
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48301
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iriRw-0003pP-W9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579093868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJJvs7HeTuvZKSsSq+jzYgZAAXsEEe3tM6wVhZy250w=;
 b=ONxYPAxjGqDUjfSg2IGPAw7YZy8N8wQtMeruGF4M48O1Oz0JcSRNjoQ9RIFxi0dnKUObZo
 EvUvg/V3bjZ+lcOf6FxFiaG41RM83CJ6uPuCxL10CG/8NAp0Ta1YkKgOWWHIqlmT/jQbnn
 SH4tP7uvohCegW7pQx8yLgN+uvChLdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-jytadgYBPIyxIzOymo45CQ-1; Wed, 15 Jan 2020 08:11:05 -0500
X-MC-Unique: jytadgYBPIyxIzOymo45CQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBBBF800D41;
 Wed, 15 Jan 2020 13:11:03 +0000 (UTC)
Received: from localhost (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813E686CB7;
 Wed, 15 Jan 2020 13:11:03 +0000 (UTC)
Date: Wed, 15 Jan 2020 13:11:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 0/4] qmp: Optionally run handlers in coroutines
Message-ID: <20200115131102.GF163546@stefanha-x1.localdomain>
References: <20200114182735.5553-1-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200114182735.5553-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 07:27:31PM +0100, Kevin Wolf wrote:
> Some QMP command handlers can block the main loop for a relatively long
> time, for example because they perform some I/O. This is quite nasty.
> Allowing such handlers to run in a coroutine where they can yield (and
> therefore release the BQL) while waiting for an event such as I/O
> completion solves the problem.
>=20
> This series adds the infrastructure to allow this and switches
> block_resize to run in a coroutine as a first example.
>=20
> This is an alternative solution to Marc-Andr=E9's "monitor: add
> asynchronous command type" series.
>=20
> v2:
> - Fix typo in a commit message [Eric]
> - Use hyphen instead of underscore for the test command [Eric]
> - Mark qmp_block_resize() as coroutine_fn [Stefan]
>=20
>=20
> Kevin Wolf (4):
>   qapi: Add a 'coroutine' flag for commands
>   vl: Initialise main loop earlier
>   qmp: Move dispatcher to a coroutine
>   block: Mark 'block_resize' as coroutine
>=20
>  qapi/block-core.json                    |  3 +-
>  tests/qapi-schema/qapi-schema-test.json |  1 +
>  docs/devel/qapi-code-gen.txt            |  4 ++
>  include/qapi/qmp/dispatch.h             |  3 +
>  monitor/monitor-internal.h              |  5 +-
>  blockdev.c                              |  6 +-
>  monitor/monitor.c                       | 24 ++++---
>  monitor/qmp.c                           | 83 ++++++++++++++++---------
>  qapi/qmp-dispatch.c                     | 38 ++++++++++-
>  tests/test-qmp-cmds.c                   |  4 ++
>  vl.c                                    | 10 +--
>  scripts/qapi/commands.py                | 17 +++--
>  scripts/qapi/doc.py                     |  2 +-
>  scripts/qapi/expr.py                    |  4 +-
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  |  9 ++-
>  tests/qapi-schema/qapi-schema-test.out  |  2 +
>  tests/qapi-schema/test-qapi.py          |  7 ++-
>  18 files changed, 158 insertions(+), 66 deletions(-)
>=20
> --=20
> 2.20.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4fD2YACgkQnKSrs4Gr
c8iNvgf/bY69FFuq4vUZhsyugPkrQetFxo4y4cJ5jYFeJSEzdvzLc3knbmX0tM7o
8ow4Q9NhA87yIUsOO725yK7OqhSXVb4ZYzfMg/3Aqn6H2aGpls7xxXLaT/TQORl5
pMYxqHt5998SO2b4WQwjDQqtQUjK8dbwQUAGHIhA2M6XDTEyJzDbuIppq7S5gspB
35P+t7JlJmSpDg6SMgIHRl9O0aCxyANnB6WMx38Mr1L0Iiysu557TOmBIMpuH/05
usjf+mOZr0P4oV1c194gvxpymC78gYYNlj2q9kY8Ed3V7BGtkoRuDMmVFxTyR0eL
gFPlfCD14hbq/uDIivlGzMc4hU3WSw==
=Q+IL
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--


