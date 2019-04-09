Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A85C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 04:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7664B20855
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 04:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STOXIb2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7664B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34786 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDiAS-0002Hi-No
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 00:15:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8p-0001PN-3K
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDi8o-00007J-1V
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:45105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDi8m-00005J-LA
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 00:13:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id bf11so8558475plb.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=BwyFboXla9UcGWhWjEcC7E4DSV+Q13Lt6gq0sT0Enag=;
	b=STOXIb2Lbd8V6dLixfQM0PvqvrQmQT2pstmtlz4KW3XV658qLap+TKaUdhFcJp7yF7
	09uZQ/M3PHtR5DrgZjovCET0L39XW1lzLu+YM+K4PkiSIVs8ncPkL61auAtFIX+6lSMK
	U9YEg3LbR9/wgy1yYcVIktf8XkpJ/EM/ErhE4EFdtxHyO9FiwzdNr2ott8PfZAxUS+8+
	UoCFOiMdyTz6oSPHOF2FtBuhhg5MRzkcG349ybj2d2iQANWDDdtNCEII1FasPxUB8Uej
	E8m6LuxnLoVMJ0eCsSFATB8DuN69Af3y3OwOnVAkh/P2MJqG7/dyjJgQaaEY3Zp0LhXV
	fsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BwyFboXla9UcGWhWjEcC7E4DSV+Q13Lt6gq0sT0Enag=;
	b=NQwrsjbCqXRlTiPgbLSOGjM1Es9sRr+3w8D39kVTGfJ4jDlXBjOoCVxhx8Arv8NlhM
	6ZBpPOb5Kd07G4PEYAjd75V0zHaUpiiJL+khuxLVmu/FqJnJD7BlWjrOoVuJV+DRpCsd
	GWUflODFcqadJqLAH5bNopAF9sFdYevIUWJ24dWitfpwi0nRNUX9cIZ49elWrjLJYfOx
	7Zbf2y5/hnDG/KyRZAV+BmVteFXhITg5LAssdcdx92T3JLJc/70MDBFhqO+AKHIaLzSk
	KAJv3F5Ep5gO5RjeGbww2D7cpTYfF0OCZTbfXfoSqHijd2jKDHrgsN6abirSLsDMicQO
	mcHA==
X-Gm-Message-State: APjAAAXwx4qdhkZfrFV+s2HQL47TsvMoN3aOyDvb8dvEo7P4yl2AFYfH
	+tDZU6VkbI6ChGbxUzowB+wtlZ0RE+Q=
X-Google-Smtp-Source: APXvYqxHj3OxGNhfFX2+1NT0IRUYhKQs3GOGNB6a+aXES8PQfaqE6/hv4bjrMm/Au90pXzPtYc8h4Q==
X-Received: by 2002:a17:902:b10c:: with SMTP id
	q12mr34410159plr.254.1554783221727; 
	Mon, 08 Apr 2019 21:13:41 -0700 (PDT)
Received: from localhost.localdomain (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	d129sm46012024pfa.142.2019.04.08.21.13.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 21:13:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 18:13:35 -1000
Message-Id: <20190409041337.23602-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62e
Subject: [Qemu-devel] [RISU 0/2] i386 support for avx
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
Cc: jan.bobek@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409041335.Fw5eZv5ls4AOkVzC27q7ltx9QaoGiSqd8Mlnp8D_tZI@z>

It's quite plausible that we should add a command-line argument for
risu, similar to the aarch64 --test-sve option, that explicitly
limits the size of the vectors to be recorded or compared.  Otherwise
I worry about the host supporting AVX-N and wanting to test TCG with
a narrower vector insns.

Anyway, adding a command-line option should be a relatively trivial
extension to the following, which works to extract state from the
Intel XSAVE structure that the kernel borrows for the signal frame.


r~


Richard Henderson (2):
  i386: Add avx512 state to reginfo_t
  HACK: Test avx2 state

 risu_reginfo_i386.h |  15 ++++
 risu_reginfo_i386.c | 194 ++++++++++++++++++++++++++++++++++++++++++--
 test_i386.S         |  39 +++++++++
 3 files changed, 243 insertions(+), 5 deletions(-)

-- 
2.17.1


