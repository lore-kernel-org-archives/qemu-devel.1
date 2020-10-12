Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A96A20708
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du2gJ+Wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A96A20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwxX-0007Fx-60
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwvg-0005cH-S4
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRwve-0006Ad-GR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602505669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F2NfoEiLnvbSxqQcX86TPNKJRsvHyN8YZWlTmyI0yzE=;
 b=Du2gJ+WgHL3/94dMBwGhvWHJqRtlNFbvWKyKBANRMCrETxKY23b3/ixZXdXBoFfmhRydkB
 OWypmiR/PCUYyscYRB+VOMMlyaB7u5Ql5/0KcBBHnvmLc2bxtsj7vPg7YHKou/DXBHAJlH
 P25QeADQeWo9pDYOfh5uE8rn9MsHqoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-2339rBxDOqOFAncyi8DVPw-1; Mon, 12 Oct 2020 08:27:48 -0400
X-MC-Unique: 2339rBxDOqOFAncyi8DVPw-1
Received: by mail-wr1-f71.google.com with SMTP id t17so9269173wrm.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=umZOP9CC5gcDuKvSU0DNU3f1zVK/h1tGiw4z3d4+CEs=;
 b=R9VKzYke5vgAxGm9oqsiBZ21KdD9QU4Z85wRIbfo1kjlzSaZRivFfljE/HmeYPnl2I
 493WxMSVsKj+fX/YuxlGGCykqk4dMStoxPg1ykWwYsE9tlLRcXrgMvLO9rA8x+Ird1o+
 UqTrisIiw26Svo3BLag6OoNTqe3XzJP2adOgIh8pXNBocFDKSBuZzdbsvkzdfFYFn3G8
 oZOvy3Bn/332MI2FBSb0WQvVEQz47TiDtPrCfMd66zJQZn94/X6J3+/zcosXRIL84JEf
 OA0Yb8aERpupn9zWbG1z762dNw5uFv0WnfNSt8JdH0pIw9NTzIVF0GiudPV/8lrrfzdD
 kqGg==
X-Gm-Message-State: AOAM531x0jyR6Yk/RSw3D2Vb1Fg/1cgySRn9qxQTTq5bmPBhUvhZh64j
 4duXI28fj/JDocFzC7eSlrX8iL2ehYk6yKEL14b4yNn3RUZVHEyIiObbJH8JsaqDXyZkg8zqhd1
 6OphPt8tN07e2/gk=
X-Received: by 2002:a5d:5548:: with SMTP id g8mr29566514wrw.364.1602505666683; 
 Mon, 12 Oct 2020 05:27:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGJLvbQRYspD5ndDvVFpHkPoRHwN2lF75RYI46V6vOa3Ukx83PJzps7XbWyO6i01Gwi3yghA==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr29566491wrw.364.1602505666434; 
 Mon, 12 Oct 2020 05:27:46 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm27755724wrr.36.2020.10.12.05.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:27:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] migration: Make save/load_snapshot() return boolean
Date: Mon, 12 Oct 2020 14:27:40 +0200
Message-Id: <20201012122743.3390867-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:=0D
- Initialize variables in first patch (Max)=0D
- Added Pavel's A-b tag=0D
=0D
I had a pair of patches making save_snapshot/load_snapshot()=0D
return a boolean (like Markus recent qdev/QOM cleanup), then=0D
realized Daniel already has series changing migration/, so I=0D
rebased my patches in the first part of his v6 series:=0D
"migration: bring improved savevm/loadvm/delvm to QMP"=0D
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02158.html=0D
=0D
I included patch #1/#3 from Daniel, #2 is my first patch,=0D
and my second patch is squashed with Daniel's #3.=0D
=0D
Daniel if you find these patches worthwhile, please consider them=0D
while merging your series (or respining).=0D
=0D
Regards,=0D
=0D
Phil.=0D
=0D
Daniel P. Berrang=C3=A9 (2):=0D
  block: push error reporting into bdrv_all_*_snapshot functions=0D
  migration: stop returning errno from load_snapshot()=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  migration: Make save_snapshot() return bool, not 0/-1=0D
=0D
 include/block/snapshot.h       | 14 +++----=0D
 include/migration/snapshot.h   | 18 +++++++-=0D
 block/monitor/block-hmp-cmds.c |  7 ++--=0D
 block/snapshot.c               | 77 +++++++++++++++++-----------------=0D
 migration/savevm.c             | 72 ++++++++++++-------------------=0D
 monitor/hmp-cmds.c             |  9 +---=0D
 replay/replay-debugging.c      |  6 +--=0D
 replay/replay-snapshot.c       |  4 +-=0D
 softmmu/vl.c                   |  2 +-=0D
 tests/qemu-iotests/267.out     | 10 ++---=0D
 10 files changed, 105 insertions(+), 114 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


