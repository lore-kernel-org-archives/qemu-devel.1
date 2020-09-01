Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30042C433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01032206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01032206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Em-0006Qu-2Q
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zT-0005t4-W2; Tue, 01 Sep 2020 10:10:28 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35029)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zP-0003wz-Do; Tue, 01 Sep 2020 10:10:27 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfpGL-1koumZ1XwH-00gG4y; Tue, 01 Sep 2020 16:10:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 31/44] util/vfio-helpers: Unify trace-events size format
Date: Tue,  1 Sep 2020 16:09:41 +0200
Message-Id: <20200901140954.889743-32-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XuDq3Ce03C4SUF81OPoY07f5QjJcTQ80clUd/CiCZW6dkdn9M1t
 t28F1yue3em7V5+lwnmMaaP/8vvLgaGnvgL0xQK/GQRa4X5BSUNtaBDVAX5Nlfu1XL70b6a
 Id7K2XjkYY2OBPjWLv/Kn17yPO/FKQ8VWD1M7qVZDeeP18NpkycAoqzp3KKFtIi4duIDuZa
 k99g0rwplU2ylAk3xg6hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zV4iK8yvxQA=:7Bv9M84nlan6nC8ZVf8vzP
 aXztW8fTMT++TnPBcl7qUle3ptDAzn7xQp5rHhgDVO0jK+NfRCmFqBBcgKEkChchepqRcvl0d
 OM43ixiO/+T3GpRB+aZFHAXHru9O8MRWzDYpJ64CdpBZ5SLjINldpBLBWE+l/kYi8ZhBUdaLx
 8mKBnYP0AhVXVDV/UwrZTwGCWsooNRRozPmoORNkTr4/bcs9cMHYeq2M1IqF2a0aQl2XkIYVH
 vp82kAgz41GieCZFcC2QDkenTenjSVMwbkBIIM6eedXXNlHR/fYTLr5MaLWgtUB20C+XUwnJm
 spDQQvcGfPAxD094SzwYyooIYJwl73Upk7SF4ebvBuBVHT4ztKysNWjr+0tBZDTCSnoJ5j6fb
 nHC1F4eIJTuQUCW001SG16JmVHGMcEECaZ7eyqsJbsZQKUjGMAgyYE/+m+SmQxQo8JJA6N507
 xZ+wQZra+G8VRXWvj3JlKn9j5GLlqNmu/x+Km9Pwo6hhK16+vqJo//RbkNEp4MIDHNM4AKQ1q
 qt6HrejWPCXMhbX6bFa3LrQ5MEoDyzVnnZVckWJeX+QVCIofYHyxmGh4RHOlhels3uYd0NixT
 CbVyC6d5iG1Fu8hOjUoDuVdxRoN56CigHTrxicSbo/dQDryg5fjClUBfsmTOXhJL2as3MRt8X
 JiKnKw427ZnT9D/5yM6RTJnE924gOmZqkArgksv13PhCm+yMTM6Ax8LWTvYpxv/T3FrnuqqMg
 1wo6GqhhfScSiaP9KzgkuDn91Lp5rlCmz5C/afMMWAs9aooNQTuuIE120N9uyLrwInVSe7lZ9
 N384fUfFSx+lLatYzdSqo3eQcuXfkgmRdlGE8Ik5DY4fjkSHwK2+pp18jlHML8mOlTBcFKa
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Some 'qemu_vfio_*' trace events sizes are displayed using
decimal notation, other using hexadecimal notation:

  qemu_vfio_ram_block_added s 0xaaaaf2448d90 host 0xffff5bc00000 size 0x4000000
  qemu_vfio_dma_map s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 temporary 0 iova (nil)
  qemu_vfio_find_mapping s 0xaaaaf2448d90 host 0xffff5bc00000
  qemu_vfio_new_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 index 4 iova 0x114000
  qemu_vfio_do_mapping s 0xaaaaf2448d90 host 0xffff5bc00000 size 67108864 iova 0x114000

As it is hard to follow, unify using hexadecimal for all sizes:

  qemu_vfio_ram_block_added s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000
  qemu_vfio_dma_map s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 temporary 0 iova (nil)
  qemu_vfio_find_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000
  qemu_vfio_new_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 index 4 iova 0x114000
  qemu_vfio_do_mapping s 0xaaaaf1c60d90 host 0xffff2bc00000 size 0x4000000 iova 0x114000

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200820171006.1140228-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/trace-events | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/util/trace-events b/util/trace-events
index 0ce42822eba9..d9a0b4f8c63a 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -79,7 +79,7 @@ qemu_vfio_dma_reset_temporary(void *s) "s %p"
 qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
-qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size %zu index %d iova 0x%"PRIx64
-qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size %zu iova 0x%"PRIx64
-qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size %zu temporary %d iova %p"
+qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
+qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size 0x%zx iova 0x%"PRIx64
+qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
-- 
2.26.2


