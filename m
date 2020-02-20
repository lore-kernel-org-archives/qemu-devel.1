Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA03BC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE4820722
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 14:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJjN63DP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE4820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4mRe-0007DG-GR
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 09:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j4mPT-0004v3-7X
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j4mPK-0007tj-Pd
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:02:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j4mPK-0007sw-JT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 09:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582207345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K44zgXHJ4/n8sKRVuHLNWK24ITsLYRb4IcSBXq4MV5Y=;
 b=aJjN63DPHCDcjq5Zj2FAyuUF9kUz3ioC1rX3idELluXIZgV6Zl1SPTeMULB8n3DjQ/O5Iw
 n5KnMoMoeoAp6pDGwBGPeGKQtDf+ngTKulVf08BDYL6JAvrSjGl42p8l0fVEOGVogvM2mT
 T/V/0wSTK4fo6LcmmJDZ/e8BhGP8AFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-itmgrS-4ObWurixaHG7N6w-1; Thu, 20 Feb 2020 09:02:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D1FE802561;
 Thu, 20 Feb 2020 14:02:16 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9535C114;
 Thu, 20 Feb 2020 14:02:14 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: kchamart@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] docs: Convert qemu-cpu-models.texi to rST
Date: Thu, 20 Feb 2020 15:02:09 +0100
Message-Id: <20200220140210.14209-2-kchamart@redhat.com>
In-Reply-To: <20200220140210.14209-1-kchamart@redhat.com>
References: <20200220140210.14209-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: itmgrS-4ObWurixaHG7N6w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This doc was originally written by Daniel P. Berrang=C3=A9
<berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
guidance on configuring CPU models for x86, 2018-06-27).

In this patch:

  - 1-1 conversion of Texinfo to rST, besides a couple of minor
    tweaks that are too trivial to mention.   (Thanks to Stephen
    Finucane on IRC for the suggestion to use rST "definition lists"
    instead of bullets in some places.)

    Further modifications will be done via a separate patch.

  - rST and related infra changes: for building the manual page,
    Makefile fixes, clean up references to qemu-cpu-models.texi, etc.

