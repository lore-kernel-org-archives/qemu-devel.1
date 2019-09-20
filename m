Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DA92086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DA92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBRCa-0005rF-Ow
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iBR9I-0008T0-EE
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iBR9H-0006xX-Bk
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iBR9H-0006x2-6G
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D0BAF85546;
 Fri, 20 Sep 2019 22:13:05 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E76C5D9C3;
 Fri, 20 Sep 2019 22:12:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] docker: misc cleanups
Date: Fri, 20 Sep 2019 18:12:50 -0400
Message-Id: <20190920221255.30412-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 20 Sep 2019 22:13:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should include anything I've sent so far (not including the RFC for
more exploratory changes) that hasn't already been included in a roundup
by Alex Benn=C3=A9e.

Mostly, it removes unused docker files and replaces python2 with python3
in all of the container environments.

V2:
- Rolled in python2 --> python3 conversion
- Added travis conversion to python patch
- Remove debian8 dockerfile, which is also now unused.

John Snow (5):
  docker: move tests from python2 to python3
  docker: remove 'deprecated' image definitions
  docker: remove debian8-mxe definitions
  docker: remove unused debian-sid and debian-ports
  docker: removed unused debian8 partial image

 tests/docker/Makefile.include                 |  8 ++---
 tests/docker/dockerfiles/centos7.docker       |  2 +-
 tests/docker/dockerfiles/debian-ports.docker  |  2 +-
 tests/docker/dockerfiles/debian-sid.docker    |  2 +-
 .../dockerfiles/debian-xtensa-cross.docker    |  2 +-
 tests/docker/dockerfiles/debian10.docker      |  2 +-
 tests/docker/dockerfiles/debian8.docker       | 34 -------------------
 tests/docker/dockerfiles/debian9.docker       |  2 +-
 tests/docker/dockerfiles/travis.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu.docker        |  2 +-
 tests/docker/dockerfiles/ubuntu1804.docker    |  2 +-
 11 files changed, 12 insertions(+), 48 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian8.docker

--=20
2.21.0


