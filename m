Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1BAC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4302068F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 09:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk5hAfhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4302068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCgDr-0002Cn-8h
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 05:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1kCg8O-00054r-El
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:29:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29350
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1kCg8M-0005KG-6n
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598866189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dRYhdYrJ/QQ7qC7lfKlFeFDFZWMtrToxGcMoZpBTThU=;
 b=Wk5hAfhZ7B16ogl78YMkRPZ2hQvOVf7ZmBO4AqV3X32tnjgG74YJVJiFR+Bb9rUKeNkZws
 TOL5Lt9AgphrsW9RVkjcIkP3paJrvKJvx/nd7sYFksL2Lejq7oW0X5nRlck++gYYey8r7s
 0WnPjUgenN/bZ0PaprrwYpsqLfruEeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-XetFIpsJN0OheFYv-zBCGQ-1; Mon, 31 Aug 2020 05:29:47 -0400
X-MC-Unique: XetFIpsJN0OheFYv-zBCGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06155801AC4;
 Mon, 31 Aug 2020 09:29:46 +0000 (UTC)
Received: from [10.35.206.182] (unknown [10.35.206.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E52C81184;
 Mon, 31 Aug 2020 09:29:42 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH 2/2] hw/virtio-pci Added AER capability.
From: Yan Vugenfirer <yvugenfi@redhat.com>
In-Reply-To: <20200813071931.19846-2-andrew@daynix.com>
Date: Mon, 31 Aug 2020 12:29:39 +0300
Message-Id: <EE08315A-A53A-4D05-B971-AEF9E3B85761@redhat.com>
References: <20200813071931.19846-1-andrew@daynix.com>
 <20200813071931.19846-2-andrew@daynix.com>
To: Andrew Melnichenko <andrew@daynix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yvugenfi@redhat.com
X-Mimecast-Spam-Score: 0.502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:56:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.

> On 13 Aug 2020, at 10:19 AM, andrew@daynix.com wrote:
>=20
> From: Andrew <andrew@daynix.com>
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1857668
> Added AER capability for virtio-pci devices.
> Also added property for devices, by default AER is enabled.
>=20
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
> hw/virtio/virtio-pci.c | 16 ++++++++++++++++
> hw/virtio/virtio-pci.h |  4 ++++
> 2 files changed, 20 insertions(+)
>=20
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8e02709605..646dfb8a0d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1806,6 +1806,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>          */
>         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>=20
> +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
> +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
> +                          PCI_ERR_SIZEOF, NULL);
> +            last_pcie_cap_offset +=3D PCI_ERR_SIZEOF;
> +        }
> +
>         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
>             /* Init error enabling flags */
>             pcie_cap_deverr_init(pci_dev);
> @@ -1847,7 +1853,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev,=
 Error **errp)
>=20
> static void virtio_pci_exit(PCIDevice *pci_dev)
> {
> +    VirtIOPCIProxy *proxy =3D VIRTIO_PCI(pci_dev);
> +    bool pcie_port =3D pci_bus_is_express(pci_get_bus(pci_dev)) &&
> +                     !pci_bus_is_root(pci_get_bus(pci_dev));
> +
>     msix_uninit_exclusive_bar(pci_dev);
> +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
> +        pci_is_express(pci_dev)) {
> +        pcie_aer_exit(pci_dev);
> +    }
> }
>=20
> static void virtio_pci_reset(DeviceState *qdev)
> @@ -1900,6 +1914,8 @@ static Property virtio_pci_properties[] =3D {
>                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>     DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_AER_BIT, true),
>     DEFINE_PROP_END_OF_LIST(),
> };
>=20
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index e2eaaa9182..4b2491ff15 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -45,6 +45,7 @@ enum {
>     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>     VIRTIO_PCI_FLAG_INIT_PM_BIT,
>     VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> +    VIRTIO_PCI_FLAG_AER_BIT,
> };
>=20
> /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -84,6 +85,9 @@ enum {
> /* Init Function Level Reset capability */
> #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>=20
> +/* Advanced Error Reporting capability */
> +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
> +
> typedef struct {
>     MSIMessage msg;
>     int virq;
> --=20
> 2.27.0
>=20
>=20


