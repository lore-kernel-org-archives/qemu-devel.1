Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6CEC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5DF12229A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 05:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cB0zrwSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DF12229A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpQwF-0003an-Lu
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 01:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <npiggin@gmail.com>) id 1hpQw2-00039Q-SP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1hpQw1-0007Dl-W9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 01:32:30 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1hpQw1-0007Cy-RS; Mon, 22 Jul 2019 01:32:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id u17so17093152pgi.6;
 Sun, 21 Jul 2019 22:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M7FSRcmoYJHaIWDpjU4QKCYnCqNouuFeSRCT2wJ/XcU=;
 b=cB0zrwStabUEaOZi0hR68fUIYlHOUr+0ICvrzYS0YxA0LzhGKhENwOxO1kDRGsooj/
 DWXjq+HbaVx5QRYHFVjvjYKjv1CN/T/OUw3ENBU6ul+2CyS8Iy5JDL+cN7Z1ZAKbDALf
 +hTHTO4jwxGrj5MNEx0LJrWQkObACGPa98T2aEXTqeDhbgtD71psQg+BkepTkQw4flsp
 heJCyCJxuxSSodyfSYtRAZ1huCEKIeWTybFGmlZVWb8Urjn2Pa3+Yu40IK2YHrq/bJxG
 jO0l6IPkthaN+WQpUV+kYjkoFc771KbtvrAMXxiCqPv+wFLl+7VkOoexWSHEjxQ84Ucd
 RkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M7FSRcmoYJHaIWDpjU4QKCYnCqNouuFeSRCT2wJ/XcU=;
 b=hfYepGVw+Z7ivk78yluD0/A/vnD1krxh4x+JgGY88AAOta48Vi6MIjwGihfQ5HvXal
 nsKPnhB7B+21VKjKGdpHtvz5G2IlUW+ZU7ce3KK7niUOthy/+vjiU6L0/B9mADQi5m12
 zcUc6fJ4BwisFRdGUijsCg8JOXa4gamF3dJxDIyCR9XYyHp4H7JxuCFD89beb0yaMLxw
 wW3rNu2xyZVEPBg847I6YhELMlFQUkxeSyRzQdKCD2UEhsQBXEI//DGXNF5WG+UGhsub
 +3g0gK5wOeOLnSeFaDR+HlpVG7KbBs/pI4V/r9HZd/hz6HB3cNi6jeITKqQc2roeutRQ
 pqDw==
X-Gm-Message-State: APjAAAUMte4uX6jTN+VfKFAfYYR/RFEt1R2TdQ2VlHvoRs7kophW5Kh0
 b1YBk7C1N+PA4KFOC7D0CrOHQjHnHMk=
X-Google-Smtp-Source: APXvYqytT2krPlBJKuE8/WQjzDSF3WfdpY5XcEjs3N+9XVEg+mJqoc1TbuutsUPu2N8YPgicauRQgQ==
X-Received: by 2002:a63:b904:: with SMTP id z4mr68480832pge.388.1563773548610; 
 Sun, 21 Jul 2019 22:32:28 -0700 (PDT)
Received: from bobo.local0.net (193-116-123-212.tpgi.com.au. [193.116.123.212])
 by smtp.gmail.com with ESMTPSA id p7sm40281670pfp.131.2019.07.21.22.32.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 21 Jul 2019 22:32:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 15:32:12 +1000
Message-Id: <20190722053215.20808-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v2 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, this series is rebased on top of the qmp event fix, and takes
Paolo's suggestion to implement ->wakeup for i386 before adding
ppc, which makes it much nicer.

If the first two patches can be agreed on initially and merged, I
can take the third patch through the ppc list after that.

Thanks,
Nick

Nicholas Piggin (3):
  machine: Add wakeup method to MachineClass
  i386: use machine class ->wakeup method
  spapr: Implement ibm,suspend-me

 hw/i386/pc.c           |  8 ++++++++
 hw/ppc/spapr.c         |  7 +++++++
 hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
 include/hw/boards.h    |  1 +
 include/hw/ppc/spapr.h |  3 ++-
 vl.c                   | 16 +++++++++++++++-
 6 files changed, 65 insertions(+), 2 deletions(-)

-- 
2.20.1


