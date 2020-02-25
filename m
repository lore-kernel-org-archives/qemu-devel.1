Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A4DC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7FD32082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 16:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjsNv6sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FD32082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dYH-0006T7-0g
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 11:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1j6dVe-0003cD-3F
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1j6dVZ-0002kn-FW
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1j6dVZ-0002kQ-7f
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 11:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582649792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w61qPrZtvXKfHiLda1EWJDLO0mcogUZekGLoEh2v6Rc=;
 b=JjsNv6sMvZCfeqea2qqSYm4eYYUj21e2l+JpPeUi82H/9eil1O41e5CLXZ/t8TRETF/sNL
 rAxgKwlCfiKTq8kUip45KYa/t/hLCCfBnkIq8iMDclin9wxSIK7Grvf02syRSuGFGyRA5r
 ANgTG9up4MyhLtp6pBDk6vS0bYSH528=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-TEl6ldF9PiSvefLRwpXP3A-1; Tue, 25 Feb 2020 11:56:25 -0500
X-MC-Unique: TEl6ldF9PiSvefLRwpXP3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D0008017DF;
 Tue, 25 Feb 2020 16:56:24 +0000 (UTC)
Received: from paraplu.redhat.com (ovpn-117-203.ams2.redhat.com
 [10.36.117.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC73E90535;
 Tue, 25 Feb 2020 16:56:21 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] docs: Convert qemu-cpu-models.texi to rST;
 related fixes
Date: Tue, 25 Feb 2020 17:56:17 +0100
Message-Id: <20200225165618.6571-2-kchamart@redhat.com>
In-Reply-To: <20200225165618.6571-1-kchamart@redhat.com>
References: <20200225165618.6571-1-kchamart@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, kchamart@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
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

  - rST and related infra changes: manual page generation, Makefile
    fixes, clean up references to qemu-cpu-models.texi, update year in
    the copyright notice, etc.

[1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
v4:
 - Correctly use the 'define-man-page' rule for qemu-cpu-models.7
   [pm215]
 - Fix author attribution as per the thread:
   Message-ID:
   <CAFEAcA8dTR6xkQnsf32HAo6aDXf5Z0UmkhL3+257KWLj1ES6Sw@mail.gmail.com>
   [danpb, pm215]
 - Don't reverse the existing order of the list of CPU models [pm215]
 - Use rST "definition lists" consistently throughout the document.
 - Consistently capitalize the phrase: "The QEMU Project Developers"
 - Update the year of copyright to 2020 in docs/conf.py
---
 MAINTAINERS                     |   2 +-
 Makefile                        |  12 +-
 docs/conf.py                    |   2 +-
 docs/qemu-cpu-models.texi       | 677 --------------------------------
 docs/system/conf.py             |   5 +-
 docs/system/index.rst           |   1 +
 docs/system/qemu-cpu-models.rst | 482 +++++++++++++++++++++++
 qemu-doc.texi                   |   5 -
 8 files changed, 495 insertions(+), 691 deletions(-)
 delete mode 100644 docs/qemu-cpu-models.texi
 create mode 100644 docs/system/qemu-cpu-models.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 36d94c17a6..3fa06de323 100644
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
index aa9cc0b584..fb18c7c7cb 100644
--- a/Makefile
+++ b/Makefile
@@ -352,9 +352,9 @@ ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_N=
G),yyy)
 DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtiofsd.1
 endif
 DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
+DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
 DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt docs/=
interop/qemu-qmp-ref.7
 DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/in=
terop/qemu-ga-ref.7
-DOCS+=3Ddocs/qemu-cpu-models.7
 DOCS+=3D$(MANUAL_BUILDDIR)/index.html
 ifdef CONFIG_VIRTFS
 DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
@@ -780,7 +780,6 @@ distclean: clean
 =09rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
 =09rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
 =09rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
-=09rm -f docs/qemu-cpu-models.7
 =09rm -rf .doctrees
 =09$(call clean-manual,devel)
 =09$(call clean-manual,interop)
@@ -859,7 +858,7 @@ ifdef CONFIG_POSIX
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
 =09$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
-=09$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
+=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)=
$(mandir)/man7"
 ifeq ($(CONFIG_TOOLS),y)
 =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mandir=
)/man1"
 =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
@@ -1076,7 +1075,9 @@ $(MANUAL_BUILDDIR)/tools/index.html: $(call manual-de=
ps,tools) $(SRC_PATH)/qemu-
=20
 $(call define-manpage-rule,interop,qemu-ga.8)
