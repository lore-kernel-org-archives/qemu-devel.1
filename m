Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F82C43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DB02067D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DB02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKmAr-0000eX-8L
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 11:57:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm94-0007h6-NE
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hKm93-0004rW-6d
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 11:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hKm8x-0004ml-NR; Sun, 28 Apr 2019 11:55:09 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32E5759447;
	Sun, 28 Apr 2019 15:55:04 +0000 (UTC)
Received: from thuth.com (ovpn-116-50.ams2.redhat.com [10.36.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5976728988;
	Sun, 28 Apr 2019 15:54:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 17:54:43 +0200
Message-Id: <20190428155451.15653-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Sun, 28 Apr 2019 15:55:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/8] tests/qemu-iotests: Run basic iotests
 during "make check"
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428155443.CzUvooTYcvzVVQHEAh3Xu0QRft_6OX7tAhfOmBeakFc@z>

People often forget to run the iotests before submitting patches or
pull requests - this is likely due to the fact that we do not run the
tests during our mandatory "make check" tests yet.
This patch series now changes the "auto" group to only include tests
that should be safe to run in all CI environments (including FreeBSD
and macOS!). Thus these iotests can now always be run during "make
check" automatically, too.

v2:
 - Use "auto" group instead of adding a new "ci" group
 - Adjusted the tests that are run automatically (after doing lots
   of CI runs on cirrus-ci.com, gitlab and travis)
 - Added patch to fix the current regression with the "qemu-io:"
   prefix in the master branch
 - Added a fix for iotest 005 on ext4 filesystems (skip it there)

Thomas Huth (8):
  tests/qemu-iotests: Fix output of qemu-io related tests
  tests/qemu-iotests/005: Add a sanity check for large sparse file
    support
  tests/qemu-iotests/check: Pick a default machine if necessary
  tests/qemu-iotests: Do not hard-code the path to bash
  cirrus / travis: Add gnu-sed and bash for macOS and FreeBSD
  tests/qemu-iotests: Remove the "_supported_os Linux" line from many
    tests
  tests/qemu-iotests/group: Re-use the "auto" group for tests that can
    always run
  tests: Run the iotests during "make check" again

 .cirrus.yml                 |   4 +-
 .travis.yml                 |   1 +
 tests/Makefile.include      |   8 +-
 tests/check-block.sh        |  44 +++++++---
 tests/qemu-iotests-quick.sh |   8 --
 tests/qemu-iotests/001      |   1 -
 tests/qemu-iotests/002      |   1 -
 tests/qemu-iotests/003      |   1 -
 tests/qemu-iotests/004      |   1 -
 tests/qemu-iotests/005      |   9 ++
 tests/qemu-iotests/007      |   1 -
 tests/qemu-iotests/008      |   1 -
 tests/qemu-iotests/009      |   1 -
 tests/qemu-iotests/010      |   1 -
 tests/qemu-iotests/011      |   1 -
 tests/qemu-iotests/012      |   1 -
 tests/qemu-iotests/015      |   1 -
 tests/qemu-iotests/017      |   1 -
 tests/qemu-iotests/020      |   1 -
 tests/qemu-iotests/021      |   1 -
 tests/qemu-iotests/022      |   1 -
 tests/qemu-iotests/025      |   1 -
 tests/qemu-iotests/026      |   1 -
 tests/qemu-iotests/026.out  | 168 +++++++++++++++++------------------
 tests/qemu-iotests/027      |   1 -
 tests/qemu-iotests/029      |   1 -
 tests/qemu-iotests/031      |   1 -
 tests/qemu-iotests/032      |   1 -
 tests/qemu-iotests/033      |   1 -
 tests/qemu-iotests/035      |   1 -
 tests/qemu-iotests/036      |   1 -
 tests/qemu-iotests/037      |   1 -
 tests/qemu-iotests/042      |   1 -
 tests/qemu-iotests/043      |   1 -
 tests/qemu-iotests/046      |   1 -
 tests/qemu-iotests/047      |   1 -
 tests/qemu-iotests/049      |   1 -
 tests/qemu-iotests/050      |   1 -
 tests/qemu-iotests/051      |   1 -
 tests/qemu-iotests/052      |   1 -
 tests/qemu-iotests/053      |   1 -
 tests/qemu-iotests/054      |   1 -
 tests/qemu-iotests/060.out  |   6 +-
 tests/qemu-iotests/062      |   1 -
 tests/qemu-iotests/063      |   1 -
 tests/qemu-iotests/066      |   1 -
 tests/qemu-iotests/067      |   1 -
 tests/qemu-iotests/068      |   1 -
 tests/qemu-iotests/069      |   1 -
 tests/qemu-iotests/069.out  |   2 +-
 tests/qemu-iotests/070.out  |   2 +-
 tests/qemu-iotests/071      |   1 -
 tests/qemu-iotests/072      |   1 -
 tests/qemu-iotests/073      |   1 -
 tests/qemu-iotests/075.out  |  14 +--
 tests/qemu-iotests/076.out  |   6 +-
 tests/qemu-iotests/078.out  |  12 +--
 tests/qemu-iotests/079      |   1 -
 tests/qemu-iotests/080.out  |  40 ++++-----
 tests/qemu-iotests/081.out  |   2 +-
 tests/qemu-iotests/082      |   1 -
 tests/qemu-iotests/085      |   1 -
 tests/qemu-iotests/088.out  |  12 +--
 tests/qemu-iotests/089      |   1 -
 tests/qemu-iotests/090      |   1 -
 tests/qemu-iotests/094      |   1 -
 tests/qemu-iotests/095      |   1 -
 tests/qemu-iotests/098      |   1 -
 tests/qemu-iotests/102      |   1 -
 tests/qemu-iotests/103      |   1 -
 tests/qemu-iotests/103.out  |  14 +--
 tests/qemu-iotests/104      |   1 -
 tests/qemu-iotests/105      |   1 -
 tests/qemu-iotests/107      |   1 -
 tests/qemu-iotests/110      |   1 -
 tests/qemu-iotests/111      |   1 -
 tests/qemu-iotests/112      |   1 -
 tests/qemu-iotests/114      |   1 -
 tests/qemu-iotests/114.out  |   2 +-
 tests/qemu-iotests/115      |   1 -
 tests/qemu-iotests/116.out  |  14 +--
 tests/qemu-iotests/117      |   1 -
 tests/qemu-iotests/120      |   1 -
 tests/qemu-iotests/125      |   1 -
 tests/qemu-iotests/126      |   1 -
 tests/qemu-iotests/127      |   1 -
 tests/qemu-iotests/131.out  |   2 +-
 tests/qemu-iotests/133      |   1 -
 tests/qemu-iotests/133.out  |  30 +++----
 tests/qemu-iotests/134      |   1 -
 tests/qemu-iotests/137.out  |  28 +++---
 tests/qemu-iotests/140.out  |   2 +-
 tests/qemu-iotests/142      |   1 -
 tests/qemu-iotests/143      |   1 -
 tests/qemu-iotests/143.out  |   2 +-
 tests/qemu-iotests/144      |   1 -
 tests/qemu-iotests/145      |   1 -
 tests/qemu-iotests/153      |   1 -
 tests/qemu-iotests/153.out  |  30 +++----
 tests/qemu-iotests/156      |   1 -
 tests/qemu-iotests/157      |   1 -
 tests/qemu-iotests/158      |   1 -
 tests/qemu-iotests/159      |   1 -
 tests/qemu-iotests/162      |   1 -
 tests/qemu-iotests/170      |   1 -
 tests/qemu-iotests/173      |   1 -
 tests/qemu-iotests/182      |   1 -
 tests/qemu-iotests/183      |   1 -
 tests/qemu-iotests/186      |   1 -
 tests/qemu-iotests/187      |   1 -
 tests/qemu-iotests/187.out  |   6 +-
 tests/qemu-iotests/188.out  |   2 +-
 tests/qemu-iotests/190      |   1 -
 tests/qemu-iotests/191      |   1 -
 tests/qemu-iotests/192      |   1 -
 tests/qemu-iotests/195      |   1 -
 tests/qemu-iotests/197      |   1 -
 tests/qemu-iotests/197.out  |   2 +-
 tests/qemu-iotests/200      |   1 -
 tests/qemu-iotests/205      |   2 +-
 tests/qemu-iotests/214      |   1 -
 tests/qemu-iotests/215      |   1 -
 tests/qemu-iotests/215.out  |   2 +-
 tests/qemu-iotests/217      |   1 -
 tests/qemu-iotests/226.out  |  16 ++--
 tests/qemu-iotests/227      |   1 -
 tests/qemu-iotests/231      |   1 -
 tests/qemu-iotests/233      |   1 -
 tests/qemu-iotests/239      |   2 +-
 tests/qemu-iotests/240      |   3 +-
 tests/qemu-iotests/241      |   2 +-
 tests/qemu-iotests/243      |   2 +-
 tests/qemu-iotests/244      |   2 +-
 tests/qemu-iotests/244.out  |  10 +--
 tests/qemu-iotests/247      |   1 -
 tests/qemu-iotests/check    |  13 ++-
 tests/qemu-iotests/group    | 169 +++++++++++++++++++-----------------
 137 files changed, 372 insertions(+), 421 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

--=20
2.21.0


