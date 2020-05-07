Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0CC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944412075E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki+yi38O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944412075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfOY-0002YL-Ii
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWfNJ-0000Xh-Fb
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30664
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWfNI-0001H9-Ks
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588853495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WXJhLr707GAro0x/lPPxvDDPBClKZHR4OxgwVVUQXTk=;
 b=Ki+yi38Oej2QHS3zwlkUu3tnGVgdnv4rbJv8aooPu/qfFd3Grl3ruj089kaQJh3b+OUWoW
 PM3/Vsgn7o8M8jSP3y4j53wVF7ERtUrRux3o5AvFtpGG0koLhhGDN+8+JPyxYqKrRaeFKy
 BZXYVeJoWZGZJGcEcWvOBtiFXsQ3xXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-gz1ZmtglOcqyFks4VFXrJw-1; Thu, 07 May 2020 08:11:33 -0400
X-MC-Unique: gz1ZmtglOcqyFks4VFXrJw-1
Received: by mail-wm1-f72.google.com with SMTP id j5so3256068wmi.4
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 05:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yTYs/7LkEfogfRI30nNyX19tU1pCrHNjgRH6+AlkyQA=;
 b=LbJhRyY9cu1wjVOq2+Cdj5bBlkQqSsJS8uK+kczBq0jzzax2AFgiCwdiUj0YD2vehe
 WL63cp5/evu/RrU390xKN+4G/aY2RUyvvP14J5Hrd1DUKx3X9CNcQ6GqtScxS3A8YBO+
 3xmKZKai/FsX8xQxVkmvD3b1syMJ3EuVbMY1kIyNWgAsvxFngMuAr5uZRVVpT6riqXQj
 8pONML3S1CcfPpjI8cQXjjjAAEGHvHArEqLxeSPpo4qsZUs9b+6CMuBX4l2tZLbqEy0u
 s9tV1t98h01vPXk9koo+y+a/175lUbWM0e61QacK09tH+UnRZKlSTYeNQ6LWRbDyDdj/
 ftCw==
X-Gm-Message-State: AGi0PubIYankwEZHca2/GzjiXgxpWOpw+5b1Q6UIp8sTMdFPTCISNRJ6
 Esg04+W6xR/QVDEqYvObll+WXbByR7bmc5hvQT+dqKS/+FTLwshDfAamDm9IHsWzi98I9lCq66D
 74sGiWff5KxA1ztA=
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr10476664wmj.170.1588853491026; 
 Thu, 07 May 2020 05:11:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLCtgWXWINTmrgRox/aMCvHxradNRPTJJI0CLUwfBCJ+dgc2mdPI09iywS4/diAAAQAzOLosA==
X-Received: by 2002:a7b:c3d4:: with SMTP id t20mr10476646wmj.170.1588853490848; 
 Thu, 07 May 2020 05:11:30 -0700 (PDT)
Received: from x1w.redhat.com (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id y7sm8188462wmb.43.2020.05.07.05.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 05:11:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] block/block-copy: Fix uninitialized variable in
 block_copy_task_entry
Date: Thu,  7 May 2020 14:11:27 +0200
Message-Id: <20200507121129.29760-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_copy_task_entry() might be written differently to avoid
the initialization. This silents the warning and let me build.

Philippe Mathieu-Daud=C3=A9 (2):
  block/block-copy: Fix uninitialized variable in block_copy_task_entry
  block/block-copy: Simplify block_copy_do_copy()

 block/block-copy.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--=20
2.21.3


