Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A8C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB7720874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB7720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi34-0001le-J6
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrz-0006XH-8N; Sat, 19 Sep 2020 14:45:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrv-0001TT-By; Sat, 19 Sep 2020 14:45:58 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQ85-1kGi8Q2jhl-00Gs73; Sat, 19 Sep 2020 20:45:28 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] contrib/: fix some comment spelling errors
Date: Sat, 19 Sep 2020 20:44:51 +0200
Message-Id: <20200919184451.2129349-18-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bOEy+G/IGMKE9gvFJ4cxzQSb4njmsnq6VEyLKdftrDeNY44YeP6
 RCINZFhrsPR+Oc0jpUFo26QXWnMoML3Li5a/1WgWI7HNPm7INUEiUkLb8nASPXpAevbn4Uf
 yofJ5dlHtYVHGqeFDndCtnnoDa0OY2rnjm1yiK9qNRQRP/g7HHez7COMOCHCDb/eic9n2Jz
 +HeiUlSKV4tRDKo+jc/cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TsAm0Bzp3+0=:Tl7ATPSARqvcIsIkhOOW1C
 mP2BM2LqmAoDKy/N96Sg4IpWqPX26Hvb3FLmUlvJTS8O85Kci3v63UuKj/6ijrsy9Q/yEz5bd
 VBf6bgvyjnDl749v4yfr0Ao4gGZanM9TLsK2+Nhim5uL0TQR8kRik3MZX/zH0ZMFaFHh2YTUZ
 4Gq5c6mDoHvNHy4ABqPklXkE+7DZqkFD3drpvxNvYyBhDPA4FAzmL9DrgPXvKap6DkPxXiWB4
 bIgIFAPeLwd4wgRxtk/zDeRZIXK4gd3aBvkHGvO5kMJyFV0flD3l3QE944i8KY6tny+4G02hR
 LxOg8WzPv51a3Au/ji9U6FZe2xjrGtgKkv3cDoVJ7vm+l33YsmGIhkr8UrQAgOk59b1+Np3Jj
 JLwdoCkobB/OgO3x3kUG3Ik5/qYdiOKx3patlfDvPK+jSpB5nu9rfDKePiCHvVH49/dCcU4bK
 nkuVhhOP49sYh5kesY5VdEIVxDYwxkjIePLtzvf7iZ4W+1dxtRYA9cNUn39bHJXFFjB1AyKYw
 pivojfkhQKZdRXDOt/uEdK2JAdQ7x6tqVyrMvbW1RPRjO11l1BrRnQdygsxOjZLDHkIP5hD+j
 iKgm4m0xgQqpBeGGUZK4t/N9taBlEg7l92FCNwDMXm0KF9ihq78D6z4jIE9ABR89VlcAmKiGI
 4wP9xNValzJmXQmGVWYs85f5YtfoCxQJk1aO8TpafCwOhBZx0I7x8EE4iZFqe+xOqEtrEYHnq
 eUgh+sgfyjgNAZTsvEC2qFo0J/EGn8GuErWe3pvZQhg0CK3g5FiZLOUfsRn8/iTweoUJXzO3m
 A5aY2eZdr2kPntUXoHOG1AqYHlE7lMxXphawAzSzJFd3/pvZhq/PAUCta92Sbw2n8gIr8Kw
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Alex Bennee <alex.bennee@linaro.org>,
 zhaolichang <zhaolichang@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: zhaolichang <zhaolichang@huawei.com>

I found that there are many spelling errors in the comments of qemu,
so I used the spellcheck tool to check the spelling errors
and finally found some spelling errors in the contrib folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: Alex Bennee <alex.bennee@linaro.org>
Message-Id: <20200917075029.313-11-zhaolichang@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 contrib/gitdm/filetypes.txt             | 6 +++---
 contrib/ivshmem-client/ivshmem-client.h | 2 +-
 contrib/libvhost-user/libvhost-user.c   | 4 ++--
 contrib/libvhost-user/libvhost-user.h   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
index 9e9c50520550..d2d6f6db8d5e 100644
--- a/contrib/gitdm/filetypes.txt
+++ b/contrib/gitdm/filetypes.txt
@@ -22,7 +22,7 @@
 # in the gitdm sample-config directory.
 #
 # This file contains associations parameters regarding filetypes
-# (documentation, develompent, multimedia, images...)
+# (documentation, development, multimedia, images...)
 #
 # format:
 # filetype <type> <regex> [<comment>]
@@ -59,8 +59,8 @@ filetype code \.s$	# Assembly
 filetype code \.S$	# Assembly
 filetype code \.asm$	# Assembly
 filetype code \.awk$	# awk
-filetype code ^common$  # script fragements
-filetype code ^common.*$  # script fragements
+filetype code ^common$  # script fragments
+filetype code ^common.*$  # script fragments
 filetype code (qom|qmp)-\w+$  # python script fragments
 
 #
diff --git a/contrib/ivshmem-client/ivshmem-client.h b/contrib/ivshmem-client/ivshmem-client.h
index fe3cc4a03d33..fc45a38060f0 100644
--- a/contrib/ivshmem-client/ivshmem-client.h
+++ b/contrib/ivshmem-client/ivshmem-client.h
@@ -174,7 +174,7 @@ int ivshmem_client_notify_all_vects(const IvshmemClient *client,
                                     const IvshmemClientPeer *peer);
 
 /**
- * Broadcat a notification to all vectors of all peers
+ * Broadcast a notification to all vectors of all peers
  *
  * @client: The ivshmem client
  *
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 53f16bdf082c..9d30ff2283c4 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -684,7 +684,7 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
 
     /*
      * If we are in postcopy mode and we receive a u64 payload with a 0 value
-     * we know all the postcopy client bases have been recieved, and we
+     * we know all the postcopy client bases have been received, and we
      * should start generating faults.
      */
     if (track_ramblocks &&
@@ -973,7 +973,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
     for (i = 0; i < dev->max_queues; i++) {
         if (dev->vq[i].vring.desc) {
             if (map_ring(dev, &dev->vq[i])) {
-                vu_panic(dev, "remaping queue %d during setmemtable", i);
+                vu_panic(dev, "remapping queue %d during setmemtable", i);
             }
         }
     }
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-user/libvhost-user.h
index 844c37c64899..287ac5fec7f1 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -424,7 +424,7 @@ typedef struct VuVirtqElement {
  * @remove_watch: a remove_watch callback
  * @iface: a VuDevIface structure with vhost-user device callbacks
  *
- * Intializes a VuDev vhost-user context.
+ * Initializes a VuDev vhost-user context.
  *
  * Returns: true on success, false on failure.
  **/
-- 
2.26.2


