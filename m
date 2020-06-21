Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B866C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00F0A23D3A
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 02:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="ODp+nd0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F0A23D3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmpSD-0000Qo-7A
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 22:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jmpR3-0007Il-Nv
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:10:17 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:38334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1jmpR1-0002Se-Ek
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 22:10:17 -0400
Received: by mail-pg1-x52b.google.com with SMTP id e8so1217334pgc.5
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=fu898FwZuSrBKxPwt07cQ4Bf98HgdV7S8eTprP/A2Qs=;
 b=ODp+nd0Cs15B2zvoiG78mY219snBlaHSFLjNxS0eu+8xfAjWQiKzGi8ubt0T6BORHb
 3Gmq5CDnQ4up2ymCagKdyHFepoffIt3uRnB+qO5Qw6oTnwmNXlbOMo6f7TO3flzmrHBf
 jEy9Jch1a+vbHE7EIV7p8P0UGDXRoJ/qkYzwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=fu898FwZuSrBKxPwt07cQ4Bf98HgdV7S8eTprP/A2Qs=;
 b=CNufQduYmm8YAhURQl4/ati0TaamaIaAqfW4551JWajmHKv+v8eS7KEE/rJiat7K5L
 IzPfIw8Bit1Y27ONC/jqWbJJz7CWUQX/wPqxfOqJ5Wynj6pTHW12LB/0LQYwYLTaCI2U
 8XK9q2dXAlADFNPWnXdwm6SkSZvZhBlH8PlV5AV/pd1qPrRqtVBRnStQE2l+WhTnMZei
 3nFsKJ9Uhm3rkmH69a3h6r/onV3OEFo7mjBorQQGjNohK4+QNPxMR0S3bAvutEAA/to5
 V7BiJSxgLBx52aWyI1Kwp2r2urHLd2JRgcaKsaQlnjphhJiktSJ+DitmkESYn0g6prmf
 MFgw==
X-Gm-Message-State: AOAM531IVtibsdAbt0PHpnvJxW2HVD2myqQQ/wR8Y3/XoB/Y+AgBj1eO
 fPaqQ/RPsH9FwwscctuVwcrVnGfjk7LrnQ==
X-Google-Smtp-Source: ABdhPJwS2lwnkCujRBimlc1q3+aDqD7vOwhE6dALbgGgSJq/wxTWhBXq0inpqa6ChbM5iyv6JSfnvg==
X-Received: by 2002:a63:5623:: with SMTP id k35mr8560496pgb.325.1592705413017; 
 Sat, 20 Jun 2020 19:10:13 -0700 (PDT)
Received: from localhost.localdomain (202-39-79-13.HINET-IP.hinet.net.
 [202.39.79.13])
 by smtp.gmail.com with ESMTPSA id q6sm9589537pff.79.2020.06.20.19.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 19:10:12 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 0/1] COLO: migrate dirty ram pages before colo checkpoint
Date: Sun, 21 Jun 2020 10:10:03 +0800
Message-Id: <20200621021004.5559-1-dereksu@qnap.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=dereksu@qnap.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, chyang@qnap.com, quintela@redhat.com,
 Derek Su <dereksu@qnap.com>, dgilbert@redhat.com, ctcheng@qnap.com,
 jwsu1986@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is to reduce the guest's downtime during colo checkpoint
by migrating dirty ram pages as many as possible before colo checkpoint.

If the iteration count reaches COLO_RAM_MIGRATE_ITERATION_MAX or
ram pending size is lower than 'x-colo-migrate-ram-threshold',
stop the ram migration and do colo checkpoint.

Test environment:
The both primary VM and secondary VM has 1GiB ram and 10GbE NIC
for FT traffic.
One fio buffer write job runs on the guest.                                                                                                                     
The result shows the total primary VM downtime is decreased by ~40%.

Please help to review it and suggestions are welcomed.
Thanks.

Derek Su (1):
  migration/colo.c: migrate dirty ram pages before colo checkpoint

 migration/colo.c       | 79 ++++++++++++++++++++++++++++++++++++++++++
 migration/migration.c  | 20 +++++++++++
 migration/trace-events |  2 ++
 monitor/hmp-cmds.c     |  8 +++++
 qapi/migration.json    | 18 ++++++++--
 5 files changed, 125 insertions(+), 2 deletions(-)

-- 
2.17.1


