Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8123FC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D27320828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHCrmngU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D27320828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSK9-0004r1-HQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSB6-0007xT-JL
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAg-0007FN-Fg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hgSAg-0006yL-9V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 07:02:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id f9so2006743wre.12
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 04:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dcB8BYSGUn66tEC53pOClW1bq1/Id357LOxsMrnpnLQ=;
 b=OHCrmngUrDmHQWiYFbVqrFKNiHsYjdujrS2wHa7KSVe/2gIvtwpy5zaUoxH9yvvz2P
 uksYH4rR30w1+9rouvED0GLtM0xy4Qp5g432ZmIfBPQtN0+wlEHAq7A2ZP8wEXcREiJK
 mI0gpjUlmGTF3ehaGWdJ9LATAL8wdSogpD+GZ4GJk2yRKcOJ0g+B8EWhf0gxRj55uonw
 Jz08gJZ1n0zbwEPFwyIArzFSg92y3Dp8aMz1eAhwleTU+EKPY8+Hg4l+PODjayss3NIz
 iCCrCKdWHxwxOBY28dM4Q2a63pnnAHvWeXNdYGnS1btlm5KrS38dZkOG4Ia4YiCqYnAU
 gBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=dcB8BYSGUn66tEC53pOClW1bq1/Id357LOxsMrnpnLQ=;
 b=URDooDmDZOKAE2HI7H68pNEwIripJ3BJBnLic8IP0uBKWV10/ulKI9IaxD6KHTmBi6
 5g+srVN8WGXBWnC04NAkEr7y/MfE/DB9qc/g61Zjg3wVMYy/bQBOInahqujQ5O2ymvGP
 Y1pqzMGzDe7co1VUcwh8VusXC7AVM8qbDgD4rBi+C133k/OJsA+NANqBX6y8I9dWdTS1
 Iy4mhJK2i6SIWrCTQqnlrWkRBBie6n/JO2iK8fk4bLFYPrnUiPYdHTiVR/vUt3Cs4MII
 ZKZ2zxgCJmMWI5h0EFQQML3OuaktsATJWm5KtZ1DhCwqhxGDXM8YQIW64Us700w1e55M
 4EoQ==
X-Gm-Message-State: APjAAAWRQAupEjEmI8212PZvSWvoRydu28Q1UUqXTY8/H4FS160G/Wek
 NhpgnWWjX69gKCJwbP17FK+WJ3h9
X-Google-Smtp-Source: APXvYqybPPHqISj7zAmkseKkbPFxV7g1zRre1Jelb9RsYM60103tuAvRsZq7qspIz++8aEuq8FY25w==
X-Received: by 2002:a5d:4908:: with SMTP id x8mr2717845wrq.290.1561633330669; 
 Thu, 27 Jun 2019 04:02:10 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id y18sm6368968wmi.23.2019.06.27.04.02.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 04:02:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 13:01:56 +0200
Message-Id: <20190627110201.1999-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH 0/5] tests/acceptance: Add tests for the
 PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Collection of various user cases from different mailing lists.

Quick tests worth to avoid regressions, idea from
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
"Maintainers, please tell us how to boot your machines"

Regards,

Phil.

Philippe Mathieu-Daudé (5):
  tests/acceptance: Add test that runs NetBSD installer on PRep/40p
  tests/acceptance: Test Open Firmware on the PReP/40p
  tests/acceptance: Test OpenBIOS on the PReP/40p
  tests/acceptance: Test Sandalfoot initrd on the PReP/40p
  .travis.yml: Let the avocado job run the 40p tests

 .travis.yml                      |   2 +-
 tests/acceptance/ppc_prep_40p.py | 150 +++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/ppc_prep_40p.py

-- 
2.19.1


