Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32565C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0122D2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 18:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmjYLKym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0122D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50535 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK5Vr-0007Eq-0a
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 14:23:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UG-00062c-Ej
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK5UF-0006Nl-FO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:45601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK5UF-0006MG-6u
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 14:22:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id y27so1268154pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Kp2L1oreruJAhVUQEiaYQt7zH1VfopMJ2io4yjBh/iM=;
	b=KmjYLKym0CDhxc48BGLXITyf9IXBig7GEun/ZeuAppcOZ7qM/imlQDOkLigsJEQ9/H
	einZTq+Ho4vqhRRNRsHhmq6N7uUMk+/vwylZYNiXj3E2sKihaK7kP/7AoAxHQJA+eZ2l
	5RmCk86jdfbaiU4DWCZy/DpI0BzDaM4ERHdNPpiEVNXXlX0ucRn9WB0R4TU2uIdTZWTQ
	YuiCVBWF9yuZ7mtlQMGnitDsEMxoAVBqb042BeyV9uOvPrqQmp/MTXeakcnosBP2eDKz
	vSNWvTQ3FCbHWB5VKpHBqcFCgCXCL+J7PCm1OgTMqu06hM5+9A9S69BT2Zzu1yHuxKTM
	ANCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Kp2L1oreruJAhVUQEiaYQt7zH1VfopMJ2io4yjBh/iM=;
	b=bnK+uMGg2dBHn44e6DHQjbtJkbZa3ZtKbOGDUczsGdi8/0vMWXBB/bTGkrC3YWUaPq
	PkUGQMDyHe36Hkei+5eVk1PDpUYqrDP/ah0BjNFtPyUJZb16UMEHaYS8YkjjXqSSlJJA
	16eH279myVrVhu3X2xWK+2qLWPtFzqmLL6kk70mDyxEWn2PznKfQYvXRqbZWoAqhTgf/
	tVb8bqrpfcp99pvO+AM/lVF5kS+0SdnlH2utwBuJ1xj+/4s9w5fNqDd26VUp0RZIT3YO
	91/eeqQB5j85B+yU8fhtVc+aUeiZDfM/NtcKS4G7AzIqdKdzjEq9Zbq3eFSwdZY4b4nD
	SoiA==
X-Gm-Message-State: APjAAAW+LXX0onhNe01UCR+XkVS+xsO1hA1F8sNoUxixnFuUUuTc4XHV
	3hYS6Ubld2Gvutiokjk48KUpbjEVVUs=
X-Google-Smtp-Source: APXvYqyJeBWyo1AqKpsLMOg6/q+q2hpXfiO/c5FdKAB45DnLWAmKmTRQGLGh2e+5SntxrfN3KaUr6g==
X-Received: by 2002:a63:6983:: with SMTP id
	e125mr42170841pgc.370.1556302932138; 
	Fri, 26 Apr 2019 11:22:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c28sm15977095pgm.42.2019.04.26.11.22.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 11:22:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 11:22:08 -0700
Message-Id: <20190426182210.10442-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::531
Subject: [Qemu-devel] [PULL 0/2] target/hppa patch queue
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426182208.oMDAnrAvVmMtTvSA_kzDTguo4McnJsGa-BcD7jiSOnE@z>

The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:

  Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-hppa-20190426

for you to fetch changes up to 647ad90a1eb6c016071d21e4f1e22b9cd4986417:

  target/hppa: Always return EXCP_DMAR for protection id trap (2019-04-26 11:09:22 -0700)

----------------------------------------------------------------
Implement fast tlb insert insns.
Fix data tlb exception for pa 1.1.

----------------------------------------------------------------
Nick Hudson (2):
      target/hppa: Implement Fast TLB Insert instructions
      target/hppa: Always return EXCP_DMAR for protection id trap

 target/hppa/mem_helper.c |  3 +--
 target/hppa/translate.c  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/insns.decode |  3 +++
 3 files changed, 58 insertions(+), 2 deletions(-)

