Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2FDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E9B2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 05:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deu3rIMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34957 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRAf-0006UI-Gj
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 01:55:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8t-0005BW-9f
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR8s-0002rl-CR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:53:55 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR8r-0002rF-NE; Fri, 03 May 2019 01:53:53 -0400
Received: by mail-pl1-x641.google.com with SMTP id y3so2188555plp.0;
	Thu, 02 May 2019 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=uTEnt+RwoXTMSi/BpLCLpLWRLd685MOhFLDweZ3zqHQ=;
	b=deu3rIMdLtquHaUSHxUqfqfcx2R4qmvGtDPO3T7n7VJO5ILXuxCPLWSPT5WUT5nymW
	uTn9lxC4AkuOAf8ugOF6jTXFMqGtOqSaMtjmWCM3EWUsy7W5xMgjyhS9m1TSKTc6ZGsC
	/UVvJ7DebhcX+rPXJ82mxuYcfA0Elij2Ax3F9xMH76b+F+tv05x9UjN7RXFz49yNmoRL
	s0hSz5nxIh+sKGq2ZtavJCW5I45x7CiYCjmIRIhvZeZpyoEOnnk53IFU6eu/hQhHxJAa
	dB6TGlurnSgRWULkXZqGY39OU1tSkojjsx294s+RfSf3ZYpDlkUXig5aJ61xMubnKZ9T
	rmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=uTEnt+RwoXTMSi/BpLCLpLWRLd685MOhFLDweZ3zqHQ=;
	b=kao0wAO4rQ52SavDYrIJCKzfeEBuhTNILfknVKz98hq3VgRAw/Xzja6QFkwyuFYdYv
	hUC6pMvMl9XqaoTLcMzgVqZKx29NXFj8iZBBp3zufqII2+soCbHms1rBpCbPkcVl+W03
	TCiLXyDCSpNg3bpR0+txaT9mXQhJcVSKo4ntf1Cb0nHbmLCYRgjxbKl3q3gQ2c0TwyCz
	6hc/yu18pYC/WSSIK28eH0vHng78vRhS6pOF2hEnPnV86UYNeOI5tF9is7VTDtU7t1lx
	5r0QGGfLEDMpoTpZWS7zlw/uMmUk7BZnltW0VNqAf4h2u+J2xTWC8dhqjk4cRtHlWWv3
	AkPQ==
X-Gm-Message-State: APjAAAXi8ar8JW+hJ/3oNCU3iRxb7bJQ1WR4dqHCBf2Odsb7jPy0G5rZ
	tzJHQdZ6qy0/nRia3dElmMehbgG8keQ=
X-Google-Smtp-Source: APXvYqzXKO2z5d17jS/s3LAplDet1MmTkrbaX1wDz5fqRMZWZCGcqX1czsq0bAQ+7P5sM96/syBycg==
X-Received: by 2002:a17:902:76c5:: with SMTP id
	j5mr8137857plt.337.1556862832667; 
	Thu, 02 May 2019 22:53:52 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.53.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:53:52 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:06 +1000
Message-Id: <20190503055316.6441-4-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 03/13] target/ppc: Add SPR ASDR
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
Cc: groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
	Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503055306.z1afoBKikSFpAkIzgaERJlNTZQ27njG7a2JtkP7ySrA@z>

The Access Segment Descriptor Register (ASDR) provides information about
the storage element when taking a hypervisor storage interrupt. When
performing nested radix address translation, this is normally the guest
real address. This register is present on POWER9 processors and later.

Implement the ADSR, note read and write access is limited to the
hypervisor.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/cpu.h                | 1 +
 target/ppc/translate_init.inc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 19b3e1de0e..8d66265e5a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1797,6 +1797,7 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_MPC_MD_DBRAM1     (0x32A)
 #define SPR_RCPU_L2U_RA3      (0x32B)
 #define SPR_TAR               (0x32F)
+#define SPR_ASDR              (0x330)
 #define SPR_IC                (0x350)
 #define SPR_VTB               (0x351)
 #define SPR_MMCRC             (0x353)
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 9cd33e79ef..a0cae58e19 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8243,6 +8243,12 @@ static void gen_spr_power9_mmu(CPUPPCState *env)
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_ptcr,
                         KVM_REG_PPC_PTCR, 0x00000000);
+    /* Address Segment Descriptor Register */
+    spr_register_hv(env, SPR_ASDR, "ASDR",
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    SPR_NOACCESS, SPR_NOACCESS,
+                    &spr_read_generic, &spr_write_generic,
+                    0x0000000000000000);
 #endif
 }
 
-- 
2.13.6


