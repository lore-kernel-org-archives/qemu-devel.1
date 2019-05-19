Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDAC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60A02083D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 04:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lanBDb4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60A02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSDXK-0000yw-4T
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 00:35:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDSq-0005xg-3d
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSDEN-0004kN-QH
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSDEN-0004jY-J8
	for qemu-devel@nongnu.org; Sun, 19 May 2019 00:15:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id r18so5134392pls.13
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 21:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=FCuqvIszZI+r7CR4RRqeHvoo3hi2127akJ+HFoM3s18=;
	b=lanBDb4Ao38xJKYI9BVPs8tDPLSjjMWggp9C1soZ+aYYNbT8vqe7aVcXq9x3XaF9St
	HnRgSxMrMkRJmf8G2csetBy+fbzVFSioVOHxX71X77NcXLmSAfn43yETdzo+puWYGqKW
	pfd+uqA6W3G8ArO0MqMvO1buOM6d3wFfowAaP1M1LKD/DWg4X7bNPniV72XKsQNZPvcl
	8jEGF//GMeUOLrMKpzMWj7GESdjnoMLlov0AjW4aDJZKfe4Ws9+6DxZTlqNjwC55VTM1
	d8acSEh5ytmKQGtlyi0p0cZkb4jiWZdNwDej6CV7ELqTFF4v7dX2/todV36ow5/k0SnZ
	MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=FCuqvIszZI+r7CR4RRqeHvoo3hi2127akJ+HFoM3s18=;
	b=uO7PWF65bEbmFKpHQQqnZnwn/8BqP8dqRY6JTEAbdb6P52w1Y9e3ZoJSoC+JeVJCNY
	DyY/FKbuL268X/Ks4LnmjVbUevLT22EZZXJR/8OeECJ9DY8hsdgeMu1sES4KAyrNK5fU
	7ts8TDeH+higY2IGYd1DhuYnNACCNZOzUt1fnNNwPrcQCo+YObjix40ZFisIbYtrRYez
	gV7jJdznhMFSewGYIAQBIbJ6Fv2GRu31e/WO4h/0Og5p7MsaiNnxDXbo0Tku0Xsn/I5S
	7pb8RFp4olZbBm9dkF4YcYQ15c+vRNxHuRz3Dn9AIinSiiTXtUZGArgiVmEEAjGLA6bD
	4opg==
X-Gm-Message-State: APjAAAV8Dqldl9nCDOCoeOfgyE2sEUYoYfN8OuF6NRmrl65FDQoOlm3q
	I1c8LbvdaIgxgt9IEBoa3iqLEHmGXOM=
X-Google-Smtp-Source: APXvYqxegr84Wm4BOMI9l+W9NBjJ4+GwynzDoX9quSb6d1E3+/lWbdczs83EFFfByJeMu12vMQGfJg==
X-Received: by 2002:a17:902:2907:: with SMTP id
	g7mr43367405plb.114.1558239324932; 
	Sat, 18 May 2019 21:15:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	k63sm19381200pfb.108.2019.05.18.21.15.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 21:15:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 21:15:15 -0700
Message-Id: <20190519041522.12327-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::633
Subject: [Qemu-devel] [PATCH v4 0/7] tcg/ppc: Add vector opcodes
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
Cc: mark.cave-ayland@ilande.co.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
Aka "tcg: misc gvec improvements".

Version 3 was last posted in March,
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg05859.html

Changes since v3:
  * Add support for bitsel, with the vsx xxsel insn.
  * Rely on the new relocation overflow handling, so
    we don't require 3 insns for a vector load.

Changes since v2:
  * Several generic tcg patches to improve dup vs dupi vs dupm.
    In particular, if a global temp (like guest r10) is not in
    a host register, we should duplicate from memory instead of
    loading to an integer register, spilling to stack, loading
    to a vector register, and then duplicating.
  * I have more confidence that 32-bit ppc host should work
    this time around.  No testing on that front yet, but I've
    unified some code sequences with 64-bit ppc host.
  * Base altivec now supports V128 only.  Moved V64 support to
    Power7 (v2.06), which has 64-bit load/store.
  * Dropped support for 64-bit vector multiply using Power8.
    The expansion was too large compared to using integer regs.


r~


Richard Henderson (7):
  tcg/ppc: Initial backend support for Altivec
  tcg/ppc: Support vector shift by immediate
  tcg/ppc: Support vector multiply
  tcg/ppc: Support vector dup2
  tcg/ppc: Update vector support to v2.06
  tcg/ppc: Update vector support to v2.07
  tcg/ppc: Update vector support to v3.00

 tcg/ppc/tcg-target.h     |   39 +-
 tcg/ppc/tcg-target.opc.h |   11 +
 tcg/ppc/tcg-target.inc.c | 1077 +++++++++++++++++++++++++++++++++++---
 3 files changed, 1063 insertions(+), 64 deletions(-)
 create mode 100644 tcg/ppc/tcg-target.opc.h

-- 
2.17.1


