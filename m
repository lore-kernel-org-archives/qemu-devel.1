Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04038C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8A321738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6bNfKSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8A321738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRV1-0007Jb-TN
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:15:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQa-000496-7n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbi.octave@gmail.com>) id 1hCRQY-0001w6-7E
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jbi.octave@gmail.com>)
	id 1hCRPh-0000Qi-Gn
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:10:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id c1so7278535wml.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=xU4rClmRxANuS82pRHz2FhS/7yD8MFysCaxJiWoZkTY=;
	b=Q6bNfKSrOfvyky+1w3dxC4cqLfss1prtbBRelI/LVjuSQGhVvgGRXmlR1SqOxqLVEp
	/vmNsDpY9+fdOu/BoDjRVGjZomQR5OIKP3iW/0AU4fZH1aPRtl9zD4LJRy8EkTP8Us4h
	spnHPczt43tmFXzzzt8YOj3utdWLytMz58R4+NyRzJjBShnS6NBDUO1GfRpMaPn1WoHA
	7zIZka6gVLUwcJp3QmBwvUw3/ZtnFZ5PKCIjqIcHcHIh0DEUIplrG0StsipkBjjSXQ5x
	IDDitbTfV8VLSh2Dq9pJOrWiaSIUg9lsjzkwWsfQb43nNc0bJo86YxicmJQhgpx+OPS9
	ljZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xU4rClmRxANuS82pRHz2FhS/7yD8MFysCaxJiWoZkTY=;
	b=tnWnvVxz7THUuPlFiwEK6hwFO9qgQDSx+dT/8T6MuRIezm8dT5ul7Yc4yGiFZPHc1U
	gztJS/UtuqJ9vvbdogUY8IfYK5Vm8k1TRBOnQzxKTwYPnhD4iOhRud7GZHIZcsBtdAze
	BmJiT+kLcsg5jfZgHzcFSGjLrzIk9zpfJn2NHfuQb0D9/MKZYXGKXLI2kAo0wp2+UeBs
	WogyKbptgCrhIaWIR9+yV0Qp1q38pMHHhNaM4m2SY0T6jYq6vKgCW7xar5mU9HwD0UVA
	KZC8Eg+ByoJI7I8mGH6Y4KJlhXt+HZEbWd6qSe4GRGbWixkPhztx+2PhwImdwIwv7M4E
	uAnw==
X-Gm-Message-State: APjAAAXcjR1aG7ktRSfYyuSfHpzfWtfQzoJWIAzfzpy/31fwxhIG9nLI
	PsxIaHuaMa3s6vkDkALesQ==
X-Google-Smtp-Source: APXvYqx3DUb1apvVEVutBq0FrmKWegRyOUiWGJk6ypa3bjpC1vu4QLj8R8vunQQHIWi2FW5aQ76lTQ==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr9123568wmh.0.1554480595285;
	Fri, 05 Apr 2019 09:09:55 -0700 (PDT)
Received: from ninjatsu.lan (host-2-103-80-5.as13285.net. [2.103.80.5])
	by smtp.gmail.com with ESMTPSA id
	z10sm2966029wmi.15.2019.04.05.09.09.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 09:09:54 -0700 (PDT)
From: Jules Irenge <jbi.octave@gmail.com>
To: amarkovic@wavecomp.com
Date: Fri,  5 Apr 2019 17:09:38 +0100
Message-Id: <20190405160938.27494-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190405160938.27494-1-jbi.octave@gmail.com>
References: <20190405160938.27494-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 4/4] target/mips: replace tab code indent
 with spaces to fix checkpatch errors
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
Cc: arikalo@wavecomp.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405160938.jWbL0oZ8MvEx1aDZAJtz_rnY3Nu9wlD_D0diTDgVmDI@z>

