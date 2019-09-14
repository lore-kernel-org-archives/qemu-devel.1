Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7090720717
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 15:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7090720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9A6n-0006gc-TG
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 11:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i9A55-0004x8-CA
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i9A4x-0004tW-Ex
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i9A4v-0004rN-CT
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 11:35:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F0A933C916;
 Sat, 14 Sep 2019 15:35:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08E7626573;
 Sat, 14 Sep 2019 15:35:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89DD3113865F; Sat, 14 Sep 2019 17:35:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 14 Sep 2019 17:34:47 +0200
Message-Id: <20190914153506.2151-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sat, 14 Sep 2019 15:35:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 00/19] qapi: Frontend fixes and cleanups
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's the next batch of qapi patches, based on my "[PATCH v3 00/16]
qapi: Schema language cleanups & doc improvements".  There's more in
the pipeline.

Based-on: <20190913201349.24332-1-armbru@redhat.com>

Markus Armbruster (19):
  tests/qapi-schema: Cover unknown pragma
  tests/qapi-schema: Delete two redundant tests
  tests/qapi-schema: Demonstrate misleading optional tag error
  tests/qapi-schema: Demonstrate broken discriminator errors
  tests/qapi-schema: Demonstrate insufficient 'if' checking
  tests/qapi-schema: Demonstrate suboptimal lexical errors
  qapi: Use quotes more consistently in frontend error messages
  qapi: Improve reporting of lexical errors
  qapi: Remove null from schema language
  qapi: Fix broken discriminator error messages
  qapi: Reject blank 'if' conditions in addition to empty ones
  qapi: Fix missing 'if' checks in struct, union, alternate 'data'
  qapi: Normalize 'if' in check_exprs(), like other sugar
  qapi: Simplify check_keys()
  qapi: Clean up around check_known_keys()
  qapi: Delete useless check_exprs() code for simple union kind
  qapi: Fix to .check() empty structs just once
  qapi: Fix excessive QAPISchemaEntity.check() recursion
  qapi: Assert .visit() and .check_clash() run only after .check()

 docs/devel/qapi-code-gen.txt                  |   4 +-
 scripts/qapi/common.py                        | 233 +++++++++---------
 tests/Makefile.include                        |   9 +-
 .../alternate-branch-if-invalid.err           |   1 +
 ....exit =3D> alternate-branch-if-invalid.exit} |   0
 .../alternate-branch-if-invalid.json          |   3 +
 ...ta.out =3D> alternate-branch-if-invalid.out} |   0
 tests/qapi-schema/bad-if-list.err             |   2 +-
 tests/qapi-schema/bad-if-list.json            |   2 +-
 tests/qapi-schema/bad-type-int.err            |   2 +-
 tests/qapi-schema/bad-type-int.json           |   2 +-
 tests/qapi-schema/doc-missing-colon.err       |   2 +-
 tests/qapi-schema/double-data.err             |   1 -
 tests/qapi-schema/double-data.json            |   2 -
 tests/qapi-schema/duplicate-key.err           |   2 +-
 tests/qapi-schema/duplicate-key.json          |   2 +-
 tests/qapi-schema/enum-int-member.err         |   2 +-
 tests/qapi-schema/escape-outside-string.err   |   1 +
 tests/qapi-schema/features-if-invalid.err     |   1 +
 ...rmat-err.exit =3D> features-if-invalid.exit} |   0
 tests/qapi-schema/features-if-invalid.json    |   4 +
 ...format-err.out =3D> features-if-invalid.out} |   0
 .../flat-union-discriminator-bad-name.err     |   1 +
 .../flat-union-discriminator-bad-name.exit    |   1 +
 .../flat-union-discriminator-bad-name.json    |  11 +
 .../flat-union-discriminator-bad-name.out     |   0
 .../flat-union-invalid-discriminator.err      |   2 +-
 .../flat-union-invalid-discriminator.json     |   5 +-
 .../flat-union-invalid-if-discriminator.err   |   2 +-
 .../flat-union-invalid-if-discriminator.json  |   5 +-
 .../flat-union-optional-discriminator.err     |   2 +-
 .../flat-union-optional-discriminator.json    |   3 +-
 tests/qapi-schema/funny-char.err              |   2 +-
 tests/qapi-schema/funny-word.err              |   1 +
 tests/qapi-schema/funny-word.exit             |   1 +
 tests/qapi-schema/funny-word.json             |   1 +
 tests/qapi-schema/funny-word.out              |   0
 tests/qapi-schema/include-before-err.err      |   2 +-
 tests/qapi-schema/include-format-err.err      |   1 -
 tests/qapi-schema/include-format-err.json     |   2 -
 tests/qapi-schema/include-nested-err.err      |   2 +-
 tests/qapi-schema/leading-comma-list.err      |   2 +-
 tests/qapi-schema/leading-comma-object.err    |   2 +-
 tests/qapi-schema/missing-colon.err           |   2 +-
 tests/qapi-schema/missing-comma-list.err      |   2 +-
 tests/qapi-schema/missing-comma-object.err    |   2 +-
 tests/qapi-schema/non-objects.err             |   2 +-
 .../pragma-name-case-whitelist-crap.json      |   2 +-
 tests/qapi-schema/pragma-unknown.err          |   1 +
 tests/qapi-schema/pragma-unknown.exit         |   1 +
 tests/qapi-schema/pragma-unknown.json         |   1 +
 tests/qapi-schema/pragma-unknown.out          |   0
 tests/qapi-schema/quoted-structural-chars.err |   2 +-
 .../qapi-schema/struct-member-if-invalid.err  |   1 +
 .../qapi-schema/struct-member-if-invalid.exit |   1 +
 .../qapi-schema/struct-member-if-invalid.json |   3 +
 .../qapi-schema/struct-member-if-invalid.out  |   0
 tests/qapi-schema/trailing-comma-list.err     |   2 +-
 tests/qapi-schema/unclosed-list.err           |   2 +-
 tests/qapi-schema/unclosed-object.err         |   2 +-
 tests/qapi-schema/union-base-empty.err        |   2 +-
 tests/qapi-schema/union-branch-if-invalid.err |   1 +
 .../qapi-schema/union-branch-if-invalid.exit  |   1 +
 .../qapi-schema/union-branch-if-invalid.json  |   6 +
 tests/qapi-schema/union-branch-if-invalid.out |   0
 65 files changed, 202 insertions(+), 157 deletions(-)
 create mode 100644 tests/qapi-schema/alternate-branch-if-invalid.err
 rename tests/qapi-schema/{double-data.exit =3D> alternate-branch-if-inva=
lid.exit} (100%)
 create mode 100644 tests/qapi-schema/alternate-branch-if-invalid.json
 rename tests/qapi-schema/{double-data.out =3D> alternate-branch-if-inval=
id.out} (100%)
 delete mode 100644 tests/qapi-schema/double-data.err
 delete mode 100644 tests/qapi-schema/double-data.json
 create mode 100644 tests/qapi-schema/escape-outside-string.err
 create mode 100644 tests/qapi-schema/features-if-invalid.err
 rename tests/qapi-schema/{include-format-err.exit =3D> features-if-inval=
id.exit} (100%)
 create mode 100644 tests/qapi-schema/features-if-invalid.json
 rename tests/qapi-schema/{include-format-err.out =3D> features-if-invali=
d.out} (100%)
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.e=
rr
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.e=
xit
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.j=
son
 create mode 100644 tests/qapi-schema/flat-union-discriminator-bad-name.o=
ut
 create mode 100644 tests/qapi-schema/funny-word.err
 create mode 100644 tests/qapi-schema/funny-word.exit
 create mode 100644 tests/qapi-schema/funny-word.json
 create mode 100644 tests/qapi-schema/funny-word.out
 delete mode 100644 tests/qapi-schema/include-format-err.err
 delete mode 100644 tests/qapi-schema/include-format-err.json
 create mode 100644 tests/qapi-schema/pragma-unknown.err
 create mode 100644 tests/qapi-schema/pragma-unknown.exit
 create mode 100644 tests/qapi-schema/pragma-unknown.json
 create mode 100644 tests/qapi-schema/pragma-unknown.out
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.err
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.exit
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.json
 create mode 100644 tests/qapi-schema/struct-member-if-invalid.out
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.err
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.exit
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.json
 create mode 100644 tests/qapi-schema/union-branch-if-invalid.out

--=20
2.21.0


