Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B11C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2664E2100A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 08:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPpVRp+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2664E2100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlTMT-0003oj-FB
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 04:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlTLq-0003Ou-UN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:23:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlTLp-0003nC-3S
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 04:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592382195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8xdagu1/UL8yK8g7bQRQnTe6fBPYWcyqblCVSft+rdo=;
 b=aPpVRp+aF0UUzrEUglT+7aLhTGl6ZfefW81Qd/qc/2kMUuqf249heBet0y0g8MtjeDSz1y
 /OGmvvuEKQAsxsDPpeyrpPE60EgY0QiIMAGnY9RH3n/hPeDKZyRvfIKiqwycyw07e2DgGd
 qlZvTfbGOJyWGMqzd3NoHgDYwDmZrGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-myfGk-21O3KEUKFinNZ5Vg-1; Wed, 17 Jun 2020 04:23:13 -0400
X-MC-Unique: myfGk-21O3KEUKFinNZ5Vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 661BE1883625;
 Wed, 17 Jun 2020 08:23:12 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC3160BE2;
 Wed, 17 Jun 2020 08:22:56 +0000 (UTC)
Subject: Re: [PATCH v3 5/8] acpi: Enable TPM IRQ
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200616205721.1191408-1-stefanb@linux.vnet.ibm.com>
 <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6b3b7b49-02e6-9d2d-91ad-65a5ea6d2244@redhat.com>
Date: Wed, 17 Jun 2020 10:22:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200616205721.1191408-6-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@redhat.com, mkedzier@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/16/20 10:57 PM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Move the TPM TIS IRQ to unused IRQ 13, which is the only one accepted by
> Windows. Query for the TPM's irq number and enable the TPM IRQ unless
> TPM_IRQ_DISABLED is returned.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/acpi-build.c  | 11 +++++------
>  include/hw/acpi/tpm.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08..bb9a7f8497 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2021,6 +2021,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>              build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>  
>              if (TPM_IS_TIS_ISA(tpm)) {
> +                int8_t irq = tpm_get_irqnum(tpm);
>                  if (misc->tpm_version == TPM_VERSION_2_0) {
>                      dev = aml_device("TPM");
>                      aml_append(dev, aml_name_decl("_HID",
> @@ -2035,12 +2036,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  crs = aml_resource_template();
>                  aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                             TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
> -                /*
> -                    FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
> -                    Rewrite to take IRQ from TPM device model and
> -                    fix default IRQ value there to use some unused IRQ
> -                 */
> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
> +
> +                if (irq != TPM_IRQ_DISABLED) {
Out of curiosity what is the goal to expose the irq num as a property
settable by the end-user if only 13 is known to work in all cases. At
least shouldn't we warn the end-user in case he attempts to change the
default value?

Thanks

Eric
> +                    aml_append(crs, aml_irq_no_flags(irq));
> +                }
>                  aml_append(dev, aml_name_decl("_CRS", crs));
>  
>                  tpm_build_ppi_acpi(tpm, dev);
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index d5caee9771..d356f2e06e 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -24,7 +24,7 @@
>  #define TPM_TIS_ADDR_BASE           0xFED40000
>  #define TPM_TIS_ADDR_SIZE           0x5000
>  
> -#define TPM_TIS_ISA_IRQ             5
> +#define TPM_TIS_ISA_IRQ             13    /* only one possible */
>  #define TPM_TIS_SYSBUS_IRQ          5
>  
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
> 


