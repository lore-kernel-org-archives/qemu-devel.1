Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDBAC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5056D207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5056D207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD70I-0007qu-C5
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6z8-0004wJ-Uh; Tue, 01 Sep 2020 10:10:06 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:47137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6z7-0003iU-2X; Tue, 01 Sep 2020 10:10:06 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MxDgm-1kWyHV1E6q-00xeVR; Tue, 01 Sep 2020 16:09:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/44] hw/register: Document register_init_block @memory_size
Date: Tue,  1 Sep 2020 16:09:11 +0200
Message-Id: <20200901140954.889743-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AtQWgzq0ULfuYw8lMJO5JadrGF34UW+j2cK9bu/8HqhC3eM58Gk
 5pcnO+cF7UjlhF9ze424xMSNZP+QogMBEPfTCYDtvwIFe6GuehGTcAAwZMQPh65bDqI8WBm
 U51OQnJMnR/+M+VHXMTbCvZCrK2pYpq+gGp0dE3F4gP0WC/TuNhgWL1UWoAZ5HAJe7yPyQG
 ObRSj9A257fVGfN5kLTJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nudx0/aGK1M=:Krqh1IHc0oKBDF0jryp0dH
 BJ3tJGqwpzZXapQbf4uzPKN62LkZzHecrVFqBh46hg/x71M+5tbDF8CtauLZ3wrny1cU3G0kB
 RCUdKRnz0Kc45KNf8kcyXxrqUp7rH5u22zTXxt6nNW/3iG9xCM8KWEzVldw/8MzY8gxm0zVh6
 Cbc8T09pm2coNffUnBQQotQiuI3IyPMjw6+6x75JytMmww4uP01ZKwh/EolrDTs2hn3hMAN7t
 T1IhAKqQbJFZkRdGOQ+YJKxAH4tpeN86QW+g0/6l/Jg8A9uWLBPlSpCVSbIl8R7t5xbrTbceh
 GcDHpsZQVPMTqIyOTFUlVDW3+YGolB4BCYEiy77BMkt+8y50UY9LEUqUgkXbqcdPBBnTkP4QB
 CAYHpTQt9EIepEbGr0vhS1gYzVvN83YtLrYSqrv7twLalDo48BjQd/oxoxyBaRkzfYvImI+Wb
 HIVwldW3JjWeAXMeo8LNC4+FiNr18vpyDDsQVmyn2+EOmagIHeDRiOgMMSUtaPwF6tPRN8zIl
 R0G55pIa6XFU7PWTlk16ynbqGZkHSU2menokAfbHkWN+sv7cIOjbH6Ptij9aJlZx0pvs/oSqG
 UGX4iMOC3IXjP9af6yzHyqHwVT+30kTyBEFPB9EcWmtmeSSnyL3RqTEVpMx+plY+ZrGWoSknz
 QlvXvFpzWG19EbQdbfK79DrAZh9wsbzzBKpSfhiLaRHFgA7a9PaHNVU02PUup0ZmhpNcBvXb3
 qXcoetKJDplZBgO6c1cPRl+PSRH3mkyvU5kB8XsRpuRQKEsdI5TwYwSsyiNNBBXRi0QyA/gn2
 5Bea1WQY6X+Mux2IO1t25Afhsciu9QC0a1aEra3ZmNroazOWTpS7qycsX8k0laPtbF/XrLU
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


