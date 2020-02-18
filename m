Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A299C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D0F20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pwdit8xQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D0F20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46cX-0001Au-B0
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j46bo-0000Bd-2x
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j46bm-0004wT-9v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:24:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j46bl-0004vV-JA
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9wzqaID556lhmDz7ptaF9S9MFe5XFUv0dltWs6xCdE=;
 b=Pwdit8xQT7b85IgjU6LN1mJc5o1ipb05eMTImegxDKAx4jKBm53hvkX+iUDfspgKQhaHnq
 qrsOJDuhWHx8uAWf2z8KwtzURbqzpV62rmd1FHugQijuT4Ln/W2ETGB8ehnKUkh4W0xh++
 UgJz2MwZUybpDc/z7eYBxoLB6OEu0Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-fKOo1hA2P92fY4D9qjJ1wA-1; Tue, 18 Feb 2020 12:24:25 -0500
X-MC-Unique: fKOo1hA2P92fY4D9qjJ1wA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C1CA100550E
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 17:24:24 +0000 (UTC)
Received: from lpt (ovpn-200-31.brq.redhat.com [10.40.200.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5C2B60BE1;
 Tue, 18 Feb 2020 17:24:15 +0000 (UTC)
Date: Tue, 18 Feb 2020 18:24:12 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
Message-ID: <20200218172412.GB577946@lpt>
References: <20200218161717.386723-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218161717.386723-1-jusual@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Feb 18, 2020 at 05:17:17PM +0100, Julia Suvorova wrote:
>Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
>to manage it and restrict unplug for the entire machine. This is going
>to prevent user-initiated unplug in guests (Windows mostly).
>Usage:
>    -device pcie-root-port,disable-hotplug=true,...
>
>Discussion related:
>    https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html
>
>Signed-off-by: Julia Suvorova <jusual@redhat.com>
>---
> hw/core/machine.c                  | 1 +
> hw/pci-bridge/pcie_root_port.c     | 3 ++-
> hw/pci-bridge/xio3130_downstream.c | 2 +-
> hw/pci/pcie.c                      | 8 ++++++--
> include/hw/pci/pcie.h              | 2 +-
> include/hw/pci/pcie_port.h         | 1 +
> 6 files changed, 12 insertions(+), 5 deletions(-)
>
>diff --git a/hw/core/machine.c b/hw/core/machine.c
>index 84812a1d1c..5ff698ac3c 100644
>--- a/hw/core/machine.c
>+++ b/hw/core/machine.c
>@@ -36,6 +36,7 @@ GlobalProperty hw_compat_4_2[] = {
>     { "usb-redir", "suppress-remote-wake", "off" },
>     { "qxl", "revision", "4" },
>     { "qxl-vga", "revision", "4" },
>+    { "pcie-root-port-base", "disable-hotplug", "false" },
> };
> const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>
>diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>index 0ba4e4dea4..d6a080bee8 100644
>--- a/hw/pci-bridge/pcie_root_port.c
>+++ b/hw/pci-bridge/pcie_root_port.c
>@@ -94,7 +94,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
>
>     pcie_cap_arifwd_init(d);
>     pcie_cap_deverr_init(d);
>-    pcie_cap_slot_init(d, s->slot);
>+    pcie_cap_slot_init(d, s);
>     pcie_cap_root_init(d);
>
>     pcie_chassis_create(s->chassis);
>@@ -147,6 +147,7 @@ static Property rp_props[] = {
>     DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                     QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>     DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
>+    DEFINE_PROP_BOOL("disable-hotplug", PCIESlot, disable_hotplug, false),
>     DEFINE_PROP_END_OF_LIST()
> };
>
>diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
>index 153a4acad2..04aae72cd6 100644
>--- a/hw/pci-bridge/xio3130_downstream.c
>+++ b/hw/pci-bridge/xio3130_downstream.c
>@@ -94,7 +94,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>     }
>     pcie_cap_flr_init(d);
>     pcie_cap_deverr_init(d);
>-    pcie_cap_slot_init(d, s->slot);
>+    pcie_cap_slot_init(d, s);
>     pcie_cap_arifwd_init(d);
>

The corresponding entry in xio3130_downstream_props[] is missing.

>     pcie_chassis_create(s->chassis);

Jano

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5MHbgACgkQ+YPwO/Ma
t50QzQgAp8aIxHvK8kteBDd9h7H6mn3EiepTfJntXj53RQ2LlyXwbbnDG1+krKVK
V7PDTbgL13S1UYMWt4J7xpe1omv5wIX8GUn8eJtGYYHiidU06+/BG0+0s7/je7nJ
1V7tmewp6Rmu9mdfApj+MR64K/69imXsCZrd+66ZK89yBEcoF9BsosM+L0PDNMkZ
o5Rdk8AB3w89JyXDu7Owp4I4VS/MMkLqOjW7VduWw32vNQHm+JHIyYAoSUCaCkgV
QFVI/DvVIb2d5OBdkDc4ESQfRBSIeeXbDiUnxyeCvUblCMP0As81bB2HhP11LeRP
FyvzpZbG6TYXqxFH0fKzUnjLTTHasQ==
=t16A
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--


