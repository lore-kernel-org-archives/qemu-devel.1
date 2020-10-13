Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD23AC43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E5F2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIvQ-0007Bg-B0
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIph-00075W-QX; Tue, 13 Oct 2020 07:51:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:53417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpf-0004xz-PO; Tue, 13 Oct 2020 07:51:09 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W4y-1kQbzE1ZhC-016xCP; Tue, 13 Oct 2020 13:50:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] hw/block/nvme: Simplify timestamp sum
Date: Tue, 13 Oct 2020 13:50:41 +0200
Message-Id: <20201013115052.133355-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/ee+PThk7XogI9GHj1Wg2rfny9f8gwTp3lAHF4xjlhyMTJpfemN
 j7RnUX8wJOWQBKfI6a+YJxSCIq6Z4GpS3A+7boOVVo2orHdS3caJhsI8bFaeQfvEwLJcAxn
 /jp4X6SpqlpPuGhberN2Y5Wkmuwm2z7EJb4cr1o7Ycgtr7LTBbYyjWxDtkD3xbx3qVVx9/o
 iZrwOAHej9cl80LuVDqNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/GdTjfWZIek=:tysByNhNiZh1Lp9V7EyKdO
 6ZLHp0VbEUbmC3ezkNKmyACGlFXlcW2urULxmyh55uHj6h2CUitYakekbwkeFcCaFMbIJPJUD
 my0J0/h6xICzGRmyflv9k6CMSGTopNNaA8mOB9yb5TFNpIdEo5LydPp+66RFNjRmeOG61xHPF
 2tvQ+ilra80FRBIgxzRpIiShWaMMgpPZ5gN8UI4PqbU6kqmJZgg81LvOIvc6SZDpWfr9pOQUr
 Rxa2/vpSsJral6XkgrxUh4DUrFdPmrsj3CNYMt6R5NFizwSj1ABZyoTu26IIYNb8iB9bdliKl
 cabWdJxNqMsIX1mNrcgpjoCUJxJGti4UgG6k6AwXbOHBYBlx211mDmgsU3yGx0BNFGPT1uSDu
 So6NZQlE0OGOPRigXKkCeD0E0OJMQv3PiTs4/uLnUT1/4UWvIh6Xq4GpuZR5z810xDRH3fl4x
 pbbR8dMuWBzP+xjP63Da9AXoHxwLPKKILSOCvoXUfsEq+IeUUD+DdzFqeR8fgQImfocnzMEBk
 e373K219ArtjZF6ConQLE+PlBl1Etywc6etM9QhNih+1ea9PfESzVizFkeqlUOGNEFGZ0nhnA
 lEd1opbWcxxk4y4IX/aiiPyGYKdItPsY7cQjdSrLovNz+hI/ng3bGt849GTeVggKJoawBnKGj
 0ntemync2YvzP2hfw/H8O3Hrl5awV7ZvGIjSRKPIF9kGecKW4xVd8lQRvjvJbXSxARbgsbyMw
 iMgvYjbrzDl7VRQtmLZq65vRbBCfzewrbAZhiPhbcUGqUhoyoSIaXYFvDOlqhvq4dcy030yOk
 F/fNo69+FYJX+PkWk8t/iuvdovJHUFsT4ZZFS3yl5rUCK13Zu+QZMOMwyEOVEIxgqsYOyXQ
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:40:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Klaus Jensen <k.jensen@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As the 'timestamp' variable is declared as a 48-bit bitfield,
we do not need to wrap the sum result.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20201002075716.1657849-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/block/nvme.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 63078f600920..44fa5b90769b 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1280,12 +1280,7 @@ static inline uint64_t nvme_get_timestamp(const NvmeCtrl *n)
 
     union nvme_timestamp ts;
     ts.all = 0;
-
-    /*
-     * If the sum of the Timestamp value set by the host and the elapsed
-     * time exceeds 2^48, the value returned should be reduced modulo 2^48.
-     */
-    ts.timestamp = (n->host_timestamp + elapsed_time) & 0xffffffffffff;
+    ts.timestamp = n->host_timestamp + elapsed_time;
 
     /* If the host timestamp is non-zero, set the timestamp origin */
     ts.origin = n->host_timestamp ? 0x01 : 0x00;
-- 
2.26.2


