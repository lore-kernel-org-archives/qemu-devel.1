Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED349C28EB6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9ACC20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ACC20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58377 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqHD-0001hL-Uw
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:09:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF4-00006V-6m
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF3-00038G-6V
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqEy-0002qn-9p; Thu, 06 Jun 2019 07:07:28 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1M9nAB-1hVnpS46PF-005qM5; Thu, 06 Jun 2019 13:06:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:15 +0200
Message-Id: <20190606110625.32127-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nK/Fel8Fvw4QdlnGmjvpi6hFRc+DYWG+wpknXymG0HExoDoxRW6
	JS3z1safrDIU+v90zDCq1g0DuA6sgY8naaPZC4Kdg+QYG/paus5ngUBcl8fBX9ZOQBZGHev
	G56PlFm1o0lb1Rw9l3fsjenpypm0FBR69f29zjX29Q2vrj6FpvVDprWg2GWP61juNvRtBJI
	vWYwZpi4a7jsKmJdPq0eA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjzVW0+XTvw=:ij1DW/g9Jjm+H2Tqx+kc40
	h9cNXbOKSs6xNcscx2nU69LmWbA5mfspAyUQ2ytl3gWBJCJwb4W2u2F6GAsJKCNMTO1IEvAtm
	pjPrx+WNe1qMCScrglUZoGi7BWcqpTD5faxZL15TVRtzwwYjKOl9N9cmh0XFsFu5s9V8Mgwta
	24POEU9jWASXcu0Yn+sV3kySbEA7zcpX41P2tQQ1BjWs/SzPy6Vh1Bs6NB91DMrOG9LxooIga
	msi2KLQt4/9fOPkGzry7mKNc5CJBX61v9ySsCqUaWE3eU6JslwL+CukShHw0WztWEfbvqEfhz
	ta82I91QBudWfa9LycIrOj1IU6OCeKOZ8t2qVW9cTnRnkmxH2MgcU942QfETyIlBfoHFw/63Q
	ID5gu2fwxre0CTxTsRVjTeC/AkDdbws2mreHh7coqzWl/WS/4vK7CLdE63MjSCPjPeE3rwAeb
	36EanCY2nPdkU2MN1+bK3Xp20jZxDWFGC3MWrU/Krb54ZUfEylwFY8Jm89Y47RiYvIVwNRlL9
	gGroEb729ceCnHCNzrHrcDlrf++EZy7pR/+RecVlpbAGlAKjApmGQ8hmB/Ic1DkgYFrP3H+i4
	5G8xxhHSIyz9dTEXeedUDK0hQfsWwgYhu3rknkFobaeolsuyiTkMaCi47kW2vtuj/tQzoSdRx
	FAnSU01oC9Rpq/Kpgs4r3DqZCJC236nBY3mm+RtBpeXtNihyeQQvQzVx3f7lMpuOmCiQZ0H+v
	IOjJiTbrPELxkPmq2UU6vEwobHDiprvUSReiRk+iXWmWYEYth9cHgREMZ2k=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 06/16] docs/devel/build-system: Update an example
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

The default-configs/ example added in 717171bd2025 is no
more accurate since fa212a2b8b60 (and various further other
commits).

The Kconfig build system is now in place.
Use the aarch64-softmmu config as example.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190529140504.21580-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/devel/build-system.txt | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/docs/devel/build-system.txt b/docs/devel/build-system.txt
index addd274eebd9..41bd08ea3ab3 100644
--- a/docs/devel/build-system.txt
+++ b/docs/devel/build-system.txt
@@ -413,18 +413,13 @@ context.
 - default-configs/*.mak
 
 The files under default-configs/ control what emulated hardware is built
-into each QEMU system and userspace emulator targets. They merely
-contain a long list of config variable definitions. For example,
-default-configs/x86_64-softmmu.mak has:
-
-  include sound.mak
-  include usb.mak
-  CONFIG_QXL=$(CONFIG_SPICE)
-  CONFIG_VGA_ISA=y
-  CONFIG_VGA_CIRRUS=y
-  CONFIG_VMWARE_VGA=y
-  CONFIG_VIRTIO_VGA=y
-  ...snip...
+into each QEMU system and userspace emulator targets. They merely contain
+a list of config variable definitions like the machines that should be
+included. For example, default-configs/aarch64-softmmu.mak has:
+
+  include arm-softmmu.mak
+  CONFIG_XLNX_ZYNQMP_ARM=y
+  CONFIG_XLNX_VERSAL=y
 
 These files rarely need changing unless new devices / hardware need to
 be enabled for a particular system/userspace emulation target
-- 
2.21.0


