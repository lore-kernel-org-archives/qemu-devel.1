Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B24C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18042073F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 16:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18042073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39497 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyk1-0007VM-2X
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 12:09:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyg1-0004d9-9x
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEyfy-0002HT-VB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 12:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hEyft-0002Ab-EC; Fri, 12 Apr 2019 12:05:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FCB223E6C5;
	Fri, 12 Apr 2019 16:05:05 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.26])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 89B8D605CF;
	Fri, 12 Apr 2019 16:05:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Apr 2019 18:04:56 +0200
Message-Id: <20190412160458.23920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 12 Apr 2019 16:05:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/2] Block layer patches for 4.0-rc4
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412160456.mH0DlTor2qM6FNSZqXcNuSOcV4c-b8g6tmtnOQeBbNk@z>

The following changes since commit 13c24edaa742181af8d9c6b027ee366b04de1e=
a1:

  qemu-img: fix .hx and .texi disparity (2019-04-12 14:17:10 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 9749636b005d118259810afb92482df2fe0ae2ad:

  iotest: Fix 241 to run in generic directory (2019-04-12 18:03:01 +0200)

----------------------------------------------------------------
Block layer patches:

- iotests fixes

----------------------------------------------------------------
Eric Blake (1):
      iotest: Fix 241 to run in generic directory

Max Reitz (1):
      iotests: Let 245 pass on tmpfs

 tests/qemu-iotests/241     |  4 +++-
 tests/qemu-iotests/241.out |  6 +++---
 tests/qemu-iotests/245     | 10 ++++++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

