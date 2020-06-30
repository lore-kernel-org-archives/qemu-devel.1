Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB78F20780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QofSXBD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB78F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDf4-00081P-T6
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDe9-0006QM-IM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:37:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqDe8-0002GH-1H
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bawrcsdOftH5MtHhKU4WC+UOM7deC54X8EyUBKb6QR4=;
 b=QofSXBD/8OR0b5V2F8luJvhaPIs0wS75uodI5SV8iWAhg+k0pxcNMdn4lcctxZKqGphu6/
 SY+blhsY5w1rlgeqaJsrKF684j8GhmOdZQ2/f6Exh1slkWQl9GbqAvTrxhK4IudPhLCx4/
 1RxRwh0vCxdHvME6+aKKPqgPfWCArpg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-x5WsEi-bO82GH_WJhGZyNg-1; Tue, 30 Jun 2020 06:37:42 -0400
X-MC-Unique: x5WsEi-bO82GH_WJhGZyNg-1
Received: by mail-ed1-f71.google.com with SMTP id i3so3932189edq.21
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 03:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bawrcsdOftH5MtHhKU4WC+UOM7deC54X8EyUBKb6QR4=;
 b=Q6paKPuBJ3GAN9Thrfxcp5oAfAc5bIs0pYRiBMGkV5jLzf81CjaGXxuf7MAGzACg7A
 Q36xDMq6RiZv5VfMLaTK+h9iTUDvQIBf1j3CNd9tyIXsgtgJ9KT8rcNIzSphGDNioYKG
 JRZrtC86ISDQTKtDGFAwXqZuNXhFWt1t5UWdd3XYy9Ta0nRe3rxJ10QtSw1+LP8JQxBK
 Hs6aTc6xgSxL2lt4jtKg4gdLmJ55eFzbRywGo9WuEOI6AcRHrI3C30B8zvZlweF9sdDW
 lsUdX/bP1edsTw74LGDCVHFAJ3EhhZT0b4Ifp9yH4nHazK0/0T15Lncf6m43HaZ95/Lm
 /p+w==
X-Gm-Message-State: AOAM532iLoJHFVzUkLtxXLQLzFI91fb49SXdCKPA/pFLzvl7mWqtGXX/
 9xHOMlE924Q9pHQeEVrRUHHvzVyfEEuQQxmAzuFPx7y4JbitFQze7oTtoI6KPC4So+TyaLHTcda
 2JPFV1MEYceE/Ehs=
X-Received: by 2002:a50:cdc6:: with SMTP id h6mr21840777edj.111.1593513461365; 
 Tue, 30 Jun 2020 03:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySkYUJKmKFgDFhlQSCKCof95D41mcwbmw6bBQYtHQ4w3kPKSslZAPXQ67k5vz2VQxtQSTeDQ==
X-Received: by 2002:a50:cdc6:: with SMTP id h6mr21840765edj.111.1593513461248; 
 Tue, 30 Jun 2020 03:37:41 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id s24sm1661591ejv.110.2020.06.30.03.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 03:37:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] hw/block/nvme: Fix I/O BAR structure
Date: Tue, 30 Jun 2020 12:37:35 +0200
Message-Id: <20200630103739.9715-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improvements for the I/O BAR structure:
- correct pmrmsc register size (Klaus)
- pack structures
- align to 4KB

Philippe Mathieu-Daudé (4):
  hw/block/nvme: Update specification URL
  hw/block/nvme: Use QEMU_PACKED on hardware/packet structures
  hw/block/nvme: Fix pmrmsc register size
  hw/block/nvme: Align I/O BAR to 4 KiB

 include/block/nvme.h | 42 ++++++++++++++++++++++--------------------
 hw/block/nvme.c      |  7 +++----
 2 files changed, 25 insertions(+), 24 deletions(-)

-- 
2.21.3


