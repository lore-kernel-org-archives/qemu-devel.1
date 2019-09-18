Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6E4C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F95720644
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F95720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAe6X-0001eb-7v
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iAcc0-0004WB-7K
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iAcbx-0006nF-Ce
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iAcbx-0006mx-6J; Wed, 18 Sep 2019 12:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 248933082B4B;
 Wed, 18 Sep 2019 16:15:20 +0000 (UTC)
Received: from thuth.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D79086114F;
 Wed, 18 Sep 2019 16:15:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-s390x@nongnu.org
Date: Wed, 18 Sep 2019 18:15:11 +0200
Message-Id: <20190918161514.15575-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 18 Sep 2019 16:15:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390x 0/3] Minor fixes for the
 s390-ccw firmware
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request is not for master !

 Hi Cornelia,

the following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:

  target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2019-09-18

for you to fetch changes up to 6b2a203579068127d7e93cb6f45d828ca04a2153:

  pc-bios/s390-ccw: Rebuild the s390-netboot.img firmware image (2019-09-18 17:47:27 +0200)

----------------------------------------------------------------
- Small fixes for the s390-ccw firmware
- I did *not* rebuild the s390-ccw.img since the patch did not
  make a difference at all - seems like GCC was smart enough
  already to put the zeroed array into the BSS before
----------------------------------------------------------------

Thomas Huth (2):
      pc-bios/s390-ccw: Do not pre-initialize empty array
      pc-bios/s390-ccw: Rebuild the s390-netboot.img firmware image

Yifan Luo (1):
      pc-bios/s390-ccw/net: fix a possible memory leak in get_uuid()

 pc-bios/s390-ccw/main.c    |   2 +-
 pc-bios/s390-ccw/netmain.c |   1 +
 pc-bios/s390-netboot.img   | Bin 67232 -> 67232 bytes
 3 files changed, 2 insertions(+), 1 deletion(-)

