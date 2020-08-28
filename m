Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC81BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDBE208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDBE208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbCq-0002g2-Rp
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kBbBJ-0000Em-AL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:00:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38446 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangxinxin.wang@huawei.com>)
 id 1kBbBC-0000IO-VQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:00:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3D53452ED479870CA382;
 Fri, 28 Aug 2020 18:00:03 +0800 (CST)
Received: from localhost (10.174.149.106) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 28 Aug 2020
 17:59:56 +0800
From: Wang Xin <wangxinxin.wang@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/2][RFC] exclude ivshmem mr from vhost sections
Date: Fri, 28 Aug 2020 17:59:51 +0800
Message-ID: <20200828095953.2276-1-wangxinxin.wang@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.106]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=wangxinxin.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 06:00:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Wang Xin <wangxinxin.wang@huawei.com>, jianjay.zhou@huawei.com,
 weidong.huang@huawei.com, dgilbert@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ivshmem me now mapped to vhost memory regions, and it reduces
the number of available memslots of vhost backend, which may
causes vhost backend memory slots limit check failure in
vhost dev init.

Since ivshmem_bar2 not normal RAM in Guest, and it shouldn't
have vhost DMAing into them, exclude it from the vhost sections.

The 1st patch re-spin Dave's patch, see link
  https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02370.html

However, I'm not sure is there any side effects, or maybe it's
better to add a new device property like 'novhost/nodma'?

Thanks,
Xin

Wang Xin (2):
  memory: Allow a MemoryRegion to be marked no_vhost
  misc/ivshmem: Mark shared memory regions as no vhost

 hw/misc/ivshmem.c     |  2 ++
 hw/virtio/vhost.c     |  5 ++++-
 include/exec/memory.h | 21 +++++++++++++++++++++
 softmmu/memory.c      | 15 +++++++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
2.26.0.windows.1



