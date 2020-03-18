Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C064C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141CD2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="folj5WzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141CD2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZSE-0005E6-5l
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ba76a85cd226b30e4b708c0663445bf3645aaa53@lizzy.crudebyte.com>)
 id 1jEZRg-0004nK-Qj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ba76a85cd226b30e4b708c0663445bf3645aaa53@lizzy.crudebyte.com>)
 id 1jEZRf-0006E9-OC
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:13:20 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:40767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <ba76a85cd226b30e4b708c0663445bf3645aaa53@lizzy.crudebyte.com>)
 id 1jEZRf-0004bj-Dq
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=m8PmIs2GUKKjHSr9p6uGHqDjFSuexFNE+11I41l1T0w=; b=folj5
 WzUib7OHs1dtri87GgeVMfJvMKUMIy6u5i5eKyCXswkP7kdq9H1U4k2z3/NoP37KEwnPi0YuhdG0J
 e7J1Ix68mNCMYUYfMqL3Rk5SSq41jn/1EkRJS+u4vcjX/jSWwjqPy7L7N52iQRelrAVsNMyfG3AwB
 zHw5sPDESRR0JKVoYAGVmAI37uoNHtnHrtnnwGm1Uky4XMAe8ssy8altpFlWzarZqyLZijycac9/g
 DpmMo1DDH31CzeLoXiNxQjb9B7pX8EJ61G+fs35sRlwlraqB9xh2rDERBjPzu5hnz4J5J8m8Ufg3a
 L/dD9GOIZ8ctOmMyl9KkdSvqVE1Mw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 18 Mar 2020 14:33:44 +0100
Subject: [PATCH] MAINTAINERS: Upgrade myself as 9pfs co-maintainer
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1jEYz4-0004pt-Cs@lizzy.crudebyte.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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

As suggested by Greg, let's upgrade myself as co-maintainer of 9pfs.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7364af0d8b..8d9cd04ab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1630,7 +1630,7 @@ F: include/hw/virtio/
 
 virtio-9p
 M: Greg Kurz <groug@kaod.org>
-R: Christian Schoenebeck <qemu_oss@crudebyte.com>
+M: Christian Schoenebeck <qemu_oss@crudebyte.com>
 S: Odd Fixes
 F: hw/9pfs/
 X: hw/9pfs/xen-9p*
-- 
2.20.1


