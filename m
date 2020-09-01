Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B26C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206B8207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206B8207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6z1-0004Jt-9T
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6xO-0002aV-HV; Tue, 01 Sep 2020 10:08:18 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6xJ-0003KL-6P; Tue, 01 Sep 2020 10:08:18 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mwwhx-1kWhB60b9P-00yN0Y; Tue, 01 Sep 2020 16:08:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/44] hw/register: Document register_init_block @memory_size
Date: Tue,  1 Sep 2020 16:07:20 +0200
Message-Id: <20200901140803.888852-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140803.888852-1-laurent@vivier.eu>
References: <20200901140803.888852-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8bPLAURVEaw24uNIxjnDnEMeRGpp+71eXkutyufMLXcBTz61pZD
 Zsupbjl+GyhN5taXWYddh3xmOxCZiHGlvixPO3J9hc6H5trWMm8/gF7RCJ8EaOUhI5uGRhu
 Nf8Kpv5uQWBIM/QidHGtsoOkbvJvr6F3jrn9T8bG+wPpLwzD8hlgD8fyYFJYqTzJW53slV4
 ZrQ7u5rwaFMkkQzi+mhWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6yH3oOnANKo=:QYcnEQLvzXxnPS4jyuek2y
 eit0oOs+cqrbApyqIrTHrsGdIwW9degKpQ/s+b9g6ASMeuBZPC0RTTw6U2M0REakn1O7ebmhT
 ePX0ON+e3CVAa/80XHq3doSSO9c2jHI8N0T10XMgS8QGfyPThQACO5L7A5sUOqEBEmqlH52Ut
 7URYzS234ZRaC8ogeXnPGzJO8RNjZ5nEI3IXu0IajH3b1ovrzpQB+HirpfhplvQ1LIpwrgyQH
 KQE7FB2loYsPk4g5PIdXx7Z8utGHoxW4VLa9WcDZaRw0PSj2P+rIfQpxqxVwgauk52c2RF8B+
 72LszN6HC2nsQ/NMLPOxbxqFtA4v9hvULGqOe+Px6b5WEjQFEqZ5i78i2j2DTCzDOehB3bMqp
 sevuvt3uoAqlSj0JOYZ6It+4m1sx1TUuPfG6+mQdUvI0TmQHyV5mTGp8FV3Ed90O5yK9UspFl
 OcCy4IQPBc2pUsK/5MOnv6uXVi9sSeV7mvIF8jU10sc6m6wBPAl8b+c0o7SPV5nhFO5W8Jz9+
 GZml2w9sCNwqVNu+m9sZGTGGMjUTcluhCbr1BbgHMM69U8PBfm1gfdaDUPpY2qmRsF87pmkJr
 5FyI72mOq/nXOilU4fKdxvyvYgEak4DQUL5wGlT/ZBhElDhyljZpBGXlwda/c93koDebyyukL
 eALGtbcSt5zljWAoDEK4N0g1ogHpaTuztw5UQ9bcnVfoJ/MvOAFByxUR9lKcArGtV/Og4t3na
 QJ1ZDWQLwAeBiZuTRMpgropAI6lFkKsn+PE6LRqmIw5flFGv1ZgbWPl7jr8bUCQU0yoSyGxQS
 NRPljbG1vStKFwQEtpX4jwTCUm1FHYrsbX3sn0xXwppMYXjkdIyhdRPE6ishhsMS2C73Gpo
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:08:11
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Document the 'memory_size' argument of register_init_block().

Fixes: a74229597e ("register: Add block initialise helper")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200707062308.4531-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/register.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/register.h b/include/hw/register.h
index 5d2c565ae02e..fdac5e69b545 100644
--- a/include/hw/register.h
+++ b/include/hw/register.h
@@ -181,6 +181,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
  * @data: Array to use for register data, must already be allocated
  * @ops: Memory region ops to access registers.
  * @debug enabled: turn on/off verbose debug information
+ * @memory_size: Size of the memory region
  * returns: A structure containing all of the registers and an initialized
  *          memory region (r_array->mem) the caller should add to a container.
  */
-- 
2.26.2


