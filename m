Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5A5C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9839208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYM/DIXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9839208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho4Q-0006NN-Sa
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2m-0004t8-ES
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2l-0004TD-AQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:56 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:42724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2l-0004St-4U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:35:55 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n127so4723042ywd.9
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62n94QOWDrXpNL8BzKpDSz1zbBlW0NpsHbWOoqaeItE=;
 b=oYM/DIXJf/4O/AedIEIBEjZFI2RfvWRhWoyFfl5mwxbX0jkrpx7z5Nd+WZpN/G2tfU
 F1DiojwIBRunjXqqqrY3FVNAp1wVKUR2FGXBANHIXwtzXlL0khhy60leG5tyC2Ely5pq
 ZkBKohpAwtuGJKDqA45MVstuuhCUVpoyosSTN1LjPj+mf5oDSVEm/CquJbl4TbaFx+48
 nFPc77TMmzSsG62a1KDLL9mpU+Px1nBN9ymZUcY5KAZfySN5IQZD7RlC2TZx6aCMZ3Y7
 2SKkrec3WGFZ3/20s9xEVyqkpyBRCi5t71qPXLhPGrWZLYkmZTiYJ/tezuM+3MYFqzy0
 tFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=62n94QOWDrXpNL8BzKpDSz1zbBlW0NpsHbWOoqaeItE=;
 b=WUYGe2bEaa8sDhE5JdndZ6RVQZkgnj/PM+5yQz8chubdjKJHtrJad9Jo6uh4Hds7MD
 jgvs6X012mG9atjiksugtpCl57ymXlWzwv6sWRIj14iYq8fJViFDu7gKDjmCo1pVKrCK
 IDUK8+YayoMN/SLKSS9xaxe6iKJbjgVzreC9BAiKQasB3bfK8fRNo/UpRJQSHv1PZhwc
 wvH73c7/Zl9n7zj/9CP5ljDZevBJVZC2O05kyyS3vCmUeIHRlztiK33tTlK2bmJNZYeV
 nSo30YDmmRkZzxJKZ3DNoMvfNMseRo55RU0OIunitmZlVL+IsUnWaAfyGHEOBmCRTNI7
 AZBg==
X-Gm-Message-State: APjAAAXJV83LjneBf+RQZ+kJ7BaIQI+ag2uP8D/ZEaZnrBar48dPycoE
 ZYSEkg2tptleZ7ZRoA3uSK8Tp9jA
X-Google-Smtp-Source: APXvYqy8n9Zh6vKmkTVZThrw+eb/YDm+x3ZSh2ID1lU/F8fIG176qmKuUNG/IrNc7Ts7pUudp6QlYw==
X-Received: by 2002:a0d:eec3:: with SMTP id
 x186mr14339257ywe.510.1561955753583; 
 Sun, 30 Jun 2019 21:35:53 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:52 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:22 -0400
Message-Id: <20190701043536.26019-1-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RISU RFC PATCH v2 00/14] Support for generating x86
 MMX/SSE/AVX test images
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

This is a v2 of the patch series first posted in [1]. This version also
implements the VEX prefix, hence all SIMD extensions up to AVX2 are
supported. Notable exceptions are LDMXCSR (cannot constrain memory
contents yet) and all forms of VGATHER (VSIB not implemented).

Note that this is still not the final version; I am planning to
implement randomization of VSIB to test VGATHER, and improve the way
registers are randomized (as discussed in e.g. [2]).

Changes since v1:
  - risugen_common: rewrote insnv to make it clearer, added a comment
    to randint_constr;
  - risugen_x86_asm: fixed a typo in rex_encode;
  - risugen_x86: use more than one opcode in write_mov_reg_imm to
    optimize space usage;
  - x86.risu: added all SIMD extensnions up to AVX2.

References:
  1. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg04123.html
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-06/msg06489.html

Jan Bobek (14):
  risugen_common: add insnv, randint_constr, rand_fill
  risugen_x86_asm: add module
  risugen_x86_emit: add module
  risugen_x86: add module
  risugen: allow all byte-aligned instructions
  x86.risu: add MMX instructions
  x86.risu: add SSE instructions
  x86.risu: add SSE2 instructions
  x86.risu: add SSE3 instructions
  x86.risu: add SSSE3 instructions
  x86.risu: add SSE4.1 and SSE4.2 instructions
  x86.risu: add AES and PCLMULQDQ instructions
  x86.risu: add AVX instructions
  x86.risu: add AVX2 instructions

 risugen             |   15 +-
 risugen_common.pm   |  107 ++++-
 risugen_x86.pm      |  498 +++++++++++++++++++++
 risugen_x86_asm.pm  |  252 +++++++++++
 risugen_x86_emit.pm |   91 ++++
 x86.risu            | 1026 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1977 insertions(+), 12 deletions(-)
 create mode 100644 risugen_x86.pm
 create mode 100644 risugen_x86_asm.pm
 create mode 100644 risugen_x86_emit.pm
 create mode 100644 x86.risu

-- 
2.20.1


