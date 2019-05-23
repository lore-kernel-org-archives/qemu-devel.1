Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E31C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E78920856
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdttC3pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E78920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpLx-0008T1-9a
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:09:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKD-0007Nr-En
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpKC-0001oF-JP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:09 -0400
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:35869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpKC-0001nC-E6
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:08:08 -0400
Received: by mail-ua1-x941.google.com with SMTP id 94so2307241uam.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=ZVSiT/Jg8PA7g4v+yMozy4ccLxQck9hBXPFU44w7Rw4=;
	b=HdttC3pLRLe054le02RJNtpveMzBX1yBryxVwF5ELGMGScvqb6tkb1ygnOuegi78ka
	PQw1V1iVIJ1oL/aAt0a2XFfLLSG4c1t8Tb59Pfj6yMVlsc6lBOzWjEVFsDy/jUMd81mR
	YPzbvmM3t7K/udElqhbfu2IfAdfp49hSbvInx73TIvcKDDWj1ZdToHUJC61HD0ijqhhv
	78CSmTH3SUZtVLYexkCcPNaB5hbQlngwOGUg7OMk5HBL3Qcu5GV8RgzZn+5M2P15sfhz
	jfoxBg25QJGORJO5SLxSWUcK3eiDtSRb8Vwn9TrWb3d/vogCNwERmKhKeB6hURInMLzv
	8gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ZVSiT/Jg8PA7g4v+yMozy4ccLxQck9hBXPFU44w7Rw4=;
	b=bOyb5NvT9oTXayiruiEfeyTri8WL7YvOjAjNP1aqjLFF7UBM8OeO6iQBSA4KLKnY1G
	voqTKDtviYUqGusN7NTCIU2hnRMmRaJ6OHWZr9Q6YtAarQ8l3bOD1L7ILJ6rqnxut1sp
	/u2twUFAOve0lolKzEbx1webEqmQJ9Eya6/cyXbwIHkeCrrqBbA60QvMCVGqKthWe6C1
	Kw22qwR7t7Wq/fEU/Kaf1k7lE95z9e3amHG7AviBhX310IqPNj8ET8hR/tMXrPXLE0wS
	HtCj58Qxshq2In+dXbXMofUv8auMQbhmzNaWR+d+UZZTlyl1u7jP0DbepJkZn72iiIWy
	zCdw==
X-Gm-Message-State: APjAAAWmvHxhSoWUGnAH/t2gQCXOvRIh1MyXmw760ZBDt/vb5WrEbsI8
	989uq213ssvzsa+c/bLM9IFEvP88jt0=
X-Google-Smtp-Source: APXvYqwA+sCLNy7JwTIsd7+IHm6CWTnqKJ+GIZgvd3yo8NUAgsV8kpyfF3PzvrmQSdFpPlbEJxzXHg==
X-Received: by 2002:ab0:115a:: with SMTP id g26mr18910761uac.84.1558624086759; 
	Thu, 23 May 2019 08:08:06 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	p70sm4227462vsd.25.2019.05.23.08.08.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:08:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:07:57 -0400
Message-Id: <20190523150803.31504-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::941
Subject: [Qemu-devel] [PATCH 0/6] target/rx: Improvements to disassembly
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
Cc: ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a sample of the new output, taken from u-boot.bin:

IN:
0xfff8000a:  fb 12 00 01 00 00          mov.l   #0x00000100, r1
0xfff80010:  fb 32 f0 13 00 00          mov.l   #0x000013f0, r3
0xfff80016:  43 13                      sub     r1, r3
0xfff80018:  fb 22 00 ea f9 ff          mov.l   #-398848, r2
0xfff8001e:  7f 8f                      smovf
0xfff80020:  ef 01                      mov.l   r0, r1
0xfff80022:  05 1e 32 00                bsr.a   fff83240

IN:
0xfff83240:  72 11 5c fb                add     #-1188, r1
0xfff83244:  75 21 f0                   and     #-16, r1
0xfff83247:  02                         rts

Obviously there are still a few inconsistencies in the
format strings used for the immediates, but the format
is readable and it is easy to look at the opcode to see
how our decode compares to the manual.


r~


Richard Henderson (6):
  target/rx: Disassemble rx_index_addr into a string
  target/rx: Replace operand with prt_ldmi in disassembler
  target/rx: Use prt_ldmi for XCHG_mr disassembly
  target/rx: Emit all disassembly in one prt()
  target/rx: Collect all bytes during disassembly
  target/rx: Dump bytes for each insn during disassembly

 target/rx/disas.c | 366 +++++++++++++++++++++-------------------------
 1 file changed, 166 insertions(+), 200 deletions(-)

-- 
2.17.1


