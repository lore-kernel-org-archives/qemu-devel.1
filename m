Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F560C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E056C2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwaI8Afi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E056C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDFg-0002yE-Bn
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEf-00029n-R0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tgolembi@redhat.com>)
 id 1kFDEe-00029G-74
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599470086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DcUt+UH83ylqUp+RroyQwxpLqBv8WcypyGpqNzZar7k=;
 b=gwaI8AfiFv7l+U98vX8U8ldKYWZRGAFsMpJ2Fs8A7cw5l9mIiq3yOWXxTrC04o99ba6Bt2
 QfpLZdLwa1ljku2H0sKjw5ccAV23P7haweopDMrlsdWEerV+FnQsgSB+1AuBNd/MgEhDiS
 5bwnJ9zdL9NBRnhAuqs0K5L0mdr9SFw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-eo09NBxjMw2M913fzmCo6w-1; Mon, 07 Sep 2020 05:14:45 -0400
X-MC-Unique: eo09NBxjMw2M913fzmCo6w-1
Received: by mail-ed1-f72.google.com with SMTP id c3so1407726eds.6
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 02:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DcUt+UH83ylqUp+RroyQwxpLqBv8WcypyGpqNzZar7k=;
 b=q9DcP45MmNXhPpJkLCVhnbpNiNj6nxEQPoLUKU/bhCKzirzP6ZwePxQ9OKznLyiDJq
 onn6ZU4TTqMvHoSVLiYsOCcvBi1pTVRqUc3Mp0fkWF01TmDrIiIKFQJGMzBQ9e5FzDma
 TSz26M/PiFKvSEpsiGeFrSH5xHSM8txx9KDZov0MWjjC2nYfW9Y+6hO21iW0Z/X7CEVs
 UcE+HvyNJ6rw5mHQXkzmPZ0MNOeeDjCZJBpkJ3tOg/VoP1ov/Dua7qxQc3k3JIu5sr6q
 bt+RbDn1nxmxx230t0kSPM5YRO5sOpk1JRgtD2jiU8fOwKfAsFNQZuKhIWH5WXqMOtqZ
 NZLg==
X-Gm-Message-State: AOAM530URJ7b/D9/fOkNqx50qXoau9OydH5XQgMNTODIpevda2s+tXGP
 A5rUhb3DHUag3KmVvZ3xSWJUSUQzQ1CU5vQvpyHH989T9l4n0mRUfGsRP0ZZZfC4N3uW7nRUy3r
 IqG2v7Aqb6zBEkNI=
X-Received: by 2002:a17:906:756:: with SMTP id
 z22mr7144389ejb.31.1599470084182; 
 Mon, 07 Sep 2020 02:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw47NnweanmpsKw7vy1WUL8JfWxf6Kb88VGMqpgiWrQD9+87q9181m4hnR3V6UFExV4ldR4GQ==
X-Received: by 2002:a17:906:756:: with SMTP id
 z22mr7144372ejb.31.1599470083982; 
 Mon, 07 Sep 2020 02:14:43 -0700 (PDT)
Received: from auriga.localdomain (ip-89-176-41-222.net.upcbroadband.cz.
 [89.176.41.222])
 by smtp.gmail.com with ESMTPSA id d6sm14394910edm.31.2020.09.07.02.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 02:14:43 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] qga: add command guest-get-disk
Date: Mon,  7 Sep 2020 11:14:39 +0200
Message-Id: <cover.1599470071.git.tgolembi@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=tgolembi@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=tgolembi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds command to list disks of the VM.

The patch does compile on master but to work properly it requires changes to
qemu-ga by Thomas Huth in series: Allow guest-get-fsinfo also for non-PCI
devices.

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

 qga/commands-posix.c | 241 ++++++++++++++++++++++++++++++++++++++++++-
 qga/commands-win32.c |  91 ++++++++++++++++
 qga/qapi-schema.json |  29 ++++++
 3 files changed, 360 insertions(+), 1 deletion(-)

-- 
2.25.0


