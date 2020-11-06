Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8825E208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="OZ1LAp7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8825E208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayGS-0003CX-I7
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22e13675874dabcb314de98134fe6142cd9864a7@lizzy.crudebyte.com>)
 id 1kayCU-0006h2-RI
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:30 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:35461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <22e13675874dabcb314de98134fe6142cd9864a7@lizzy.crudebyte.com>)
 id 1kayCT-0007GK-AM
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=kE1Rd2lNhe5C4t2nRY+ov+TdCYGfSEXqermgTf+ZyXo=; b=OZ1LA
 p7wIrEQ/FaBvd24ilZddJ8vogTrHHTEcX2fzr9Z8lrNYe/hWat5PzF1DApVa81SKW9581ed7BV4SA
 GQoixpSrLOgQspaUXYz6GrFEuIiQgXGayz20uJJGsNQ+sv9S17e+otvhTXg2F/fyFEq8WjclMbYEq
 7JbfI2BCyy/zZ/OtNrkvRNv5lrOdtwAACsNwU3lPX7c80GhheDzcwts/qDBx1PAwG9yIxtwNXxeUf
 CDMvq3bo8iwZBlNbe4mHuDgL7I0ROvpUEUL7Wo1Oc8xp9gdjOo2KhHbg0Z1MgohvDwaBdvfu06DkP
 avbCf0BGW9lBi8uspDzJHxQfqQskw==;
Message-Id: <22e13675874dabcb314de98134fe6142cd9864a7.1604653990.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604653990.git.qemu_oss@crudebyte.com>
References: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 06 Nov 2020 10:13:10 +0100
Subject: [PULL 3/4] hw/9pfs : add space before the open parenthesis '('
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Xinhao Zhang <zhangxinhao1@huawei.com>,
 Kai Deng <dengkai1@huawei.com>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=22e13675874dabcb314de98134fe6142cd9864a7@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:36:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xinhao Zhang <zhangxinhao1@huawei.com>

Fix code style. Space required before the open parenthesis '('.

Signed-off-by: Xinhao Zhang <zhangxinhao1@huawei.com>
Signed-off-by: Kai Deng <dengkai1@huawei.com>
Reported-by: Euler Robot <euler.robot@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20201030043515.1030223-3-zhangxinhao1@huawei.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/cofs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index 55991916ec..0b321b456e 100644
--- a/hw/9pfs/cofs.c
+++ b/hw/9pfs/cofs.c
@@ -23,7 +23,7 @@ static ssize_t __readlink(V9fsState *s, V9fsPath *path, V9fsString *buf)
     ssize_t len, maxlen = PATH_MAX;
 
     buf->data = g_malloc(PATH_MAX);
-    for(;;) {
+    for (;;) {
         len = s->ops->readlink(&s->ctx, path, buf->data, maxlen);
         if (len < 0) {
             g_free(buf->data);
-- 
2.20.1


