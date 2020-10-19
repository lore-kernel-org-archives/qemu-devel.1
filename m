Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14381C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCBC22268
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCBC22268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUU3E-0005pI-4o
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kUU1i-0004ty-MQ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:12:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5183 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kUU1e-0004Ga-27
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:12:34 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 03535D6A9D4B611A07CD;
 Mon, 19 Oct 2020 20:12:12 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 20:12:02 +0800
Message-ID: <5F8D8292.5030302@huawei.com>
Date: Mon, 19 Oct 2020 20:12:02 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>
Subject: io: Don't use '#' flag of printf format
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 08:12:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: zhengchuan@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: AlexChen <alex.chen@huawei.com>
---
 io/channel-websock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 47a0e941d9..e94a1fcf99 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -746,7 +746,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE &&
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PING &&
             opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PONG) {
-            error_setg(errp, "unsupported opcode: %#04x; only binary, close, "
+            error_setg(errp, "unsupported opcode: 0x%04x; only binary, close, "
                        "ping, and pong websocket frames are supported", opcode);
             qio_channel_websock_write_close(
                 ioc, QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA ,
-- 
2.19.1

