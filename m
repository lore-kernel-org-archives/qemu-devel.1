Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD9C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256E821835
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 21:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uuSDPjda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256E821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inUSW-0006id-0S
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 16:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1inURR-0005WM-Um
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1inURQ-000416-ND
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:09 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:46097)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1inURQ-0003vY-En
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 16:25:08 -0500
Received: by mail-pg1-x52e.google.com with SMTP id z124so23923811pgb.13
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 13:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GlnJADtheWLSMIbG8F1swPuxgd1Nh5Eic2eEJWoP9wk=;
 b=uuSDPjdaKC8PXDXBnWpiZ+eAbMbNMIe+9jp5yuuJLMWF6FTplZk15VDPHarL/aSBSD
 EY5rDabnrAMPe8BYyhV8xSJdGwANdn9DCa4yXri/p1/DRR3aZuVhh2RvDb1UZe1Dt9W9
 VC1U1PiKvQqMmUc2Z++lgiE6wPofZxxj/AEghCbdgouh+Z9faxrB2nR8PdsRKZhM9i1C
 /9zbIQicx4JGKInI6+6vzx5heAl4jr8sjlGa8TFAB5p7Rl52/e33gNOprLFxtvOPmnt+
 Cid4oNdZ8LsKVIIR8410Un8IpgZE9SIQPezh0jNkU33Y4nKCpxjuFhJQUPsjSPG1ID/1
 iMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GlnJADtheWLSMIbG8F1swPuxgd1Nh5Eic2eEJWoP9wk=;
 b=QlMY9YUHBiC7KKDL7nd+XFkiA+4mMKJgd6nxOTUamSTrQG/SkEq/8mg1OH6IMNJ//6
 o+eq1ZYCRmOYI6vjuz8HINb6DQm3XO5M3ezhu/MdJqUgZZONOjIHzNBV2wzgRuU0fYfg
 hiYpL5If0X+zn+oaDOyzsFPQ3hDvm2cmOnl/+uArKQV6Sb7iBrmd34iGU3cdA/eCGD5h
 83ij0e9iP9FcyqVmKlQc9FxUvXjq810inpM88Sw3iP1SvLpmOmimE/ugWNOSQA7D4x3D
 JXEIObw9gKo4+z+voXlFoUT1bbiMhzfTgbf7BGimNC6HKoWFxs0nZsTpgVUV22jlLsVi
 nfNw==
X-Gm-Message-State: APjAAAU8RqZ3Wb1sYi1tGc9wzTdMuad2RIdJTFc1dzg1dtjw7v6bYBPp
 O5v7p9rmGbH2Vaq2bZ4IJ/tM98MisMeucg==
X-Google-Smtp-Source: APXvYqyjMf391ICvGFnRkJcZIko4+Dpihr/9cGbEsuqulTge/Fu7QhNwvYemyI2ylaUX8inhfLnhNw==
X-Received: by 2002:a62:1958:: with SMTP id 85mr93972334pfz.221.1578086706488; 
 Fri, 03 Jan 2020 13:25:06 -0800 (PST)
Received: from localhost.localdomain
 (59-100-211-22.bri.static-ipl.aapt.com.au. [59.100.211.22])
 by smtp.gmail.com with ESMTPSA id c15sm16668907pja.30.2020.01.03.13.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2020 13:25:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] capstone: update to next
Date: Sat,  4 Jan 2020 07:24:57 +1000
Message-Id: <20200103212500.14384-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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

I keep hoping that there will be a new official capstone
release, but I've now waited all of 2019, so I'm going to
suggest updating to the head of the development branch.

That, at least, has significant benefits wrt read-only data:
writable data down from 1.5MB to 48 bytes.


r~


Richard Henderson (3):
  capstone: Update to next
  capstone: Enable disassembly for s390x
  capstone: Add skipdata hook for s390x

 Makefile           |  2 ++
 disas.c            | 40 ++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.c |  4 ++++
 capstone           |  2 +-
 configure          |  2 +-
 5 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.20.1


