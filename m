Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CE5C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C742083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 16:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwG9RHyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C742083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2zzU-0005rE-4w
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 11:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2zyX-0004c4-Q5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2zyW-0001N7-6u
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2zyW-0001MA-1K
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 11:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581782843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VZfoK9cVI0kWIlDrx7TDM7WEcV1PYPUKO2B5DytlUK8=;
 b=LwG9RHyD7877euIlj2SFfBimkUIzJU7pz/K1pymG5ZdgOsIK7SNFcKan8HRRpwne9CNTA1
 uT+lOebctrDjjFTMgQlBiSoEu6gC4U9VdPSUfGUrzAV3WuHhmUD24pP6FbvW7LT8QReicS
 s8dY3BfRyabgDG7yxTrm/TI2zhYIkXY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-jXNYfm2YNSWke4xoTAxMSQ-1; Sat, 15 Feb 2020 11:07:20 -0500
Received: by mail-wr1-f72.google.com with SMTP id r1so5892341wrc.15
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 08:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/clwGACR79rdwW5OyRUYtzv4VHiwpJ51gOfEqIctx9M=;
 b=WEJOkIMVd8TLml6Epvc2wQEBsW8gVyFTW6qIgjF9tYbAHn6frtuGKpXfg/F1J1FwnB
 zR2pJd0oHUav+A9bY0SKpLr2t0LhfBAFmO+t1Xyv5iwYmspwD76t5bCr/ILc3N6aJT97
 XUOBkNQakr212of7CE/voLLZpPq0RbffvzcIgCarF6stMByXDz4ScHpRcIeYO6IHpNzV
 3Ug26BXjJTn+LrILl3FG3X4qfKbTQP7nblKV/2TZOblxHoilim3uMJgCMw3Obw13aThi
 QNT8wazrxx6TFtRCKgW7D/5gE4tcKUriPumHJFAJUhDD8ZaSZTIyQ1JjSJitwwUY6Edj
 iy/A==
X-Gm-Message-State: APjAAAVyVyXdQuvYq57gp4XCc16mD11jzlvUo50tLGkXb+WsVjuWzMJ9
 z/AG1pe5UwV2uD1AEgSi1clNxzO7ujRb0vW3p2Jn60jnGxC1OFW71r2mAAfs2WWXSmpuTs8sdLS
 0y3HMBxKh1tfIzxs=
X-Received: by 2002:a1c:c5:: with SMTP id 188mr11181077wma.187.1581782839221; 
 Sat, 15 Feb 2020 08:07:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqoh9Uv2g2VAiVFSLwSUCPzTicBNno6Dh2GjPmk1m8ksePYGv76CTonmLg8A2V5+xbHGW+6w==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr11181062wma.187.1581782838968; 
 Sat, 15 Feb 2020 08:07:18 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b18sm12103829wru.50.2020.02.15.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 08:07:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] tools/virtiofsd: Fix warning reported by Clang static
 code analyzer
Date: Sat, 15 Feb 2020 17:07:13 +0100
Message-Id: <20200215160716.1262-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-MC-Unique: jXNYfm2YNSWke4xoTAxMSQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Philippe Mathieu-Daud=C3=A9 (3):
  tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
  tools/virtiofsd/passthrough_ll: Remove unneeded variable assignment
  tools/virtiofsd/fuse_lowlevel: Fix fuse_out_header.error value

 tools/virtiofsd/fuse_lowlevel.c  | 2 +-
 tools/virtiofsd/passthrough_ll.c | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

--=20
2.21.1


