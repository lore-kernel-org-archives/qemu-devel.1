Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B62C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65EF02070B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejhrHVYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EF02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k19Ko-0003hj-HV
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 10:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k19Ij-000122-LV
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:12:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k19Ih-0004HN-Td
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596118371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1nCUmzxGIbC0kn3/ng/Xf3mTqDwzdByUhgD6JCrp3Ls=;
 b=ejhrHVYaxeksXpCQiQxvTISt1JCy2J4RVSsG7zAl/skB0LalMqY5seX7iIx1m/npAWvYQJ
 x7eueFwELPdxSFt3c8R+XqaPDiaffXAzzyLaKcGZiIRO+edxP1EvfMMgfzGvnLJ/aAkiMI
 RuHMDI2Vs9TCL7nHWE5yGTPXelFETNc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-wMtA9j9GO3iARRrwngURRA-1; Thu, 30 Jul 2020 10:12:49 -0400
X-MC-Unique: wMtA9j9GO3iARRrwngURRA-1
Received: by mail-wr1-f70.google.com with SMTP id t3so6954122wrr.5
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 07:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1nCUmzxGIbC0kn3/ng/Xf3mTqDwzdByUhgD6JCrp3Ls=;
 b=AdfR63ErJmhc9lPY/VQ9gfHBwq7ya5Rx/sWofWIwUf+GZGAy1IC9nCXZUYktGYxzfa
 kDofSJD2/elWeCuSJHD4ILP1U6fuabtpiEPwxlFzT0+Q2R1GVCYXistnKJX1HfBfYtfy
 Pbj1sW7ISWXWzojZKSiTWtqD8fV29Z1dqj1M1CmjHHM4yg6NtsROMNrQTPBOpGLcrG68
 nsywtBhAu2rGIW88QVMXqMBlvrbS0apjyIFztskH36DkMfEzY/BWmRBJQGdNdTjf1WH/
 XY+qbT/PxAfBKw9MdFi9rSO0yGD0ZCKQrTvuiJspbcG5dZ0ZpTfi3JE4zocToOXor7eN
 9uuA==
X-Gm-Message-State: AOAM5320Q7jOHMCTZD1bwBJxps9eqBAUpn23PQUTwh34/hgSXYyOTB1T
 B+QbNRKfpjV4cMHyefuL9ihmxY1U+2jv3U4NTOaXdAznIaqSFM2GXsjt2i2+6lhiNaFJA86s5Zq
 qBr4CC5Kp2yei8tA=
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr3326748wrn.340.1596118368097; 
 Thu, 30 Jul 2020 07:12:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAWJCTyc1yX9F+GsslaNXx+FdufjDrNeO7osI5iibj6rASK8Lnwmt5G0LLkaV/o05prpzKBQ==
X-Received: by 2002:adf:e9cd:: with SMTP id l13mr3326725wrn.340.1596118367870; 
 Thu, 30 Jul 2020 07:12:47 -0700 (PDT)
Received: from localhost.localdomain (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id x11sm9644402wrl.28.2020.07.30.07.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 07:12:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? v2 0/2] util/pagesize: Make qemu_real_host_page_size
 of type size_t
Date: Thu, 30 Jul 2020 16:12:43 +0200
Message-Id: <20200730141245.21739-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:41:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Kaige Li <likaige@loongson.cn>,
 kvm@vger.kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
Make QEMU_VMALLOC_ALIGN unsigned in a previous patch

Philippe Mathieu-Daudé (2):
  qemu/osdep: Make QEMU_VMALLOC_ALIGN unsigned long
  util/pagesize: Make qemu_real_host_page_size of type size_t

 include/exec/ram_addr.h  | 4 ++--
 include/qemu/osdep.h     | 6 +++---
 accel/kvm/kvm-all.c      | 3 ++-
 block/qcow2-cache.c      | 2 +-
 exec.c                   | 8 ++++----
 hw/ppc/spapr_pci.c       | 2 +-
 hw/virtio/virtio-mem.c   | 2 +-
 migration/migration.c    | 2 +-
 migration/postcopy-ram.c | 2 +-
 monitor/misc.c           | 2 +-
 util/pagesize.c          | 2 +-
 11 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.21.3


