Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A93C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED75206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 07:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxU5fsw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED75206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWEVk-00034g-Co
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 03:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWETk-0000WJ-A5
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:28:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jWETj-0000dz-DO
 for qemu-devel@nongnu.org; Wed, 06 May 2020 03:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588750106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZijX+2RRhY35gsAavv5x8qvB+3nIQZWn57R4AyOkSM=;
 b=VxU5fsw7F9wINlpE05UMgqrUsiPsEeE6IzoLIPGy7XskNHif6vTL4y6jzlsonrkQU7xZNh
 MiItmNwq5e1Hj3qsH7RBUPbAs9zH2YzTy/oRpEpfagzAYpxe9xjT3A96rOOyCC39dM8uIZ
 tVap4Pzwa1Lke7eqfedW+nXExBzwgYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-RJwQQhF7N3OILZew6U6thg-1; Wed, 06 May 2020 03:28:24 -0400
X-MC-Unique: RJwQQhF7N3OILZew6U6thg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33E89107B265;
 Wed,  6 May 2020 07:28:23 +0000 (UTC)
Received: from localhost (ovpn-113-195.rdu2.redhat.com [10.10.113.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2B606061C;
 Wed,  6 May 2020 07:28:17 +0000 (UTC)
Date: Wed, 6 May 2020 09:28:16 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 12/13] microvm: make virtio irq base runtime
 configurable
Message-ID: <20200506072816.cyfnwzsta6idyzzj@dritchie>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-13-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-13-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qimkkgcyabbtfu32"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 02:39:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qimkkgcyabbtfu32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 03:43:04PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/i386/microvm.h |  2 +-
>  hw/i386/acpi-microvm.c    |  6 +++---
>  hw/i386/microvm.c         | 11 +++++++----
>  3 files changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index 55f5984cfaa1..878d2a8011f4 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -28,7 +28,6 @@
> =20
>  /* Platform virtio definitions */
>  #define VIRTIO_MMIO_BASE      0xc0000000
> -#define VIRTIO_IRQ_BASE       5
>  #define VIRTIO_NUM_TRANSPORTS 8
>  #define VIRTIO_CMDLINE_MAXLEN 64
> =20
> @@ -63,6 +62,7 @@ typedef struct {
>      bool auto_kernel_cmdline;
> =20
>      /* Machine state */
> +    uint32_t virtio_irq_base;
>      bool kernel_cmdline_fixed;
>      Notifier machine_done;
>      AcpiDeviceIf *acpi_dev;
> diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
> index 4d91ac9360ce..1230080c45cd 100644
> --- a/hw/i386/acpi-microvm.c
> +++ b/hw/i386/acpi-microvm.c
> @@ -47,7 +47,7 @@ static void acpi_dsdt_add_power_button(Aml *scope)
>      aml_append(scope, dev);
>  }
> =20
> -static void acpi_dsdt_add_virtio(Aml *scope)
> +static void acpi_dsdt_add_virtio(Aml *scope, MicrovmMachineState *mms)
>  {
>      gchar *separator;
>      long int index;
> @@ -75,7 +75,7 @@ static void acpi_dsdt_add_virtio(Aml *scope)
>                  continue;
>              }
> =20
> -            uint32_t irq =3D VIRTIO_IRQ_BASE + index;
> +            uint32_t irq =3D mms->virtio_irq_base + index;
>              hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
>              hwaddr size =3D 512;
> =20
> @@ -119,7 +119,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *li=
nker,
>      build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
>                    GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
>      acpi_dsdt_add_power_button(sb_scope);
> -    acpi_dsdt_add_virtio(sb_scope);
> +    acpi_dsdt_add_virtio(sb_scope, mms);
>      aml_append(dsdt, sb_scope);
> =20
>      scope =3D aml_scope("\\");
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index a3708fdf1e39..2aa2804e4ca0 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -124,10 +124,11 @@ static void microvm_devices_init(MicrovmMachineStat=
e *mms)
> =20
>      kvmclock_create();
> =20
> +    mms->virtio_irq_base =3D 8;
>      for (i =3D 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
>                               VIRTIO_MMIO_BASE + i * 512,
> -                             x86ms->gsi[VIRTIO_IRQ_BASE + i]);
> +                             x86ms->gsi[mms->virtio_irq_base + i]);
>      }
> =20
>      /* Optional and legacy devices */
> @@ -274,7 +275,7 @@ static void microvm_memory_init(MicrovmMachineState *=
mms)
>      x86ms->ioapic_as =3D &address_space_memory;
>  }
> =20
> -static gchar *microvm_get_mmio_cmdline(gchar *name)
> +static gchar *microvm_get_mmio_cmdline(gchar *name, uint32_t virtio_irq_=
base)
>  {
>      gchar *cmdline;
>      gchar *separator;
> @@ -294,7 +295,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
>      ret =3D g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
>                       " virtio_mmio.device=3D512@0x%lx:%ld",
>                       VIRTIO_MMIO_BASE + index * 512,
> -                     VIRTIO_IRQ_BASE + index);
> +                     virtio_irq_base + index);
>      if (ret < 0 || ret >=3D VIRTIO_CMDLINE_MAXLEN) {
>          g_free(cmdline);
>          return NULL;
> @@ -306,6 +307,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
>  static void microvm_fix_kernel_cmdline(MachineState *machine)
>  {
>      X86MachineState *x86ms =3D X86_MACHINE(machine);
> +    MicrovmMachineState *mms =3D MICROVM_MACHINE(machine);
>      BusState *bus;
>      BusChild *kid;
>      char *cmdline;
> @@ -329,7 +331,8 @@ static void microvm_fix_kernel_cmdline(MachineState *=
machine)
>              BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
> =20
>              if (!QTAILQ_EMPTY(&mmio_bus->children)) {
> -                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline(mmio_bu=
s->name);
> +                gchar *mmio_cmdline =3D microvm_get_mmio_cmdline
> +                    (mmio_bus->name, mms->virtio_irq_base);
>                  if (mmio_cmdline) {
>                      char *newcmd =3D g_strjoin(NULL, cmdline, mmio_cmdli=
ne, NULL);
>                      g_free(mmio_cmdline);
> --=20
> 2.18.4
>=20

--qimkkgcyabbtfu32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl6yZw8ACgkQ9GknjS8M
AjWlbRAAjdwb80ih3rlE4W2HfbrYIRnIWqGdltgzQw7+3WC7+dzo+HVOKn0PQroP
/ZfXlimbMB4T1Sp4+tXYNSlZkjSP5Qgq0IUoY2dOu7YEQ6NeFNVaLJr6/ssb5kWf
OAcuG/6QplcWVWiqeENLa4CZ3ilZuLMBr0Wo9oYYs+phpUdTmsqQA4SPvSucsvyh
l8vHeZU3AMitoia7avwBEO8rZ2Zt6sqXzR8ErDkQl3bv8ZUrY0987het1zGaJ4F2
d+g9d1/eeR5mwJnNu5w4RDuuyotVQ1jUjMFwsqz+XEVNJxtExZgpJI0LtWmqqnJS
aZ/qL6yMvmIwpaLylDY0PLHI4XPlxS5C2vy1HwCbm58KtwjxU9kiOry8vsANebHg
mpqug09/B2l8XqFDQodDJrBELWOfrKJEBtdNmdOI5PdptWVKp+L8NChDwr5wjZW7
xKa9yAdMZTxSq8malrwxuwa+eqGuc5AkoifsUwvb4ZyDWhjzo4grbqo6oZLR0PVF
N3g6E+4dNQQ0giyc2IInapsX1PTlMSmz9lBnDDdIMwVZPbmbMtUcfYT77unWCqlf
iwEjMpfk57chpuTWe1MMwdResIVamOE9eXprHGiqo+d96Y6M0WD5VPD2rNHql8dY
6TezzOm1Ng+cC+JR2x2AsZKc+GaKhQCITK/bUmMEle8W2kULVW4=
=ec/t
-----END PGP SIGNATURE-----

--qimkkgcyabbtfu32--


