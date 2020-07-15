Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80372C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5143420656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdY5lkTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5143420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvlgz-0001wO-IT
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 13:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlg5-00013S-AM
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45037
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvlg2-0005fz-Fc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 13:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594835921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m3vuMucPz9eZa2I8Eh5r3KZuzfzSaPRP8vgG64vMveA=;
 b=BdY5lkTW3JD38z9yg9uGfuYDPSC58UcyCWHnPziGOaBInNZ6s80CuEiiq8MY8g7bj+JVAW
 /1/XGvP1lSgFtDRUHkc1bbUjcUVbb6aqCRyO+xKXGpkbpoY0Ie9XG4JNb4G7WIBY29jJs2
 gRQkj+SFXiPHJktbTVT19fGo2dV3IDY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-KI2YA5CbPtWcQLwZv5LxFQ-1; Wed, 15 Jul 2020 13:58:39 -0400
X-MC-Unique: KI2YA5CbPtWcQLwZv5LxFQ-1
Received: by mail-wm1-f72.google.com with SMTP id l5so1630981wml.7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 10:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=m3vuMucPz9eZa2I8Eh5r3KZuzfzSaPRP8vgG64vMveA=;
 b=KvzsDPVocfVn2vXJGkoYkngQXVL+xmWfBXJ6DYDZR3WcuDnibN9vdtbGLLpjJjuIGp
 44wLtJexq4Rr4o9XR84DtIbTQYLmuUrjgVJVwEbjQO8NBkqgJxihh0PuWYhKqpNCxfIM
 FIxw7HFagrNcgHPR4s9ToDHTb4XueLJruNNHleJj8xQfjdHpV7yV3NYmM7uQ3T8boAtV
 YCQBMH/+gAurYAIzVFBqwAynRDV0Oa3Pi+Tw1FJozfoCXZebpSslPLqhDIinmVrWKFue
 SLAh7i6Ga+r6aTHI4tSO6e/iYP3BUh/FDU6cbkp4Quw0chXG//HF7fKJouRH7OxyTPS5
 8yAw==
X-Gm-Message-State: AOAM532RwCIGgHoFzUI7O0H/KRGDBGb1v8czgnVwHUgEiXVQOZF/XYKc
 WijIFahVfUQdzKr2nE+k5G4AzaxYP/fdokG9ef9w1Ys/j5tcjLbPACmPFuP4J0M056GlS4zPcc5
 JjUCWQTB0Nhzwuiw=
X-Received: by 2002:a05:600c:2187:: with SMTP id
 e7mr548252wme.171.1594835917988; 
 Wed, 15 Jul 2020 10:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNsQfa9iG7NUMEKnG9wt9t2yG1j8DBqZkkw0BulBwoUCbsNIl+WQyjEN1NsQXcujfBdl3arA==
X-Received: by 2002:a05:600c:2187:: with SMTP id
 e7mr548233wme.171.1594835917754; 
 Wed, 15 Jul 2020 10:58:37 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d18sm4700323wrj.8.2020.07.15.10.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 10:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH-for-5.2 0/5] qom: Let ObjectPropertyGet functions return a
 boolean value
Date: Wed, 15 Jul 2020 19:58:30 +0200
Message-Id: <20200715175835.27744-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RFC series to follow Markus direction to simplify error
propagation. Not sure it is worth it yet. It starts to
be interesting when using the QEMU_WARN_UNUSED_RESULT
attribute in the visitors, such:

-- >8 --
@@ -525,6 +533,7 @@ bool visit_type_uint8(Visitor *v, const char *name, uint8_t *obj,
  * Visit a uint16_t value.
  * Like visit_type_int(), except clamps the value to uint16_t range.
  */
+QEMU_WARN_UNUSED_RESULT
 bool visit_type_uint16(Visitor *v, const char *name, uint16_t *obj,
                        Error **errp);

---

But to get there we need to update the QAPI generators first :)

Philippe Mathieu-Daudé (5):
  hw/core/qdev-properties: Simplify get_reserved_region()
  qom: Split ObjectPropertyAccessor as ObjectProperty[Get/Set]
  qom: Use g_autofree in ObjectPropertyGet functions
  qom: Let ObjectPropertyGet functions return a boolean value
  hw/virtio: Simplify virtio_mem_set_requested_size()

 include/hw/qdev-core.h           |   4 +-
 include/qom/object.h             |  50 +++++++++-----
 accel/kvm/kvm-all.c              |   4 +-
 accel/tcg/tcg-all.c              |   4 +-
 authz/list.c                     |   4 +-
 backends/cryptodev.c             |   4 +-
 backends/hostmem-file.c          |   4 +-
 backends/hostmem-memfd.c         |   4 +-
 backends/hostmem.c               |  13 ++--
 backends/tpm/tpm_util.c          |   7 +-
 block/throttle-groups.c          |   8 +--
 bootdevice.c                     |   4 +-
 chardev/char-socket.c            |   4 +-
 crypto/secret_keyring.c          |   5 +-
 hw/acpi/ich9.c                   |   4 +-
 hw/arm/virt.c                    |   4 +-
 hw/block/xen-block.c             |   9 ++-
 hw/core/machine.c                |   4 +-
 hw/core/qdev-properties-system.c |  33 +++++----
 hw/core/qdev-properties.c        |  89 ++++++++++++------------
 hw/core/qdev.c                   |   5 +-
 hw/cpu/core.c                    |   8 +--
 hw/gpio/aspeed_gpio.c            |   8 +--
 hw/i386/microvm.c                |  12 ++--
 hw/i386/pc.c                     |  12 ++--
 hw/i386/x86.c                    |   8 +--
 hw/ide/qdev.c                    |   4 +-
 hw/intc/apic_common.c            |   4 +-
 hw/mem/nvdimm.c                  |  11 ++-
 hw/mem/pc-dimm.c                 |   6 +-
 hw/misc/aspeed_sdmc.c            |   4 +-
 hw/misc/pca9552.c                |   8 +--
 hw/misc/tmp105.c                 |   4 +-
 hw/misc/tmp421.c                 |   8 +--
 hw/net/ne2000-isa.c              |   4 +-
 hw/pci-host/i440fx.c             |  16 ++---
 hw/pci-host/q35.c                |  16 ++---
 hw/ppc/spapr_caps.c              |  21 +++---
 hw/ppc/spapr_drc.c               |  21 +++---
 hw/riscv/sifive_u.c              |   4 +-
 hw/s390x/css.c                   |   4 +-
 hw/s390x/s390-pci-bus.c          |   4 +-
 hw/usb/dev-storage.c             |   4 +-
 hw/vfio/pci-quirks.c             |  14 ++--
 hw/virtio/virtio-balloon.c       |  16 +++--
 hw/virtio/virtio-mem.c           |  17 ++---
 iothread.c                       |   4 +-
 net/colo-compare.c               |   8 +--
 net/dump.c                       |   4 +-
 net/filter-buffer.c              |   4 +-
 qom/object.c                     | 115 ++++++++++++++++---------------
 softmmu/memory.c                 |  14 ++--
 target/arm/cpu64.c               |  14 ++--
 target/i386/cpu.c                |  48 ++++++++-----
 target/ppc/compat.c              |   4 +-
 target/s390x/cpu.c               |  11 +--
 target/s390x/cpu_models.c        |  14 ++--
 target/sparc/cpu.c               |   4 +-
 58 files changed, 397 insertions(+), 352 deletions(-)

-- 
2.21.3


