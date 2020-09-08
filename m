Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06761C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9538220738
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ftd62LG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9538220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfzP-0005lf-Ab
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyG-0004GV-Er
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35553)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyA-0003rw-Hs
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9j8LNni0K0Ze9zlV3rWaTDC98qmRJvn1PKy4tvgP9TY=;
 b=Ftd62LG5O+CEUa5+nmmhqgxXBmwAm0XnmgjH6EcPt3mBtmsA12aWfNdrRweSfwEtt9OV9e
 bVTzSV3sYpNxm91r+R+tWpRGLxqTlIKuZ1aNul7USx/0nNkbMqeWdUARWBW5QoN8C/L/N7
 nYL5MU+4JrtU3Ff7jwk7f7Z/BwgbUVY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-UEbSlhxEPQKrLa8GYhqGFg-1; Tue, 08 Sep 2020 11:55:34 -0400
X-MC-Unique: UEbSlhxEPQKrLa8GYhqGFg-1
Received: by mail-wr1-f71.google.com with SMTP id l9so4976467wrq.20
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9j8LNni0K0Ze9zlV3rWaTDC98qmRJvn1PKy4tvgP9TY=;
 b=cv1MWQtUK97asXiIHII1BfRllrH0wjXbv+OyQj8AaNVPyBfcQBk+BdFlP0rZMjvphz
 yYkpS1mKwyXehfS9ewVl0NPC/D/FXSXnB6D2fnWs3+tIECzgn8mpgIDmINWtA40J59hW
 HrTmvOfNReIN9EsZpkpWuRyDFonDMFsqgzS5JExaOkqKfKAaiBYJREsh1aVXOEqwUTkh
 CKq73zRcbWNKpe4jY1sEYEG0pMzU5M5Y0g8cZb98S1ZaUKu2f4IMjD5XlT1uqEhtgtH+
 UAJGf0GfFpb8EuiBkF4vvw/roMsxXFgoQ5aqEzMfUubbB3kPl3lphxdpxN8sVHWU8V19
 Hd5A==
X-Gm-Message-State: AOAM533rqp//k3K8ES69VXuZrRu0E5qhNmXInLa2pSmQImNkuvuwcBMQ
 zBkyaUWT6cmBNVK6+7s9re06/hXvv05YSIVOD5yXWtJKlBP1X/Bh/qEshdMIBNdFeOo4QHshD3f
 FgFmJ085G0SjWcD8=
X-Received: by 2002:adf:f082:: with SMTP id n2mr290530wro.35.1599580532999;
 Tue, 08 Sep 2020 08:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxYkBgGzzaWKvpOFlNbbbbP9lrh/psCt3R+tnd0FsuRZrWeLF+XgkSPHCNZYgHHlXHTFCwjQ==
X-Received: by 2002:adf:f082:: with SMTP id n2mr290518wro.35.1599580532824;
 Tue, 08 Sep 2020 08:55:32 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t1sm30401380wmi.16.2020.09.08.08.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:55:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/6] hw/xen: Housekeeping
Date: Tue,  8 Sep 2020 17:55:24 +0200
Message-Id: <20200908155530.249806-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hard to make an exciting cover of this series.

Basically:
- Make better separation between Xen accel and Xen hardware,
- Move stuff around to restrict PCMachineState to hw/i386/.

Since v1:
- added missing include in stubs/xen-hw-stub.c
- added missing 'exec/cpu-common.h' for ram_addr_t

(Due to a bug in 'make', while rebasing the archives
 might not be updated... so I missed this missing
 hunk as hw/core/libhwcore.fa didn't rebuilt stubs/)

Philippe Mathieu-Daudé (6):
  hw/i386/q35: Remove unreachable Xen code on Q35 machine
  hw/i386/xen: Rename X86/PC specific function as xen_hvm_init_pc()
  sysemu/xen: Add missing 'exec/cpu-common.h' header for ram_addr_t type
  stubs: Split accelerator / hardware related stubs
  hw/xen: Split x86-specific declaration from generic hardware ones
  typedefs: Restrict PCMachineState to 'hw/i386/pc.h'

 include/hw/i386/pc.h     |  4 ++--
 include/hw/xen/xen-x86.h | 15 ++++++++++++
 include/hw/xen/xen.h     |  2 --
 include/qemu/typedefs.h  |  1 -
 include/sysemu/xen.h     |  2 ++
 accel/stubs/xen-stub.c   | 41 +-------------------------------
 hw/i386/pc_piix.c        |  8 +++----
 hw/i386/pc_q35.c         | 13 ++---------
 hw/i386/xen/xen-hvm.c    |  3 ++-
 stubs/xen-hw-stub.c      | 50 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS              |  1 +
 stubs/meson.build        |  1 +
 12 files changed, 80 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/xen/xen-x86.h
 create mode 100644 stubs/xen-hw-stub.c

-- 
2.26.2


