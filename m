Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A734DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7690B20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z24SakDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7690B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxXt-000097-Pu
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juxUy-0004Gy-9H
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1juxUu-0008BS-3O
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594643030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pr2TTBrlMPWhX3Ba8UeHdk4ZpzYU8YXfo6YrFPYSe8k=;
 b=Z24SakDM8+xtHvOgYRsHS7ZxGnP0J6LTAJ6C0FY7TAd1SFHMyb2RzM/S4fsMprVzNPm3Rq
 mWc9VL4Lu9p+m4lIkfi8M7LW1dKNEvyreoXNExHkb/GR5EWXW1HcKoPgge+pw+4OXuvI3g
 zoRFZV4lsPObWggDEJ8L1Yszl6kq8lI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-X19QcKCFPZCpATtjxJkP_A-1; Mon, 13 Jul 2020 08:23:49 -0400
X-MC-Unique: X19QcKCFPZCpATtjxJkP_A-1
Received: by mail-wr1-f71.google.com with SMTP id b14so17654116wrp.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rBlfRcvWq1OAymIDqRMQXpM4b3oQjMvkrnWo1f8bhz4=;
 b=XIOPyDME8Eta7sU9xrMrs/wMofDOGmJcVXSKvIPpxIWLrlZOxuXmY6eBDQ37CwuyZF
 FzOu8xq6KZvqmNzPfyxlYDNNutTiel6CFliEIUiDLwN/NmYIm16hsgMFtvCFVInqGt8D
 1qfiSIOQLbiG1xzmfeiUP0h2vzolngNOjbbOBLwdTcWk0KyZYgio7aEM36iZgdukC/Nn
 cB2B/k7dDOBvFkmd2pNCvYrnzwbA3vq3j5L9fKoyPzUwSOJkEneeKYtnA13suGne8p+z
 671tUGDCgevq1PbO/ceW9bJk1Fh3MEzQe991xT5oOSsUtgzFc7yRrAJ5YBp9tRBSvbX6
 DJyA==
X-Gm-Message-State: AOAM533GivGY7zxGddQpWAbjebM4FDCBAZ/3NlSP1hlgrA1bcJzhmhtv
 TYVMB2XZuBpX4lojtg6KLOmn4Spcfv3GMJQZ/MbPKjYPu2x8aZTYaU4kC6mb9thbkMp3Lh4P1Ki
 7J7DkYCCT+/daosI=
X-Received: by 2002:a1c:a557:: with SMTP id o84mr18808037wme.42.1594643027431; 
 Mon, 13 Jul 2020 05:23:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBVx53u/2ZDmvHfBQWg/WYo/p6/rWhKGU7MxZHn/RFnLkwFSKECIiy5FcDi9NFgCZ6up33TQ==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr18808024wme.42.1594643027216; 
 Mon, 13 Jul 2020 05:23:47 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id a123sm23908850wmd.28.2020.07.13.05.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 05:23:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Migration Pull request
Date: Mon, 13 Jul 2020 14:23:42 +0200
Message-Id: <20200713122345.9289-1-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It includes several fixes:=0D
=0D
- fix qemu_fclose(denis)=0D
- remove superfluous breaks (liao)=0D
- fix memory leak (zheng)=0D
=0D
Please apply=0D
=0D
Denis V. Lunev (1):=0D
  migration/savevm: respect qemu_fclose() error code in save_snapshot()=0D
=0D
Liao Pingfang (1):=0D
  migration/migration.c: Remove superfluous breaks=0D
=0D
Zheng Chuan (1):=0D
  migration: fix memory leak in qmp_migrate_set_parameters=0D
=0D
 migration/migration.c | 6 ++----=0D
 migration/savevm.c    | 8 ++++++--=0D
 2 files changed, 8 insertions(+), 6 deletions(-)=0D
=0D
--=20=0D
2.25.4=0D
=0D


