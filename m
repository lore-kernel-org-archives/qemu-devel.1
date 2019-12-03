Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D900C43215
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8FCD2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffXoXaYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8FCD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3Lx-0004Qn-24
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ic3Iy-00033c-J9
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ic3Iv-0000CK-Ff
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37664)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ic3Iv-0008P3-6n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:13:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so2365945wmf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n63209VtnNR9i+NWxkRj5oWetsPQlEgQRscph+/shdQ=;
 b=ffXoXaYqreEbuerXRoCM9mjBoMuhKLIoiy3Qp10Xa70iEiumqdNCK1Mxry/Fnmp3qu
 B9Xv5ymfMsjEB5dz6pvSAjkaaIn2kIN3/roUqqH/ueRGp+9zWGDMqRnR5OVNBG1v4JwI
 NRHfMjwlB9+mKyg5O3RbZQwZaMT7QNX2mu0R63TB0/tzR6a0IwDOIuiLA67nOe2OE+Bs
 kAhjXKIGhJJmlEprKp5Rm0rplMkiyEKKCWzMuJ2X1Wv2nqgngng1D6nS3c+/kS6LVru6
 cC+M0CHgyNjjEK9D27ZvHVVkuOuAWDf8EJTu3bTKgszyHjYhC7j5alr8CVPT6DTaYFrJ
 31OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n63209VtnNR9i+NWxkRj5oWetsPQlEgQRscph+/shdQ=;
 b=Iu9NG4rA4+HVDR81R2+n+FB5i6jogDMU5gXDH7wRkYr21kqtmXrZGL+T5L+sy8gdsT
 UBmHhABxqe/fCPJ0O1Sq9DabL8xKYRFeOd8L8cMigGfIZU3/77hY8HqnP0fryKUKZQrl
 PIJmr6915JbyKu1LyXMn88cktUZiMjHjTfJn1bYEubQgNVcZIBBDfpoLeCE/UH3kgStB
 3Ol6uhQfyyTMLh14w2WLKvsWvUP5Xoalcz5hUHrf5ckc/U1vZXXF5kkJntQ/WwIxZWBG
 jiEHeGkNWzm0KDgwcOWY7hfoTeXpLRY3iCUhRMjpnZ6RNs2hhfRK7hJ0yN0ggRb82m37
 DaWg==
X-Gm-Message-State: APjAAAXQSq+pzeX0alGFchqrLkr4TMXNXGCtzHPFsj5Xld0KlQ4+rA+i
 eBFw48SlGwCyBHIwLvD6W5XiURev
X-Google-Smtp-Source: APXvYqwV7f6XSRNGfRSm9vn6QLREscetkkUAGCyXuhE1JvugeOKoy0iu9EXN/DAACPgs+7Av6X1iwQ==
X-Received: by 2002:a1c:9a45:: with SMTP id c66mr29330100wme.107.1575360780620; 
 Tue, 03 Dec 2019 00:13:00 -0800 (PST)
Received: from donizetti.lan ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
 by smtp.gmail.com with ESMTPSA id d14sm2711593wru.9.2019.12.03.00.12.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 00:12:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] HVF fix QEMU 4.2-rc
Date: Tue,  3 Dec 2019 09:12:58 +0100
Message-Id: <20191203081259.906-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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

The following changes since commit 39032981fa851d25fb27527f25f046fed800e585:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2019-12-02' into staging (2019-12-02 16:29:41 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 64bef038e777208e4c35beae7f980fbd994b87eb:

  hvf: correctly inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR. (2019-12-03 09:11:42 +0100)

----------------------------------------------------------------
* last HVF fix (Cameron)

----------------------------------------------------------------
Cameron Esfahani (1):
      hvf: correctly inject VMCS_INTR_T_HWINTR versus VMCS_INTR_T_SWINTR.

 target/i386/hvf/hvf.c    |  4 +++-
 target/i386/hvf/x86hvf.c | 14 +++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)
-- 
2.21.0


