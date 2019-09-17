Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3D7C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57FB21852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57FB21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9gU-0003Jv-J4
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iA9ej-0001Sf-21
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iA9eh-0004S5-9e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iA9ec-0004Nl-Po; Tue, 17 Sep 2019 05:20:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C7E43082B1F;
 Tue, 17 Sep 2019 09:20:09 +0000 (UTC)
Received: from localhost (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A6019C70;
 Tue, 17 Sep 2019 09:20:06 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 11:19:57 +0200
Message-Id: <20190917092004.999-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 17 Sep 2019 09:20:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 0/7] iotests: Selfish patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Again, let me start with a link to an actually explanatory cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg01102.html

v3:
https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00950.html

v4:
- I merged the old patch 1 in the meantime

- Patch 2: Adjusted the comment to make it more clear that it is
           case_notrun() itself that will not skip the test case, as
           requested by Andrey (I hope it fits what he had in mind, more
           or less); kept the R-bs, because I somehow feel like that=E2=80=
=99s
           the right thing to do here.

- Patch 3: The func_wrapper returned by the skip_test_decorator has a
           mandatory argument; make that and its required type explicit
           (with an annotation), as suggested by John
           (Kevin made me aware of the fact that annotations exist since
           Python 3.0, it=E2=80=99s just that they didn=E2=80=99t mean an=
ything back
           then (neither do they really now, but whatever, it=E2=80=99s b=
etter
           than a comment))

- Patch 4: Resolved a conflict because of the change to patch 3


git-backport-diff against v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively

001/7:[----] [--] 'iotests: Prefer null-co over null-aio'
002/7:[0007] [FC] 'iotests: Allow skipping test cases'
003/7:[0008] [FC] 'iotests: Use case_skip() in skip_if_unsupported()'
004/7:[0002] [FC] 'iotests: Let skip_if_unsupported() accept a method'
005/7:[----] [--] 'iotests: Test driver whitelisting in 093'
006/7:[----] [--] 'iotests: Test driver whitelisting in 136'
007/7:[----] [--] 'iotests: Cache supported_formats()'


Max Reitz (7):
  iotests: Prefer null-co over null-aio
  iotests: Allow skipping test cases
  iotests: Use case_skip() in skip_if_unsupported()
  iotests: Let skip_if_unsupported accept a function
  iotests: Test driver whitelisting in 093
  iotests: Test driver whitelisting in 136
  iotests: Cache supported_formats()

 tests/qemu-iotests/093        | 19 ++++++++-----
 tests/qemu-iotests/136        | 14 +++++++---
 tests/qemu-iotests/245        |  2 +-
 tests/qemu-iotests/iotests.py | 52 +++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 24 deletions(-)

--=20
2.21.0


