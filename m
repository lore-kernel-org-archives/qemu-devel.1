Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC57C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB67220678
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRYK595l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB67220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itybj-0003c0-VQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 13:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1ityb6-000346-8E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1ityb0-0006HL-S8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:49:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ityb0-0006Gb-OV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579632589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V3/j7C93YnnXqLs/KNCSE3TIqNo81fQdlN65oZ+/Rfg=;
 b=ZRYK595lTojCgY0FVJpdMYlZE8ypsBRRU2kPYRY9SxuhKpK0z4k5p1AlawJYN+Kq6B53Ca
 qeYDWeuY698qezHRa5u5PM/4NzG7FS9t/3mWNHg8sCKELt3XlBu7g9MZ7wMod6ul30EpKD
 fVNqg8rbdMlj8VN8+4Jma7G63nN9Vh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-_VZvokN8O2CDmP-QaIrQQg-1; Tue, 21 Jan 2020 13:49:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48D1E1005512
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:49:47 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-114.ams2.redhat.com
 [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8B2E101E26B;
 Tue, 21 Jan 2020 18:49:45 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] qemu-cpu-models: Document -noTSX, mds-no, taa-no,
 and tsx-ctrl
Date: Tue, 21 Jan 2020 19:49:39 +0100
Message-Id: <20200121184940.26520-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: _VZvokN8O2CDmP-QaIrQQg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add the '-noTSX' variants for CascadeLake and SkyLake.

- Document the three MSR bits: 'mds-no', 'taa-no', and 'tsx-ctrl'

  Two confusing about 'mds-no' (and the first point applies to the other
  two MSRs too):

  (1) The 'mds-no' will _not_ show up in the guest's /proc/cpuinfo.
      Rather it is used to fill in the guest's sysfs:

        sys/devices/system/cpu/vulnerabilities/mds:Not affected

      Paolo confirmed on IRC as such.

  (2) There are _three_ variants[+] of CascadeLake CPUs, with different
      stepping levels: 5, 6, and 7.  To quote wikichip.org[*]:

        "note that while steppings 6 & 7 are fully mitigated, earlier
        stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"

      The above is also indicated in the Intel's document[+], as
      indicated by "No" under the three columns of MFBDS, MSBDS, and
      MLPDS.

      [+] https://software.intel.com/security-software-guidance/insights/pr=
ocessors-affected-microarchitectural-data-sampling
      [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_lak=
e#Key_changes_from_Skylake

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v2:
 - Address feedback from DanPB
 - Add sections on 'taa-no' and 'tsx-ctrl' (appreciate a closer look on
   the latter).

Question: How can a user validate that TSX is indeed disabled for the
          guest?
Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
 docs/qemu-cpu-models.texi | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index f88a1def0d042cc25213259172a648f0a9c514dc..4b608513f2ba54efc91300ee3fe=
4b6a6ebe02cef 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -72,14 +72,25 @@ between machines, if live migration compatibility is re=
quired, use the newest
 CPU model that is compatible across all desired hosts.
=20
 @table @option
+
+@item @code{Cascadelake-Server}
+@item @code{Cascadelake-Server-noTSX}
+
+Intel Xeon Processor (Cascade Lake, 2019), with "stepping" levels
+6 or 7 only.  (The Cascade Lake Xeon processor with @b{stepping 5 is
+vulnerable to MDS variants}.)
+
+
 @item @code{Skylake-Server}
 @item @code{Skylake-Server-IBRS}
+@item @code{Skylake-Server-noTSX-IBRS}
=20
 Intel Xeon Processor (Skylake, 2016)
=20
=20
 @item @code{Skylake-Client}
 @item @code{Skylake-Client-IBRS}
+@item @code{Skylake-Client-noTSX-IBRS}
=20
 Intel Core Processor (Skylake, 2015)
=20
@@ -214,9 +225,49 @@ Must be explicitly turned on for all Intel CPU models.
=20
 Requires the host CPU microcode to support this feature before it
 can be used for guest CPUs.
+
+@item @code{mds-no}
+
+Recommended to inform the guest OS that the host is @i{not} vulnerable
+to any of the MDS variants ([MFBDS] CVE-2018-12130, [MLPDS]
+CVE-2018-12127, [MSBDS] CVE-2018-12126).
+
+This is an MSR (Model-Specific Register) feature rather than a CPUID
+feature, so it will not appear in the Linux @code{/proc/cpuinfo} in the
+host or guest.  Instead, the host kernel uses it to populate the MDS
+vulnerability file in @code{sysfs}.
+
+So it should only be enabled for VMs if the host reports @code{Not
+affected} in the @code{/sys/devices/system/cpu/vulnerabilities/mds}
+file.
+
+@item @code{taa-no}
+
+Recommended to inform that the guest that the host is @i{not} vulnerable
+to CVE-2019-11135, TSX Asyncrnous Abort (TAA).
+
+This too is an MSR feature, so it does not show up in the Linux
+@code{/proc/cpuinfo} in the host or guest.
+
+It should only be enabled for VMs if the host reports @code{Not
+affected} in the
+@code{/sys/devices/system/cpu/vulnerabilities/tsx_async_abort} file.
+
+@item @code{tsx-ctrl}
+
+Recommended to inform the guest to @i{disable} the Intel TSX
+(Transactional Synchronization Extensions) feature.  Expose this to the
+guest OS if and only if: (a) the host has TSX enabled; and (b) the guest
+has @code{rtm} CPU flag enabled.
+
+By disabling TSX, KVM-based guests can avoid paying the price of
+mitigting TSX-based attacks.
+
+Note that too is an MSR feature, so it does not show up in the Linux
+@code{/proc/cpuinfo} in the host or guest.
+
 @end table
=20
-
 @node preferred_cpu_models_amd_x86
 @subsubsection Preferred CPU models for AMD x86 hosts
=20
--=20
2.21.0


