Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC85C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E1320786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="En6MP5+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E1320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0N1O-0007RA-N0
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzW-0004gs-F8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzU-0002lF-Bl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so17777271wrs.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MuL01ug1d9rCh7z9d9DHphbv9uJzL7Lki+sHKMO8sc8=;
 b=En6MP5+OLse5Z8aZFFwlsnTBv8TZHfSgb/j7SmkDdxnTe2Jf1GT+oyLGArrBn5bt7p
 FlFcCsIfidPI7zzhYQZd8IgnB39+kO1AnC1N46dDi9r+eebH/9iKL/PMc9u4J/T/Xr78
 kXubBirwO0Wb+PqxU1lZLtc488tXYSNEuVvvi7OlFmNe/qhUuMhtbsn9BGPJZBZNIzHm
 xAFOjKXXCjotjUoeK3zH1qL0/gFXN/g0MU22xL4FvmIPm0vXNoTmozpUKIQvQLpNSGnt
 AVojcvSMeRCizKvOWvvXNVDCUFnnUJXN/0u/HFQn6PJ8LpVsnplb8BUKDoBrqte0e3gv
 89gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MuL01ug1d9rCh7z9d9DHphbv9uJzL7Lki+sHKMO8sc8=;
 b=TTSfRVgQ/mewyoVXxjQ8r7RA0kXFyMldMEr9YsLiMWxd/3Rd2V1BFQHkRFO9m6jlpv
 p/F2BRPhMXoxkIMv7YRlhDOWUIxBQJsZNUX8sZgN6cJQ+GL6NObRmE8eqgATFp6gh+fM
 cIU4FC1NNBYAqVu5mcAWsRCyf3dnCZHB15u5ppPpDPubgjDdn9d4Ac2zEgzmmnYi5zVH
 FvW7nQzl8fDaYkUlGPxpQM3L8KfNpeoh/o5HlXXTo41ifOT+IBloPr0NXNtedT03XMHl
 Opz4tOQfh3c9CS7IWkw0cEzZKy9HH46YZw39Nktdkf7Kq9xR6KrDUqMFUOc/b83I0Nxi
 LFxA==
X-Gm-Message-State: AOAM532b0zCSqUqBjtS8dyOt1CKXOpgVRDSIlVJK45aupJ4NzO6wYNcW
 TyssAmD7Tima/Weshm0CuPgOD+/+ta8UBQ==
X-Google-Smtp-Source: ABdhPJyNap0O5ZSGdecgD7qR37JMKitiVcLzYl40Ej1RUINcmbTvKR+imqtKv0BvE+llNGGcc0HXeg==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr25245982wrq.189.1595932666778; 
 Tue, 28 Jul 2020 03:37:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w16sm18634657wrg.95.2020.07.28.03.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:37:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1? 0/3] Fix AIRCR.SYSRESETREQ for most M-profile boards
Date: Tue, 28 Jul 2020 11:37:41 +0100
Message-Id: <20200728103744.6909-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU's NVIC device provides an outbound qemu_irq "SYSRESETREQ" which
it signals when the guest sets the SYSRESETREQ bit in the AIRCR
register.  This matches the hardware design (where the CPU has a
signal of this name and it is up to the SoC to connect that up to an
actual reset mechanism), but in QEMU it mostly results in duplicated
code in SoC objects and bugs where SoC model implementors forget to
wire up the SYSRESETREQ line.

This patchseries provides a default behaviour for the case where
SYSRESETREQ is not actually connected to anything: use
qemu_system_reset_request() to perform a system reset. This is a
much more plausible default than "do nothing". It allows us to
allow us to remove the implementations of SYSRESETREQ handling from
the boards which currently hook up a reset function that just
does that (stellaris, emcraft-sf2), and also fixes the bugs
in these board models which forgot to wire up the signal:

 * microbit
 * mps2-an385
 * mps2-an505
 * mps2-an511
 * mps2-an521
 * musca-a
 * musca-b1
 * netduino
 * netduinoplus2

[I admit that I have not specifically checked for datasheets
and errata notes for all these boards to confirm that AIRCR.SYSRESETREQ
really does reset the system or to look for more complex
reset-control logic... As an example, though, the SSE-200 used in
the mps2-an521 and the musca boards has a RESET_MASK register in the
system control block that allows a guest to suppress reset requests from
one or both CPUs. Since we don't model that register, "always reset"
is still closer to reasonable behaviour than "do nothing".]

We still allow the board to wire up the signal if it needs to, in case
we need to model more complicated reset controller logic (eg if we
wanted to get that SSE-200 corner case right in future) or to model
buggy SoC hardware which forgot to wire up the line itself. But
defaulting to "reset the system" is going to be correct much more
often than "do nothing".

Patch 1 introduces a new API for "check whether my qemu_irq is
actually connected to anything" (the test is trivial but the
encapsulation seems worthwhile); patch 2 provides the new default
and patch 3 removes the now-unnecessary SYSRESETREQ handlers in
board/SoC code.

thanks
-- PMM

Peter Maydell (3):
  include/hw/irq.h: New function qemu_irq_is_connected()
  hw/intc/armv7m_nvic: Provide default "reset the system" behaviour for
    SYSRESETREQ
  msf2-soc, stellaris: Don't wire up SYSRESETREQ

 include/hw/arm/armv7m.h |  4 +++-
 include/hw/irq.h        | 18 ++++++++++++++++++
 hw/arm/msf2-soc.c       | 11 -----------
 hw/arm/stellaris.c      | 12 ------------
 hw/intc/armv7m_nvic.c   | 17 ++++++++++++++++-
 5 files changed, 37 insertions(+), 25 deletions(-)

-- 
2.20.1