[1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v2: Fix rST conversion, man page creation, Makefile changes, et al
    (thanks, Peter Maydell)
---
 MAINTAINERS                     |   2 +-
 Makefile                        |  10 +-
 docs/qemu-cpu-models.texi       | 677 --------------------------------
 docs/system/conf.py             |   3 +
 docs/system/index.rst           |   1 +
 docs/system/qemu-cpu-models.rst | 514 ++++++++++++++++++++++++
 qemu-doc.texi                   |   5 -
 7 files changed, 524 insertions(+), 688 deletions(-)
 delete mode 100644 docs/qemu-cpu-models.texi
 create mode 100644 docs/system/qemu-cpu-models.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index e72b5e5f69..38bb821034 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -319,7 +319,7 @@ F: tests/tcg/i386/
 F: tests/tcg/x86_64/
 F: hw/i386/
 F: disas/i386.c
-F: docs/qemu-cpu-models.texi
+F: docs/system/qemu-cpu-models.rst
 T: git https://github.com/ehabkost/qemu.git x86-next
=20
 Xtensa TCG CPUs
diff --git a/Makefile b/Makefile
index 461d40bea6..5377a30d88 100644
--- a/Makefile
+++ b/Makefile
@@ -349,9 +349,9 @@ DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
 DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
+DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
 DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-qmp-ref.7
 DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/in=
terop/qemu-ga-ref.7
-DOCS+=3Ddocs/qemu-cpu-models.7
 DOCS+=3D$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
 DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
@@ -764,7 +764,6 @@ distclean: clean
 =09rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 =09rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 =09rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-=09rm -f docs/qemu-cpu-models.7
 =09rm -rf .doctrees
 =09$(call clean-manual,devel)
 =09$(call clean-manual,interop)
@@ -841,7 +840,7 @@ ifdef CONFIG_POSIX
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 =09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
-=09$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
+=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)=
$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(mand=
ir)/man1"
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -1056,6 +1055,8 @@ $(call define-manpage-rule,interop,\
=20
 $(call define-manpage-rule,system,qemu-block-drivers.7)
=20
+$(call define-manpage-rule,system,qemu-cpu-models.7)
+
 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version=
.h
 =09@mkdir -p "$(MANUAL_BUILDDIR)"
 =09$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
@@ -1078,7 +1079,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qg=
a-qapi-doc.texi
=20
 qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-inf=
o.texi
 qemu.1: qemu-option-trace.texi
-docs/qemu-cpu-models.7: docs/qemu-cpu-models.texi
=20
 html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-re=
f.html sphinxdocs
 info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-re=
f.info
@@ -1090,7 +1090,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt=
: \
 =09qemu-tech.texi qemu-option-trace.texi \
 =09qemu-deprecated.texi qemu-monitor.texi \
 =09qemu-monitor-info.texi \
-=09docs/qemu-cpu-models.texi docs/security.texi
+=09docs/security.texi
=20
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
deleted file mode 100644
index f88a1def0d..0000000000
--- a/docs/qemu-cpu-models.texi
+++ /dev/null
@@ -1,677 +0,0 @@
-@c man begin SYNOPSIS
-QEMU / KVM CPU model configuration
-@c man end
-
-@set qemu_system_x86 qemu-system-x86_64
-
-@c man begin DESCRIPTION
-
-@menu
-* recommendations_cpu_models_x86::  Recommendations for KVM CPU model conf=
iguration on x86 hosts
-* recommendations_cpu_models_MIPS:: Supported CPU model configurations on =
MIPS hosts
-* cpu_model_syntax_apps::           Syntax for configuring CPU models
-@end menu
-
-QEMU / KVM virtualization supports two ways to configure CPU models
-
-@table @option
-
-@item Host passthrough
-
-This passes the host CPU model features, model, stepping, exactly to the
-guest. Note that KVM may filter out some host CPU model features if they
-cannot be supported with virtualization. Live migration is unsafe when
-this mode is used as libvirt / QEMU cannot guarantee a stable CPU is
-exposed to the guest across hosts. This is the recommended CPU to use,
-provided live migration is not required.
-
-@item Named model
-
-QEMU comes with a number of predefined named CPU models, that typically
-refer to specific generations of hardware released by Intel and AMD.
-These allow the guest VMs to have a degree of isolation from the host CPU,
-allowing greater flexibility in live migrating between hosts with differin=
g
-hardware.
-@end table
-
-In both cases, it is possible to optionally add or remove individual CPU
-features, to alter what is presented to the guest by default.
-
-Libvirt supports a third way to configure CPU models known as "Host model"=
.
-This uses the QEMU "Named model" feature, automatically picking a CPU mode=
l
-that is similar the host CPU, and then adding extra features to approximat=
e
-the host model as closely as possible. This does not guarantee the CPU fam=
ily,
-stepping, etc will precisely match the host CPU, as they would with "Host
-passthrough", but gives much of the benefit of passthrough, while making
-live migration safe.
-
-@node recommendations_cpu_models_x86
-@subsection Recommendations for KVM CPU model configuration on x86 hosts
-
-The information that follows provides recommendations for configuring
-CPU models on x86 hosts. The goals are to maximise performance, while
-protecting guest OS against various CPU hardware flaws, and optionally
-enabling live migration between hosts with heterogeneous CPU models.
-
-@menu
-* preferred_cpu_models_intel_x86::       Preferred CPU models for Intel x8=
6 hosts
-* important_cpu_features_intel_x86::     Important CPU features for Intel =
x86 hosts
-* preferred_cpu_models_amd_x86::         Preferred CPU models for AMD x86 =
hosts
-* important_cpu_features_amd_x86::       Important CPU features for AMD x8=
6 hosts
-* default_cpu_models_x86::               Default x86 CPU models
-* other_non_recommended_cpu_models_x86:: Other non-recommended x86 CPUs
-@end menu
-
-@node preferred_cpu_models_intel_x86
-@subsubsection Preferred CPU models for Intel x86 hosts
-
-The following CPU models are preferred for use on Intel hosts. Administrat=
ors /
-applications are recommended to use the CPU model that matches the generat=
ion
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the new=
est
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{Skylake-Server}
-@item @code{Skylake-Server-IBRS}
-
-Intel Xeon Processor (Skylake, 2016)
-
-
-@item @code{Skylake-Client}
-@item @code{Skylake-Client-IBRS}
-
-Intel Core Processor (Skylake, 2015)
-
-
-@item @code{Broadwell}
-@item @code{Broadwell-IBRS}
-@item @code{Broadwell-noTSX}
-@item @code{Broadwell-noTSX-IBRS}
-
-Intel Core Processor (Broadwell, 2014)
-
-
-@item @code{Haswell}
-@item @code{Haswell-IBRS}
-@item @code{Haswell-noTSX}
-@item @code{Haswell-noTSX-IBRS}
-
-Intel Core Processor (Haswell, 2013)
-
-
-@item @code{IvyBridge}
-@item @code{IvyBridge-IBRS}
-
-Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
-
-
-@item @code{SandyBridge}
-@item @code{SandyBridge-IBRS}
-
-Intel Xeon E312xx (Sandy Bridge, 2011)
-
-
-@item @code{Westmere}
-@item @code{Westmere-IBRS}
-
-Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
-
-
-@item @code{Nehalem}
-@item @code{Nehalem-IBRS}
-
-Intel Core i7 9xx (Nehalem Class Core i7, 2008)
-
-
-@item @code{Penryn}
-
-Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
-
-
-@item @code{Conroe}
-
-Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
-
-@end table
-
-@node important_cpu_features_intel_x86
-@subsubsection Important CPU features for Intel x86 hosts
-
-The following are important CPU features that should be used on Intel x86
-hosts, when available in the host CPU. Some of them require explicit
-configuration to enable, as they are not included by default in some, or a=
ll,
-of the named CPU models listed above. In general all of these features are
-included if using "Host passthrough" or "Host model".
-
-
-@table @option
-
-@item @code{pcid}
-
-Recommended to mitigate the cost of the Meltdown (CVE-2017-5754) fix
-
-Included by default in Haswell, Broadwell & Skylake Intel CPU models.
-
-Should be explicitly turned on for Westmere, SandyBridge, and IvyBridge
-Intel CPU models. Note that some desktop/mobile Westmere CPUs cannot
-support this feature.
-
-
-@item @code{spec-ctrl}
-
-Required to enable the Spectre v2 (CVE-2017-5715) fix.
-
-Included by default in Intel CPU models with -IBRS suffix.
-
-Must be explicitly turned on for Intel CPU models without -IBRS suffix.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-
-
-@item @code{stibp}
-
-Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
-operating systems.
-
-Must be explicitly turned on for all Intel CPU models.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-
-
-@item @code{ssbd}
-
-Required to enable the CVE-2018-3639 fix
-
-Not included by default in any Intel CPU model.
-
-Must be explicitly turned on for all Intel CPU models.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-
-
-@item @code{pdpe1gb}
-
-Recommended to allow guest OS to use 1GB size pages
-
-Not included by default in any Intel CPU model.
-
-Should be explicitly turned on for all Intel CPU models.
-
-Note that not all CPU hardware will support this feature.
-
-@item @code{md-clear}
-
-Required to confirm the MDS (CVE-2018-12126, CVE-2018-12127, CVE-2018-1213=
0,
-CVE-2019-11091) fixes.
-
-Not included by default in any Intel CPU model.
-
-Must be explicitly turned on for all Intel CPU models.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-@end table
-
-
-@node preferred_cpu_models_amd_x86
-@subsubsection Preferred CPU models for AMD x86 hosts
-
-The following CPU models are preferred for use on Intel hosts. Administrat=
ors /
-applications are recommended to use the CPU model that matches the generat=
ion
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the new=
est
-CPU model that is compatible across all desired hosts.
-
-@table @option
-
-@item @code{EPYC}
-@item @code{EPYC-IBPB}
-
-AMD EPYC Processor (2017)
-
-
-@item @code{Opteron_G5}
-
-AMD Opteron 63xx class CPU (2012)
-
-
-@item @code{Opteron_G4}
-
-AMD Opteron 62xx class CPU (2011)
-
-
-@item @code{Opteron_G3}
-
-AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
-
-
-@item @code{Opteron_G2}
-
-AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
-
-
-@item @code{Opteron_G1}
-
-AMD Opteron 240 (Gen 1 Class Opteron, 2004)
-@end table
-
-@node important_cpu_features_amd_x86
-@subsubsection Important CPU features for AMD x86 hosts
-
-The following are important CPU features that should be used on AMD x86
-hosts, when available in the host CPU. Some of them require explicit
-configuration to enable, as they are not included by default in some, or a=
ll,
-of the named CPU models listed above. In general all of these features are
-included if using "Host passthrough" or "Host model".
-
-
-@table @option
-
-@item @code{ibpb}
-
-Required to enable the Spectre v2 (CVE-2017-5715) fix.
-
-Included by default in AMD CPU models with -IBPB suffix.
-
-Must be explicitly turned on for AMD CPU models without -IBPB suffix.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-
-
-@item @code{stibp}
-
-Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
-operating systems.
-
-Must be explicitly turned on for all AMD CPU models.
-
-Requires the host CPU microcode to support this feature before it
-can be used for guest CPUs.
-
-
-@item @code{virt-ssbd}
-
-Required to enable the CVE-2018-3639 fix
-
-Not included by default in any AMD CPU model.
-
-Must be explicitly turned on for all AMD CPU models.
-
-This should be provided to guests, even if amd-ssbd is also
-provided, for maximum guest compatibility.
-
-Note for some QEMU / libvirt versions, this must be force enabled
-when when using "Host model", because this is a virtual feature
-that doesn't exist in the physical host CPUs.
-
-
-@item @code{amd-ssbd}
-
-Required to enable the CVE-2018-3639 fix
-
-Not included by default in any AMD CPU model.
-
-Must be explicitly turned on for all AMD CPU models.
-
-This provides higher performance than virt-ssbd so should be
-exposed to guests whenever available in the host. virt-ssbd
-should none the less also be exposed for maximum guest
-compatibility as some kernels only know about virt-ssbd.
-
-
-@item @code{amd-no-ssb}
-
-Recommended to indicate the host is not vulnerable CVE-2018-3639
-
-Not included by default in any AMD CPU model.
-
-Future hardware generations of CPU will not be vulnerable to
-CVE-2018-3639, and thus the guest should be told not to enable
-its mitigations, by exposing amd-no-ssb. This is mutually
-exclusive with virt-ssbd and amd-ssbd.
-
-
-@item @code{pdpe1gb}
-
-Recommended to allow guest OS to use 1GB size pages
-
-Not included by default in any AMD CPU model.
-
-Should be explicitly turned on for all AMD CPU models.
-
-Note that not all CPU hardware will support this feature.
-@end table
-
-
-@node default_cpu_models_x86
-@subsubsection Default x86 CPU models
-
-The default QEMU CPU models are designed such that they can run on all hos=
ts.
-If an application does not wish to do perform any host compatibility check=
s
-before launching guests, the default is guaranteed to work.
-
-The default CPU models will, however, leave the guest OS vulnerable to var=
ious
-CPU hardware flaws, so their use is strongly discouraged. Applications sho=
uld
-follow the earlier guidance to setup a better CPU configuration, with host
-passthrough recommended if live migration is not needed.
-
-@table @option
-@item @code{qemu32}
-@item @code{qemu64}
-
-QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
-
-qemu64 is used for x86_64 guests and qemu32 is used for i686 guests, when =
no
--cpu argument is given to QEMU, or no <cpu> is provided in libvirt XML.
-@end table
-
-
-@node other_non_recommended_cpu_models_x86
-@subsubsection Other non-recommended x86 CPUs
-
-The following CPUs models are compatible with most AMD and Intel x86 hosts=
, but
-their usage is discouraged, as they expose a very limited featureset, whic=
h
-prevents guests having optimal performance.
-
-@table @option
-
-@item @code{kvm32}
-@item @code{kvm64}
-
-Common KVM processor (32 & 64 bit variants)
-
-Legacy models just for historical compatibility with ancient QEMU versions=
.
-
-
-@item @code{486}
-@item @code{athlon}
-@item @code{phenom}
-@item @code{coreduo}
-@item @code{core2duo}
-@item @code{n270}
-@item @code{pentium}
-@item @code{pentium2}
-@item @code{pentium3}
-
-Various very old x86 CPU models, mostly predating the introduction of
-hardware assisted virtualization, that should thus not be required for
-running virtual machines.
-@end table
-
-@node recommendations_cpu_models_MIPS
-@subsection Supported CPU model configurations on MIPS hosts
-
-QEMU supports variety of MIPS CPU models:
-
-@menu
-* cpu_models_MIPS32::               Supported CPU models for MIPS32 hosts
-* cpu_models_MIPS64::               Supported CPU models for MIPS64 hosts
-* cpu_models_nanoMIPS::             Supported CPU models for nanoMIPS host=
s
-* preferred_cpu_models_MIPS::       Preferred CPU models for MIPS hosts
-@end menu
-
-@node cpu_models_MIPS32
-@subsubsection Supported CPU models for MIPS32 hosts
-
-The following CPU models are supported for use on MIPS32 hosts. Administra=
tors /
-applications are recommended to use the CPU model that matches the generat=
ion
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the new=
est
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{mips32r6-generic}
-
-MIPS32 Processor (Release 6, 2015)
-
-
-@item @code{P5600}
-
-MIPS32 Processor (P5600, 2014)
-
-
-@item @code{M14K}
-@item @code{M14Kc}
-
-MIPS32 Processor (M14K, 2009)
-
-
-@item @code{74Kf}
-
-MIPS32 Processor (74K, 2007)
-
-
-@item @code{34Kf}
-
-MIPS32 Processor (34K, 2006)
-
-
-@item @code{24Kc}
-@item @code{24KEc}
-@item @code{24Kf}
-
-MIPS32 Processor (24K, 2003)
-
-
-@item @code{4Kc}
-@item @code{4Km}
-@item @code{4KEcR1}
-@item @code{4KEmR1}
-@item @code{4KEc}
-@item @code{4KEm}
-
-MIPS32 Processor (4K, 1999)
-@end table
-
-@node cpu_models_MIPS64
-@subsubsection Supported CPU models for MIPS64 hosts
-
-The following CPU models are supported for use on MIPS64 hosts. Administra=
tors /
-applications are recommended to use the CPU model that matches the generat=
ion
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the new=
est
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{I6400}
-
-MIPS64 Processor (Release 6, 2014)
-
-
-@item @code{Loongson-2F}
-
-MIPS64 Processor (Loongson 2, 2008)
-
-
-@item @code{Loongson-2E}
-
-MIPS64 Processor (Loongson 2, 2006)
-
-
-@item @code{mips64dspr2}
-
-MIPS64 Processor (Release 2, 2006)
-
-
-@item @code{MIPS64R2-generic}
-@item @code{5KEc}
-@item @code{5KEf}
-
-MIPS64 Processor (Release 2, 2002)
-
-
-@item @code{20Kc}
-
-MIPS64 Processor (20K, 2000)
-
-
-@item @code{5Kc}
-@item @code{5Kf}
-
-MIPS64 Processor (5K, 1999)
-
-
-@item @code{VR5432}
-
-MIPS64 Processor (VR, 1998)
-
-
-@item @code{R4000}
-
-MIPS64 Processor (MIPS III, 1991)
-@end table
-
-@node cpu_models_nanoMIPS
-@subsubsection Supported CPU models for nanoMIPS hosts
-
-The following CPU models are supported for use on nanoMIPS hosts. Administ=
rators /
-applications are recommended to use the CPU model that matches the generat=
ion
-of the host CPUs in use. In a deployment with a mixture of host CPU models
-between machines, if live migration compatibility is required, use the new=
est
-CPU model that is compatible across all desired hosts.
-
-@table @option
-@item @code{I7200}
-
-MIPS I7200 (nanoMIPS, 2018)
-
-@end table
-
-@node preferred_cpu_models_MIPS
-@subsubsection Preferred CPU models for MIPS hosts
-
-The following CPU models are preferred for use on different MIPS hosts:
-
-@table @option
-@item @code{MIPS III}
-R4000
-
-@item @code{MIPS32R2}
-34Kf
-
-@item @code{MIPS64R6}
-I6400
-
-@item @code{nanoMIPS}
-I7200
-@end table
-
-@node cpu_model_syntax_apps
-@subsection Syntax for configuring CPU models
-
-The example below illustrate the approach to configuring the various
-CPU models / features in QEMU and libvirt
-
-@menu
-* cpu_model_syntax_qemu::    QEMU command line
-* cpu_model_syntax_libvirt:: Libvirt guest XML
-@end menu
-
-@node cpu_model_syntax_qemu
-@subsubsection QEMU command line
-
-@table @option
-
-@item Host passthrough
-
-@example
-   $ @value{qemu_system_x86} -cpu host
-@end example
-
-With feature customization:
-
-@example
-   $ @value{qemu_system_x86} -cpu host,-vmx,...
-@end example
-
-@item Named CPU models
-
-@example
-   $ @value{qemu_system_x86} -cpu Westmere
-@end example
-
-With feature customization:
-
-@example
-   $ @value{qemu_system_x86} -cpu Westmere,+pcid,...
-@end example
-
-@end table
-
-@node cpu_model_syntax_libvirt
-@subsubsection Libvirt guest XML
-
-@table @option
-
-@item Host passthrough
-
-@example
-   <cpu mode=3D'host-passthrough'/>
-@end example
-
-With feature customization:
-
-@example
-   <cpu mode=3D'host-passthrough'>
-       <feature name=3D"vmx" policy=3D"disable"/>
-       ...
-   </cpu>
-@end example
-
-@item Host model
-
-@example
-   <cpu mode=3D'host-model'/>
-@end example
-
-With feature customization:
-
-@example
-   <cpu mode=3D'host-model'>
-       <feature name=3D"vmx" policy=3D"disable"/>
-       ...
-   </cpu>
-@end example
-
-@item Named model
-
-@example
-   <cpu mode=3D'custom'>
-       <model name=3D"Westmere"/>
-   </cpu>
-@end example
-
-With feature customization:
-
-@example
-   <cpu mode=3D'custom'>
-       <model name=3D"Westmere"/>
-       <feature name=3D"pcid" policy=3D"require"/>
-       ...
-   </cpu>
-@end example
-
-@end table
-
-@c man end
-
-@ignore
-
-@setfilename qemu-cpu-models
-@settitle QEMU / KVM CPU model configuration
-
-@c man begin SEEALSO
-The HTML documentation of QEMU for more precise information and Linux
-user mode emulator invocation.
-@c man end
-
-@c man begin AUTHOR
-Daniel P. Berrange
-@c man end
-
-@end ignore
diff --git a/docs/system/conf.py b/docs/system/conf.py
index 7ca115f5e0..7cc9da9508 100644
--- a/docs/system/conf.py
+++ b/docs/system/conf.py
@@ -18,5 +18,8 @@ html_theme_options['description'] =3D u'System Emulation =
User''s Guide'
 man_pages =3D [
     ('qemu-block-drivers', 'qemu-block-drivers',
      u'QEMU block drivers reference',
+     ['Fabrice Bellard and the QEMU Project developers'], 7),
+    ('qemu-cpu-models', 'qemu-cpu-models',
+     u'QEMU CPU Models',
      ['Fabrice Bellard and the QEMU Project developers'], 7)
 ]
diff --git a/docs/system/index.rst b/docs/system/index.rst
index f66e6ea585..849dcd8cb8 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -15,3 +15,4 @@ Contents:
    :maxdepth: 2
=20
    qemu-block-drivers
+   qemu-cpu-models
diff --git a/docs/system/qemu-cpu-models.rst b/docs/system/qemu-cpu-models.=
rst
new file mode 100644
index 0000000000..a189d6a9da
--- /dev/null
+++ b/docs/system/qemu-cpu-models.rst
@@ -0,0 +1,514 @@
+QEMU / KVM CPU model configuration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. |qemu_system| replace:: qemu-system-x86_64
+
+.. only:: man
+
+  Synopsis
+  --------
+
+  QEMU CPU Modelling Infrastructure manual
+
+Two ways to configure CPU models with QEMU / KVM
+------------------------------------------------
+
+(1) **Host passthrough**
+
+    This passes the host CPU model features, model, stepping, exactly to
+    the guest. Note that KVM may filter out some host CPU model features
+    if they cannot be supported with virtualization. Live migration is
+    unsafe when this mode is used as libvirt / QEMU cannot guarantee a
+    stable CPU is exposed to the guest across hosts. This is the
+    recommended CPU to use, provided live migration is not required.
+
+(2) **Named model**
+
+    QEMU comes with a number of predefined named CPU models, that
+    typically refer to specific generations of hardware released by
+    Intel and AMD.  These allow the guest VMs to have a degree of
+    isolation from the host CPU, allowing greater flexibility in live
+    migrating between hosts with differing hardware.  @end table
+
+In both cases, it is possible to optionally add or remove individual CPU
+features, to alter what is presented to the guest by default.
+
+Libvirt supports a third way to configure CPU models known as "Host
+model".  This uses the QEMU "Named model" feature, automatically picking
+a CPU model that is similar the host CPU, and then adding extra features
+to approximate the host model as closely as possible. This does not
+guarantee the CPU family, stepping, etc will precisely match the host
+CPU, as they would with "Host passthrough", but gives much of the
+benefit of passthrough, while making live migration safe.
+
+
+Recommendations for KVM CPU model configuration on x86 hosts
+------------------------------------------------------------
+
+The information that follows provides recommendations for configuring
+CPU models on x86 hosts. The goals are to maximise performance, while
+protecting guest OS against various CPU hardware flaws, and optionally
+enabling live migration between hosts with heterogeneous CPU models.
+
+
+Preferred CPU models for Intel x86 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are preferred for use on Intel hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+* Intel Xeon Processor (Skylake, 2016)
+
+  * ``Skylake-Server``
+  * ``Skylake-Server-IBRS``
+
+* Intel Core Processor (Skylake, 2015)
+
+  * ``Skylake-Client``
+  * ``Skylake-Client-IBRS``
+
+* Intel Core Processor (Broadwell, 2014)
+
+  * ``Broadwell``
+  * ``Broadwell-IBRS``
+  * ``Broadwell-noTSX``
+  * ``Broadwell-noTSX-IBRS``
+
+* Intel Core Processor (Haswell, 2013)
+
+  * ``Haswell``
+  * ``Haswell-IBRS``
+  * ``Haswell-noTSX``
+  * ``Haswell-noTSX-IBRS``
+
+* Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
+
+  * ``IvyBridge``
+  * ``IvyBridge-IBR``
+
+* Intel Xeon E312xx (Sandy Bridge, 2011)
+
+  * ``SandyBridge``
+  * ``SandyBridge-IBRS``
+
+* Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
+
+  * ``Westmere``
+  * ``Westmere-IBRS``
+
+* Intel Core i7 9xx (Nehalem Class Core i7, 2008)
+
+  * ``Nehalem``
+  * ``Nehalem-IBRS``
+
+* Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
+
+  * ``Penryn``
+
+* Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
+
+  * ``Conroe``
+
+
+Important CPU features for Intel x86 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following are important CPU features that should be used on Intel
+x86 hosts, when available in the host CPU. Some of them require explicit
+configuration to enable, as they are not included by default in some, or
+all, of the named CPU models listed above. In general all of these
+features are included if using "Host passthrough" or "Host model".
+
+``pcid``
+  Recommended to mitigate the cost of the Meltdown (CVE-2017-5754) fix.
+
+  Included by default in Haswell, Broadwell & Skylake Intel CPU models.
+
+  Should be explicitly turned on for Westmere, SandyBridge, and
+  IvyBridge Intel CPU models. Note that some desktop/mobile Westmere
+  CPUs cannot support this feature.
+
+``spec-ctrl``
+  Required to enable the Spectre v2 (CVE-2017-5715) fix.
+
+  Included by default in Intel CPU models with -IBRS suffix.
+
+  Must be explicitly turned on for Intel CPU models without -IBRS
+  suffix.
+
+  Requires the host CPU microcode to support this feature before it
+  can be used for guest CPUs.
+
+``stibp``
+  Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
+  operating systems.
+
+  Must be explicitly turned on for all Intel CPU models.
+
+  Requires the host CPU microcode to support this feature before it can
+  be used for guest CPUs.
+
+``ssbd``
+  Required to enable the CVE-2018-3639 fix.
+
+  Not included by default in any Intel CPU model.
+
+  Must be explicitly turned on for all Intel CPU models.
+
+  Requires the host CPU microcode to support this feature before it
+  can be used for guest CPUs.
+
+``pdpe1gb``
+  Recommended to allow guest OS to use 1GB size pages.
+
+  Not included by default in any Intel CPU model.
+
+  Should be explicitly turned on for all Intel CPU models.
+
+  Note that not all CPU hardware will support this feature.
+
+``md-clear``
+  Required to confirm the MDS (CVE-2018-12126, CVE-2018-12127,
+  CVE-2018-12130, CVE-2019-11091) fixes.
+
+  Not included by default in any Intel CPU model.
+
+  Must be explicitly turned on for all Intel CPU models.
+
+  Requires the host CPU microcode to support this feature before it
+  can be used for guest CPUs.
+
+
+Preferred CPU models for AMD x86 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are preferred for use on Intel hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+* AMD EPYC Processor (2017)
+
+  * ``EPYC``
+  * ``EPYC-IBPB``
+
+* ``Opteron_G5`` =E2=80=93 AMD Opteron 63xx class CPU (2012)
+
+* ``Opteron_G4`` =E2=80=93 AMD Opteron 62xx class CPU (2011)
+
+* ``Opteron_G3`` =E2=80=93 AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
+
+* ``Opteron_G2`` =E2=80=93 AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
+
+* ``Opteron_G1`` =E2=80=93 AMD Opteron 240 (Gen 1 Class Opteron, 2004)
+
+
+Important CPU features for AMD x86 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following are important CPU features that should be used on AMD x86
+hosts, when available in the host CPU. Some of them require explicit
+configuration to enable, as they are not included by default in some, or
+all, of the named CPU models listed above. In general all of these
+features are included if using "Host passthrough" or "Host model".
+
+``ibpb``
+  Required to enable the Spectre v2 (CVE-2017-5715) fix.
+
+  Included by default in AMD CPU models with -IBPB suffix.
+
+  Must be explicitly turned on for AMD CPU models without -IBPB suffix.
+
+  Requires the host CPU microcode to support this feature before it
+  can be used for guest CPUs.
+
+``stibp``
+  Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
+  operating systems.
+
+  Must be explicitly turned on for all AMD CPU models.
+
+  Requires the host CPU microcode to support this feature before it
+  can be used for guest CPUs.
+
+``virt-ssbd``
+  Required to enable the CVE-2018-3639 fix
+
+  Not included by default in any AMD CPU model.
+
+  Must be explicitly turned on for all AMD CPU models.
+
+  This should be provided to guests, even if amd-ssbd is also provided,
+  for maximum guest compatibility.
+
+  Note for some QEMU / libvirt versions, this must be force enabled when
+  when using "Host model", because this is a virtual feature that
+  doesn't exist in the physical host CPUs.
+
+``amd-ssbd``
+  Required to enable the CVE-2018-3639 fix
+
+  Not included by default in any AMD CPU model.
+
+  Must be explicitly turned on for all AMD CPU models.
+
+  This provides higher performance than ``virt-ssbd`` so should be
+  exposed to guests whenever available in the host. ``virt-ssbd`` should
+  none the less also be exposed for maximum guest compatibility as some
+  kernels only know about ``virt-ssbd``.
+
+``amd-no-ssb``
+  Recommended to indicate the host is not vulnerable CVE-2018-3639
+
+  Not included by default in any AMD CPU model.
+
+  Future hardware generations of CPU will not be vulnerable to
+  CVE-2018-3639, and thus the guest should be told not to enable
+  its mitigations, by exposing amd-no-ssb. This is mutually
+  exclusive with virt-ssbd and amd-ssbd.
+
+``pdpe1gb``
+  Recommended to allow guest OS to use 1GB size pages
+
+  Not included by default in any AMD CPU model.
+
+  Should be explicitly turned on for all AMD CPU models.
+
+  Note that not all CPU hardware will support this feature.
+
+
+Default x86 CPU models
+----------------------
+
+The default QEMU CPU models are designed such that they can run on all
+hosts.  If an application does not wish to do perform any host
+compatibility checks before launching guests, the default is guaranteed
+to work.
+
+The default CPU models will, however, leave the guest OS vulnerable to
+various CPU hardware flaws, so their use is strongly discouraged.
+Applications should follow the earlier guidance to setup a better CPU
+configuration, with host passthrough recommended if live migration is
+not needed.
+
+* QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
+
+  * ``qemu32``
+  * ``qemu64``
+
+  ``qemu64`` is used for x86_64 guests and ``qemu32`` is used for i686
+  guests, when no ``-cpu`` argument is given to QEMU, or no ``<cpu>`` is
+  provided in libvirt XML.
+
+Other non-recommended x86 CPUs
+------------------------------
+
+The following CPUs models are compatible with most AMD and Intel x86
+hosts, but their usage is discouraged, as they expose a very limited
+featureset, which prevents guests having optimal performance.
+
+* Common KVM processor (32 & 64 bit variants):
+
+  * ``kvm32``
+  * ``kvm64``
+
+  Legacy models just for historical compatibility with ancient QEMU
+  versions.
+
+* Various very old x86 CPU models, mostly predating the introduction of
+  hardware assisted virtualization, that should thus not be required for
+  running virtual machines.
+
+  * ``486``
+  * ``athlon``
+  * ``phenom``
+  * ``coreduo``
+  * ``core2duo``
+  * ``n270``
+  * ``pentium``
+  * ``pentium2``
+  * ``pentium3``
+
+
+Supported CPU model configurations on MIPS hosts
+------------------------------------------------
+
+QEMU supports variety of MIPS CPU models:
+
+Supported CPU models for MIPS32 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are supported for use on MIPS32 hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+* ``mips32r6-generic`` =E2=80=93 MIPS32 Processor (Release 6, 2015)
+
+* ``P5600`` =E2=80=93 MIPS32 Processor (P5600, 2014)
+
+* MIPS32 Processor (M14K, 2009)
+
+  * ``M14K``
+  * ``M14Kc``
+
+* ``74Kf`` =E2=80=93 MIPS32 Processor (74K, 2007)
+
+* ``34Kf`` =E2=80=93 MIPS32 Processor (34K, 2006)
+
+* MIPS32 Processor (24K, 2003)
+
+  * ``24Kc``
+  * ``24KEc``
+  * ``24Kf``
+
+* MIPS32 Processor (4K, 1999)
+
+  * ``4Kc``
+  * ``4Km``
+  * ``4KEcR1``
+  * ``4KEmR1``
+  * ``4KEc``
+  * ``4KEm``
+
+
+Supported CPU models for MIPS64 hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are supported for use on MIPS64 hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+* ``I6400`` =E2=80=93 MIPS64 Processor (Release 6, 2014)
+
+* ``Loongson-2F`` =E2=80=93 MIPS64 Processor (Loongson 2, 2008)
+
+* ``Loongson-2E`` =E2=80=93 MIPS64 Processor (Loongson 2, 2006)
+
+* ``mips64dspr2`` =E2=80=93 MIPS64 Processor (Release 2, 2006)
+
+* MIPS64 Processor (Release 2, 2002)
+
+  * ``MIPS64R2-generic``
+  * ``5KEc``
+  * ``5KEf``
+
+* ``20Kc`` =E2=80=93 MIPS64 Processor (20K, 2000
+
+* MIPS64 Processor (5K, 1999)
+
+  * ``5Kc``
+  * ``5Kf``
+
+* ``VR5432`` =E2=80=93 MIPS64 Processor (VR, 1998)
+
+* ``R4000`` =E2=80=93 MIPS64 Processor (MIPS III, 1991)
+
+
+Supported CPU models for nanoMIPS hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are supported for use on nanoMIPS hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+* ``I7200`` =E2=80=93 MIPS I7200 (nanoMIPS, 2018)
+
+Preferred CPU models for MIPS hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are preferred for use on different MIPS hosts:
+
+* ``MIPS III`` =E2=80=93 R4000
+
+* ``MIPS32R2`` =E2=80=93 34Kf
+
+* ``MIPS64R6`` =E2=80=93 I6400
+
+* ``nanoMIPS`` =E2=80=93 I7200
+
+Syntax for configuring CPU models
+---------------------------------
+
+The examples below illustrate the approach to configuring the various
+CPU models / features in QEMU and libvirt.
+
+QEMU command line
+~~~~~~~~~~~~~~~~~
+
+Host passthrough:
+
+.. parsed-literal::
+
+  |qemu_system| -cpu host
+
+Host passthrough with feature customization:
+
+.. parsed-literal::
+
+  |qemu_system| -cpu host,-vmx,...
+
+Named CPU models:
+
+.. parsed-literal::
+
+  |qemu_system| -cpu Westmere
+
+Named CPU models with feature customization:
+
+.. parsed-literal::
+
+  |qemu_system| -cpu Westmere,+pcid,...
+
+Libvirt guest XML
+~~~~~~~~~~~~~~~~~
+
+Host passthrough::
+
+    <cpu mode=3D'host-passthrough'/>
+
+Host passthrough with feature customization::
+
+    <cpu mode=3D'host-passthrough'>
+        <feature name=3D"vmx" policy=3D"disable"/>
+        ...
+    </cpu>
+
+Host model::
+
+    <cpu mode=3D'host-model'/>
+
+Host model with feature customization::
+
+    <cpu mode=3D'host-model'>
+        <feature name=3D"vmx" policy=3D"disable"/>
+        ...
+    </cpu>
+
+Named model::
+
+    <cpu mode=3D'custom'>
+        <model name=3D"Westmere"/>
+    </cpu>
+
+Named model with feature customization::
+
+    <cpu mode=3D'custom'>
+        <model name=3D"Westmere"/>
+        <feature name=3D"pcid" policy=3D"require"/>
+        ...
+    </cpu>
diff --git a/qemu-doc.texi b/qemu-doc.texi
index a1ef6b6484..c6a74877d6 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -616,11 +616,6 @@ The monitor understands integers expressions for every=
 integer
 argument. You can use register names to get the value of specifics
 CPU registers by prefixing them with @emph{$}.
=20
-@node cpu_models
-@section CPU models
-
-@include docs/qemu-cpu-models.texi
-
 @node disk_images
 @section Disk Images
=20
--=20
2.21.0


