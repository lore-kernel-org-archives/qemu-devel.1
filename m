Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C80C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0E62083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKzSDNbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0E62083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4B5-0002xf-1l
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49o-0001gF-ER
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kQ49m-0004Cf-VI
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602056798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aOZCfLbGzFrrvXBjwyTT2gCd6RbFvtyRcpkBW+tRCSE=;
 b=PKzSDNbomyCA8tS7SX0UHH9ttH8MjV5mHopXTJVrPQNCDsTkTep1byuerNL9Sp3TTv+Z4a
 NcgdfDKcAPd+jgwS4BCjsNpBuqywrnb3iFvzgA9ss6cxP7yzQ8VSCgKUIMn1Cgliy4K/Yy
 XcjLb35Nxl2AiPjwrYvbtEbgBfmARd4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-PJwsnS2sMaGrmTIIsNuu1g-1; Wed, 07 Oct 2020 03:46:34 -0400
X-MC-Unique: PJwsnS2sMaGrmTIIsNuu1g-1
Received: by mail-wr1-f69.google.com with SMTP id 33so624423wrk.12
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aOZCfLbGzFrrvXBjwyTT2gCd6RbFvtyRcpkBW+tRCSE=;
 b=khX/qcA+IQzTczepZ2RNAULJxF5H/F5iGOHfgd/Fwtv/+uTCmTgy8U36lK+iruwaZ2
 Z7XJtW0YQSlKvZ2Lr6iE1JuZOeAECAQV65oB0KVTwvFNo0lunh7PkPvPOl4Vw2KQWJqk
 7Hb4NuHVIx2q2AHusruetXOBeu0VM0AfG1JjQh8fLBeVzpO82SWCMo6CVK2mutV6sIGb
 Y/w6SLsh8ZMGSJIlS3MrvwvpdL9nnvX5mzYx4fit3OZWpzOYaw+jxxUNKdlOXzxEBE/U
 X0G00kan0TukkhLQXb4i9lCLMSaqcf+kRqPfcjHZMGWqwz5WbN0yGp48gn/7Q0HvWk9y
 ChPg==
X-Gm-Message-State: AOAM5325INaxCybmG6bksib680oNuOv5Uy+NrZTNANnsNvwrHNZA5iKX
 HeZqZh6fKpCmK2GtRbp/dD4O49CxWdstwYy6egANO6vPgVlv4/hpzLVziO7FqrRfuq6ezZA0fTh
 NEXOrjIp3gIqXdXs=
X-Received: by 2002:a1c:6743:: with SMTP id b64mr1733786wmc.157.1602056793225; 
 Wed, 07 Oct 2020 00:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJQEDmffntQbpfULo6cuJKWkKoCSvNiRbpnQdxcyhjxr/MJWIWj5Xf5M959RNHMIEe2gVcYg==
X-Received: by 2002:a1c:6743:: with SMTP id b64mr1733762wmc.157.1602056793020; 
 Wed, 07 Oct 2020 00:46:33 -0700 (PDT)
Received: from auriga.redhat.com (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id o14sm1505615wmc.36.2020.10.07.00.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 00:46:32 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/3] qga: add command guest-get-disks
Date: Wed,  7 Oct 2020 09:46:28 +0200
Message-Id: <cover.1602056784.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 qga/commands-posix.c | 287 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c |  92 ++++++++++++++
 qga/qapi-schema.json |  31 +++++
 3 files changed, 407 insertions(+), 3 deletions(-)

-- 
2.28.0


