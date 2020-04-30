Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B17C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B742082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljn/+XPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5xq-0004OE-Oe
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5li-0007ju-Ih
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jU5lh-0004wE-W9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34800
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jU5lh-0004w4-JX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588239968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpm/vwpRUHoqvmijjl3SeEzENCzlNTQO2Sv4APnpUQU=;
 b=Ljn/+XPZORb5EfhyBOA+ml4B624RshEPeyCNLmWdKDuMBNO3Qccvvk6M6WrcKVXDKgPfQ/
 qcRmqZOUXdAbAXzz1isjhnjPGt0/0NfSADOCUe5/7RRFB31HVA7Noc66uWR8N2TRxlg4Sc
 gDzLqoyar/RycwSke51mtdQkG1uczms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-FW_GfyccPcmE4Uo8phA_9Q-1; Thu, 30 Apr 2020 05:46:04 -0400
X-MC-Unique: FW_GfyccPcmE4Uo8phA_9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3313D45F;
 Thu, 30 Apr 2020 09:46:03 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5A3960BF4;
 Thu, 30 Apr 2020 09:45:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/20] docs: system: Add protvirt docs
Date: Thu, 30 Apr 2020 11:44:41 +0200
Message-Id: <20200430094445.25943-17-cohuck@redhat.com>
In-Reply-To: <20200430094445.25943-1-cohuck@redhat.com>
References: <20200430094445.25943-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's add some documentation for the Protected VM functionality.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200319131921.2367-16-frankja@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 docs/system/s390x/protvirt.rst | 60 ++++++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  5 +++
 2 files changed, 65 insertions(+)
 create mode 100644 docs/system/s390x/protvirt.rst

diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rs=
t
new file mode 100644
index 000000000000..712974ad87b9
--- /dev/null
+++ b/docs/system/s390x/protvirt.rst
@@ -0,0 +1,60 @@
+Protected Virtualization on s390x
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The memory and most of the registers of Protected Virtual Machines
+(PVMs) are encrypted or inaccessible to the hypervisor, effectively
+prohibiting VM introspection when the VM is running. At rest, PVMs are
+encrypted and can only be decrypted by the firmware, represented by an
+entity called Ultravisor, of specific IBM Z machines.
+
+
+Prerequisites
+-------------
+
+To run PVMs, a machine with the Protected Virtualization feature, as
+indicated by the Ultravisor Call facility (stfle bit 158), is
+required. The Ultravisor needs to be initialized at boot by setting
+`prot_virt=3D1` on the host's kernel command line.
+
+Running PVMs requires using the KVM hypervisor.
+
+If those requirements are met, the capability `KVM_CAP_S390_PROTECTED`
+will indicate that KVM can support PVMs on that LPAR.
+
+
+QEMU Settings
+-------------
+
+To indicate to the VM that it can transition into protected mode, the
+`Unpack facility` (stfle bit 161 represented by the feature
+`unpack`/`S390_FEAT_UNPACK`) needs to be part of the cpu model of
+the VM.
+
+All I/O devices need to use the IOMMU.
+Passthrough (vfio) devices are currently not supported.
+
+Host huge page backings are not supported. However guests can use huge
+pages as indicated by its facilities.
+
+
+Boot Process
+------------
+
+A secure guest image can either be loaded from disk or supplied on the
+QEMU command line. Booting from disk is done by the unmodified
+s390-ccw BIOS. I.e., the bootmap is interpreted, multiple components
+are read into memory and control is transferred to one of the
+components (zipl stage3). Stage3 does some fixups and then transfers
+control to some program residing in guest memory, which is normally
+the OS kernel. The secure image has another component prepended
+(stage3a) that uses the new diag308 subcodes 8 and 10 to trigger the
+transition into secure mode.
+
+Booting from the image supplied on the QEMU command line requires that
+the file passed via -kernel has the same memory layout as would result
+from the disk boot. This memory layout includes the encrypted
+components (kernel, initrd, cmdline), the stage3a loader and
+metadata. In case this boot method is used, the command line
+options -initrd and -cmdline are ineffective. The preparation of a PVM
+image is done via the `genprotimg` tool from the s390-tools
+collection.
diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
index 4c8b7cdd6615..7d76ae97b401 100644
--- a/docs/system/target-s390x.rst
+++ b/docs/system/target-s390x.rst
@@ -24,3 +24,8 @@ or vfio-ap is also available.
 .. toctree::
    s390x/vfio-ap
=20
+Architectural features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. toctree::
+   s390x/protvirt
--=20
2.21.1


