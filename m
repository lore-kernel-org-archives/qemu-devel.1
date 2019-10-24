Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEAB20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP5Q6fx1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEAB20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNf9C-0003ZJ-Du
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiz-0007tn-PZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdiu-0007jT-Bj
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdiu-0007il-4k
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id q130so2569881wme.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I9JsqJ1MLvuD5qQCxsE/vI2P7L8FB/WYGzzDrDXMd7I=;
 b=JP5Q6fx1YrRB6ChMMcZCCZ5fOjoWBV7f4/M6bWUaW8D3M0wNF0JuUf6LoHXt4UvIU8
 u82cnIEvXjyV+pqemUcvWo9xG5b5lBFaDu4gWHpp9RHrnkONVM5LLZIH7QIbft3/S7Du
 I0Bh2ztLNTr4w2FD5w+rEp3/w+69TC7cjw4k+UnIbDuydztDb1VEQ76EExgz2R+X1f8a
 ppTkgHrPFBCffzKRpWRT57X47L57NvXTSEAEJNTMb2ohsU6Pt1PUe4/PhM+EKMbRDPTN
 XS9mfZM5A4F8VOUtv0bkHa/+vFsSM5Dit13uWpHKi06/PuAxbdQgGMVOQ8i5g4HkKWGo
 GK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I9JsqJ1MLvuD5qQCxsE/vI2P7L8FB/WYGzzDrDXMd7I=;
 b=Ebon9oncuvTIe2ZURp6UuhaXNSmy+lRmj4jP4t/tgn/KT20PMe/DYfmoZCYC/nMNs/
 +b0eGqG8Wd+G1DrSMT1SdgEMttxwO2IjWaABQJLciRQXynKL1SsRKRthDvW6wWlXjHj6
 +auAwy+UQlGm0YR6aZr9oy+0wtJcQPDWKppcl0M9rDjZ9ihNn65tLLdclSndvkvFyOg9
 L7WwxLSmcsdQPcl0ZL/SmRD5bQ4gNXb8aVy6ypYWS4lulLYbk/lycc+8beKQ769/s6a9
 8MH/qQbvriaUpnqypEPdlViOjFzsCLAGTSbWjKKTGPU5ZO+c111bdD/fk0CFQO1r12Sh
 hF5g==
X-Gm-Message-State: APjAAAXB9EWBYFL+01nWtkqXbnH7eWu/e6fMQx23Zk3SClPvI/FawNxY
 YHc1OP9Zb4/vonVA+XnfSyMg1gL6
X-Google-Smtp-Source: APXvYqzLTlA28o+4ls/bYxiv6g1u1Ofs0WFkewu6HSoLKPQ2OVgyhUPp7NifROiI9UgM75+KXwcflw==
X-Received: by 2002:a1c:e404:: with SMTP id b4mr5557560wmh.90.1571925858542;
 Thu, 24 Oct 2019 07:04:18 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/39] docs/microvm.rst: document the new microvm machine type
Date: Thu, 24 Oct 2019 16:03:35 +0200
Message-Id: <1571925835-31930-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

Document the new microvm machine type.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/microvm.rst | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 docs/microvm.rst

diff --git a/docs/microvm.rst b/docs/microvm.rst
new file mode 100644
index 0000000..aae811a
--- /dev/null
+++ b/docs/microvm.rst
@@ -0,0 +1,108 @@
+====================
+microvm Machine Type
+====================
+
+``microvm`` is a machine type inspired by ``Firecracker`` and
+constructed after its machine model.
+
+It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
+designed for short-lived guests. microvm also establishes a baseline
+for benchmarking and optimizing both QEMU and guest operating systems,
+since it is optimized for both boot time and footprint.
+
+
+Supported devices
+-----------------
+
+The microvm machine type supports the following devices:
+
+- ISA bus
+- i8259 PIC (optional)
+- i8254 PIT (optional)
+- MC146818 RTC (optional)
+- One ISA serial port (optional)
+- LAPIC
+- IOAPIC (with kernel-irqchip=split by default)
+- kvmclock (if using KVM)
+- fw_cfg
+- Up to eight virtio-mmio devices (configured by the user)
+
+
+Limitations
+-----------
+
+Currently, microvm does *not* support the following features:
+
+ - PCI-only devices.
+ - Hotplug of any kind.
+ - Live migration across QEMU versions.
+
+
+Using the microvm machine type
+------------------------------
+
+Machine-specific options
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+It supports the following machine-specific options:
+
+- microvm.x-option-roms=bool (Set off to disable loading option ROMs)
+- microvm.pit=OnOffAuto (Enable i8254 PIT)
+- microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
+- microvm.pic=OnOffAuto (Enable i8259 PIC)
+- microvm.rtc=OnOffAuto (Enable MC146818 RTC)
+- microvm.auto-kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
+
+
+Boot options
+~~~~~~~~~~~~
+
+By default, microvm uses ``qboot`` as its BIOS, to obtain better boot
+times, but it's also compatible with ``SeaBIOS``.
+
+As no current FW is able to boot from a block device using
+``virtio-mmio`` as its transport, a microvm-based VM needs to be run
+using a host-side kernel and, optionally, an initrd image.
+
+
+Running a microvm-based VM
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+By default, microvm aims for maximum compatibility, enabling both
+legacy and non-legacy devices. In this example, a VM is created
+without passing any additional machine-specific option, using the
+legacy ``ISA serial`` device as console::
+
+  $ qemu-system-x86_64 -M microvm \
+     -enable-kvm -cpu host -m 512m -smp 2 \
+     -kernel vmlinux -append "earlyprintk=ttyS0 console=ttyS0 root=/dev/vda" \
+     -nodefaults -no-user-config -nographic \
+     -serial stdio \
+     -drive id=test,file=test.img,format=raw,if=none \
+     -device virtio-blk-device,drive=test \
+     -netdev tap,id=tap0,script=no,downscript=no \
+     -device virtio-net-device,netdev=tap0
+
+While the example above works, you might be interested in reducing the
+footprint further by disabling some legacy devices. If you're using
+``KVM``, you can disable the ``RTC``, making the Guest rely on
+``kvmclock`` exclusively. Additionally, if your host's CPUs have the
+``TSC_DEADLINE`` feature, you can also disable both the i8259 PIC and
+the i8254 PIT (make sure you're also emulating a CPU with such feature
+in the guest).
+
+This is an example of a VM with all optional legacy features
+disabled::
+
+  $ qemu-system-x86_64 \
+     -M microvm,x-option-roms=off,pit=off,pic=off,isa-serial=off,rtc=off \
+     -enable-kvm -cpu host -m 512m -smp 2 \
+     -kernel vmlinux -append "console=hvc0 root=/dev/vda" \
+     -nodefaults -no-user-config -nographic \
+     -chardev stdio,id=virtiocon0 \
+     -device virtio-serial-device \
+     -device virtconsole,chardev=virtiocon0 \
+     -drive id=test,file=test.img,format=raw,if=none \
+     -device virtio-blk-device,drive=test \
+     -netdev tap,id=tap0,script=no,downscript=no \
+     -device virtio-net-device,netdev=tap0
-- 
1.8.3.1



