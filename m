Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61851C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330AE207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mExEB+Ny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330AE207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5wL-00049a-E9
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50K-00007L-8X
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jb50J-0008T4-0K
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:22:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id u188so4338955wmu.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ZjKBwiDAWPFROTnrqRvW4dHVl/RK9qMqvCeW7JnC0cA=;
 b=mExEB+Nyx4KVTWedfzbCg0r5kioL9QsBsl0psWXwjdjW1GcoPZBNgAKdA8xHIs9+t7
 iu/rqEXtSN7qrOvMq3izk2RXM93A96qC5AgILKxLo3DXfktiKB470tcS0sZxxOmZoWk4
 P1WS1ToxJiWVzAyyd5zOWHNTfa+cHQa18cZzyQ09ikaIxvEALV2BnVab0Qd08rNcCscz
 qQmXqG7L+yRBqR0+bBuQym8YW7R0Lo8jARu95lzkRBX/J2UaXxmPc1WehRDPCOxWXoOl
 AfNptkfD7w7cPIPxAdsCdnRAQ3CnOmxyYaXd3Wp1PrGWQDsdqnrFeLSTO2Cx7YJSqt1/
 igOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZjKBwiDAWPFROTnrqRvW4dHVl/RK9qMqvCeW7JnC0cA=;
 b=WlFw3roI+oyZ585tv4va8IfYsrU5z3i3lRwsbHkWrHk3kTsR6KqNPEQWq7Wg8RtvzE
 Ed1PzoRNsKmsFuTrj6o8xDMGqxvg24pdwO++kBVlfAevVkK4tMWdV87qr2JobCtmWE9U
 ZHAxW9GrCLpluwOl771dtEl/KQC1y96KUEEzCL+3pdIZF1J3B+SI15yDi0djbrZxagBQ
 2F9/bpnD50dwkqa7P5/8v/D/Xz0bbkVYkRnGvqq5cSrG5SXrA/XxwfTuEcEjSifffFRy
 2nT+tXaFYzIDOO+2lwjw+A3PpL9+rSxCFAvvXUFxlK7Pv4mgYhgA/ExnKrwbDwxgt4qL
 Nwmw==
X-Gm-Message-State: AOAM532EtQ4N45W17WG1LFcwH2rKqdpL8sOEmBT8PVFbGLYZMS3n2qUc
 3gUazGInA8pMHsRU65O/RpbzpGFe
X-Google-Smtp-Source: ABdhPJyJOIZJX0ZTCVnmDWaOfO2lpRbqp6zKkWhYda6I7TtAoO8u+yz2ZAiCcEuH7W+9heT4qFUvhw==
X-Received: by 2002:a05:600c:2dd7:: with SMTP id
 e23mr195048wmh.96.1589905324372; 
 Tue, 19 May 2020 09:22:04 -0700 (PDT)
Received: from AK-L.domain.name ([41.40.225.250])
 by smtp.gmail.com with ESMTPSA id j190sm202729wmb.33.2020.05.19.09.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:22:03 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org,
	rth@twiddle.net,
	ysato@users.sourceforge.jp
Subject: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
Date: Tue, 19 May 2020 18:21:42 +0200
Message-Id: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_BL=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 May 2020 13:21:16 -0400
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greetings to all QEMU developers!

First of all, I want to say I'm really honored that I will be working
with you on the Google Summer of Code project "TCG Continuous
Benchmarking" this June, July and August.

This is my first set of patches sent to the QEMU mailing list, that
came up as a result of some preliminary exploration for this project.

***

Dear Mr. Richard,

During some performance experiments that Mr. Aleksandar Markovic an I
were doing recently, we discovered a performance drop in the the hppa
target user mode after the commit below:

https://git.qemu.org/?p=qemu.git;a=commit;h=f3b423ec6e

The issue arose because the page crossings check in use_goto_tb()
function is required only in the system mode. Checking it in both modes
causes an unnecessary overhead in the user mode.

The issue can be solved by simply checking for the page crossings only
in the system mode. By doing so, the runtime of the target decreased by
up to 6.93% on some benchmarks that we tested against.

The patch 1/2 proposes such solution for the mentioned problem.

***

Dear Mr. Yoshinori,

For the rx target, the problem is almost the opposite to one described
above for the hppa target problem. The page crossings check in rx's
use_goto_tb() was missing, so I included it to be checked, and, off
course, in the system mode only. Just for the sake of clarity, I added
some other relatively minor improvements to that function. Without this
patch, you may experience intermittent and hard-to-debug bugs while
running rx target in system-mode.

The patch 2/2 proposes the solution for the problem I described.

***

The approach to the "TCG Continuous Benchmarking" project adopted by
Mr. Aleksandar and I can by called "tool-agnostic". This means that we
will not favor any single performance-measurement-related tool, but that
we will consider a wide range of such tools, examine the details of
functionalities they provide, and use the one that fits a given
situation the most.

For performance measurements related to patch 1/2, we utilized a tool
called Valgrind (more precisely, its subtool called Callgrind) - we
measured the performance before and after the fix using it. The reason
for such choice is that this method gave use the most stable results -
the results between subsequent measurements of an identical experiment
had very little differences. That quality was not present in other
tools, or, at least, was not that good for other tools.

We plan to continue such pragmatic approach to tools choice - rather
than fix the preferred tool in advance at the beginning of the project.

For starters, we will present to you a comparison between Perf and
Valgrind/Callgrind tools. To know more on the setup, usage, pros and
cons of each of these tools, keep an eye on the mailing list for a
detailed post that will be sent by myself very soon. It will cover the
basics of what you should know to start integrating these tools in your
development workflow.

Best regards,
Ahmed Karaman

Ahmed Karaman (2):
  target/hppa: Check page crossings in use_goto_tb() only in system mode
  target/rx: Check for page crossings in use_goto_tb()

 target/hppa/translate.c | 18 ++++++++++++++----
 target/rx/translate.c   | 12 ++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.17.1


