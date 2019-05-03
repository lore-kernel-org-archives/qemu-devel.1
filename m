Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4160C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEBD206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 06:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Af6Axvyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEBD206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMRIH-0005JF-Mz
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 02:03:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9D-0005S0-W2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1hMR9C-00032k-A2
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:54:15 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sjitindarsingh@gmail.com>)
	id 1hMR9C-0002zZ-0e; Fri, 03 May 2019 01:54:14 -0400
Received: by mail-pf1-x442.google.com with SMTP id v80so2353483pfa.3;
	Thu, 02 May 2019 22:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wUZAXOTwdw2I/hZuC5jS4/OqNN0mBHOWVDEizVGw6GQ=;
	b=Af6AxvyqyVqgdx5sR9vt6CetSMY498qPkmWf3OjJNGMDcg2ddNIfbPZzyq332xmqsh
	NBeya8BT1uEgWonEwLsDp0/ne3QtR6PIDAj7nXYqtdPCPT2iablRFHZPdA4jSbVOJ2DC
	lxS9KGmLzAx2wgO+Q6jrlzyczAAU18o8BnwqvswvsjMRvOGV9ga1aPLZPWxIHv15f9pC
	2Gh/X9ZyQDVS2ObIlOzM+pdcwbjAlrp+tSH2+BKG4wRgZK+9ziayr1LhDM67RFvQM4d5
	tCxrigMfEz85CBu9Y+RotUlGLdpLo92zY5I09Bq/Uo6/BzeLicQXP9tj/f5HYKTCD9Tt
	F/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wUZAXOTwdw2I/hZuC5jS4/OqNN0mBHOWVDEizVGw6GQ=;
	b=tDC2aLc5XRJPV3Jq9kFocopDf2qSU6B58UDEgLkFGOsXQfnISbsIC7MS+sPC8Tl3RB
	kdwwnaSwaysD70ge++46GKTHyhhTrZaKi6HwGcbXAerZ6HlBFfvQcmzPPGP7I1Ncuh8k
	aQ+Zjrl7Eqek7U/ptw82z4MR7f4QqetwGUrJMAanWB0McFjsKahXjRRe+Ny/iYrpkxgy
	WqmyJLGcJGCAx6BpW6qm3kdNuX3+XzMHFA/Foovk7VyepejbBWmkwHwUIxtTEnsT+2g3
	gcEKsYIgiTikPR9GeqM9n+JHdw/q3j11uBNMUMD0pA38L08aBZkcJ3vzzr0AS/vpo4GY
	l0Vw==
X-Gm-Message-State: APjAAAWb0xajo2J7SYoLLSpl2s4C0UBPfLxngs1kpIxUCfJVWHeF9p+B
	oAitc5WK8cO9WUfnl3VQvEbSKENOCpA=
X-Google-Smtp-Source: APXvYqxPUPVhxF4jxE8BFdmppxcc+9qa8+6brNnYwfd4qF10qVOD5UY8ZyVwxrLGWVAt/gTJ4VchIQ==
X-Received: by 2002:a63:9541:: with SMTP id t1mr4336289pgn.97.1556862848390;
	Thu, 02 May 2019 22:54:08 -0700 (PDT)
Received: from localhost.ibm.com ([1.129.142.217])
	by smtp.gmail.com with ESMTPSA id
	h187sm1292983pfc.52.2019.05.02.22.54.02
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 22:54:07 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 15:53:09 +1000
Message-Id: <20190503055316.6441-7-sjitindarsingh@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190503055316.6441-1-sjitindarsingh@gmail.com>
References: <20190503055316.6441-1-sjitindarsingh@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 06/13] target/ppc: Enforce that the
 root page directory size must be at least 5
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
Message-ID: <20190503055309.stLO5UEPWdq6vD4yte8Lyo8u8dTgwREKWdvY6gw8CAY@z>

According to the ISA the root page directory size of a radix tree for
either process or partition scoped translation must be >= 5.

Thus add this to the list of conditions checked when validating the
partition table entry in validate_pate();

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-radix64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index a6ab290323..afa5ba506a 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -249,6 +249,8 @@ static bool validate_pate(PowerPCCPU *cpu, uint64_t lpid, ppc_v3_pate_t *pate)
     if (lpid == 0 && !msr_hv) {
         return false;
     }
+    if ((pate->dw0 & PATE1_R_PRTS) < 5)
+        return false;
     /* More checks ... */
     return true;
 }
-- 
2.13.6


