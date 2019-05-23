Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FFEC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3CC2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eHdd0n1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43210 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTukJ-0006OM-W2
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:55:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTuf3-0001nC-1T
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTuf1-00081Q-8S
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:50:00 -0400
Received: from mail-yw1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:46385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTuf1-00080R-3R
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:49:59 -0400
Received: by mail-yw1-xc2d.google.com with SMTP id a130so2778964ywe.13
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=a+3rJtBWdgGlttG2ZME1TEiP+kye/QCD7UopGUsqM/0=;
	b=eHdd0n1KQxKuyb31xUjaom0wwKClGnX71cIM6XQmhEydX+SxpGoz8do4tQXc9KAnRf
	181uP4CxUtKdu5UOW9A2PpoU5Pa+b9cApSuMTzTnJUjFYFbUK2v7m0xyW1vBR4deTYTS
	wXH+s/Ee4j7N7Dgp5zjWfiFyOibJb/1CkFka60zKJ2dg7kag7y3TB1pCFckuGH0sZzec
	SnJrcUc8zKh+2r+suQun0CrAIx1CaxpPJlzdKzWAPTsjU/lnbzSDNJwCbaVJuHJBh5FC
	M19lmp8Gjqrrf/VMAfomNwV4r2US1/koYjUtmefdoDzY5HoqN6CivWAbCI2+UBRSNRTt
	Rtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=a+3rJtBWdgGlttG2ZME1TEiP+kye/QCD7UopGUsqM/0=;
	b=HkoZKHBxIN8WR00G2G7M/vfKGj3tTxcoKDNOZV22Jqr/M2S2WyRUq2kjfHJGBpY6S7
	IyTT0bbOsxR93ORKKRUjnIzwA+VnANwaa4+EQRZMNdQdNON+t6CHuBsvuB4U0nAmi5A0
	8anrKaG44ilqgmp3+ztb/wovCT/IwMMb4nGSLkwDMAn/tE838sGnnzI3cyzueVT67feH
	D1YWE474mJDMDvnV4uUcjxKZq0zv+cQOk/vpQuyyIktsEfTNwqUwd7EWPxaLODxlxzWj
	WnCjsb5LKwCVzgcXS9pjrWVlq2SlSQ+/uaAy3lgh7JSKXwSCeq34tQzmIo8m8VmQ6b+e
	XWXQ==
X-Gm-Message-State: APjAAAX1qoEO9AYHu2VqNldh6vt/Y+iIxJ1oiiJ13J63BARtsaO8N96L
	jnnFOw75Qsfrx1efOeOFCmoV6bA1b3I=
X-Google-Smtp-Source: APXvYqxPLnbn3SdQ5DU3ExxLfdH6JilYX3U21m8Pbj2K7o9SHPwIJ/wzSrrr4PmS8UdvXDpdEaXXow==
X-Received: by 2002:a0d:dd91:: with SMTP id g139mr8651161ywe.218.1558644597074;
	Thu, 23 May 2019 13:49:57 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.19])
	by smtp.gmail.com with ESMTPSA id j187sm98341ywj.32.2019.05.23.13.49.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 13:49:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 16:49:52 -0400
Message-Id: <20190523204954.13122-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c2d
Subject: [Qemu-devel] [PATCH v2 0/2] Update capstone module
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There has recently been some good progress in the upstream
capstone repository, syncing the instruction sets from the
(further) upstream llvm.

In particular, there are Power9 and System z13 instructions.
Both of which were missing from our current snapshot and from
our (ancient) binutils opcodes snapshots.

Changes for v2:
  * Drop the installed directory change.  This does force a
    different include change when building from git.
  * Drop the s390 skipdata callback for now.


r~


Richard Henderson (2):
  capstone: Update to master
  capstone: Enable disassembly for s390x

 Makefile           | 1 +
 disas.c            | 3 +++
 target/s390x/cpu.c | 4 ++++
 capstone           | 2 +-
 configure          | 2 +-
 5 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1