Replace tab code indent with spaces to fix errors issued by checkpatch.pl tool
"ERROR: code indent should never use tabs"
within "target/mips/cpu.h" file.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 target/mips/cpu.h | 138 +++++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index e2f421359a..03ebdba90f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -109,25 +109,25 @@ struct CPUMIPSFPUContext {
 typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
 struct CPUMIPSMVPContext {
     int32_t CP0_MVPControl;
-#define CP0MVPCo_CPA	3
-#define CP0MVPCo_STLB	2
-#define CP0MVPCo_VPC	1
-#define CP0MVPCo_EVP	0
+#define CP0MVPCo_CPA    3
+#define CP0MVPCo_STLB   2
+#define CP0MVPCo_VPC    1
+#define CP0MVPCo_EVP    0
     int32_t CP0_MVPConf0;
-#define CP0MVPC0_M	31
-#define CP0MVPC0_TLBS	29
-#define CP0MVPC0_GS	28
-#define CP0MVPC0_PCP	27
-#define CP0MVPC0_PTLBE	16
-#define CP0MVPC0_TCA	15
-#define CP0MVPC0_PVPE	10
-#define CP0MVPC0_PTC	0
+#define CP0MVPC0_M      31
+#define CP0MVPC0_TLBS   29
+#define CP0MVPC0_GS     28
+#define CP0MVPC0_PCP    27
+#define CP0MVPC0_PTLBE  16
+#define CP0MVPC0_TCA    15
+#define CP0MVPC0_PVPE   10
+#define CP0MVPC0_PTC    0
     int32_t CP0_MVPConf1;
-#define CP0MVPC1_CIM	31
-#define CP0MVPC1_CIF	30
-#define CP0MVPC1_PCX	20
-#define CP0MVPC1_PCP2	10
-#define CP0MVPC1_PCP1	0
+#define CP0MVPC1_CIM    31
+#define CP0MVPC1_CIF    30
+#define CP0MVPC1_PCX    20
+#define CP0MVPC1_PCP2   10
+#define CP0MVPC1_PCP1   0
 };
 
 typedef struct mips_def_t mips_def_t;
@@ -495,44 +495,44 @@ struct CPUMIPSState {
  */
     int32_t CP0_Random;
     int32_t CP0_VPEControl;
-#define CP0VPECo_YSI	21
-#define CP0VPECo_GSI	20
-#define CP0VPECo_EXCPT	16
-#define CP0VPECo_TE	15
-#define CP0VPECo_TargTC	0
+#define CP0VPECo_YSI    21
+#define CP0VPECo_GSI    20
+#define CP0VPECo_EXCPT  16
+#define CP0VPECo_TE     15
+#define CP0VPECo_TargTC 0
     int32_t CP0_VPEConf0;
-#define CP0VPEC0_M	31
-#define CP0VPEC0_XTC	21
-#define CP0VPEC0_TCS	19
-#define CP0VPEC0_SCS	18
-#define CP0VPEC0_DSC	17
-#define CP0VPEC0_ICS	16
-#define CP0VPEC0_MVP	1
-#define CP0VPEC0_VPA	0
+#define CP0VPEC0_M      31
+#define CP0VPEC0_XTC    21
+#define CP0VPEC0_TCS    19
+#define CP0VPEC0_SCS    18
+#define CP0VPEC0_DSC    17
+#define CP0VPEC0_ICS    16
+#define CP0VPEC0_MVP    1
+#define CP0VPEC0_VPA    0
     int32_t CP0_VPEConf1;
-#define CP0VPEC1_NCX	20
-#define CP0VPEC1_NCP2	10
-#define CP0VPEC1_NCP1	0
+#define CP0VPEC1_NCX    20
+#define CP0VPEC1_NCP2   10
+#define CP0VPEC1_NCP1   0
     target_ulong CP0_YQMask;
     target_ulong CP0_VPESchedule;
     target_ulong CP0_VPEScheFBack;
     int32_t CP0_VPEOpt;
-#define CP0VPEOpt_IWX7	15
-#define CP0VPEOpt_IWX6	14
-#define CP0VPEOpt_IWX5	13
-#define CP0VPEOpt_IWX4	12
-#define CP0VPEOpt_IWX3	11
-#define CP0VPEOpt_IWX2	10
-#define CP0VPEOpt_IWX1	9
-#define CP0VPEOpt_IWX0	8
-#define CP0VPEOpt_DWX7	7
-#define CP0VPEOpt_DWX6	6
-#define CP0VPEOpt_DWX5	5
-#define CP0VPEOpt_DWX4	4
-#define CP0VPEOpt_DWX3	3
-#define CP0VPEOpt_DWX2	2
-#define CP0VPEOpt_DWX1	1
-#define CP0VPEOpt_DWX0	0
+#define CP0VPEOpt_IWX7  15
+#define CP0VPEOpt_IWX6  14
+#define CP0VPEOpt_IWX5  13
+#define CP0VPEOpt_IWX4  12
+#define CP0VPEOpt_IWX3  11
+#define CP0VPEOpt_IWX2  10
+#define CP0VPEOpt_IWX1  9
+#define CP0VPEOpt_IWX0  8
+#define CP0VPEOpt_DWX7  7
+#define CP0VPEOpt_DWX6  6
+#define CP0VPEOpt_DWX5  5
+#define CP0VPEOpt_DWX4  4
+#define CP0VPEOpt_DWX3  3
+#define CP0VPEOpt_DWX2  2
+#define CP0VPEOpt_DWX1  1
+#define CP0VPEOpt_DWX0  0
 /*
  * CP0 Register 2
  */
@@ -639,33 +639,33 @@ struct CPUMIPSState {
 #define CP0PC_PSN       0     /*  5..0  */
     int32_t CP0_SRSConf0_rw_bitmask;
     int32_t CP0_SRSConf0;
-#define CP0SRSC0_M	31
-#define CP0SRSC0_SRS3	20
-#define CP0SRSC0_SRS2	10
-#define CP0SRSC0_SRS1	0
+#define CP0SRSC0_M      31
+#define CP0SRSC0_SRS3   20
+#define CP0SRSC0_SRS2   10
+#define CP0SRSC0_SRS1   0
     int32_t CP0_SRSConf1_rw_bitmask;
     int32_t CP0_SRSConf1;
-#define CP0SRSC1_M	31
-#define CP0SRSC1_SRS6	20
-#define CP0SRSC1_SRS5	10
-#define CP0SRSC1_SRS4	0
+#define CP0SRSC1_M      31
+#define CP0SRSC1_SRS6   20
+#define CP0SRSC1_SRS5   10
+#define CP0SRSC1_SRS4   0
     int32_t CP0_SRSConf2_rw_bitmask;
     int32_t CP0_SRSConf2;
-#define CP0SRSC2_M	31
-#define CP0SRSC2_SRS9	20
-#define CP0SRSC2_SRS8	10
-#define CP0SRSC2_SRS7	0
+#define CP0SRSC2_M      31
+#define CP0SRSC2_SRS9   20
+#define CP0SRSC2_SRS8   10
+#define CP0SRSC2_SRS7   0
     int32_t CP0_SRSConf3_rw_bitmask;
     int32_t CP0_SRSConf3;
-#define CP0SRSC3_M	31
-#define CP0SRSC3_SRS12	20
-#define CP0SRSC3_SRS11	10
-#define CP0SRSC3_SRS10	0
+#define CP0SRSC3_M      31
+#define CP0SRSC3_SRS12  20
+#define CP0SRSC3_SRS11  10
+#define CP0SRSC3_SRS10  0
     int32_t CP0_SRSConf4_rw_bitmask;
     int32_t CP0_SRSConf4;
-#define CP0SRSC4_SRS15	20
-#define CP0SRSC4_SRS14	10
-#define CP0SRSC4_SRS13	0
+#define CP0SRSC4_SRS15  20
+#define CP0SRSC4_SRS14  10
+#define CP0SRSC4_SRS13  0
 /*
  * CP0 Register 7
  */
@@ -691,7 +691,7 @@ struct CPUMIPSState {
  * CP0 Register 10
  */
     target_ulong CP0_EntryHi;
-#define CP0EnHi_EHINV 10
+#define CP0EnHi_EHINV  10
     target_ulong CP0_EntryHi_ASID_mask;
 /*
  * CP0 Register 11
-- 
2.20.1


