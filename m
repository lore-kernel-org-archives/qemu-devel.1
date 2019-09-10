Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC75208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 06:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC75208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Zzq-0001v3-En
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i7ZmO-0004kE-RL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007h0-ID
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i7ZmL-0007gi-AB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 02:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EC667BDA2;
 Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 907135D6C8;
 Tue, 10 Sep 2019 06:37:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F4FC1165361; Tue, 10 Sep 2019 08:37:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 08:37:08 +0200
Message-Id: <20190910063724.28470-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 10 Sep 2019 06:37:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 00/16] qapi: Schema language cleanups & doc
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
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
* PATCH v1 05: Dropped
* PATCH 01,05,07-11,16: New
* PATCH 03:
  - Commit message typo fixed
  - Assertions tightened
* PATCH 04:
  - Document member name 'u' is reserved
  - Drop an accidental change to section "Enumeration types"
  - Typo fixed
* PATCH 06:
  - Outlaw anything but printable ASCII, not just control characters
* PATCH 15:
  - Adopt more convenient terminology: directive, definition
  - Explanation of grammar notation missed grouping
  - Drop a more text redundant with the grammar
  - Drop more text redundant with section "Naming rules and reserved
    names"
  - Turn "boxed needs data: STRING" into syntax
  - Improve section "Documentation comments" some more
  - Minor phrasing tweaks