=20
-$(call define-manpage-rule,system,qemu-block-drivers.7)
+$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)
+
+$(call define-manpage-rule,system,qemu-cpu-models.7)
=20
 $(call define-manpage-rule,tools,\
        qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
@@ -1105,7 +1106,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/qg=
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
@@ -1117,7 +1117,7 @@ qemu-doc.html qemu-doc.info qemu-doc.pdf qemu-doc.txt=
: \
 =09qemu-tech.texi qemu-option-trace.texi \
 =09qemu-deprecated.texi qemu-monitor.texi \
 =09qemu-monitor-info.texi \
-=09docs/qemu-cpu-models.texi docs/security.texi
+=09docs/security.texi
=20
 docs/interop/qemu-ga-ref.dvi docs/interop/qemu-ga-ref.html \
     docs/interop/qemu-ga-ref.info docs/interop/qemu-ga-ref.pdf \
diff --git a/docs/conf.py b/docs/conf.py
index 7588bf192e..1650fc8698 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -80,7 +80,7 @@ master_doc =3D 'index'
=20
 # General information about the project.
 project =3D u'QEMU'
-copyright =3D u'2019, The QEMU Project Developers'
+copyright =3D u'2020, The QEMU Project Developers'
 author =3D u'The QEMU Project Developers'
=20
 # The version info for the project you're documenting, acts as replacement=
 for
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
index 7ca115f5e0..68d36d6fc6 100644
--- a/docs/system/conf.py
+++ b/docs/system/conf.py
@@ -18,5 +18,8 @@ html_theme_options['description'] =3D u'System Emulation =
User''s Guide'
 man_pages =3D [
     ('qemu-block-drivers', 'qemu-block-drivers',
      u'QEMU block drivers reference',
-     ['Fabrice Bellard and the QEMU Project developers'], 7)
+     ['Fabrice Bellard and the QEMU Project Developers'], 7),
+    ('qemu-cpu-models', 'qemu-cpu-models',
+     u'QEMU CPU Models',
+     ['The QEMU Project Developers'], 7)
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
index 0000000000..2bf635ecab
--- /dev/null
+++ b/docs/system/qemu-cpu-models.rst
@@ -0,0 +1,482 @@
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
+``Skylake-Server``, ``Skylake-Server-IBRS``
+    Intel Xeon Processor (Skylake, 2016)
+
+``Skylake-Client``, ``Skylake-Client-IBRS``
+    Intel Core Processor (Skylake, 2015)
+
+``Broadwell``, ``Broadwell-IBRS``, ``Broadwell-noTSX``, ``Broadwell-noTSX-=
IBRS``
+    Intel Core Processor (Broadwell, 2014)
+
+``Haswell``, ``Haswell-IBRS``, ``Haswell-noTSX``, ``Haswell-noTSX-IBRS``
+    Intel Core Processor (Haswell, 2013)
+
+``IvyBridge``, ``IvyBridge-IBR``
+    Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
+
+``SandyBridge``, ``SandyBridge-IBRS``
+    Intel Xeon E312xx (Sandy Bridge, 2011)
+
+``Westmere``, ``Westmere-IBRS``
+    Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
+
+``Nehalem``, ``Nehalem-IBRS``
+    Intel Core i7 9xx (Nehalem Class Core i7, 2008)
+
+``Penryn``
+    Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
+
+``Conroe``
+    Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
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
+``EPYC``, ``EPYC-IBPB``
+    AMD EPYC Processor (2017)
+
+``Opteron_G5``
+    AMD Opteron 63xx class CPU (2012)
+
+``Opteron_G4``
+    AMD Opteron 62xx class CPU (2011)
+
+``Opteron_G3``
+    AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
+
+``Opteron_G2``
+    AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
+
+``Opteron_G1``
+    AMD Opteron 240 (Gen 1 Class Opteron, 2004)
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
+``qemu32``, ``qemu64``
+    QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
+
+``qemu64`` is used for x86_64 guests and ``qemu32`` is used for i686
+guests, when no ``-cpu`` argument is given to QEMU, or no ``<cpu>`` is
+provided in libvirt XML.
+
+Other non-recommended x86 CPUs
+------------------------------
+
+The following CPUs models are compatible with most AMD and Intel x86
+hosts, but their usage is discouraged, as they expose a very limited
+featureset, which prevents guests having optimal performance.
+
+``kvm32``, ``kvm64``
+    Common KVM processor (32 & 64 bit variants).
+
+    Legacy models just for historical compatibility with ancient QEMU
+    versions.
+
+``486``, ``athlon``, ``phenom``, ``coreduo``, ``core2duo``, ``n270``, ``pe=
ntium``, ``pentium2``, ``pentium3``
+    Various very old x86 CPU models, mostly predating the introduction
+    of hardware assisted virtualization, that should thus not be
+    required for running virtual machines.
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
+``mips32r6-generic``
+    MIPS32 Processor (Release 6, 2015)
+
+``P5600``
+    MIPS32 Processor (P5600, 2014)
+
+``M14K``, ``M14Kc``
+    MIPS32 Processor (M14K, 2009)
+
+``74Kf``
+    MIPS32 Processor (74K, 2007)
+
+``34Kf``
+    MIPS32 Processor (34K, 2006)
+
+``24Kc``, ``24KEc``, ``24Kf``
+    MIPS32 Processor (24K, 2003)
+
+``4Kc``, ``4Km``, ``4KEcR1``, ``4KEmR1``, ``4KEc``, ``4KEm``
+    MIPS32 Processor (4K, 1999)
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
+``I6400``
+    MIPS64 Processor (Release 6, 2014)
+
+``Loongson-2F``
+    MIPS64 Processor (Loongson 2, 2008)
+
+``Loongson-2E``
+    MIPS64 Processor (Loongson 2, 2006)
+
+``mips64dspr2``
+    MIPS64 Processor (Release 2, 2006)
+
+``MIPS64R2-generic``, ``5KEc``, ``5KEf``
+    MIPS64 Processor (Release 2, 2002)
+
+``20Kc``
+    MIPS64 Processor (20K, 2000
+
+``5Kc``, ``5Kf``
+    MIPS64 Processor (5K, 1999)
+
+``VR5432``
+    MIPS64 Processor (VR, 1998)
+
+``R4000``
+    MIPS64 Processor (MIPS III, 1991)
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
+``I7200``
+    MIPS I7200 (nanoMIPS, 2018)
+
+Preferred CPU models for MIPS hosts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following CPU models are preferred for use on different MIPS hosts:
+
+``MIPS III``
+    R4000
+
+``MIPS32R2``
+    34Kf
+
+``MIPS64R6``
+    I6400
+
+``nanoMIPS``
+    I7200
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
index 33b9597b1d..97eb08a2b8 100644
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


