Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9527C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751D821479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 14:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUqpQ6K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751D821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hUW-00032i-0a
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNi-0005Ku-CW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7hNg-0004xP-UT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:34 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:36619)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7hNg-0004wn-Ku
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 10:44:32 -0400
Received: by mail-wr1-x42b.google.com with SMTP id y19so20838250wrd.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xTjf3hmMk5rbmJgPO5PWGWbjlNL8080SfY7U6rGODTo=;
 b=bUqpQ6K5odLPzxzHikD/LNM/4ehLGw8tz+HBXQ0FQgvStfMhmDKDw6wucYPtuA6b7d
 zGolzHBXoKBxsjjwtTwGFC8Lvp40WGguivRLGy5FLcETEC3s6It/ln/p9jlpORdW7rSP
 uTdudX+i8cuT5qcLNC5MYrneALDOYc943GcHHU/6YrHiVlUZFxD7z340hcyvSJtmETE9
 IK/NRc5hA0Cl3aJXA/2a6WUPAii3gS/VlLJHyxJOZ500ZJ1vpM0fcKyhBfapeEZjtIPh
 z1Cu00+Qi0T5cLrzcNfr8f++HZdLToAvDZeBtVfKXBWdR4YFIyIPaHQ6Y1Sh2xqLQHK+
 ylGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xTjf3hmMk5rbmJgPO5PWGWbjlNL8080SfY7U6rGODTo=;
 b=Gp7AW8ovZ0pNTRwA/BDM/OC+CBRr/3fu5a2entQPRdHcyw7Oox3D/FfAaUhs8U/smb
 XicULdj1d5X/vJnzE7YkRMAlQRmf8FmNkApS1f0tW1kLYtUX7NUlKHaZLt6m2kyoGl0D
 Tq8KMTwwsILYW4qAjAlZOif26U1TqpStMwjG4mbGUBAwGmA3X0Nci5pf+jSJiICMV2O4
 rpVoWU+Itj3yP/1F3XiiD+dD2QNSrHEhp16sWXr+8JIA9hIbJOQdBRZ54nvQC2ehgKM2
 mgXYsWadPup3kaO2rSz9Lfg9hMeQm+1IGJ4Jw4z/PSVnNuhhUQMLMZXchPzgCf/49SLa
 ilIw==
X-Gm-Message-State: APjAAAU3m+6IoWpN2sYU74ZmLn4YNDD3FhW68yYRnVnqkSdh+d028ixP
 vPNFxJ32Sz2V4MSFZ3uUdZOCZQ==
X-Google-Smtp-Source: APXvYqy2DW/PTCIhH6eGxV3ioXMM2UKzrw+zK2KM1HdkOcPTwURxC+qSNInGMcjaiiTMuCWvd7z0JA==
X-Received: by 2002:adf:e2d0:: with SMTP id d16mr15254677wrj.245.1568126671179; 
 Tue, 10 Sep 2019 07:44:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a192sm5703814wma.1.2019.09.10.07.44.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 07:44:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 15:44:15 +0100
Message-Id: <20190910144428.32597-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PATCH 00/13] target/arm: Implement semihosting v2.0
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

This patchset implements support in QEMU for v2.0 of the
Arm semihosting specification:
 https://developer.arm.com/docs/100863/latest/preface

Specifically, v2.0 has:
 * a mechanism for detection of optional extra features,
   which works by allowing the guest to open a magic file
   named ":semihosting-features" and read some feature
   flags from it
 * two defined extensions:
  - STDOUT_STDERR lets the guest separately open stdout and
    stderr via the ":tt" magic filename (v1.0 only allowed
    access to stdout)
  - EXIT_EXTENDED lets A32/T32 guests exit with a specified
    exit status (otherwise only available to A64 guests).
    This is something that people have been complaining
    about for a long time.

(Technically some of the things we already support, like
having an A64 semihosting interface at all, are also part of
the v2.0 spec.)

This patchset:
 * fixes some bugs relating to errnos in some cases
 * makes semihosting hand out its own filedescriptors rather
   than just passing out host fd numbers
 * abstracts out the fd-related semihosting calls so they
   indirect via a function table based on the type of the fd
 * adds a new type of fd representing the magic file
   ":semihosting-features" which is used for feature-detection
 * implements both of the extensions defined by the v2.0 spec

I've tested this by improving my semihosting test suite:
 https://git.linaro.org/people/peter.maydell/semihosting-tests.git/
(if people have other guest binaries that make much use of
semihosting then testing would certainly be welcome.)

thanks
-- PMM

Peter Maydell (13):
  target/arm/arm-semi: Capture errno in softmmu version of
    set_swi_errno()
  target/arm/arm-semi: Always set some kind of errno for failed calls
  target/arm/arm-semi: Make semihosting code hand out its own file
    descriptors
  target/arm/arm-semi: clean up TaskState* usage in non-user-only code
  target/arm/arm-semi: Factor out implementation of SYS_CLOSE
  target/arm/arm-semi: Factor out implementation of SYS_WRITE
  target/arm/arm-semi: Factor out implementation of SYS_READ
  target/arm/arm-semi: Factor out implementation of SYS_ISTTY
  target/arm/arm-semi: Factor out implementation of SYS_SEEK
  target/arm/arm-semi: Factor out implementation of SYS_FLEN
  target/arm/arm-semi: Implement support for semihosting feature
    detection
  target/arm/arm-semi: Implement SH_EXT_STDOUT_STDERR extension
  target/arm/arm-semi: Implement SH_EXT_EXIT_EXTENDED extension

 target/arm/arm-semi.c | 613 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 513 insertions(+), 100 deletions(-)

-- 
2.20.1


