Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28918C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9117208CE
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 07:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWBsSzCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9117208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWxod-0004kI-3u
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 02:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iWxn7-0003cU-SN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iWxn6-0002HS-Bl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:19:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iWxn6-0002HI-7C
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 02:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574147951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X7cz3Qi3Id+zSGWQGIHK4AUPcwiMoSkm48JlLWWhCH0=;
 b=LWBsSzCgswpn16rUcudMm1stl5VseRoNOXLwj//mLW4GWgB5q/TNhRmXfShGlsdznbba0j
 mLCGMNaF0gqoFLYt0M0yJc/L4qkOMa7MQTmcVx24rnhcA/tb7dukxvjErO3bjGloE7kZkp
 ewRHGcdKveZEdTp5yjrtMY1vNIqSXjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-3y47ZqRdN2qldQggaz2GLQ-1; Tue, 19 Nov 2019 02:19:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B6631005500;
 Tue, 19 Nov 2019 07:19:09 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9CAB10027AF;
 Tue, 19 Nov 2019 07:19:05 +0000 (UTC)
Date: Tue, 19 Nov 2019 08:19:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: lichun <706701795@qq.com>
Subject: Re: [PATCH] i440FX-pcihost: add 'allow-hotplug' property for
 configuring whether to expose the BSEL to the guest.
Message-ID: <20191119081904.2da9cfd4@redhat.com>
In-Reply-To: <1574157080-7724-1-git-send-email-706701795@qq.com>
References: <1574157080-7724-1-git-send-email-706701795@qq.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3y47ZqRdN2qldQggaz2GLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 17:51:20 +0800
lichun <706701795@qq.com> wrote:


...
here should go rationale why it's needed.


> Signed-off-by: lichun <706701795@qq.com>
> ---
>  hw/acpi/pcihp.c              |  2 +-
>  hw/pci-host/i440fx.c         | 11 +++++++++++
>  include/hw/pci-host/i440fx.h |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 8413348..4f5e0d3 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -98,7 +98,7 @@ static void acpi_set_pci_info(void)
>      bsel_is_set =3D true;
> =20
>      bus =3D find_i440fx(); /* TODO: Q35 support */
> -    if (bus) {
> +    if (bus && i440fx_allow_hotplug()) {
>          /* Scan all PCI buses. Set property to enable acpi based hotplug=
. */
>          pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &bsel_all=
oc);
>      }
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index f271311..32bf9bf 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -49,6 +49,7 @@ typedef struct I440FXState {
>      uint64_t pci_hole64_size;
>      bool pci_hole64_fix;
>      uint32_t short_root_bus;
> +    bool allow_hotplug;
>  } I440FXState;
> =20
>  #define I440FX_PCI_DEVICE(obj) \
> @@ -354,6 +355,15 @@ PCIBus *find_i440fx(void)
>      return s ? s->bus : NULL;
>  }
> =20
> +bool i440fx_allow_hotplug(void)
> +{
> +    I440FXState *s;
> +
> +    s =3D I440FX_PCI_HOST_BRIDGE(object_resolve_path("/machine/i440fx", =
NULL));
> +
> +    return s ? s->allow_hotplug : true;
> +}
> +
>  static void i440fx_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -487,6 +497,7 @@ static Property i440fx_props[] =3D {
>                       pci_hole64_size, I440FX_PCI_HOST_HOLE64_SIZE_DEFAUL=
T),
>      DEFINE_PROP_UINT32("short_root_bus", I440FXState, short_root_bus, 0)=
,
>      DEFINE_PROP_BOOL("x-pci-hole64-fix", I440FXState, pci_hole64_fix, tr=
ue),
> +    DEFINE_PROP_BOOL("allow-hotplug", I440FXState, allow_hotplug, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
> index f54e646..4a607e9 100644
> --- a/include/hw/pci-host/i440fx.h
> +++ b/include/hw/pci-host/i440fx.h
> @@ -32,5 +32,6 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,
>                      MemoryRegion *ram_memory);
> =20
>  PCIBus *find_i440fx(void);
> +bool i440fx_allow_hotplug(void);
> =20
>  #endif


