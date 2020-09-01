Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C898C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E447B206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E447B206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Cg-00020R-W8
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zP-0005e5-GA; Tue, 01 Sep 2020 10:10:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zJ-0003q8-HW; Tue, 01 Sep 2020 10:10:23 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MdNTs-1kmRnl1vAu-00ZOSj; Tue, 01 Sep 2020 16:10:01 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/44] block/vmdk: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:16 +0200
Message-Id: <20200901140954.889743-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9wtfzMg5h42L8zLIZ5MY4d1StIUcSwuyoMS1KXY1qPL9bKgHQGG
 gcqTAG2jl9PCl4Mpscv2LUEL0i6o7f6BZY5Rggc4E8ibppLpuV4+C8JUqAXtsGdKrGRhfhj
 L8ghfwYhgNZrKY8Hx1GJf+MNNZg5vZINf9+Z7wyNuAnH3xMNorSDdz5KDf5RWqH+q0TRMQx
 6VAH8GdbXM0EQtmkz/RKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXSwrQqWkOQ=:yHcjmdYNlpacSrQivakCb3
 l5Qf7W9ACAeCuhz+HMkeqeEp5yanC8ON3NJPAzA6qK7T+J09/uoKd1fYdJ6HejeKxYkgZp8qE
 +Xx94VxW3HkmKIL2980elyRkDzmkLz+twpXNbm2W/hZ0MFL3k2qhAsVs162mto7XuOITG3vHz
 1uEmtFW+LZXBlKuliPbPiQjFPdonnIE+T+fNUP77sWJlwHgVbJykBga4DrI0lKKgZ+UNYe9r7
 AwOaSGU0vwHt1pX7hGjlY9p7pkYXgw36jzAmLGLczfwVI5M/2kuqSolT3nfpbNDXbX1O/N9gn
 OqGWaAjrszW/ly7ou4XFcp+7jY9ilVI+vvP4pBK9u3cxUvpKZ4fwqhnUs9uLvy5+F61ICJzvb
 /yzIyLRE8RDYM0CBfM+t1twM+RM9at+Ud/CEyCMiEDFhptkDsU3bNUW9XhtnTPLFmIDt65/N+
 ESBZLAXJ+7msJe3g6bmKrNBYPUCsco9V16ldu/pGftgSEUS8Uk8jChqKZkqhG6/Bbi2GQ1329
 pd/HZzOE62Q7gmZkjk8WJg1HA2h67xySQeQ66fZW9G7ysTJi+L9Z0elgKMK9eItdOcC8LaUbX
 AuyARP8EVKpkjEznq7oi7ujGjufE/vV1uj0HvKKn05Yj8pnqAukqYZHeOl9xvcEHiMm8UgNVC
 G7bIXwoc+dmZF+MAlaHyaeLfvXpBM/pixBR900Ml8G83aMNqDIWJ8h5qImlUDSaTnW7Bzi9wP
 B99jaCyA1xtoiMD5Pxew/1g9wD117zqwAoJDyHnIoLZ1XHIx3GJUkUM4SyN5X1+ypxpaJh83O
 FnYDp10aL4VOD9swMuafrmQY5Df+/TDoP0VFLRrP8/jBFAHXaRg1X6EAsdOsdS6QlMjGuEM
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:03
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1594631107-36574-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 block/vmdk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index bf9df5ce92ed..d90855446af4 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1053,14 +1053,11 @@ static int vmdk_open_sparse(BlockDriverState *bs, BdrvChild *file, int flags,
     switch (magic) {
         case VMDK3_MAGIC:
             return vmdk_open_vmfs_sparse(bs, file, flags, errp);
-            break;
         case VMDK4_MAGIC:
             return vmdk_open_vmdk4(bs, file, flags, options, errp);
-            break;
         default:
             error_setg(errp, "Image not in VMDK format");
             return -EINVAL;
-            break;
     }
 }
 
-- 
2.26.2


