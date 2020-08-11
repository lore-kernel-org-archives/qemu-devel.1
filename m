Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60ADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 840D7206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PmrbYs6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840D7206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y6b-0007hW-No
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y50-0005uY-VZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:28:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40278
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y4z-0007re-BZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FfvWPzeheH68Bn5ocQeCVk8q4jf6x860utIhcEx6yrc=;
 b=PmrbYs6Q7f1kyRiqfPIZowOui+Y5scykbMeTxG4QJcJigpjZVAYXDPFz0Tyu8MjVQOO03D
 nF3VCEOgPUVJqmQ+7lcLGCAiXgP/hKQUjjnaczD4xT5s2CCD7xXbCLQPj600amRUk+SK4y
 8MWf3cKWSftJG15Gr5uqMQH7ozRFb0k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-yzEIbp1JP6-ZnSW70uJxvg-1; Tue, 11 Aug 2020 13:28:50 -0400
X-MC-Unique: yzEIbp1JP6-ZnSW70uJxvg-1
Received: by mail-wr1-f72.google.com with SMTP id o10so1210716wrs.21
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:28:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FfvWPzeheH68Bn5ocQeCVk8q4jf6x860utIhcEx6yrc=;
 b=RpiJtyCp5kT6DvyYropPt49iWZIPQ0dKIc6dSVI5VtP7lOSpN4NzpuhSkALlSLGTMd
 UoURIpyju91n4fIOP0/v61SRAV1PJKegc9cVwlr2j5l6XLBgea+RifYFf6Dfk1MKnOQ/
 RKUQJoiljKFeK1zAIblakor776ezpJGOnYYySZ6oWkbTAvJU0Q03mgUdDSMSxy1dlrGW
 41A4OAig0ErG3sTyYbjMcgwZuej6Gw3H0sUNRTpeIESkC3K+3wByO+jM7br0ocaPwGhT
 VbG1DCesokKSB/79n2BewWoKErDoydrSEC6S8mHuINP6WMmGjtyaRjVvT9qWPQZ7PIIw
 y1JA==
X-Gm-Message-State: AOAM532Xdxcuj2xSG4ahCdJtJpL8LK6asr0T+peaao6QeEMI2+2xcpv/
 hgAUjz8zrszeO3kLkuUsz4HppC7Vw2BsPGO3Umm4/ZkMGm+HyybdxOueZAxMQq/WE4vSg4XXNSR
 BTrQ74LDCdm+joHM=
X-Received: by 2002:adf:f151:: with SMTP id y17mr7465535wro.179.1597166927782; 
 Tue, 11 Aug 2020 10:28:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGqpqkL4iR6Q7otflWnR/SJVYaROtQPkQ3KNZW07fWYMKz5bsCS+0lB4QAqmROEqrkXBrE9g==
X-Received: by 2002:adf:f151:: with SMTP id y17mr7465518wro.179.1597166927646; 
 Tue, 11 Aug 2020 10:28:47 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id s20sm5998834wmh.21.2020.08.11.10.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 10:28:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 0/3] util/vfio-helpers: Fixes to allow using multiple IRQs
Date: Tue, 11 Aug 2020 19:28:42 +0200
Message-Id: <20200811172845.16698-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A pair of fixes to allow binding notifiers on different IRQs
(NVMe block driver series will follow).

Philippe Mathieu-Daudé (3):
  util/vfio-helpers: Store eventfd using int32_t type
  util/vfio-helpers: Add trace event to display device IRQs available
  util/vfio-helpers: Let qemu_vfio_pci_init_irq take IRQ index argument

 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                |  2 +-
 util/vfio-helpers.c         | 17 ++++++++++++-----
 util/trace-events           |  1 +
 4 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.21.3


