Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBAAC43215
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D35F20706
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjH57kV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D35F20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFRI-0007Ez-RP
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iVFOi-0005LU-0d
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iVFOf-0002xq-IU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40499
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iVFOf-0002wk-CY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573738972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TM9e+q950Pd4m4nrTBUVas6lzUjplmEG4gGAewbYC2g=;
 b=FjH57kV8G8utOqC5EbohBax2BnpIHlb/X+ib2ms3bsdBMgivAlQotby06+IEQVLG9Sg+ru
 cvWSZzBSlvnr9VRr4yynWH92OG6+71jhjQYc5vHr9za48+kcNCGjoIlN0KHRS9GgSNEFIj
 QUmDlhjTRHV2cVwlb1hqn/o+qmndi08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-BjKeD_X9PV2XWYwZsKJQ5g-1; Thu, 14 Nov 2019 08:42:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E154107ACC5;
 Thu, 14 Nov 2019 13:42:49 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8834B60FC4;
 Thu, 14 Nov 2019 13:42:46 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] tests/vm: Allow to set path to qemu-img
Date: Thu, 14 Nov 2019 08:42:45 -0500
Message-Id: <20191114134246.12073-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BjKeD_X9PV2XWYwZsKJQ5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Usually I build QEMU in a system which doesn't have any qemu
package installed. When I need to `make vm-build-something`
it fails due system-qemu-<arch> and qemu-img not found
system-wide (and I want to use the built binaries). The
formed can be set with QEMU env var, but the later can't. So
this patch allows to set the path to qemu-img using yet another
env var.

Git:
 - Tree: https://github.com/wainersm/qemu
 - Branch: https://github.com/wainersm/qemu/tree/test_vm_qemu-img

Travis:
  - (FAIL) https://travis-ci.org/wainersm/qemu/builds/611563267
    Two build jobs reached timeout. Not related with this change though.

Bug found: I realized that when I export QEMU it is always overwritten
           with <BUILD>/qemu/xtensa-linux-user/qemu-xtensa
           See the error below.
---
[root@localhost qemu]# export QEMU_IMG=3D$PWD/qemu-img
[root@localhost qemu]# export QEMU=3D$PWD/x86_64-softmmu/qemu-system-x86_64
[root@localhost qemu]# make vm-build-fedora
    VM-IMAGE fedora=20
### Downloading install iso ...
### Preparing iso and disk image ...
Formatting '/root/.cache/qemu-vm/images/fedora.img.tmp', fmt=3Dqcow2 size=
=3D21474836480 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
### Booting installer ...
ERROR:root:Failed to launch QEMU, command line:
ERROR:root:/root/build/qemu/xtensa-linux-user/qemu-xtensa -nodefaults -m 4G=
 -cpu max -netdev user,id=3Dvnet,hostfwd=3D:127.0.0.1:0-:22 -device virtio-=
net-pci,netdev=3Dvnet -vnc 127.0.0.1:0,to=3D20 -smp 8 -enable-kvm -device V=
GA -drive file=3D/root/.cache/qemu-vm/images/fedora.img.tmp,if=3Dnone,id=3D=
drive0,cache=3Dwriteback -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -b=
ios pc-bios/bios-256k.bin -machine graphics=3Doff -cdrom /root/.cache/qemu-=
vm/images/fedora.img.install.iso
ERROR:root:Log:
ERROR:root:qemu: unknown option 'chardev'
---

Wainer dos Santos Moschetta (1):
  tests/vm: Allow to set qemu-img path

 docs/devel/testing.rst    | 6 ++++--
 tests/vm/Makefile.include | 1 +
 tests/vm/basevm.py        | 5 +++++
 tests/vm/centos           | 2 +-
 tests/vm/fedora           | 4 +---
 tests/vm/freebsd          | 3 +--
 tests/vm/netbsd           | 3 +--
 tests/vm/openbsd          | 3 +--
 tests/vm/ubuntu.i386      | 2 +-
 9 files changed, 16 insertions(+), 13 deletions(-)

--=20
2.18.1


