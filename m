Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9A1C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0412082F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTpaWRjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0412082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNFG-0007ki-JJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKNEG-0006JI-JZ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKNEF-00080L-LR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:40559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKNEF-0007ti-Fp
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:23:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id s8so6618951wrt.7
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8sCkq4ekfkohDaPAcnhgbzeFwXLhPDoN24GtgfbGCM=;
 b=hTpaWRjB3ObzYYIedFnKf67+klsMgxz1TBZNLzp4FxJF+1FrjlQejbTYsn9Zqxc4Ka
 RXirh6G07syeBayWknvVBhz/8iUY5GyJw+LMRVuf6uV6JW3fWb85aTD/W3GB2jlvTK/H
 CwuztlKnZ73Dg5fHCFHFKhiXrLBfI1Q+/BffqvUTfRPJuNOV6Srs5sX5K41fO9ZxoTzJ
 1dqiFBlwKzXperLrLIm+/Lco2txFuh7JV5uAVOhPdmUe7Gg1K9/7/w+wD1b7vPXFZCox
 2uigYOPRsZAO6MniaXQNIC2Moa/6L3Op7+WDvdNEFdz4noLh0WuSWYHg0+kum8uyDU2S
 tE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L8sCkq4ekfkohDaPAcnhgbzeFwXLhPDoN24GtgfbGCM=;
 b=RC1ApAiAxZZ940nDC5QNnBOYxLtuLjBQmU0ITRwf19vth8o3ZDanWo607UP0N4deyL
 kloqri8QAI5/NdS/B5hOS2IKInRrYBBz9fLndh/GAAPzm0Tzi7Zh94x9Yk28O6uu+8JR
 Od+3Os5gs6XlUISAVDRcvt3O1JePBTvFxhE6RESHQkrTQWyTzyF+iGi+aGCQZHCITsLb
 JpR9UDPDw7lD32NdEq4HwFfea/rENuto3HVFak900aSsnPZae2jpWe1gPYWmdDOqliSV
 E9VF2DQiHejGFowGrkphP96s6GmmL6zm3Y9YWfI7u/ppJmgoBlHadIxrOD+yGOKwxBU2
 e3tg==
X-Gm-Message-State: AGi0PuYXpVTjlkE62nFlxy1sPJDfWuvyl23QBbddoEnvRxops158dv9z
 3X70ydIuMideiQbm5ToCkPHWw6DAqAc=
X-Google-Smtp-Source: APiQypK92MaI6axdhwGMYJbzXu4qg3yRyXdQIg6YwYX3kqANr6Hln2p9wzviPg1QyHibztcR6QJr6w==
X-Received: by 2002:a05:6000:10e:: with SMTP id
 o14mr8983072wrx.231.1585923804411; 
 Fri, 03 Apr 2020 07:23:24 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-167.inter.net.il. [84.229.154.167])
 by smtp.gmail.com with ESMTPSA id i2sm12218646wrx.22.2020.04.03.07.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:23:23 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/5] hyperv: VMBus implementation
Date: Fri,  3 Apr 2020 17:23:03 +0300
Message-Id: <20200403142308.82990-1-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: pbonzini@redhat.com, vkuznets@redhat.com, ehabkost@redhat.com,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a rebase of the old patchset from Roman for HyperV VMBus
implementation.

How to use:
-device vmbus-bridge

Later on new paravirtualized devices can be implemented on top of it
(Network/SCSI/etc.)

Jon Doron (5):
  hyperv: expose API to determine if synic is enabled
  hyperv: SControl is optional to enable SynIc
  vmbus: add vmbus protocol definitions
  vmbus: vmbus implementation
  i386: Hyper-V VMBus ACPI DSDT entry

 Makefile.objs                  |    1 +
 hw/Kconfig                     |    1 +
 hw/Makefile.objs               |    1 +
 hw/hyperv/hyperv.c             |  250 ++--
 hw/i386/Kconfig                |    1 +
 hw/i386/acpi-build.c           |   42 +
 hw/i386/pc_q35.c               |    2 +
 hw/vmbus/Kconfig               |    3 +
 hw/vmbus/Makefile.objs         |    1 +
 hw/vmbus/trace-events          |    8 +
 hw/vmbus/vmbus.c               | 2422 ++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv.h     |    3 +
 include/hw/vmbus/vmbus-proto.h |  222 +++
 include/hw/vmbus/vmbus.h       |  109 ++
 target/i386/hyperv.c           |    2 +
 15 files changed, 2986 insertions(+), 82 deletions(-)
 create mode 100644 hw/vmbus/Kconfig
 create mode 100644 hw/vmbus/Makefile.objs
 create mode 100644 hw/vmbus/trace-events
 create mode 100644 hw/vmbus/vmbus.c
 create mode 100644 include/hw/vmbus/vmbus-proto.h
 create mode 100644 include/hw/vmbus/vmbus.h

-- 
2.24.1


