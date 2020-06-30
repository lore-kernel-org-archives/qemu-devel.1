Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61347C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E7320759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8htkF03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E7320759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq9L8-0007Hj-At
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 02:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jq9JP-0006I1-J7
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 02:00:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jq9JM-0000I4-Cu
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 02:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593496802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=w+H+FMV8Z5eikLECDxnhdARKkB1uGFMaBwUXXA8jiPs=;
 b=M8htkF03gmRM5EXEEG3ekfqcgqr1xEkuJLkI+IO8Gn7G0xSg6ojDmm9zc+2i7qJWllmEYD
 UkGED3UK6rAEKgBcc9jsvJE1LHpV0SLD50AL31wH+kyke20MTSTsFZAWCU9bhRadrKB5L5
 3Rm99lEl6VFvxjk6SoiKHNqyjrZUEhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-r_cGvIFhPriAu4IrOLbg5Q-1; Tue, 30 Jun 2020 02:00:00 -0400
X-MC-Unique: r_cGvIFhPriAu4IrOLbg5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BA981005512;
 Tue, 30 Jun 2020 05:59:59 +0000 (UTC)
Received: from thuth.com (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FEC85D9CC;
 Tue, 30 Jun 2020 05:59:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] disas/sh4: Add missing fallthrough annotations
Date: Tue, 30 Jun 2020 07:59:53 +0200
Message-Id: <20200630055953.9309-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add fallthrough annotations to be able to compile the code without
warnings with -Wimplicit-fallthrough. Looking at the code, it seems
like the fallthrough is indeed intended here, so the comments should
be appropriate.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: The new lines use TABs since all the surounding code uses TABs, too.
 Please ignore the checkpatch warnings.

 disas/sh4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disas/sh4.c b/disas/sh4.c
index 55ef865a36..dcdbdf26d8 100644
--- a/disas/sh4.c
+++ b/disas/sh4.c
@@ -1963,6 +1963,7 @@ print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 		  fprintf_fn (stream, "xd%d", rn & ~1);
 		  break;
 		}
+	      /* fallthrough */
 	    case D_REG_N:
 	      fprintf_fn (stream, "dr%d", rn);
 	      break;
@@ -1972,6 +1973,7 @@ print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 		  fprintf_fn (stream, "xd%d", rm & ~1);
 		  break;
 		}
+	      /* fallthrough */
 	    case D_REG_M:
 	      fprintf_fn (stream, "dr%d", rm);
 	      break;
-- 
2.18.1


