Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7218C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7AA2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 13:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7AA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhcx-0007te-EJ
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 09:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hck-ci@localhost>) id 1hzhbS-0006xS-Af
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hck-ci@localhost>) id 1hzhbP-0005bA-Ee
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:41 -0400
Received: from [141.226.163.173] (port=35970 helo=groan)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <hck-ci@localhost>) id 1hzhbD-0005UN-B0
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 09:21:35 -0400
Received: by groan (Postfix, from userid 1000)
 id 7C91A20AEE24B; Mon, 19 Aug 2019 16:16:20 +0300 (IDT)
From: Bishara AbuHattoum <bishara@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 19 Aug 2019 16:16:19 +0300
Message-Id: <20190819131620.1302-1-bishara@daynix.com>
X-Mailer: git-send-email 2.17.2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 141.226.163.173
Subject: [Qemu-devel] [PATCH 0/1] BZ#1733165: network-get-interfaces Chinese
 NIC name
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://bugzilla.redhat.com/show_bug.cgi?id=1733165

Uppon renaming a NIC to a Chinese name and invoking the network get
interfaces command, guest-network-get-interfaces, the returned name
field has the (\ufffd) value for each Chinese character the NIC name
had, this value is the indication that the code page does not have the
decoding information for the given character.

The suggested fix is to use the CP_UTF8 code page for decoding the NIC's
name instead of the CP_ACP code page.

Bishara AbuHattoum (1):
  qga-win: network-get-interfaces command name field bug fix

 qga/commands-win32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.17.2


