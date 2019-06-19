Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63911C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310A9208CB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 05:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcVcoVFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310A9208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdSr5-0000ee-FZ
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 01:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmT-0003u6-90
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hdSmP-0001dT-Ho
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:07 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:42669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hdSmO-0001ab-Oe
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 01:05:04 -0400
Received: by mail-yb1-xb44.google.com with SMTP id c7so7068806ybs.9
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 22:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oHgBFtSwsKdkaL7+CpH5HEOf8Bsgg2J9D/ISE/dA+Bg=;
 b=WcVcoVFf+XZ9XSibh5o3QrKMieACPBKFlOolNAnSpvSXiMoMilz5RSoYhfbj2QxXGu
 5L8RJmoZb7wo3CSfEPYjEUsDIk2myYJZ7qqOAZ9xMcEr+YPMAWv9mbVQFdOj8dgk4yNh
 NYgcdwvwgFb12Hv1IYNu4w6n/4LG6dvzWlOA06KvCYq0OI8jJZmc+FKCwc7vD5XAV2tW
 1kU/DsHOnEYsIHzcwtrayAP3y8VcWB3iLVkNA3N9KwA0AdKz5kDgKwNUgHcJVDLoXa3T
 lMsxKYGwl/71kAyWmSkrruGDTq265SrpSoMk0wStbFhZa81omQEP4wuyecpLU1qESNpF
 OZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oHgBFtSwsKdkaL7+CpH5HEOf8Bsgg2J9D/ISE/dA+Bg=;
 b=X97MDeUz9QbdQxYkSjFNIPeloFwPB53bg/U8jEexIPLxgLHO8zL/vkyg3gKQL/82t/
 /JF9X+px6uYdLuz5w10RJDCc1pN6bfvTnbaCU7W8kRCSxMae6SCWo6lPewTuz7dfu7VP
 kv63QybxX4XgRAk+qKk+PZ5J8zvXmeo+8PX3JypEnkcLWoxcOT/IsniG4k4/0ConrsJl
 BcB0cB4Wp6IeI+CKHlYXSPSeMUCcs79PukxLwixdFurwpP5UxEN7bF0u5TFQj7CbL/lY
 iI08XffQLl6tCycObdOZecelq4s2UIHsJgQ+LiYltxWgvPxDodQggz6LwLfq9/Y/4JCK
 qp4w==
X-Gm-Message-State: APjAAAVjRGYu+/EmfOOJWiBDcdMd/HnivnrBIwh/vcvvQtE8sF400G9c
 u86nW+qcPcvvPHa4c+l9U8jXa/PE
X-Google-Smtp-Source: APXvYqxayVu+gJO8MYxh7zDKIfBs6vxbW85K7Qg51QKu0hYwNNd0PiSNvu9FDaespUjzJ+U84y1crA==
X-Received: by 2002:a5b:2c1:: with SMTP id h1mr20659935ybp.453.1560920702545; 
 Tue, 18 Jun 2019 22:05:02 -0700 (PDT)
Received: from localhost.localdomain (67-9-99-67.biz.bhn.net. [67.9.99.67])
 by smtp.gmail.com with ESMTPSA id e12sm1714426ywe.85.2019.06.18.22.05.01
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 18 Jun 2019 22:05:02 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 01:04:40 -0400
Message-Id: <20190619050447.22201-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RISU RFC PATCH v1 0/7] Support for generating x86
 SSE/SSE2 test images
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

this is v1 of my changes to risugen in order to support generating x86
test images. It's still work-in-progress (thus marked RFC; notably,
there is no support for AVX yet), but I would like to get this out
there to get some early feedback on my approach.

Initially, I thought adding support for arbitrarily-long instructions
would be more or less enough for x86, but unfortunately this turned
out not to be the case; the length variation introduced by ModR/M, SIB
and displacement fields would force us to have to have at least 6
config file entries per almost every instruction, which is pretty much
unmaintainable. Instead, I drew inspiration from the "memory" blocks
in arm.risu for specifying memory constraints, and introduced "emit"
blocks for x86. Example x86 config file with SSE and SSE2 instructions
can be found in the last two commits, let me know what you think.

There are still some limitations -- besides missing (E)VEX support,
some forms of ModR/M are also not supported (mostly because it's hard
or impossible to figure out and use the correct memory address), and
the LDMXCSR instruction is currently commented out because there's no
way to specify constraints on memory contents. However, this patch
series should have enough code to demonstrate my intended general
approach, and that's what I am looking for feedback for.

Best,
 -Jan

Jan Bobek (7):
  risugen_common: add insnv, randint_constr, rand_fill
  risugen_x86_asm: add module
  risugen_x86_emit: add module
  risugen_x86: add module
  risugen: allow all byte-aligned instructions
  x86.risu: add SSE instructions
  x86.risu: add SSE2 instructions

 risugen             |  15 +-
 risugen_common.pm   | 101 +++++++++-
 risugen_x86.pm      | 455 ++++++++++++++++++++++++++++++++++++++++++++
 risugen_x86_asm.pm  | 186 ++++++++++++++++++
 risugen_x86_emit.pm |  85 +++++++++
 x86.risu            | 245 ++++++++++++++++++++++++
 6 files changed, 1075 insertions(+), 12 deletions(-)
 create mode 100644 risugen_x86.pm
 create mode 100644 risugen_x86_asm.pm
 create mode 100644 risugen_x86_emit.pm
 create mode 100644 x86.risu

-- 
2.20.1


