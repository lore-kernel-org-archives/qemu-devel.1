Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0407FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8D420719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbhdHToV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8D420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxj0-0003p9-GG
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHu-00045P-VR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHs-0006Mu-4s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHr-0006Gv-V9
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqxX7RV+tk2/7J3Xr0yT/Gwt34XZbIeFvDkXq7c9x5U=;
 b=RbhdHToVy5MND+NkvyN/oc9cJJprOZHXAZH9VjgcpLhrWx4/Z5e1/X6YTS76OC3GLi+jbP
 4TtezJ2xjRjRUr/j+CGP9gvEkU6faeFAI5TphvVla6HIpuUvTmRU6ZfkGqegPeiJTEi797
 qAv418Il/U9tcdfiOogrigHxLFf322U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-gUk2UZ3DOSOtSaptpi3BEw-1; Mon, 16 Mar 2020 17:28:30 -0400
X-MC-Unique: gUk2UZ3DOSOtSaptpi3BEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D223D149C3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:29 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CED519C4F;
 Mon, 16 Mar 2020 21:28:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/61] qemu-cpu-models.rst: Document -noTSX, mds-no, taa-no,
 and tsx-ctrl
Date: Mon, 16 Mar 2020 22:26:57 +0100
Message-Id: <1584394048-44994-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kashyap Chamarthy <kchamart@redhat.com>

- Add the '-noTSX' variants for CascadeLake and SkyLake.

- Document the three MSR bits: 'mds-no', 'taa-no', and 'tsx-ctrl'

  Two confusing things about 'mds-no' (and the first point applies to
  the other two MSRs too):

  (1) The 'mds-no' bit will _not_ show up in the guest's /proc/cpuinfo.
      Rather it is used to fill in the guest's sysfs:

        /sys/devices/system/cpu/vulnerabilities/mds:Not affected

      Paolo confirmed on IRC as such.

  (2) There are _three_ variants[+] of CascadeLake CPUs, with different
      stepping levels: 5, 6, and 7.  To quote wikichip.org[*]:

        "note that while steppings 6 & 7 are fully mitigated, earlier
        stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"

      The above is also indicated in the Intel's document[+], as
      indicated by "No" under the three columns of MFBDS, MSBDS, and
      MLPDS.

  I've expressed this in the docs without belabouring the details.

      [+] https://software.intel.com/security-software-guidance/insights/pr=
ocessors-affected-microarchitectural-data-sampling
      [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_lak=
e#Key_changes_from_Skylake

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Message-Id: <20200225165618.6571-3-kchamart@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/cpu-models-x86.rst.inc | 57 ++++++++++++++++++++++++++++++++++=
++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x8=
6.rst.inc
index cbad930..9a23278 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -49,10 +49,15 @@ mixture of host CPU models between machines, if live mi=
gration
 compatibility is required, use the newest CPU model that is compatible
 across all desired hosts.
=20
-``Skylake-Server``, ``Skylake-Server-IBRS``
+``Cascadelake-Server``, ``Cascadelake-Server-noTSX``
+    Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels 6
+    or 7 only.  (The Cascade Lake Xeon processor with *stepping 5 is
+    vulnerable to MDS variants*.)
+
+``Skylake-Server``, ``Skylake-Server-IBRS``, ``Skylake-Server-IBRS-noTSX``
     Intel Xeon Processor (Skylake, 2016)
=20
-``Skylake-Client``, ``Skylake-Client-IBRS``
+``Skylake-Client``, ``Skylake-Client-IBRS``, ``Skylake-Client-noTSX-IBRS}`=
`
     Intel Core Processor (Skylake, 2015)
=20
 ``Broadwell``, ``Broadwell-IBRS``, ``Broadwell-noTSX``, ``Broadwell-noTSX-=
IBRS``
@@ -148,6 +153,54 @@ features are included if using "Host passthrough" or "=
Host model".
   Requires the host CPU microcode to support this feature before it
   can be used for guest CPUs.
=20
+``mds-no``
+  Recommended to inform the guest OS that the host is *not* vulnerable
+  to any of the MDS variants ([MFBDS] CVE-2018-12130, [MLPDS]
+  CVE-2018-12127, [MSBDS] CVE-2018-12126).
+
+  This is an MSR (Model-Specific Register) feature rather than a CPUID fea=
ture,
+  so it will not appear in the Linux ``/proc/cpuinfo`` in the host or
+  guest.  Instead, the host kernel uses it to populate the MDS
+  vulnerability file in ``sysfs``.
+
+  So it should only be enabled for VMs if the host reports @code{Not
+  affected} in the ``/sys/devices/system/cpu/vulnerabilities/mds`` file.
+
+``taa-no``
+  Recommended to inform that the guest that the host is ``not``
+  vulnerable to CVE-2019-11135, TSX Asynchronous Abort (TAA).
+
+  This too is an MSR feature, so it does not show up in the Linux
+  ``/proc/cpuinfo`` in the host or guest.
+
+  It should only be enabled for VMs if the host reports ``Not affected``
+  in the ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort``
+  file.
+
+``tsx-ctrl``
+  Recommended to inform the guest that it can disable the Intel TSX
+  (Transactional Synchronization Extensions) feature; or, if the
+  processor is vulnerable, use the Intel VERW instruction (a
+  processor-level instruction that performs checks on memory access) as
+  a mitigation for the TAA vulnerability.  (For details, refer to
+  Intel's `deep dive into MDS
+  <https://software.intel.com/security-software-guidance/insights/deep-div=
e-intel-analysis-microarchitectural-data-sampling>`_.)
+
+  Expose this to the guest OS if and only if: (a) the host has TSX
+  enabled; *and* (b) the guest has ``rtm`` CPU flag enabled.
+
+  By disabling TSX, KVM-based guests can avoid paying the price of
+  mitigating TSX-based attacks.
+
+  Note that ``tsx-ctrl`` too is an MSR feature, so it does not show
+  up in the Linux ``/proc/cpuinfo`` in the host or guest.
+
+  To validate that Intel TSX is indeed disabled for the guest, there are
+  two ways: (a) check for the *absence* of ``rtm`` in the guest's
+  ``/proc/cpuinfo``; or (b) the
+  ``/sys/devices/system/cpu/vulnerabilities/tsx_async_abort`` file in
+  the guest should report ``Mitigation: TSX disabled``.
+
=20
 Preferred CPU models for AMD x86 hosts
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--=20
1.8.3.1



