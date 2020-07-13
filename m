Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195BBC433FB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AA9207F9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7/YQavO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AA9207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwEl-0001I0-6I
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7l-0000ED-Dd
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7j-0003xl-MZ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=/7EduRkP+yVD/+i4K7RshcaxB25w1vJnUfxhro97LSM=;
 b=X7/YQavOtlcVJQJEC6WzkR5a8ewdnXXsbRerTWzMooYrMOeJcRzCS+bl09JlLki511iaOp
 Ih8ElON965OpHkcHpypobch/w2Tjl/qdaseXw+xcdtLn9+/FeBawx/ZSqkjS75CTgooYyg
 gT3pMug6z38xl7DvocItz1ZQyuFrOes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-VBo5UQlJNQ-K9WSBY0In5g-1; Mon, 13 Jul 2020 06:55:47 -0400
X-MC-Unique: VBo5UQlJNQ-K9WSBY0In5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C116480183C;
 Mon, 13 Jul 2020 10:55:46 +0000 (UTC)
Received: from thuth.com (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E82B327CCC;
 Mon, 13 Jul 2020 10:55:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 7/9] disas/sh4: Add missing fallthrough annotations
Date: Mon, 13 Jul 2020 12:55:32 +0200
Message-Id: <20200713105534.10872-8-thuth@redhat.com>
In-Reply-To: <20200713105534.10872-1-thuth@redhat.com>
References: <20200713105534.10872-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add fallthrough annotations to be able to compile the code without
warnings with -Wimplicit-fallthrough. Looking at the code, it seems
like the fallthrough is indeed intended here, so the comments should
be appropriate.

Message-Id: <20200630055953.9309-1-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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


