Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4250CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2462080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2462080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIwS-0008Sn-N8
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpl-0007Em-K9; Tue, 13 Oct 2020 07:51:13 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpj-0004yq-OP; Tue, 13 Oct 2020 07:51:13 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MYe6H-1kxStr1AHr-00VhdU; Tue, 13 Oct 2020 13:51:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] target/sparc/int32_helper: Remove duplicated 'Tag
 Overflow' entry
Date: Tue, 13 Oct 2020 13:50:50 +0200
Message-Id: <20201013115052.133355-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nCNc9T18Be/d8Qh5C3QrpTMVnQZPU+9VitGm2C64Prae8UVty5r
 1GM5RBumt5mlrX0Q1g+VQVcU4wAvdy+lYsUoIRR30PTmdlNPJouL4wN/o2ZEglCgzx5UhQp
 c4BNFlSfWaAeUwG4pE878ZiMVRbENB91iIL+DBNDkTA0I29APF5oe/ww579qZYzPr+GHu7N
 zut0fuXyYOmn5ooRoDhgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rGXvPaVQ8hI=:4xwJj5mpYOQIZESBxcXy7M
 Ix9XO+Ysg06c8qgjReihx68hlYUj8B9RhXVpIoENJuR2ipHi8PEpeq3L1ltog9aL87brvlKXs
 oT9ybv0debaSYMr5Di8pzzuexyx+YGQ5yq0Qhm3kHNMeVlo4c35nztARGIadhudL3r4v9TYt9
 CzXCGmbCKLfHQnW+AjA2w1ORWxDhyrfWFNgIG830RZKbJD5dONbfddh3VLuA7y+PNYNRhY0sl
 TeTyBLSkf5QIP5kTwPiSvdHyOpiCAad+O8VAxoxWpDQNaQOXydbboIOgNbjN/A1pStXiw8dUZ
 MWR4K4ZO5eTh4f1J57Osq+v0G5oAee1LmLSZqr3A5/mpBZdmNniFRqiF/Z9bcrHf6AVJdhCUf
 1BhIQ6wtoR/6VYgkgJfnczadVSoC0lsNHQ6MmdQmh6QrtDl3RHr41f48x/FnLbQOjndkAy97w
 yHxajkqnnYFnmX8v3v74kn7ZyGBaAXaQ0ZYDh02j1+iYGk7/olkw2mSuxM9u3S+VdLPSEWI4G
 iHYDJX9QY+9sY+QnirNmIN34BDJXi89w602P9vOKcP32OPiizrvLUuYBlB74vr6jzWzUD8gQX
 emePB102gcZJ2u//IlwgRJppaFifxdCwVN8gp4SnsQTpCjZnfAxzimP2lsMxhLZi+gsTVeJzb
 T544QbAgb7SKEskLdlcjnuW5OqD6UiU24IeFZKj20VDViq24jw1SzC7wltxBFwN9xv/X0cgQF
 bnFHqDhPNK+p4oqcFTSemDZt64JecQp1UwuXgZHyAG3b7JZuN5518hxaM4a8U2EpltOc3SO96
 MZ2EGOWyvqM2pBdjRtcv2TCnSNOuCI6PhYSPXA9weUTEPSqLsFcVlJPL3N1vSDJGFqrnDvA
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Commit 0b09be2b2f ("Nicer debug output for exceptions") added
twice the same "Tag Overflow" entry, remove the extra one.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20201011200112.3222822-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/int32_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 9a71e1abd871..ba63c739c1e8 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -50,7 +50,6 @@ static const char * const excp_names[0x80] = {
     [TT_EXTINT | 0xd] = "External Interrupt 13",
     [TT_EXTINT | 0xe] = "External Interrupt 14",
     [TT_EXTINT | 0xf] = "External Interrupt 15",
-    [TT_TOVF] = "Tag Overflow",
     [TT_CODE_ACCESS] = "Instruction Access Error",
     [TT_DATA_ACCESS] = "Data Access Error",
     [TT_DIV_ZERO] = "Division By Zero",
-- 
2.26.2


