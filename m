Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A6CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BE32065F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 11:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Je0rn66D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BE32065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqE4x-0008MP-Vi
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 07:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE44-00072o-Vm
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqE43-0006PJ-An
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 07:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593515074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dQtdX/Iepj7l620FVFuLcRqaReUJLFsonligtePyPJQ=;
 b=Je0rn66D6EhnTOjXiWr9OGALZDK29YY8RC4gBaHpzrM4cXgxFi+gHxDfDiPf2yvmZfktEi
 jQ4w/+yGj/sQsg8UrEicksvCkt1RfNu1KiYPk0CoTKDE1Gn6GnFgkgu4c1enqaCjaHLulC
 Id+NCpcvYAMMpf2aCniEWQS0h8WmAVI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-o66w8F3tPDWaWC8r3XZAnA-1; Tue, 30 Jun 2020 07:04:33 -0400
X-MC-Unique: o66w8F3tPDWaWC8r3XZAnA-1
Received: by mail-ed1-f69.google.com with SMTP id h5so16655828edl.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 04:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dQtdX/Iepj7l620FVFuLcRqaReUJLFsonligtePyPJQ=;
 b=racDkDU+uuhtIbA/04UlKIbq4vkRrK6J44SKSxO20LN0UgZpvARcMHZqb4/9ucz4OF
 nyDqdUsVms7W5b/2PzSvAlRdFCRwUwPcroiZ2YkZ4s1PmjV/3I7FGBMAzNViMZaCE3E+
 gNFScaF/g5PI/+iE2eykQlg9yN/aTbaE2NIjlXZhUhR2rvK75ewpSZCzGtqaN3lmOdhk
 4trQyeSprPU0Ze0+RMzqqg8NvZMg8yQvWqek4Ahju1PNUx6yTBNkeUISjoGSQCbQyX9i
 G/g7Yg98eARRsy1/sC9dBsxy00KUsXEp7imwac6+0kwvWtETw5e8xykaNI1VY8CXTMdV
 4csg==
X-Gm-Message-State: AOAM532BVd96tzKmd5scnTffcv5tJF7xyemBPQjN+4EMFLLyoJcHjA4s
 5FZI92CnxVZp81XiTCmyqk+S7wDZwZ20oY61Jez7v0FyGiyBFElUWe7ReqwBzE3wGH/On+Gdmu9
 3OXxvVvfaxk/YGV0=
X-Received: by 2002:a17:906:c30b:: with SMTP id
 s11mr18499358ejz.263.1593515071551; 
 Tue, 30 Jun 2020 04:04:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEM5OlDDjfebCOE2ywQ6CZKkIYy+ClRXbFBOzhuC5r4K5WAVH5zCKdic+RIDj8xf9ANiLN5Q==
X-Received: by 2002:a17:906:c30b:: with SMTP id
 s11mr18499334ejz.263.1593515071358; 
 Tue, 30 Jun 2020 04:04:31 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d24sm2094129edp.83.2020.06.30.04.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 04:04:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/4] hw/block/nvme: Fix I/O BAR structure
Date: Tue, 30 Jun 2020 13:04:25 +0200
Message-Id: <20200630110429.19972-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improvements for the I/O BAR structure:
- correct pmrmsc register size (Klaus)
- pack structures
- align to 4KB

Since v2:
- Added Klaus' tags with correct address

$ git backport-diff -u v2
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/4:[----] [--] 'hw/block/nvme: Update specification URL'
002/4:[----] [--] 'hw/block/nvme: Use QEMU_PACKED on hardware/packet structures'
003/4:[----] [--] 'hw/block/nvme: Fix pmrmsc register size'
004/4:[----] [--] 'hw/block/nvme: Align I/O BAR to 4 KiB'

Philippe Mathieu-Daudé (4):
  hw/block/nvme: Update specification URL
  hw/block/nvme: Use QEMU_PACKED on hardware/packet structures
  hw/block/nvme: Fix pmrmsc register size
  hw/block/nvme: Align I/O BAR to 4 KiB

 include/block/nvme.h | 42 ++++++++++++++++++++++--------------------
 hw/block/nvme.c      |  7 +++----
 2 files changed, 25 insertions(+), 24 deletions(-)

-- 
2.21.3


