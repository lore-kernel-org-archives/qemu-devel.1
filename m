Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6697BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 324D22070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNN5UNr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324D22070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxl3-0000VF-8a
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxk1-0007DA-OR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:50:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57258
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxjz-0007IA-CP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=kzYShqYmxQFxU/HjxCjn+gVfLmM9FZnhcjMxXeRSmdg=;
 b=fNN5UNr9ZA9WB4IBuix5HEgj65DmmRCtIyAmrRU5qYK9nU6Y26P6PPXV+Rpsh81FPbkXc3
 nChUFvxihllHd4x3OPjd/pI4z1ABRWuxvZyxe1vUY+JesZ2EHemLAJ6dS8bGwNqIKgRNjp
 ot4jdCxCcL68wmiDzoic4dnGXHcyb3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-YT3lTxr2NEyYpnBuV4s6Yw-1; Thu, 02 Jul 2020 07:50:50 -0400
X-MC-Unique: YT3lTxr2NEyYpnBuV4s6Yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F1141005513;
 Thu,  2 Jul 2020 11:50:49 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A49A460CD3;
 Thu,  2 Jul 2020 11:50:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 00/11] s390-ccw bios update
Date: Thu,  2 Jul 2020 13:50:34 +0200
Message-Id: <20200702115045.6171-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This pull request is not for master.

 Hi Cornelia,

the following changes since commit fc1bff958998910ec8d25db86cd2f53ff125f7ab:

  hw/misc/pca9552: Add missing TypeInfo::class_size field (2020-06-29 21:16:10 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/s390-ccw-bios-2020-07-02

for you to fetch changes up to b71db6b9abb5af302c9669c133d78115c6437c45:

  pc-bios/s390: Update s390-ccw bios binaries with the latest changes (2020-07-02 11:51:31 +0200)

----------------------------------------------------------------
* Source code clean-ups from Janosch
----------------------------------------------------------------

Janosch Frank (9):
      pc-bios: s390x: cio.c cleanup and compile fix
      pc-bios: s390x: Consolidate timing functions into time.h
      pc-bios: s390x: Move sleep and yield to helper.h
      pc-bios: s390x: Get rid of magic offsets into the lowcore
      pc-bios: s390x: Rename PSW_MASK_ZMODE to PSW_MASK_64
      pc-bios: s390x: Use PSW masks where possible and introduce PSW_MASK_SHORT_ADDR
      pc-bios: s390x: Move panic() into header and add infinite loop
      pc-bios: s390x: Use ebcdic2ascii table
      pc-bios: s390x: Make u32 ptr check explicit

Thomas Huth (2):
      pc-bios/s390-ccw: Generate and include dependency files in the Makefile
      pc-bios/s390: Update s390-ccw bios binaries with the latest changes

 pc-bios/s390-ccw.img           | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/Makefile      |   3 +++
 pc-bios/s390-ccw/bootmap.c     |   4 +---
 pc-bios/s390-ccw/cio.c         |  40 ++++++++++++++++++++++------------------
 pc-bios/s390-ccw/cio.h         |  17 +++++++++++------
 pc-bios/s390-ccw/helper.h      |  19 ++++++++++++++++++-
 pc-bios/s390-ccw/jump2ipl.c    |  10 ++++------
 pc-bios/s390-ccw/main.c        |  15 +++------------
 pc-bios/s390-ccw/menu.c        |   1 +
 pc-bios/s390-ccw/netboot.mak   |  13 +++++++------
 pc-bios/s390-ccw/netmain.c     |  23 +++--------------------
 pc-bios/s390-ccw/s390-arch.h   |   4 +++-
 pc-bios/s390-ccw/s390-ccw.h    |  27 +++++++--------------------
 pc-bios/s390-ccw/s390-time.h   |  23 +++++++++++++++++++++++
 pc-bios/s390-ccw/start.S       |   5 +++--
 pc-bios/s390-ccw/virtio-net.c  |   2 ++
 pc-bios/s390-ccw/virtio-scsi.c |   2 ++
 pc-bios/s390-ccw/virtio.c      |  18 +++---------------
 pc-bios/s390-netboot.img       | Bin 67232 -> 67232 bytes
 19 files changed, 116 insertions(+), 110 deletions(-)
 create mode 100644 pc-bios/s390-ccw/s390-time.h


