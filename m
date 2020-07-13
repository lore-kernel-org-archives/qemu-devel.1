Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694B2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCC8206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDog9n1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCC8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2fj-0000eN-Fx
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2ct-0005sy-56
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2cq-0007U6-Mu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594662743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=atkzl5MkGztamzVGtPTwBrURmb4X4Z192S38bx1odeU=;
 b=NDog9n1H5TznbBu8exTg90YE+GuRUs9IR/iL8OLGzV9nvYPxM7GuRPtfDeqsRa9P2GVtFn
 TOGnBUF4tYI9zKV8BKsu7V7hzs7PYtpUpTbtLJp/DihmbHJ9grK2ExWpslfp9jh0X3IddU
 qXFGRHA9S5dWekHUJuOf+V0s1X/S7yA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-nnfcSzLCMwSu9gTZughuiQ-1; Mon, 13 Jul 2020 13:52:09 -0400
X-MC-Unique: nnfcSzLCMwSu9gTZughuiQ-1
Received: by mail-wr1-f69.google.com with SMTP id e11so18306444wrs.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/lF0UEH8S3JqW2azIcK76oafDa6Q2u5ckVUvusPRvdg=;
 b=d0ZkvPMnMXLFeworP6XQUWZTWV4zHVgQbKaUilVhDJvIMzJtwt2tySkYPQxTGGlqCw
 ySbdxDIUl3u6hkfG+y1PadbPn1/rYwK4FJsaSYeXMbH5eBsgcIJFSUMsNV428shvL3rH
 E+DBEIUw8bYyuyuz0QiOW03kTCo81vAsbYDmMLu++Qt0C7y5YgzTuiJLuyJ0q+ThQwef
 ftbWsOrjdKlic8g5v12qVBqI886R5fLdDToDOpx3ZA5jqcPnlo/nXP8UojJyMrcxmqKK
 bvpfQu9UwSYvsHYSlUV12+fJm9fmfbIxeIv7zrA1uThxcjbjbXZKFrGzrHf7RVV/wIN4
 mg1A==
X-Gm-Message-State: AOAM530dGKcGbrY0BG+S67CqIsBNA8YQLZmlC4m4FX/eycUnY9PB/Vz5
 KxQcJl2N10bWboxz00ZrffKcp3cZYElN856paMfDtEHgkyxQhEbH8AYe7gCF3ay6oQbP7X22Nlg
 9D/4Zp11G1gOug1g=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr533526wre.369.1594662728171; 
 Mon, 13 Jul 2020 10:52:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAOmscLd2LYb7rVt0/pSh//7MaTthqgYWMXR9JsCisRjO/vI79DgRNrhwTyG36A2f9q6twBA==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr533505wre.369.1594662727914; 
 Mon, 13 Jul 2020 10:52:07 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id k20sm445058wmi.27.2020.07.13.10.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:52:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Migration patches
Date: Mon, 13 Jul 2020 19:52:03 +0200
Message-Id: <20200713175206.13659-1-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@trasno.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785=
:=0D
=0D
  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-=
110720-2' into staging (2020-07-12 15:32:05 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://github.com/juanquintela/qemu.git tags/migration-pull-request=0D
=0D
for you to fetch changes up to eb9bd46ff658e05e2c0c71fc308f3b811afa87e1:=0D
=0D
  migration/migration.c: Remove superfluous breaks (2020-07-13 18:15:36 +02=
00)=0D
=0D
----------------------------------------------------------------=0D
Migration Pull request=0D
=0D
It includes several fixes:=0D
=0D
- fix qemu_fclose(denis)=0D
- remove superfluous breaks (liao)=0D
- fix memory leak (zheng)=0D
=0D
Please apply=0D
=0D
[v1 & v2]=0D
=0D
There was one error on the huawei address of the 1st patch and mail=0D
was bouncing.  Fixed.=0D
=0D
----------------------------------------------------------------=0D
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


