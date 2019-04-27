Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA566C43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 00:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938CE20873
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 00:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1xnPesX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938CE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKBbU-0006Fm-O0
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 20:54:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBZu-0005He-MD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBYv-000105-BI
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hKBYv-0000zP-5k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id y27so1634487pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 17:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id;
	bh=ea+01ZcI0n2piqN+q9Ur9FZEsb85lfqrn+mmYVtcB/c=;
	b=Y1xnPesXGIZUvEuE0aKctJ6YSpxjQY359mJUeeBYexsA1FrxXk9wN25PO1pl6jq7xV
	kHBzu9tvXElPwyqOE3TENTtMm6gXYZ/zfH7ft823dDZoccviMfNvhfkxXojvadbx9tSA
	bkseRDz5gr5vBAUSPPaKJBWSxIZLStPfQ2/I5Tj9GqyhKR/m7uRB6m06BaS4a1pzi8ZA
	DAV7E/pxGgWjj1xHgrVp6BGmQiychVz47P57/K2RgxvwV8p6jefraNIHy7JJ164fRgYB
	AyxhfY6XvesKOyi44ZRy8lJugMGYlfqnXS8w28abyu6Bspn7BPxOxor3d5eWQox7pkO/
	jN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=ea+01ZcI0n2piqN+q9Ur9FZEsb85lfqrn+mmYVtcB/c=;
	b=HrslLge9IIdnDdRAxAaBn4AGSsgXEvJDiegseheznI4ExCxW+DYkt5jhoTtRXa8elA
	o5urKlftxI6Wzf/qQEpf8uIFnx5dLndZ+05EHi9MLl6ImSHGe3acn6NyOs5kgAENehfO
	6r4jo1H3x77+SGcwkWD5U75klYbcvgerpV3eXA/RspOaK2D0emt+FNIWM2EHfaw1Rwk1
	UTDjDe1H1czzZqJdxkfoX1xdpyHIk8kjhzHsBPwbJqc0pb8GRkTl28e1Yu3FoP4Wx0H5
	5qtEVofQOUuVbEqnBzheu5y+V+kcHT8ZQ2HnuN2DU33b3VQ/xCBqkei9HFZCdfRJLDiE
	RPvw==
X-Gm-Message-State: APjAAAUOdPDWfk88FudO/zxJQlvokFR7tou66tKIf8RcnCAuop0iyhqf
	9w5KZksbbEXhNoH2bPod9XY3liMOd6c=
X-Google-Smtp-Source: APXvYqxeQpY4BkEmeodcKzfK/xBLslLjxyTlSD6dbWvzWdAeyS1BTrcTKpJx11RA/IsN55ijlb2v4w==
X-Received: by 2002:a63:170d:: with SMTP id x13mr46275214pgl.169.1556326286170;
	Fri, 26 Apr 2019 17:51:26 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	b20sm5301745pff.118.2019.04.26.17.51.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 17:51:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 17:51:22 -0700
Message-Id: <20190427005124.12756-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH 0/2] target/alpha: Fix bug 1701835
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
Message-ID: <20190427005122.i-ckbvFZT0hSrf4JtbhZCA_DXNm5ACkjyHCxzZY6fo4@z>

Serves me right for really only being interested in system testing.
Anyway, in order to emulate user-only properly, we have to do all
of the crazy things the kernel does, forced on us by the crazy DEC
hardware engineers.


r~


Richard Henderson (2):
  target/alpha: Clean up alpha_cpu_dump_state
  target/alpha: Fix user-only floating-point exceptions

 linux-user/syscall_defs.h |   3 +-
 target/alpha/cpu.h        |  42 +++++++++++++++
 linux-user/syscall.c      | 104 ++++++++++++++++++--------------------
 target/alpha/fpu_helper.c |  21 ++++++--
 target/alpha/helper.c     |  39 ++++++++++----
 5 files changed, 140 insertions(+), 69 deletions(-)

-- 
2.17.1


