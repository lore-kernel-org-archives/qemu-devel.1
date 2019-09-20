Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688E1C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:15:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37912217D6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37912217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB6aO-00053H-MB
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iB6Z6-00049a-EE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iB6Z4-00051l-1t
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iB6Z3-00050k-Sr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C4C6190C019;
 Fri, 20 Sep 2019 00:14:20 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74AC419C5B;
 Fri, 20 Sep 2019 00:14:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] docker: misc cleanups
Date: Thu, 19 Sep 2019 20:14:10 -0400
Message-Id: <20190920001413.22567-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Fri, 20 Sep 2019 00:14:20 +0000 (UTC)
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

Another handful of misc tidyups.

Note: this WILL conflict with the other cleanups already in-flight, but
I didn't have a convenient branch to base against at the time; but
it should be pretty trivial to resolve/respin.

John Snow (3):
  docker: remove 'deprecated' image definitions
  docker: remove debian8-mxe definitions
  docker: remove unused debian-sid and debian-ports

 tests/docker/Makefile.include                |  9 +++--
 tests/docker/dockerfiles/debian-ports.docker | 36 --------------------
 tests/docker/dockerfiles/debian-sid.docker   | 35 -------------------
 3 files changed, 4 insertions(+), 76 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
 delete mode 100644 tests/docker/dockerfiles/debian-sid.docker

--=20
2.21.0


