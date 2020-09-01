Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384BC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E0A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0A206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Mp-0006MQ-UD
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zZ-0006A5-SJ; Tue, 01 Sep 2020 10:10:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zX-00040M-U7; Tue, 01 Sep 2020 10:10:33 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MkpjD-1kri4W0g07-00mHgY; Tue, 01 Sep 2020 16:10:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 38/44] hw/net/virtio-net:Remove redundant statement in
 virtio_net_rsc_tcp_ctrl_check()
Date: Tue,  1 Sep 2020 16:09:48 +0200
Message-Id: <20200901140954.889743-39-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GpwwH3w0iP+ROO0G5v0szD4r3uVxpbrANqTycm0vX5WOZteZR3r
 ciwv50BXPB9l7ItFtSRftIs+M9qgzDkVcIUcRCpizwoic0icTL6Fs+/Zzhef8uZAW5YMSTt
 R1ZnnwiEetUbXiGDW2cUNbPd73JKz3TNB4hIWDPink4N/9XoVKU7kGp/neZFRRHnLqWZNmD
 7/1kms6yn2aaVRdKMKMfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6fEAJAzPqzQ=:0OBQLBVFGA5XJ6QPnY4gJC
 P+9g17uUb8xDTIbnGnwqtSObAk1xH15tRQey3XRciM6FONoobxqilr6w/ahfOR2mV6D0YB+lK
 HWLz2otoNARPeQg64tJfOMm+QpXxCTrGeHM58AuNolHAq4wluQWEV/HnwVvsR4k6mjqgzHC81
 sIIe4c5hC+LIWbh7W2fZ3HYpVD/gjXoWxcrHf+2E/fJmtBvVNQBxgHj9+rMsLDav5rJZuDf7c
 k4Cad1DYQqMilqDe0mqkQGdxlB95Kh6pg8j8VgKFbX1PeB+zXMaMO9wlmrm+euQpbjSTFwW6B
 YaF0u/N2HQEU4BHSBaoSHrFdD5S6Y91ZJ3O/NsdNuC1kXhj2UZeaZKop7Xr93x8NRtSBXqPEV
 nIGph7TisjnHoSkxZCVDQNdF/v6ELB9uxiIn9UefKnMQQGUz49oHT/Bpb9+o6akuds6QOZT0n
 KABrzmP5mIAMrV/wtFWLTevKp11afo/p/4+1n1i69w8fLrU7Lypi5PaFuRkB9ngpiZZfFN/To
 rUvpCVNM54OW8POY1aBc505m4lVYO2cD3TZN+hLplElPzIF0t220UMG9S6ndkKz4sLTyvizze
 XvcXcBhTEgqdW5p2UDN2NL+40i8JxePAmc4DYitSA/vbYz0rIJ26QOt9s/A4Qv6oJ9idfxm0L
 wJkFeBCBKVHYvOER4T1PcL/ymfZmMIYjv/yg3nUL5j25gpanCohBMLVR8LuV/0sbbyVMJWNps
 yPXGL0fRiXQ0n4/wbpkhCKfH+kBmXPfn41ZMc1ogAKdE+7GyLoy/hHIF0OJRvGa7m5EwALOrE
 5G58ksT68kLjhSD9jD0kcP++/UEedoPz5IrgrPZjf0qTfQC5R0+TIhf2kGwTgkF7XyvOnnQ
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/net/virtio-net.c:2077:5: warning: Value stored to 'tcp_flag' is never read
    tcp_flag &= VIRTIO_NET_TCP_FLAG;
    ^           ~~~~~~~~~~~~~~~~~~~

The 'VIRTIO_NET_TCP_FLAG' is '0x3F'. The last ‘tcp_flag’ assignment statement is
 the same as that of the first two statements.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20200827110311.164316-7-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/virtio-net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a1fe9e928533..cb0d27084c10 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2075,7 +2075,6 @@ static int virtio_net_rsc_tcp_ctrl_check(VirtioNetRscChain *chain,
     tcp_flag = htons(tcp->th_offset_flags);
     tcp_hdr = (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
     tcp_flag &= VIRTIO_NET_TCP_FLAG;
-    tcp_flag = htons(tcp->th_offset_flags) & 0x3F;
     if (tcp_flag & TH_SYN) {
         chain->stat.tcp_syn++;
         return RSC_BYPASS;
-- 
2.26.2


