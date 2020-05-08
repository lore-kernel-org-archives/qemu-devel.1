Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EE7C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B0320708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFOsSxeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B0320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWy3d-0006t8-Bh
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy2r-0005ix-0E
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50079
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWy2q-0006M1-7K
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588925263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lsVYqGBtTkxgpJepH+D6TJxoO78gJAP4vg9zK14/HUc=;
 b=BFOsSxeChGhwyvitefLCkmoIxOsdwRsDiHA0OwZBwPWIkhnxei/Q3QBVF04nZX3sw6kFu4
 JRef51DWnWS1nkaT2TgS5fzUWJQIUtU4hayBYeUoqfX/WVK4KBZFMmnzKz2nYeJux1D9ah
 KJS+vrOihfAn2UNvPKcxW8+vpuXvBQs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-_-pZtur4OvWitYJBZktrKA-1; Fri, 08 May 2020 04:07:42 -0400
X-MC-Unique: _-pZtur4OvWitYJBZktrKA-1
Received: by mail-wr1-f69.google.com with SMTP id r14so219993wrw.8
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zjPOOqjFPt4tAr2EgDf+wraBoTpFRAsGJe9UIuI6ceQ=;
 b=bI8yaeZwzA3iTijMV3l430h0VRoNC2kZGJP+Z9ByeWQGhAWtbh1qO0imIWy2LxnuB7
 xr9VlZe+5kn0MdiSbGFReyIwek7XoMC/rj1x2vovjCanS491SGSGFT0TuC2BTHMxRCzE
 COq5HECHjhDGkPoKLdOCiyF6v7PaesRSdaJCBPQtZ9qBTXkgMcweHVHMWeEj3RzdO7WY
 +5d/aMt6PXzPVuVA7NDb0KhjXVIUiPgVylw0hOvHNvdmu2lCIhcdmBF0vLT4OgdWM90a
 PNCm1URz4AxNqzsycKw0SdrqhtAwqxfqxQHNa7mjL1ewRT1UVrFtRSMcvlUbhPe+FFFe
 aGEQ==
X-Gm-Message-State: AGi0PuY2RhuOf3zZ60vavZNjhzG9oFOx7NXBEJT/VPBVrjNPEtKcVaeG
 uKCSba4EiEMvNkJrLm9avjJl2/4Ksezf2ExnlJGvun9qzYoS1dATydCWifS9hub4YBjbMV2Jtzd
 tHHL8Y+qFD89IWXY=
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr15838022wmi.155.1588925260460; 
 Fri, 08 May 2020 01:07:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypIe+hKHXvjzeDcgPVLdfTohkt78fgSMzmCSKrRSdn3j/e/e+bwypmyK/i5YdwMWhV4+LWV5Tg==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr15837999wmi.155.1588925260304; 
 Fri, 08 May 2020 01:07:40 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b82sm12514617wmh.1.2020.05.08.01.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 01:07:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] accel: Move Xen accelerator code under accel/xen/
Date: Fri,  8 May 2020 10:07:36 +0200
Message-Id: <20200508080738.2646-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:25
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Supersedes: <20200507155813.16169-1-philmd@redhat.com>

Philippe Mathieu-Daud=C3=A9 (2):
  exec: Check Xen is enabled before calling the Xen API
  accel: Move Xen accelerator code under accel/xen/

 include/exec/ram_addr.h                    | 10 ++++--
 include/hw/xen/xen.h                       | 11 ------
 include/sysemu/xen.h                       | 40 ++++++++++++++++++++++
 hw/xen/xen-common.c =3D> accel/xen/xen-all.c |  3 ++
 hw/acpi/piix4.c                            |  2 +-
 hw/i386/pc.c                               |  1 +
 hw/i386/pc_piix.c                          |  1 +
 hw/i386/pc_q35.c                           |  1 +
 hw/i386/xen/xen-hvm.c                      |  1 +
 hw/i386/xen/xen_platform.c                 |  1 +
 hw/isa/piix3.c                             |  1 +
 hw/pci/msix.c                              |  1 +
 migration/savevm.c                         |  2 +-
 softmmu/vl.c                               |  2 +-
 stubs/xen-hvm.c                            |  9 -----
 target/i386/cpu.c                          |  2 +-
 MAINTAINERS                                |  2 ++
 accel/Makefile.objs                        |  1 +
 accel/xen/Makefile.objs                    |  1 +
 hw/xen/Makefile.objs                       |  2 +-
 20 files changed, 66 insertions(+), 28 deletions(-)
 create mode 100644 include/sysemu/xen.h
 rename hw/xen/xen-common.c =3D> accel/xen/xen-all.c (99%)
 create mode 100644 accel/xen/Makefile.objs

--=20
2.21.3


