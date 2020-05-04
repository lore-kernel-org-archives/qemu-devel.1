Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB5EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F09E206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 16:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F09E206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdbP-0001Zw-Cg
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 12:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdW0-0001Sd-NH; Mon, 04 May 2020 12:00:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVdVz-0005tc-O2; Mon, 04 May 2020 12:00:20 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MScHp-1jgwCr2R4L-00Ssf8; Mon, 04 May 2020 18:00:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 13/19] hw/i2c/pm_smbus: Remove dead assignment
Date: Mon,  4 May 2020 17:59:50 +0200
Message-Id: <20200504155956.380695-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504155956.380695-1-laurent@vivier.eu>
References: <20200504155956.380695-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IcV9362VkIZBpTgL0+Mugc2QoGskXIha9mZ+/XOQjriZYJzKTZr
 KXo0iV1TNpqa7CvEg1EEpjnJa1p7v+USa6SUuw/WH+ALG5Uywf3q8jSk3bOXHwi5Pc2XRAI
 7/kgREaBr2fE5loNgrBzU1d+6mHa57M57V4qu8GjJG+kQEPW0rHgxYi6mH9qfVS2ZpdeRYl
 hN2UdSE4D/vaoayjBWjYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pSVrhZIcdm4=:PiZDsZnNHMtOpHRBwhkzAB
 vGXoKZ4OLsiAfHmWW+bB/oIFdQKpZMhtdmt/RV87hef3uDXv48ZYDlB0zDHru2PU2cdVYCqHJ
 EQxk9wm1wtBzn+jJz3HFflDrqFnByFX5n4/mLBb7SvZxagFYUPhPaIVcc3nd+qU47uzK2OKGp
 Aw7uwsG0EOqLitfICDiOvcWyzphA3L/hjqL1k/zu9KLDBPBoNWst1sXFrZutTP6j4lPxy2UDb
 7+VeNybb6QQ8I71B0hLIGPAJADZl2U4X10vEAxW4txZiNtxvFqvwd35suLK2+CZ3S5jCy+AKc
 cib1aGb+gIMyfl/UHsrOXXQt1EOW8gRnNQrtMny6JZVIAkHX4CFe/YTYFfbFoeu21a2YltX+K
 8D7tPj4Lx5CmVk9ExD6LWtpVTi4nLTE8vHB/hMV1jXurezPmStwS82dOR0pcejEFARpR4uP0P
 qFzWtcq8XyhKWsInX06lk1Ftk05bPp1NdbzP4mBGb9fmfjpozUoX3UeZcbt6pKetMhG90HPO5
 CxcqvWqMdvApJ/iLWcMjTZeob4Qsdu+ZRHwg9V5oJX5P8eOn0objHkVI7f9OC0oG5/TM0/Jbm
 xnnFb4WrSsre6rIoJM9sHxRzZddjGuW3yj/Kg3uMpdqYOTA4zYO+q9PPu1rVe6d+CkwLJOehS
 k0ErdAuoOup6N7gLcIpJbR4psuNDfoEgkVohDahF2TeKISzLRkeqYMBZQnIM4ihiel9EimCeQ
 T5MA3Dx7pjMNsVprVkfuylB51FeTnj2WgtAugSuXBxKlXVl3W/9c6jqZPBKws55INzl3+mKSx
 9KXXWFRO8xlhCkJccjKD10TIG78YWJrd1hviYa5+a0bDlVJDIi1hklY8codY1jliRH3rX0F
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 12:00:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

    CC      hw/i2c/pm_smbus.o
  hw/i2c/pm_smbus.c:187:17: warning: Value stored to 'ret' is never read
                  ret = 0;
                  ^     ~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200422133152.16770-4-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i2c/pm_smbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 36994ff5857c..4728540c37e6 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -184,7 +184,6 @@ static void smb_transaction(PMSMBus *s)
                 s->smb_stat |= STS_HOST_BUSY | STS_BYTE_DONE;
                 s->smb_data[0] = s->smb_blkdata;
                 s->smb_index = 0;
-                ret = 0;
             }
             goto out;
         }
-- 
2.26.2


