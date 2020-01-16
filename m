Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DCC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68439246E9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5/253Ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68439246E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is95c-00083o-K3
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 12:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1is94u-0007dR-DQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1is94s-0001ho-1O
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:37:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30620
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1is94r-0001hQ-UD
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 12:37:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579196225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h9pPBaqVcd682kI0MDgau8NI+0WH/QOAWAEIfL7WpOM=;
 b=S5/253QlBHh6lIb7E9MvsOs9LdDfZ71ZM6o3ov1TsfGRdoY9oOEYIuID+9HA4OIIAMbKjt
 hZLRqpWH8PzV5PSh7aqTx8/I0xb0BtPRuelu8TYy+lbPSyHQBn9SkiRO7zorbTKQ2hupOR
 Qscw1ZFn+kEQGnhkuNW0Qta/L+REnBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-3vqVdUl7NsWD6BDcsRE5EA-1; Thu, 16 Jan 2020 12:37:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE7758010C0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 17:37:02 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-244.ams2.redhat.com
 [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E62389D09;
 Thu, 16 Jan 2020 17:37:01 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs: qemu-cpu-models: Document '-noTSX' variants and 'mds-no'
Date: Thu, 16 Jan 2020 18:36:38 +0100
Message-Id: <20200116173639.28524-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3vqVdUl7NsWD6BDcsRE5EA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Add the -noTSX variants for CascadeLake and SkyLake.

- Add a note aboute the 'mds-no' MSR.  Two confusing things about this:

  (1) The 'mds-no' will _not_ show up in the guest's /proc/cpuinfo.
      Rather it is used to fill in the guest's sysfs:

        sys/devices/system/cpu/vulnerabilities/mds:Not affected

      Paolo confirmed on IRC as such.

  (2) There are _three_ variants[+] of CascadeLake CPUs, with different
      stepping levels: 5, 6, and 7.  To quite wikichip.org[*]:

        "note that while steppings 6 & 7 are fully mitigated, earlier
        stepping 5 is not protected against MSBDS, MLPDS, nor MDSUM"

      The above is also indicated in the Intel's manual itself[+], as
      indicated by "No" under the three columns of MFBDS, MSBDS, and
      MLPDS.

      [+] https://software.intel.com/security-software-guidance/insights/pr=
ocessors-affected-microarchitectural-data-sampling
      [*] https://en.wikichip.org/wiki/intel/microarchitectures/cascade_lak=
e#Key_changes_from_Skylake

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
TODO:
 - I think I also need to add a note about 'tsx-ctrl' bit.  Here too,
   same question as above -- does it show up in /proc/cpuinfo/?
---
 docs/qemu-cpu-models.texi | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index f88a1def0d042cc25213259172a648f0a9c514dc..e6c4058e764a81988d6bc97457c=
668cb0ad2ea37 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -72,14 +72,30 @@ between machines, if live migration compatibility is re=
quired, use the newest
 CPU model that is compatible across all desired hosts.
=20
 @table @option
+
+@item @code{Cascadelake-Server-noTSX}
+
+Intell Xeon Processor (Cascade Lake, 2019-2020), with "stepping" levels
+6 or 7 only.  (The Cascade Lake Xeon processor with @b{stepping 5 is
+vulnerable to MDS variants}; refer below.)
+
+@code{/proc/cpuinfo}.
+
+The @code{mds-no} bit does not show up under @code{/proc/cpuinfo}.
+Rather it shows up under the @code{sysfs}, as
+@code{/sys/devices/system/cpu/vulnerabilities/mds:Not affected}
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
@@ -214,9 +230,28 @@ Must be explicitly turned on for all Intel CPU models.
=20
 Requires the host CPU microcode to support this feature before it
 can be used for guest CPUs.
+
+@item @code{mds-no}
+
+This is an MSR (Model-Specific Register) used by QEMU to indicate that
+the host is @i{not} vulnerable to any of the MDS variants ([MFBDS]
+CVE-2018-12130, [MLPDS] CVE-2018-12127, [MSBDS] CVE-2018-12126).
+
+Note that there are @i{three} versions of Intel's Cascade Lake
+processor, as distinguished by their "stepping" levels 5, 6, and 7.  The
+CPU with stepping "5" is @b{vulnerable to MDS variants}; and the CPUs
+with steppings "6" and "7" are @b{not vulnerable} to the above mentioned
+MDS variants.  The processor "stepping" is reported in
+@code{/proc/cpuinfo}.
+
+Confusingly, the @code{mds-no} bit does not show up under
+@code{/proc/cpuinfo} inside the guest.  Rather the kernel uses it to
+fill in the @code{sysfs}, as
+@code{/sys/devices/system/cpu/vulnerabilities/mds: Not affected},
+assuming the processor is running with stepping 6 or 7.
+
 @end table
=20
-
 @node preferred_cpu_models_amd_x86
 @subsubsection Preferred CPU models for AMD x86 hosts
=20
--=20
2.21.0


