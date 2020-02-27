Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3006C4BA3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A292B24699
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 12:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Tf3ZPhNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A292B24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7I7G-0008IQ-RV
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 07:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6F-00072f-HC
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anthony.perard@citrix.com>) id 1j7I6D-0001C2-C4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:07 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:64923)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anthony.perard@citrix.com>)
 id 1j7I6C-0001AF-PM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 07:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1582805825;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z+JBE/qWSO5nUyB0osbzoDZoZzb91YmZWMVffW9rbmA=;
 b=Tf3ZPhNqYRrHYz+8N3545JwqFkFun8UaaMP38TWlz2kgj2diSaBaaVox
 nvV0b0SEfubtz0cY8Yr0Q8jL2SOh7MPnMeMEeq6MpydfoUgsIpHYhFs/n
 yFRRF4wgte0CnXBmjOT2hHreCoejlq2VfgX+0M5vuU3eTkSv765kT2Ikw 8=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=anthony.perard@citrix.com;
 spf=Pass smtp.mailfrom=anthony.perard@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 anthony.perard@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 anthony.perard@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="anthony.perard@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="anthony.perard@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 6HDLwN2y+PFLSalCjceQp0430N+RKVAXGxKaBmeZ9eoxZik/rbVEZ3jbYVAkz+fxyYFxuH7mJZ
 5axX9fqv83Pp1JoqMFHGPO3ll6pQ4OVxa8nPO58rylEZPX0BQyn0/EJLr2ZR2EkmbY6QwarEz/
 KLYnACqCe5Cimcim4u9y3n/4IHCvbXjv3KXlV/6PmPZT8mrItsMFa5ppWG6Sr/uULI//N0NX9O
 QfWP6GQwGz2pl0Bcl39YEIjql8T4IS8SDj8r1605Dx9gydT5AKZprEBoI443HnXDQu2MwLIjq1
 zpg=
X-SBRS: 2.7
X-MesageID: 13277764
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,492,1574139600"; d="scan'208";a="13277764"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 3/3] Memory: Only call ramblock_ptr when needed in
 qemu_ram_writeback
Date: Thu, 27 Feb 2020 12:16:45 +0000
Message-ID: <20200227121645.2601280-4-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227121645.2601280-1-anthony.perard@citrix.com>
References: <20200227121645.2601280-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is possible that a ramblock doesn't have memory that QEMU can
access, this is the case with the Xen hypervisor.

In order to avoid to trigger an assert, only call ramblock_ptr() when
needed in qemu_ram_writeback(). This should fix migration of Xen
guests that was broken with bd108a44bc29 ("migration: ram: Switch to
ram block writeback").

Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20191219154323.325255-1-anthony.perard@citrix.com>
---
 exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index 231d6e564109..0cc500d53a23 100644
--- a/exec.c
+++ b/exec.c
@@ -2116,14 +2116,13 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
  */
 void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
 {
-    void *addr = ramblock_ptr(block, start);
-
     /* The requested range should fit in within the block range */
     g_assert((start + length) <= block->used_length);
 
 #ifdef CONFIG_LIBPMEM
     /* The lack of support for pmem should not block the sync */
     if (ramblock_is_pmem(block)) {
+        void *addr = ramblock_ptr(block, start);
         pmem_persist(addr, length);
         return;
     }
@@ -2134,6 +2133,7 @@ void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
          * specified as persistent (or is not one) - use the msync.
          * Less optimal but still achieves the same goal
          */
+        void *addr = ramblock_ptr(block, start);
         if (qemu_msync(addr, length, block->fd)) {
             warn_report("%s: failed to sync memory range: start: "
                     RAM_ADDR_FMT " length: " RAM_ADDR_FMT,
-- 
Anthony PERARD