Markus Armbruster (16):
  scripts/git.orderfile: Match QAPI schema more precisely
  qapi: Drop check_type()'s redundant parameter @allow_optional
  qapi: Drop support for boxed alternate arguments
  docs/devel/qapi-code-gen: Minor specification fixes
  tests/qapi-schema: Demonstrate bad reporting of funny characters
  qapi: Restrict strings to printable ASCII
  qapi: Drop support for escape sequences other than \\
  qapi: Permit 'boxed' with empty type
  qapi: Permit alternates with just one branch
  qapi: Permit omitting all flat union branches
  qapi: Adjust frontend errors to say enum value, not member
  docs/devel/qapi-code-gen: Reorder sections for readability
  docs/devel/qapi-code-gen: Rewrite compatibility considerations
  docs/devel/qapi-code-gen: Rewrite introduction to schema
  docs/devel/qapi-code-gen: Improve QAPI schema language doc
  qapi: Tweak code to match docs/devel/qapi-code-gen.txt

 docs/devel/qapi-code-gen.txt                  | 1068 ++++++++++-------
 tests/test-qmp-cmds.c                         |    4 +
 scripts/git.orderfile                         |    4 +-
 scripts/qapi/commands.py                      |    4 +-
 scripts/qapi/common.py                        |  144 +--
 scripts/qapi/events.py                        |   10 +-
 tests/Makefile.include                        |    7 +-
 tests/qapi-schema/alternate-empty.err         |    2 +-
 tests/qapi-schema/alternate-empty.json        |    4 +-
 tests/qapi-schema/args-boxed-empty.err        |    1 -
 tests/qapi-schema/args-boxed-empty.json       |    3 -
 tests/qapi-schema/args-invalid.err            |    2 +-
 tests/qapi-schema/doc-missing.err             |    2 +-
 tests/qapi-schema/doc-no-symbol.err           |    2 +-
 tests/qapi-schema/enum-bad-name.err           |    2 +-
 tests/qapi-schema/enum-bad-name.json          |    3 +-
 tests/qapi-schema/enum-clash-member.err       |    2 +-
 .../qapi-schema/enum-dict-member-unknown.err  |    2 +-
 tests/qapi-schema/enum-member-case.err        |    2 +-
 tests/qapi-schema/escape-outside-string.err   |    1 -
 tests/qapi-schema/escape-outside-string.json  |    3 -
 tests/qapi-schema/escape-too-big.err          |    1 -
 tests/qapi-schema/escape-too-big.exit         |    1 -
 tests/qapi-schema/escape-too-big.json         |    3 -
 tests/qapi-schema/escape-too-big.out          |    0
 tests/qapi-schema/escape-too-short.err        |    1 -
 tests/qapi-schema/escape-too-short.exit       |    1 -
 tests/qapi-schema/escape-too-short.json       |    3 -
 tests/qapi-schema/escape-too-short.out        |    0
 tests/qapi-schema/flat-union-empty.err        |    2 +-
 tests/qapi-schema/flat-union-empty.json       |    2 +-
 tests/qapi-schema/ident-with-escape.err       |    1 +
 tests/qapi-schema/ident-with-escape.exit      |    2 +-
 tests/qapi-schema/ident-with-escape.json      |    2 +-
 tests/qapi-schema/ident-with-escape.out       |   16 -
 tests/qapi-schema/pragma-non-dict.err         |    2 +-
 tests/qapi-schema/qapi-schema-test.json       |   13 +-
 tests/qapi-schema/qapi-schema-test.out        |   21 +-
 tests/qapi-schema/string-code-point-127.err   |    1 +
 ...-empty.exit =3D> string-code-point-127.exit} |    0
 tests/qapi-schema/string-code-point-127.json  |    2 +
 ...ed-empty.out =3D> string-code-point-127.out} |    0
 tests/qapi-schema/string-code-point-31.err    |    1 +
 ...-string.exit =3D> string-code-point-31.exit} |    0
 tests/qapi-schema/string-code-point-31.json   |    2 +
 ...de-string.out =3D> string-code-point-31.out} |    0
 tests/qapi-schema/struct-data-invalid.err     |    2 +-
 tests/qapi-schema/unicode-str.err             |    1 -
 tests/qapi-schema/unicode-str.exit            |    1 -
 tests/qapi-schema/unicode-str.json            |    2 -
 tests/qapi-schema/unicode-str.out             |    0
 tests/qapi-schema/union-empty.err             |    2 +-
 tests/qapi-schema/union-empty.json            |    2 +-
 tests/qapi-schema/unknown-escape.json         |    2 +-
 54 files changed, 737 insertions(+), 624 deletions(-)
 delete mode 100644 tests/qapi-schema/args-boxed-empty.err
 delete mode 100644 tests/qapi-schema/args-boxed-empty.json
 delete mode 100644 tests/qapi-schema/escape-outside-string.err
 delete mode 100644 tests/qapi-schema/escape-outside-string.json
 delete mode 100644 tests/qapi-schema/escape-too-big.err
 delete mode 100644 tests/qapi-schema/escape-too-big.exit
 delete mode 100644 tests/qapi-schema/escape-too-big.json
 delete mode 100644 tests/qapi-schema/escape-too-big.out
 delete mode 100644 tests/qapi-schema/escape-too-short.err
 delete mode 100644 tests/qapi-schema/escape-too-short.exit
 delete mode 100644 tests/qapi-schema/escape-too-short.json
 delete mode 100644 tests/qapi-schema/escape-too-short.out
 create mode 100644 tests/qapi-schema/string-code-point-127.err
 rename tests/qapi-schema/{args-boxed-empty.exit =3D> string-code-point-1=
27.exit} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-127.json
 rename tests/qapi-schema/{args-boxed-empty.out =3D> string-code-point-12=
7.out} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-31.err
 rename tests/qapi-schema/{escape-outside-string.exit =3D> string-code-po=
int-31.exit} (100%)
 create mode 100644 tests/qapi-schema/string-code-point-31.json
 rename tests/qapi-schema/{escape-outside-string.out =3D> string-code-poi=
nt-31.out} (100%)
 delete mode 100644 tests/qapi-schema/unicode-str.err
 delete mode 100644 tests/qapi-schema/unicode-str.exit
 delete mode 100644 tests/qapi-schema/unicode-str.json
 delete mode 100644 tests/qapi-schema/unicode-str.out

--=20
2.21.0


