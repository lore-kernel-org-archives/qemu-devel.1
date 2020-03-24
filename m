Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C62BC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD26A2070A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 21:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQazus/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD26A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGrWU-00064P-WD
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 17:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jGrR9-00082z-Ax
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jGrR6-00082o-42
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:50:15 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:41933)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jGrR5-000816-TO
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 17:50:12 -0400
Received: by mail-oi1-x22c.google.com with SMTP id k9so141201oia.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=yXg8sMM6U5FdfSVzVpi3JGnDqUoXRli4Xh2+OabyHxs=;
 b=RQazus/8H9f6z3YGQCozuMG+hfMwsxbTm7SV337akLT7I/AnJCkpKZ9UH9Qe9dXTZV
 sZXXB6HXkAiw1NfaIf8w22GNuYg58eOnCTfgUkoFVHyqzJNsV+3WnK3o73RB0adqeZhO
 eWCouJ4myo3cqf7DO8Cn3sTwIQCkLKlqq4t7yoL9x1D0VsnC2sYWYnkHclGLJrose0hO
 7IPs5CO+S+y9jC1aSqWnK5oopW0q833l/LOFuVzpcqX6NjFAgn+SDCkqKUn0cn7lfysj
 2pwxuAy9NXVwnlvnb/D2S6dVd0fG8oX9B4xBt8yWCeRngJmqFtEcf7t9/57W0do8PEtq
 tzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=yXg8sMM6U5FdfSVzVpi3JGnDqUoXRli4Xh2+OabyHxs=;
 b=ZPyZer7ctOa+Udyb+optY6cvD3mSu0Yw2DK9Rba40b8+nF341n/04i3DD9C9Ke1H4y
 9YN1kjX1JE8AbFcIAuEnw4IUyjd6NV6awJ7v92BuPT9QJDCXnUQA5kK9a/jeVxmO5DLC
 dBTGCQONslVV4gZQuYesbggostzljVEtCM8ESBCDlIIOE/+wUQ1gi3dfQPEFAH7CEVeK
 +sPgNobEa6PMsS7U9iZNaNlgL7U+kTfgYkpNkhIeg3k5STaXOMvDazdOsYJUw37mdmtK
 alNBmN/FD5V5BSQhQor8s4WO3eCrfW79MVQ7oxF7lGCgdZZQ+mwYj7frTB9wofaSq3U3
 E4Gg==
X-Gm-Message-State: ANhLgQ3fvuLfm/6i8vRvfeRzg4c1o8dMoAGsBOI9jD/yCL+yDa6RYYTF
 B+40aru9hsKzJiaBFf5amFQ=
X-Google-Smtp-Source: ADFU+vsyvvlnsp0j8tsrFsb3kJmeJR1p0JfIL+onpK1L2KR9tmoyx4wM0vULX/7qFffTSHKlwob7dw==
X-Received: by 2002:aca:3b82:: with SMTP id i124mr271277oia.61.1585086610726; 
 Tue, 24 Mar 2020 14:50:10 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w21sm5221256oif.45.2020.03.24.14.50.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Mar 2020 14:50:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <158508660355.20966.2977449825157044760@sif>
Subject: [ANNOUNCE] QEMU 5.0.0-rc0 is now available
Date: Tue, 24 Mar 2020 16:50:03 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 5.0 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.0.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-5.0.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 5.0 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.0

Please add entries to the ChangeLog for the 5.0 release below:

  http://wiki.qemu.org/ChangeLog/5.0

Thank you to everyone involved!


