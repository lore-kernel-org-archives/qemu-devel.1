Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B44AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61062078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61062078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEFP-0001jH-KA
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBZ-0004w9-6O; Tue, 13 Oct 2020 02:53:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBX-0000EC-Db; Tue, 13 Oct 2020 02:53:24 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTRIi-1ktg8I0xUy-00Tjrr; Tue, 13 Oct 2020 08:53:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] target/i386/cpu: Update comment that mentions Texinfo
Date: Tue, 13 Oct 2020 08:53:00 +0200
Message-Id: <20201013065313.7349-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aOPdbd0/QNgignjlMKnrrE/N+IJOP3L7RsemEXgjbAaHm7hplkd
 gFTBnhMYeE6z6NvRQf6o+gcTaUFxPO9Y99Grb9qIUVRSQdoODs3J6wRUWgwyemD8aTukME9
 yz779Yf287RgXpxcqGR23dwBV0kwTP6SU+znz52fzaBy1Jin02h7w5FIGMWrBqKzh8hr36f
 Jx9cINej1mxTFE8zNBePA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oX8jXPjBIdw=:LaIysuB9PRisQlZUiKUHq3
 6LDYHKyKLzuV6bB3h4gZqJ9RrHAutOvGEhDWBrDQHcnLbIw4GCVNgMlHfAP3bgFd0odfvcR0z
 AZra7nasaPijSs3DYESqmvsb4/vDElZAvaXibsXFPjz5tE8UAYXOv6qKwS+LyJ6TLJAwy/pYg
 VpepBOZqf7S1wWG4d3hlhr4FUWbl0gMPPKvvB1JsfUkKpYwl6f1MHbiISl14mAMxlTFDNWPHf
 RdPwyiXVi71zJzVHNL+tyBlnys09BLCRBO2tqtN1RHHbepHGtjAtLYbgo0Gnzr/HLC/Ww6rYy
 ruZ20rPH6Bft91gWsqXGkarEH4ZuafR8WOw9nic+tjn8uMiZT49FLpzF1DtKFoSMV2eE9Kq5R
 xmbTcqwR0GFyBMIRsrB+/aomsZxC38mezVJsF3mUs+oqK6RkDxBlQUGoiAUL4yVr69D7ivuA4
 FZLBi26bLpzDlu2aPZ2W5eq4yBstv+LwVFcomLDLIZ3o7RrSMsOpmQ5zColBWhLTntf4/Esqr
 zPcoN9vMUVnpdXQeiwDgueKTjRr6AjP9dloVYIxDZIczqukqhxcVzBwk8tA6PSXQvmOpS3g3c
 0P8S+/OApP81QvOmT5ysbWjiXIIc5FUiU5iCC3LYeTO6ZimiW8pOBEFbcOPWLUkJ93V6ynnMe
 c2VIVhgli5cORzUKJ7UxO7hclvTdCxRPMjSSJomZUoMhua5Hvhcain8aMepsGtFc5SeingnyB
 DZCbljwB5kIikTFbZ3ENxSQwERFNuWxycKdZwsOyPcrbgS4YLo4cfY3+gjhe4sFqvOo74+NZR
 fQKSD3+nhszIF/IRcFCR/MZCFrm3Jl19zgwPbvb7ZXMgp5JGh2ajQhQjPc04pQ58QPsBRU4
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:21
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Missed in commit 41fba1618b "docs/system: convert the documentation of
deprecated features to rST."

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200929075824.1517969-3-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f37eb7b675f4..9eafbe369075 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4127,7 +4127,8 @@ static PropValue tcg_default_props[] = {
  * We resolve CPU model aliases using -v1 when using "-machine
  * none", but this is just for compatibility while libvirt isn't
  * adapted to resolve CPU model versions before creating VMs.
- * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi.
+ * See "Runnability guarantee of CPU models" at
+ * docs/system/deprecated.rst.
  */
 X86CPUVersion default_cpu_version = 1;
 
-- 
2.26.2


