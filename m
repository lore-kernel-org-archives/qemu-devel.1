Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA08C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDE42074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 08:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGbncslb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDE42074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRtM4-0004U4-Hc
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kRtJU-00011p-TL
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kRtJS-00006p-K8
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 04:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602491768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j99NTBH3vKR0X9ldo+s5mUagXWGEvm0hDA64crECKgk=;
 b=EGbncslbq6Cvy/moIF/aMdSxOBZUfuJZ0mLrwhtOZ6OHBJV0Ik6NEjBnwFJDj/8rGtBGGB
 GU3THIqzun+ZFslHNlXp//UbC1n9r3Fjf2Ld7ZRc2VGKrqak5LPHdpAA3+7Suto52evG+0
 n5H0Ktz4jgzyvW+oKc30ZGEiT+llyWA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-URu1Z7lfPlSRLcDeHy4WXQ-1; Mon, 12 Oct 2020 04:36:06 -0400
X-MC-Unique: URu1Z7lfPlSRLcDeHy4WXQ-1
Received: by mail-wm1-f69.google.com with SMTP id z7so5525297wmi.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 01:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=j99NTBH3vKR0X9ldo+s5mUagXWGEvm0hDA64crECKgk=;
 b=jw+9aztcou7Y/HXrx6O5jW2Uc2BKT0ost9kpZ2YMKVnk88Y7FPGudUV3W/kfyKlus2
 QhX0hY7s08uOtILATSK9R7k7Lv4GCVTLbEZ9LhSt9cxM112EKWhz0F5RGF0wqpIPb2El
 FvsJtyuwDbCu8CDxsoKIM4XAZsfQ6ingeOi0xLDEpSgaeTGoMm6Q2EFik2mUbctrbbaB
 GgrHriV4QXY4ixIApZMDUsM/A9/WSACoHvTn+a+4H/47pj3ocEk/T8dtN7MYE3LYd5hk
 /nPEx3tOR8pj3PPghul1zWBiFCInXKPHszhVsW4t61D5eWG1pR1hSRTCS7uWup7tLHWB
 VuJA==
X-Gm-Message-State: AOAM532IIjYprRxVHoeHKpvLpcI4/npsVt7xvoRKBQGKdMHftS0fs4Bb
 CCprxpOVQV8lmuBj9iTcE/bUVKcOvxCybw45car7y/T+Mg5aBIz2IJgAPNc6ii3cuZgxAPcUQFn
 FKXRUBYrbc6dUCGQ=
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr7695170wmj.168.1602491765440; 
 Mon, 12 Oct 2020 01:36:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxy7nDSMiL6eZQOQsRJo5qTh1rr1dgttmlcWVw7BGTw8HK9N5LxVlUCEj/iYld/YmWhH4MWQ==
X-Received: by 2002:a7b:cd85:: with SMTP id y5mr7695157wmj.168.1602491765268; 
 Mon, 12 Oct 2020 01:36:05 -0700 (PDT)
Received: from auriga.redhat.com (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id u2sm25040217wre.7.2020.10.12.01.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 01:36:04 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/3] qga: add command guest-get-disks
Date: Mon, 12 Oct 2020 10:36:00 +0200
Message-Id: <cover.1602491752.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds command to list disks of the VM.

The patch does compile on master but to work properly it requires changes to
qemu-ga by Thomas Huth in series: Allow guest-get-fsinfo also for non-PCI
devices.

v4:
- 2/3: don't leak syspath in build_guest_fsinfo_for_device()
- 3/3:
  - added ERRP_GUARD
  - don't loop forever when qga fails to get device information details

v3:
- renamed "slaves" field to "dependents"
- comments from Marc and Daniel
- 2/3: factored out pieces of code into separate functions

v2:
- added new struct in API to handle the information
- split changes into several patches
- for Linux list also slaves, partitions and virtual disks so that the disk
  hierarchy is preserved
- fixed issues pointed out by Michael

Tomáš Golembiovský (3):
  qga: add command guest-get-disks
  qga: add implementation of guest-get-disks for Linux
  qga: add implementation of guest-get-disks for Windows

 qga/commands-posix.c | 290 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c | 101 +++++++++++++++
 qga/qapi-schema.json |  31 +++++
 3 files changed, 417 insertions(+), 5 deletions(-)

-- 
2.28.0


