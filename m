Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136FC55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578A820724
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5h6w9Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578A820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kamkO-0003L4-TQ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 16:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj7-0002nZ-4K
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kamj5-0005TQ-9l
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:23:24 -0500
Received: by mail-wr1-x441.google.com with SMTP id y12so3404050wrp.6
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxKircR/bUaAbf2jcsGjxHMNsd9yC/9W9AUuZG2bGrg=;
 b=x5h6w9NvaNUQGimHC3WUzpVps/fnb5xXdTztwxt188HS+bacP4+KIfeIy6AMCFSVLD
 Lb7SEi9s/QWLUW+OuDGjVap8wFo9v1TTWWUK0rTEqqKwg6ssAicOAuPoYMP63ehOEUXe
 hEcS54FCe85cBsW8eiYLtqNN6F9b/W/pYNUz37+e/MLTeIN9lb/gnnDAdjVzRtDlyKM9
 VkXDEJDej5gnzGOQBv3VuPQ9wLJgh+K8kjJMf9UAEwwgsVRqaiTccvQv0xxIPoIkYbsU
 LwTO8KbGoJqH6jBvRRG1SCxzXWI700zqY9Furd3t4MqpWjQPlEWGBPG51VGYD6g8FwEt
 Lq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxKircR/bUaAbf2jcsGjxHMNsd9yC/9W9AUuZG2bGrg=;
 b=LLs2bA1HNCe7iAMakT0CnoFylBq+Pj41chHOMkQLSlaHu3aql4hlGTtAlBhBv9R2Dn
 XM7WTKsBzDdzO5OXyVEtWkofLBE5SZkxnSf2dXcohuSWtnT8fPXT56jtT8sjUOlWJQnz
 NTL/LUCSRLP3AeJOMpozib6nThipinfSbecdiY2n/wI45ORNSG7uibklqL/m847xnEQO
 4Emv36qaPPduTOcZz9Nb+PQDW3Ox8lOIZ7+s6KLIIN/DeZijowpZKjHHJiZTyRP9VSsQ
 KC3Gi7R/ONubUohgdPksjBPgZIR5+6EC5tibXV2su3oXpjJWaJYB/dmAHolI3TaGs/uR
 AWTA==
X-Gm-Message-State: AOAM533vldvFSbece4rqRZFOE8bdDfmsNhDAdqY02meWobceIcBbM47d
 aVIec3jdS3u38dBjmhgJsw7ANZVGIbEVlw==
X-Google-Smtp-Source: ABdhPJxTi4Zae71D0ZVHrQl8WjJVtJJWQ64Yx6Adup81u5eF+7lOS/qL8VyHXQumFc6wD6wSR1qVJA==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr5047763wrt.51.1604611397246;
 Thu, 05 Nov 2020 13:23:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e25sm4861587wrc.76.2020.11.05.13.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 13:23:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.2 0/3] linux-user: fix various sparc64 guest bugs
Date: Thu,  5 Nov 2020 21:23:11 +0000
Message-Id: <20201105212314.9628-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This set of patches fixes bugs which were preventing the
Debian sparc64 /bin/bash from running:
 * the target_ucontext structure put the registers in the
   wrong place (missing alignment specifier, mostly)
 * the set_context and get_context traps weren't saving fp
   and i7, which meant that guest code that did a longjmp would
   crash shortly afterwards (SPARC64 uses these traps to
   implement setjmp/longjmp)
 * we were trying to stuff a 64-bit PC into a uint32_t in
   sigreturn, which caused a SEGV on return from a signal handler

Review very much desired in particular from anybody who understands
SPARC register windows and how we handle them in linux-user for
patch 2! The other patches are straightforward.

This patchset is sufficient that I can at least chroot into
a Debian sparc64 chroot and run basic commands like 'ls' from
the shell prompt (together with Giuseppe Musacchio's patch that
fixes the stack_t struct).

There are clearly a bunch of other bugs in sparc signal handling
(starting with the fact that rt_frame support is simply not
implemented, but there are also some XXX/FIXME comments about TSTATE
save/restore in set/get_context and about the FPU state in the signal
frame code). There's also a Coverity issue about accessing off the
end of the sregs[] array in the target_mc_fpu struct -- the error is
actually harmless (we're accessing into the space in the union for
dregs[16..31] which is what we want to be doing) but I'll probably
put together a patch to make Coverity happier.

thanks
-- PMM

Peter Maydell (3):
  linux-user/sparc: Fix errors in target_ucontext structures
  linux-user/sparc: Correct set/get_context handling of fp and i7
  linux-user/sparc: Don't zero high half of PC, NPC, PSR in sigreturn

 linux-user/sparc/signal.c | 62 ++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

-- 
2.20.1


