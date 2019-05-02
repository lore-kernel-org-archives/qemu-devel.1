Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602AAC04AA8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:47:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C152075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C152075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47685 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7Nf-0005Mq-81
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:47:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7Lp-0004H6-O0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:46:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hM7Lh-0003SV-QR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:45:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hM7LF-0002uB-5f; Thu, 02 May 2019 04:45:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E5B38830A;
	Thu,  2 May 2019 08:45:17 +0000 (UTC)
Received: from thuth.com (ovpn-116-131.ams2.redhat.com [10.36.116.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E635254FDF;
	Thu,  2 May 2019 08:45:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:44:59 +0200
Message-Id: <20190502084506.8009-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Thu, 02 May 2019 08:45:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/7] tests/qemu-iotests: Run basic iotests
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
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>, Max Reitz <mreitz@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502084459.r7LGafNRVXCK2pV3BJe55RO8_7oVpJpTtmd1kLlKDBY@z>

People often forget to run the iotests before submitting patches or
pull requests - this is likely due to the fact that we do not run the
tests during our mandatory "make check" tests yet.
This patch series now changes the "auto" group to only include tests
that should be safe to run in all CI environments (including FreeBSD
and macOS!). Thus these iotests can now always be run during "make
check" automatically, too.

v3:
 - Rebase to master, solved trivial conflict with new iotest 249
   (and the patch to fix the "qemu-io" output has already been merged)
 - Removed some more tests from the "auto" group that failed in
   certain environments
 - Added Reviewed-by tags

v2:
 - Use "auto" group instead of adding a new "ci" group
 - Adjusted the tests that are run automatically (after doing lots
   of CI runs on cirrus-ci.com, gitlab and travis)
 - Added patch to fix the current regression with the "qemu-io:"
   prefix in the master branch
 - Added a fix for iotest 005 on ext4 filesystems (skip it there)

Thomas Huth (7):
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
 tests/check-block.sh        |  44 +++++++--
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
 tests/qemu-iotests/062      |   1 -
 tests/qemu-iotests/063      |   1 -
 tests/qemu-iotests/066      |   1 -
 tests/qemu-iotests/067      |   1 -
 tests/qemu-iotests/068      |   1 -
 tests/qemu-iotests/069      |   1 -
 tests/qemu-iotests/071      |   1 -
 tests/qemu-iotests/072      |   1 -
 tests/qemu-iotests/073      |   1 -
 tests/qemu-iotests/079      |   1 -
 tests/qemu-iotests/082      |   1 -
 tests/qemu-iotests/085      |   1 -
 tests/qemu-iotests/089      |   1 -
 tests/qemu-iotests/090      |   1 -
 tests/qemu-iotests/094      |   1 -
 tests/qemu-iotests/095      |   1 -
 tests/qemu-iotests/098      |   1 -
 tests/qemu-iotests/102      |   1 -
 tests/qemu-iotests/103      |   1 -
 tests/qemu-iotests/104      |   1 -
 tests/qemu-iotests/105      |   1 -
 tests/qemu-iotests/107      |   1 -
 tests/qemu-iotests/110      |   1 -
 tests/qemu-iotests/111      |   1 -
 tests/qemu-iotests/112      |   1 -
 tests/qemu-iotests/114      |   1 -
 tests/qemu-iotests/115      |   1 -
 tests/qemu-iotests/117      |   1 -
 tests/qemu-iotests/120      |   1 -
 tests/qemu-iotests/125      |   1 -
 tests/qemu-iotests/126      |   1 -
 tests/qemu-iotests/127      |   1 -
 tests/qemu-iotests/133      |   1 -
 tests/qemu-iotests/134      |   1 -
 tests/qemu-iotests/142      |   1 -
 tests/qemu-iotests/143      |   1 -
 tests/qemu-iotests/144      |   1 -
 tests/qemu-iotests/145      |   1 -
 tests/qemu-iotests/153      |   1 -
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
 tests/qemu-iotests/190      |   1 -
 tests/qemu-iotests/191      |   1 -
 tests/qemu-iotests/192      |   1 -
 tests/qemu-iotests/195      |   1 -
 tests/qemu-iotests/197      |   1 -
 tests/qemu-iotests/200      |   1 -
 tests/qemu-iotests/214      |   1 -
 tests/qemu-iotests/215      |   1 -
 tests/qemu-iotests/217      |   1 -
 tests/qemu-iotests/227      |   1 -
 tests/qemu-iotests/231      |   1 -
 tests/qemu-iotests/233      |   1 -
 tests/qemu-iotests/239      |   2 +-
 tests/qemu-iotests/240      |   3 +-
 tests/qemu-iotests/241      |   2 +-
 tests/qemu-iotests/243      |   2 +-
 tests/qemu-iotests/244      |   2 +-
 tests/qemu-iotests/247      |   1 -
 tests/qemu-iotests/check    |  13 ++-
 tests/qemu-iotests/group    | 177 +++++++++++++++++++-----------------
 111 files changed, 162 insertions(+), 211 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

--=20
2.21.0


