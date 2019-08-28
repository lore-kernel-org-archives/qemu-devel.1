Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1985320856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1985320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34Z8-0005NV-Cz
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i34Wk-0003cK-KV
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i34Wi-0002lt-ST
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i34Wi-0002l7-Mx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 32E52793E5;
 Wed, 28 Aug 2019 20:26:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F39BE19D70;
 Wed, 28 Aug 2019 20:26:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6BB141165361; Wed, 28 Aug 2019 22:26:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 22:26:32 +0200
Message-Id: <20190828202641.24752-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 28 Aug 2019 20:26:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/9] qapi: Schema language cleanups & doc
 improvements
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster (9):
  qapi: Drop check_type()'s redundant parameter @allow_optional
  qapi: Drop support for boxed alternate for commands, events
  docs/devel/qapi-code-gen: Minor specification fixes
  qapi: Outlaw control characters in strings
  tests/qapi-schema: Consistently name string tests string-FOO
  docs/devel/qapi-code-gen: Reorder sections for readability
  docs/devel/qapi-code-gen: Rewrite compatibility considerations
  docs/devel/qapi-code-gen: Rewrite introduction to schema
  docs/devel/qapi-code-gen: Improve QAPI schema language doc

 docs/devel/qapi-code-gen.txt                  | 1048 ++++++++++-------
 tests/qapi-schema/qapi-schema-test.json       |    2 +-
 tests/qapi-schema/string-control.json         |    2 +
 ...losed-string.json =3D> string-unclosed.json} |    0
 .../{unicode-str.json =3D> string-unicode.json} |    0
 scripts/qapi/common.py                        |   27 +-
 tests/Makefile.include                        |    5 +-
 tests/qapi-schema/qapi-schema-test.out        |    2 +-
 tests/qapi-schema/string-control.err          |    1 +
 ...closed-string.exit =3D> string-control.exit} |    0
 ...unclosed-string.out =3D> string-control.out} |    0
 tests/qapi-schema/string-unclosed.err         |    1 +
 ...{unicode-str.exit =3D> string-unclosed.exit} |    0
 .../{unicode-str.out =3D> string-unclosed.out}  |    0
 tests/qapi-schema/string-unicode.err          |    1 +
 tests/qapi-schema/string-unicode.exit         |    1 +
 tests/qapi-schema/string-unicode.out          |    0
 tests/qapi-schema/unclosed-string.err         |    1 -
 tests/qapi-schema/unicode-str.err             |    1 -
 19 files changed, 622 insertions(+), 470 deletions(-)
 create mode 100644 tests/qapi-schema/string-control.json
 rename tests/qapi-schema/{unclosed-string.json =3D> string-unclosed.json=
} (100%)
 rename tests/qapi-schema/{unicode-str.json =3D> string-unicode.json} (10=
0%)
 create mode 100644 tests/qapi-schema/string-control.err
 rename tests/qapi-schema/{unclosed-string.exit =3D> string-control.exit}=
 (100%)
 rename tests/qapi-schema/{unclosed-string.out =3D> string-control.out} (=
100%)
 create mode 100644 tests/qapi-schema/string-unclosed.err
 rename tests/qapi-schema/{unicode-str.exit =3D> string-unclosed.exit} (1=
00%)
 rename tests/qapi-schema/{unicode-str.out =3D> string-unclosed.out} (100=
%)
 create mode 100644 tests/qapi-schema/string-unicode.err
 create mode 100644 tests/qapi-schema/string-unicode.exit
 create mode 100644 tests/qapi-schema/string-unicode.out
 delete mode 100644 tests/qapi-schema/unclosed-string.err
 delete mode 100644 tests/qapi-schema/unicode-str.err

--=20
2.21.0


