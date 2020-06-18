Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5051FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B2AB21548
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 07:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNoeFJsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2AB21548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jloi6-0006xh-Bj
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 03:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jlohB-00066f-Ba
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:10:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jloh9-0004GZ-L8
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 03:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592464243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiKE0ilEZSbeqVaWqbO5PW8F41W/fxpV1Bitxd7zY2E=;
 b=SNoeFJsbbK4296mqKT44MydfppwZMtIXs4dqF6yf/QFPXmrwNCVaoJ7A0o2+M3vRng7I6l
 c1DVvnmTt86zOb3OQUe6dJQqf+uzqgl6+yOCmvYtLuRHNqBG+ChR1mdew0yIsKIlAExdxk
 yfCUe4kSc5B0RelGuwzijjRZA3qpqes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-q0_VtqfFMkO98e-UZHvkHA-1; Thu, 18 Jun 2020 03:10:40 -0400
X-MC-Unique: q0_VtqfFMkO98e-UZHvkHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4855107ACCD;
 Thu, 18 Jun 2020 07:10:39 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 559EA6E9F3;
 Thu, 18 Jun 2020 07:10:35 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] tpm: Extend TPMIfClass with get_irqnum() function
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20200617142305.1198672-1-stefanb@linux.vnet.ibm.com>
 <20200617142305.1198672-3-stefanb@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <235fd158-16b6-e864-0b66-225ab9e12a54@redhat.com>
Date: Thu, 18 Jun 2020 09:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200617142305.1198672-3-stefanb@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
 philmd@redhat.com, mkedzier@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/17/20 4:22 PM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
> 
> Implement get_irqnum() as part of the TPMIfClass to get the assigned IRQ
> number or TPM_IRQ_DISABLED (~0) in case IRQs cannot be used.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-id: 20200616205721.1191408-3-stefanb@linux.vnet.ibm.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


> ---
>  hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>  hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>  include/sysemu/tpm.h    | 12 ++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 30ba37079d..ed6d422f05 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>  
> +static int8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
> +    TPMState *s = &isadev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_isa_reset(DeviceState *dev)
>  {
>      TPMStateISA *isadev = TPM_TIS_ISA(dev);
> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_isa_reset;
>      tc->request_completed = tpm_tis_isa_request_completed;
>      tc->get_version = tpm_tis_isa_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_isa_get_irqnum;
>  }
>  
>  static const TypeInfo tpm_tis_isa_info = {
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index eced1fc843..86b3988be5 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>      return tpm_tis_get_tpm_version(s);
>  }
>  
> +static int8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
> +{
> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
> +    TPMState *s = &sbdev->state;
> +
> +    return s->irq_num;
> +}
> +
>  static void tpm_tis_sysbus_reset(DeviceState *dev)
>  {
>      TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>      dc->reset = tpm_tis_sysbus_reset;
>      tc->request_completed = tpm_tis_sysbus_request_completed;
>      tc->get_version = tpm_tis_sysbus_get_tpm_version;
> +    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
>  }
>  
>  static const TypeInfo tpm_tis_sysbus_info = {
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 03fb25941c..7ebe9f7ef0 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -25,6 +25,8 @@ typedef enum TPMVersion {
>      TPM_VERSION_2_0 = 2,
>  } TPMVersion;
>  
> +#define TPM_IRQ_DISABLED  ~0
> +
>  #define TYPE_TPM_IF "tpm-if"
>  #define TPM_IF_CLASS(klass)                                 \
>      OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
> @@ -41,6 +43,7 @@ typedef struct TPMIfClass {
>      enum TpmModel model;
>      void (*request_completed)(TPMIf *obj, int ret);
>      enum TPMVersion (*get_version)(TPMIf *obj);
> +    int8_t (*get_irqnum)(TPMIf *obj);
>  } TPMIfClass;
>  
>  #define TYPE_TPM_TIS_ISA            "tpm-tis"
> @@ -74,4 +77,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>      return TPM_IF_GET_CLASS(ti)->get_version(ti);
>  }
>  
> +static inline int8_t tpm_get_irqnum(TPMIf *ti)
> +{
> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
> +        return TPM_IRQ_DISABLED;
> +    }
> +
> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
> +}
> +
>  #endif /* QEMU_TPM_H */
> 


