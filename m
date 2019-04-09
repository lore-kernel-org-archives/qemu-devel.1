Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3947C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEEC2084C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 08:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEEC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmWS-0004xI-Se
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 04:54:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmUz-00041B-9x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDmUy-0002sa-FI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hDmUw-0002rI-A5; Tue, 09 Apr 2019 04:52:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B663F309E967;
	Tue,  9 Apr 2019 08:52:52 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AE8771A917;
	Tue,  9 Apr 2019 08:52:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 10:52:40 +0200
Message-Id: <20190409085245.31548-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Tue, 09 Apr 2019 08:52:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1 0/5] First batch of
 global_qtest-removement patches for QEMU 4.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
	armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
	John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409085240.V_83FlRgLpUO5rtCVy6yUigqVN9t8tYCizkD0UdNKCA@z>

While global_qtest and its wrapper functions work fine for tests that onl=
y
run one instance of QEMU, using the global_qtest variable in our qtests i=
s
very problematic for tests that use multiple test states (e.g. migration
tests). Thus tests that still use global_qtest make it hard to share code
(either by copy-n-pasting or by calling common functions) with tests that
try to track multiple test states, so we should try to completely get rid
of the global_qtest variable and its wrapper function in the long run.

Here's another set of patches that cleans up the usage of global_qtest
in a couple of tests.

Thomas Huth (5):
  tests/tco: Make test independent of global_qtest
  tests/megasas: Make test independent of global_qtest
  tests/qmp-cmd-test: Use qtest_init() instead of qtest_start()
  tests/test-hmp: Use qtest_init() instead of qtest_start()
  tests/ide-test: Make test independent of global_qtest

 tests/ide-test.c     | 284 ++++++++++++++++++++++++-------------------
 tests/megasas-test.c |   2 +-
 tests/qmp-cmd-test.c |  15 ++-
 tests/tco-test.c     |  63 +++++-----
 tests/test-hmp.c     |  19 +--
 5 files changed, 211 insertions(+), 172 deletions(-)

--=20
2.21.0


