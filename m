Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312A3C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0118A2133D
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0118A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51647 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1zN-0007sb-9c
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:25:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yP-0007Om-Gw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hE1yO-0001sC-H1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 21:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hE1yM-0001hi-Ee; Tue, 09 Apr 2019 21:24:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CEB0307D98B;
	Wed, 10 Apr 2019 01:24:17 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30BE61073027;
	Wed, 10 Apr 2019 01:24:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue,  9 Apr 2019 21:24:10 -0400
Message-Id: <20190410012413.31569-1-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 10 Apr 2019 01:24:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC 0/3] qemu-img: remove command documentation
 duplication
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	John Snow <jsnow@redhat.com>, armbru@redhat.com,
	Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410012410.NY2f-V4EAJkyoLZtpLiJaWqh8de7MzLGa4g2pS955Jk@z>

This might hopefully cut down on the doc duplication/mismatching
until I can devise something more comprehensive.

Ideally, I'd like to redo all of the documentation for qemu-img
nearly from scratch; with a parser generator that helps generate
the documentation as well so they'll never get out of date.

That's probably quite a ways off, and maybe there are other
structural changes we want to make with respect to sphinx and
other build tools, so I am sending something very minimal instead.

This ought to be functionally identical down to the last char.

(I've re-included patch one which I have sent to the list separately,
purely as a dependency if you want to apply these patches.)

John Snow (3):
  qemu-img: fix .hx and .texi disparity
  pxtool: Add new qemu-img command info generation tool
  qemu-img.texi: use macros for command summaries

 qemu-img.texi      |  28 ++++----
 Makefile           |   8 +--
 qemu-img-cmds.json | 165 +++++++++++++++++++++++++++++++++++++++++++++
 qemu-img-cmds.hx   | 102 ----------------------------
 scripts/pxtool.py  |  53 +++++++++++++++
 5 files changed, 236 insertions(+), 120 deletions(-)
 create mode 100644 qemu-img-cmds.json
 delete mode 100644 qemu-img-cmds.hx
 create mode 100755 scripts/pxtool.py

-- 
2.17.2


