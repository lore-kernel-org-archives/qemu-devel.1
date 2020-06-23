Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E91320776
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 13:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OllQbGUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E91320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jniaw-000252-M4
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 09:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jniaA-0001Em-Tc
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:03:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnia8-0003Pe-79
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 09:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592917398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhooRDZRoeoCB8hD8sojsZV4rMxRQ+mOUNx4EzvRRjg=;
 b=OllQbGUNzjlGRh57Fky2M53/0iozxCMcvgVVsm7f3mnQ6RaDmMwqO+GO/rASlhJQ5yKarf
 lRkilsyHhsJW5tSV/QoxS24x7RydpbEoyFMYU+/ip3pKoZzjDK+dZxCpL0svosqA/UUPtp
 qY5umZd0/wAkH2jFOCl0hDIpmEv5/hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-FhgTfHbjOQ-i6PwdoNntRQ-1; Tue, 23 Jun 2020 09:02:12 -0400
X-MC-Unique: FhgTfHbjOQ-i6PwdoNntRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EFC08031C2;
 Tue, 23 Jun 2020 13:02:11 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 161215C1D4;
 Tue, 23 Jun 2020 13:01:57 +0000 (UTC)
Date: Tue, 23 Jun 2020 15:01:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 5/8] acpi: Enable TPM IRQ
Message-ID: <20200623150156.2e350e18@redhat.com>
In-Reply-To: <20200617142305.1198672-6-stefanb@linux.vnet.ibm.com>
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-6-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com, mkedzier@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 10:23:02 -0400
Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:

> From: Stefan Berger <stefanb@linux.ibm.com>
>=20
> Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
> Windows. Query for the TPM's irq number and enable the TPM IRQ unless
> TPM_IRQ_DISABLED is returned.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Message-id: 20200616205721.1191408-6-stefanb@linux.vnet.ibm.com
> CC: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c  | 11 +++++------
>  include/hw/acpi/tpm.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08..bb9a7f8497 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
> =20
>              if (TPM_IS_TIS_ISA(tpm)) {
> +                int8_t irq =3D tpm_get_irqnum(tpm);
>                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>                      dev =3D aml_device("TPM");
>                      aml_append(dev, aml_name_decl("_HID",
> @@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
>                  crs =3D aml_resource_template();
>                  aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                             TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> -                /*
> -                    FIXME: TPM_TIS_IRQ=3D5 conflicts with PNP0C0F irqs,
> -                    Rewrite to take IRQ from TPM device model and
> -                    fix default IRQ value there to use some unused IRQ
> -                 */
> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +
> +                if (irq !=3D TPM_IRQ_DISABLED) {
> +                    aml_append(crs, aml_irq_no_flags(irq));
> +                }
>                  aml_append(dev, aml_name_decl("_CRS", crs));
> =20
>                  tpm_build_ppi_acpi(tpm, dev);
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d5caee9771..d356f2e06e 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -24,7 +24,7 @@
>  #define TPM_TIS_ADDR_BASE           0xFED40000
>  #define TPM_TIS_ADDR_SIZE           0x5000
> =20
> -#define TPM_TIS_ISA_IRQ             5
> +#define TPM_TIS_ISA_IRQ             13    /* only one possible */
>  #define TPM_TIS_SYSBUS_IRQ          5
> =20
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */


