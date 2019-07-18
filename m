Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFDC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40AA221783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 10:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaciHP/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40AA221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho3px-0003ic-8T
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 06:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1ho3pi-00032R-E8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1ho3ph-0000Wv-Ez
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 06:40:18 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:34970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1ho3pe-0000S8-Dx; Thu, 18 Jul 2019 06:40:14 -0400
Received: by mail-pg1-x544.google.com with SMTP id s1so6404419pgr.2;
 Thu, 18 Jul 2019 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VoU78vkRfZNKUvIBmmoiil699xg9w0xbDVDY9dS5Tys=;
 b=ZaciHP/yB7sa2BnZeFOv76gM7fh4d1g615CaMAXwr2iENgdeVTZIM2I2H4Q9Yco9dA
 gxd3Hptt8wDvRwsteXA8s8lpKSnGVF8VS3BT6nsRz+QdZAwICFGkj60FKc3KM6vM6Qjo
 CuhlrMSHXeq/uktcmZOnqn6tEG9C7xiUm7NatXGmA0bsQHnJlVAlr84EdighqmUqM8Gk
 cDgTejeqm/EKcGmH4A9D55a9Z7pplSlhVAPVvSU5OuR68Q5ryPUtVPY/SEiF09hTnsJP
 U8omoCbYwtQ1X9+UTGY9ssKKWoxagGTsWJq83VE6HiJKzo42u1W4Uf4pdufcQYsGWrpu
 ZL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VoU78vkRfZNKUvIBmmoiil699xg9w0xbDVDY9dS5Tys=;
 b=T/vmhItbI5lvVL6PB3yhOEch2CuFUAUdtHBMpyBpHbIVqSb4/s2PVUQkBjM3ZSyHJM
 vfcv0JH/X0KwE8aATVOttgs1AmaJaDuN8c45eHaU0eQ0X/DItfzTWJ7WFjt+BmKAKEly
 LgVZskOCS34QSlb9XHlHl4k1GHh6ukQd6aYSn+ZFOHHq3Anq+RZYJ1h1R/ZWQhFaMtV2
 QUNMIylqvIgmpFUvgEAXcuGOnZiloQeAJI1rlUBf2KelXCleJS9SB/Er63fuz21Oxsod
 CfudgwSR9ehoZfXuUT0lyYeFEjpxA6VhDeDAscy+wUJG8HRAE0fPPUQp3prZ84xYAZab
 YPtg==
X-Gm-Message-State: APjAAAWBK0OEWADG/5xO6vvoUbH14H0kR4hrqQPxy847g8dTY2WLoKhv
 N4FvDCtKZtmB0KuumEm8rZnbXt1T
X-Google-Smtp-Source: APXvYqyY+AtVCQzXAnQiXGxVjAlSPVbgOeuqAxmE7HCE0VUibOEvvaVzHSuUsZ+SI/1PKABO7prmow==
X-Received: by 2002:a17:90a:1b48:: with SMTP id
 q66mr48129044pjq.83.1563446411628; 
 Thu, 18 Jul 2019 03:40:11 -0700 (PDT)
Received: from bobo.local0.net (61-68-63-89.tpgi.com.au. [61.68.63.89])
 by smtp.gmail.com with ESMTPSA id y10sm28243415pfm.66.2019.07.18.03.40.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 18 Jul 2019 03:40:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 20:39:48 +1000
Message-Id: <20190718103951.10027-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 0/3] Series to implement suspend for ppc/spapr
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any comments on this series would be welcome. Hopefully someone who
knows i386 can give some feedback on the possible bug fix, and
whether the new wakeup method will suit i386.

Thanks,
Nick

Nicholas Piggin (3):
  qmp: don't emit the RESET event on wakeup
  machine: Add wakeup method to MachineClass
  spapr: Implement ibm,suspend-me

 hw/ppc/spapr.c         | 11 +++++++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/boards.h    |  1 +
 include/hw/ppc/spapr.h |  3 ++-
 vl.c                   | 31 +++++++++++++++++++++++++++++--
 5 files changed, 75 insertions(+), 3 deletions(-)

-- 
2.20.1


