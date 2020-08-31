Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235E3C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E462071B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 18:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFOUoya2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E462071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCokF-0003ih-2P
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 14:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCojA-0001fc-TH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:44179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCoj8-0007AK-OZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 14:40:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id o20so1073890pfp.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m6pgdynR0VeZCI36OMiuEL47OfF+3c/eQ/RKBt4vgFo=;
 b=wFOUoya2qauJvFJw0thWVkTnOGMKDKUnb2YmDAvANYYcwYKXMSN4MjuR2E0sE2rzt8
 6Q8hlUPjI3WXC1lD8Nfzrl30RR4dAzWXrxdh71yaSs2VgvVaPuQhlXVkm1s8IlYIJpWV
 tzfwoztqi7ODfCUL5dl3IoIJoqhiKL1FB0KoPinQdxptkE7R09q/JQ4r1ah3dCzDqh0O
 2Kc6ucYN9Btw6gKz46NfGQL1w0AOznpX75aikxVsY6Bxcr/8qUmPY8EteBVs1HW5iTt0
 zNDPGybjrJo/QD85L134I2h7O99lOPyDUbyCUe09QTSDdBE85mnnK0OCAfH21v5WJihk
 RPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m6pgdynR0VeZCI36OMiuEL47OfF+3c/eQ/RKBt4vgFo=;
 b=ZLdwNZgp/QDxogD4PqOnLEfJTxCaXMj90wrzyxPFD5Ux5W3hXVdZ+VjfzkDZz8VQ9f
 AEVf0LUPp4vBRgVdpD6zcbO5GJaVsfYzsgF3f/wyqzKq680CklQvrlfcLuyL4ILgxg9Z
 ny1+FILqtci3ubDJsB98F4haT6n5QIrS7C9JUu7ICkDR6XzcjuNGq+X6nriqFMOrUgpC
 nn3W1SR81vLyM1sUPR3ac/fb7xkY1aQjQMKhwj33vn37U0/BJBf0Tu6hiP1hcRFfS2i+
 5qGRHZsVL8jjsWeH9TFZiI3rVqUZRwtoeN7pSRmvbfbVli6doW1q+Aw2gRpVFdL9eFfK
 yj8Q==
X-Gm-Message-State: AOAM533huCQnfmGL5TZhu6AbSkxQTIaG0J1MbXfMzr1H9nbl9FCEq5xR
 DECFRL3wfIN1e62NylCcmA2D6/o/kpQFJQ==
X-Google-Smtp-Source: ABdhPJz7QMdrHcRR7WRhd0W5pbNgApXADet4nTyq4Gk2QOhTvUilnhyfVPoT04Xtq3xNrzM0YzpE2A==
X-Received: by 2002:a62:3641:: with SMTP id d62mr2374997pfa.82.1598899220527; 
 Mon, 31 Aug 2020 11:40:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y195sm5757580pfc.137.2020.08.31.11.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 11:40:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Date: Mon, 31 Aug 2020 11:40:12 -0700
Message-Id: <20200831184018.839906-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200831160601.833692-1-richard.henderson@linaro.org>
("[PULL 00/76] target/microblaze improvements")

Hello again, Edgar.

I had dropped the tcg_gen_lookup_and_goto_ptr patch from the
previous omnibus patch set, as you had reported lockups.

I have identified, by inspection, two cases in which we failed
to return to the main loop even though we should have:

(1) Return-from-exception type instructions.

I had missed these before because they hadn't set cpustate_changed.
This still worked fine because they are all indirect branches, and
had exited immediately.

Fixed by distinguishing these cases from normal indirect branches
before we start using lookup_and_goto_ptr.

(2) MTS in a branch delay slot.

We did not check dc->cpustate_changed before setting
dc->base.is_jmp to DISAS_JUMP, which lost the fact that we
need to return to the main loop.

This mostly works fine without lookup_and_goto_ptr, because
we either (a) finished an indirect branch and returned to the
main loop anyway or (b) we'd return to the main loop via some
subsequent indirect branch, which would happen "soon enough".

We should have been able to see soft-lockup with the existing
code in the case of a cpustate_changed in the delay slot of
a loop of direct branches that all use goto_tb.  E.g.

	brid	0
	 msrset MSR_IE

I.e. an immediate branch back to the same branch insn,
re-enabling interrupts in the delay slot.  Probably not
something that shows up in the wild.

----

Follow-up question: The manual says that several classes of
instructions are invalid in a branch delay slot, but does
not say what action is taken, if any.

Some of these invalid cases could leave qemu in an inconsistent
state.  Would it be legal for us to diagnose these cases with
trap_illegal?  If not, what *should* we be doing?  We could also
LOG_GUEST_ERROR for these either way.

I've added some TODO comments in these patches that are relevant.

Thanks,


r~


Richard Henderson (6):
  target/microblaze: Rename DISAS_UPDATE to DISAS_EXIT
  target/microblaze: Introduce DISAS_EXIT_NEXT, DISAS_EXIT_JUMP
  target/microblaze: Replace cpustate_changed with DISAS_EXIT_NEXT
  target/microblaze: Handle DISAS_EXIT_NEXT in delay slot
  target/microblaze: Force rtid, rted, rtbd to exit
  target/microblaze: Use tcg_gen_lookup_and_goto_ptr

 target/microblaze/translate.c | 128 ++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 46 deletions(-)

-- 
2.25.1


