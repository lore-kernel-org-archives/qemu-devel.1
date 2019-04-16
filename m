Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E806AC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC9F320868
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4f+R1n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9F320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGNk7-0000KR-UT
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:03:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNf2-0004Vf-II
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGNez-00016M-1k
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:58:02 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGNev-00012p-9x
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:57:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so26959475wrq.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 05:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=6cCVRnIqDr1YlxNV4JvcQbdEHcgddBmMkialjOjujLk=;
	b=c4f+R1n+jjnEslMRaVeRaR6ItZ5Mw1u+NmUqBlFdCRt0wh83Y76IWliCl2MB5evha/
	VdLNuhgxNjWwmmlkSA3m5/B/I/4d9yJz1NxhNHjOhIxOkC2EaPInzU+TrXG/O34GlqfM
	ZmxEJhCi94tuUOGnsZIQZJlZ1Pn4v3PvIoyzXDJDepjoRQ9vD+2Ua5OLQW4yTPBPwz7o
	dppuCApRJ6d+8kybhp004Z1gJ+037lSjr9XpmUXakMzbBhwNWEzA2R+dWtMe6TAhVq/6
	MBCCp6gnRZ64THuI4ZT0wswx8szE3/HrpuX8Nw2L0nZq3G8msGk2bucTUAGjcbeBT7Wp
	GESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=6cCVRnIqDr1YlxNV4JvcQbdEHcgddBmMkialjOjujLk=;
	b=meQZJ2jB1NhzNycOBYkI1FrLs2hSxptiob176sz+4dsTZO7zm2Jcg3JhXZ/U7Wcklx
	Qk1adRpSyI1BNl6k+3ahBLOgFBD3PZRZ65lqd4hY24eKWod8jvoKjyp60fN4ds0/nQ+W
	vt62IkKPdlcGrK7k9cCtxaOqSGRtUQyF8ySQfJU9fRaGd0nW051D+gey61ip0+CgjPZr
	4ykzhK/imP6Ff3/UU/sE34JJfQQ7badkTcVNL3FR0IINwMHnMRnavsB5KnI1jRyVPOZj
	X/O/i271Cpo0avaN3EiZp+1GvmLMEqDQqii3HqXT3njIomv/egjx3LoWY6o8gemCeI/w
	hp+w==
X-Gm-Message-State: APjAAAXzdDU1kafTCVuzBjMNX5L2j4UOB0gTrUO9sjK9iWWOLWaujBVR
	fM+Za4aDWv3NvTjha/sycTxXWQ==
X-Google-Smtp-Source: APXvYqxCheZt7DalEk/3eS6/S984Feaz4yZqP3+I7clWmS1jeCRDFgKgatHvtt6l97CZTdxlrxHq2Q==
X-Received: by 2002:adf:b6a4:: with SMTP id j36mr50713225wre.55.1555419475203; 
	Tue, 16 Apr 2019 05:57:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	v184sm39476572wma.6.2019.04.16.05.57.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 05:57:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 13:57:22 +0100
Message-Id: <20190416125744.27770-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125744.27770-1-peter.maydell@linaro.org>
References: <20190416125744.27770-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 04/26] target/arm: Disable most VFP sysregs for
 M-profile
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416125722.op8geYS2EfsqOpnGSj_CDggV6BcHbJAu5WHo6xqQ9io@z>

The only "system register" that M-profile floating point exposes
via the VMRS/VMRS instructions is FPSCR, and it does not have
the odd special case for rd==15. Add a check to ensure we only
expose FPSCR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d408e4d7ef4..d56488ec847 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3512,12 +3512,27 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 }
             } else { /* !dp */
+                bool is_sysreg;
+
                 if ((insn & 0x6f) != 0x00)
                     return 1;
                 rn = VFP_SREG_N(insn);
+
+                is_sysreg = extract32(insn, 21, 1);
+
+                if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                    /*
+                     * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
+                     * Writes to R15 are UNPREDICTABLE; we choose to undef.
+                     */
+                    if (is_sysreg && (rd == 15 || (rn >> 1) != ARM_VFP_FPSCR)) {
+                        return 1;
+                    }
+                }
+
                 if (insn & ARM_CP_RW_BIT) {
                     /* vfp->arm */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         /* system register */
                         rn >>= 1;
 
@@ -3584,7 +3599,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 } else {
                     /* arm->vfp */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         rn >>= 1;
                         /* system register */
                         switch (rn) {
-- 
2.20.1


