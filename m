Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E1BC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D936A2064B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDdl5MLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D936A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idF9m-0003sX-4p
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1idEXz-0003Ka-3H
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1idEXx-0007tk-ID
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:25:30 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1idEXv-0007kd-DJ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:25:29 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so7962982wrw.8
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Eea0WX9KA4AlsRKFxgjV5UrPcoF5uGNUHKNO/XsBxco=;
 b=qDdl5MLTb3bICzUm74XaO66YfYK/tNd55fR8VkobXyD2hqjhbeZiUbvemhLbr146zT
 AswpzEX8X3KWIbWdDU+BTzT66lF1WXHAUBikreEjt/r8N0hKaCKwgMB8BzZXAUqtwBHo
 dgiNy4WBGSPf0DtytUryAP487wgk30wEXYX4HfLp/V4a3uyYSGPIjXifmZfEEqbAmN56
 jcmlPudEDth4GtXISw4gXjpjJy2Ri0hglCUcMsKItQP5lpKcFSSEsmjWDZIL8rmvi8kD
 NikZpcPoJe6289ikhSgvF6OEqWE27/scFLv45rANoKoUgaZlywlgd2Hsc1fj7LYo185h
 nEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=Eea0WX9KA4AlsRKFxgjV5UrPcoF5uGNUHKNO/XsBxco=;
 b=EaSyV3gGj0NcH/WVMTi0z57OXi1nOs3SJae4xz2IhoUtJ+2kgkXegqJXs1yr9N4i5+
 hK/mQYW9N2QL8fQbYGrsS0277v2ib07+8H3V9e68rOoy3BSff0jC62f+UcQkdQ+LJxz+
 VeOtVpArYImilAeJ4AbMKXUpWAwnUYrWWMYizVlBNIPVMTgv3en887sJe9+1B7ysJHzT
 C6VdMFLrjpc7antHmQAY2/O2Z4Ipu4kgiqOV4jrKNua114TzI9yAiE9LeWfJbQsDWPW5
 pd08u8Grszc+10uV9i4ZAcK01UHyczJKVFUQVP0kU3wkOfETAZwZZMrcZCK2dgq1Vpfd
 RWqA==
X-Gm-Message-State: APjAAAWCVm81Glfc5YD76Sit9DoNqE4Hs61h/azMXU50debKIQkaVCa+
 n1ocuGG8ONTR5H1IwTkr5RcLRf0t
X-Google-Smtp-Source: APXvYqzSFhAH00/dzvPmZlTlzNstSu3+1SFO4u2sbKBVCpPe29Uj1uK5ydI5XrU4uo8zbLOx7U2z8A==
X-Received: by 2002:adf:f847:: with SMTP id d7mr15917933wrq.35.1575632197223; 
 Fri, 06 Dec 2019 03:36:37 -0800 (PST)
Received: from donizetti.redhat.com (nat-pool-mxp-u.redhat.com.
 [149.6.153.187])
 by smtp.gmail.com with ESMTPSA id s65sm3181026wmf.48.2019.12.06.03.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2019 03:36:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] KVM fix for QEMU 4.2-rc
Date: Fri,  6 Dec 2019 12:36:34 +0100
Message-Id: <20191206113635.6570-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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

The following changes since commit 1bdc319ab5d289ce6b822e06fb2b13666fd9278e:

  Update version for v4.2.0-rc4 release (2019-12-03 17:56:30 +0000)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2605188240f939fa9ae9353f53a0985620b34769:

  target/i386: disable VMX features if nested=0 (2019-12-06 12:35:40 +0100)

----------------------------------------------------------------
* fix for x86 KVM on older kernels (Yang Zhong)

----------------------------------------------------------------
Yang Zhong (1):
      target/i386: disable VMX features if nested=0

 target/i386/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)
-- 
2.21.0


