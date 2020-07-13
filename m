Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4479DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1293F2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlQhSAYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293F2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0rT-0001YD-8B
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0qh-0000UM-1S
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32282
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0qf-0008NU-52
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594655911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pr2TTBrlMPWhX3Ba8UeHdk4ZpzYU8YXfo6YrFPYSe8k=;
 b=LlQhSAYUdamrp7o9yMhpS0PZdm+nfz9KShGIhhi2eiN+a2qVVcf4Hk6ggWPNEXoPZW57PD
 PNokHke7fHNMpek2R5x0FradoivNbwmt9GuSvdwYnQVNS3T7of7SO83ClQO7W6rgEw2eIM
 Q0sq7JBmSqx+FUGuVBYPzO2C8BPXNuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-GolF_bLHO-mgek8BJGkzLA-1; Mon, 13 Jul 2020 11:58:30 -0400
X-MC-Unique: GolF_bLHO-mgek8BJGkzLA-1
Received: by mail-wm1-f70.google.com with SMTP id 65so3360wmd.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rBlfRcvWq1OAymIDqRMQXpM4b3oQjMvkrnWo1f8bhz4=;
 b=oa0n8XLpiQchABekTKKgpBDkTOyhh2L71/9r+pcI/j7aonF0YMBZcF6hEcKiqhgTRF
 cVHR4wee1oASWxV47V9TWjVXepdKBaUshhAaopZ7UBaWn9aD1kRiMUQcR1z3v9a0Qvjb
 U32BRnNwiMJ9Hss/u1pOISpvREBY/XYsmgBrIUMqFcRoyuD6Q7y1RZF6/hQxRtaC4n4n
 htR3jB/lI2LdIF1ND27BtEi9zbAFQksDdOAoYLHJ0MCRPbwoGL0wbTWmKa0CgwJQjZmi
 XQzvxD/L5AW2GU7TsB+AWgeQVUTBce7QFgGE36eGD9x0HQfePi75nj5oq0smocentZr7
 3jgw==
X-Gm-Message-State: AOAM533u4mHTFIsI/izyxMZdRaz8PRXPCBtVon9qYmLDbLqU0RJ2PXOO
 Wdj719CjZ9DHkEzcCyVohQzlP1Y0av3tLUrsMiPPamTfPpRk6VFiRyopMlfhX7ceCOfyYYxN4Jc
 siPEmP+coHLy0WVo=
X-Received: by 2002:a1c:d8:: with SMTP id 207mr33642wma.81.1594655908876;
 Mon, 13 Jul 2020 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1YjwdQ6x8zy37z7EoA/hjAzRePxhYQqWr//gmsXH+fz36YEEsWxE8LejZ4AWUXGdhPNgusw==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr33632wma.81.1594655908634;
 Mon, 13 Jul 2020 08:58:28 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id b17sm23560414wrp.32.2020.07.13.08.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 08:58:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Migration Pull request
Date: Mon, 13 Jul 2020 17:58:24 +0200
Message-Id: <20200713155827.10670-1-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: quintela@trasno.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
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


