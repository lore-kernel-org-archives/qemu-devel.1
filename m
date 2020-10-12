Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC1EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387CE2076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrDKpOkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387CE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyeX-000477-8U
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 10:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRycr-0002pb-CJ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57050)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kRyco-0004n5-RD
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 10:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602512188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvTUejg+9RAW/6kvjaabG5f3Eg/FgmhKNfxI5UFxa8g=;
 b=CrDKpOkqlZWNObfXAPI43PoP/9Yh0CsfK4hHZxdWuXeioSTWpcBPlZNmI7UgK4PCpGY58k
 CHR88pKLLRbSzSVcWuD8v//0F/KywWJCvOnqu6Tm7rHcP1kG+BUcjubspDJlGTStVSlADr
 DWabUl3qCcOCBTQRHpXs5pDkUPM5auk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-3y8gcP5xPnyQyy5UjJQNLQ-1; Mon, 12 Oct 2020 10:16:24 -0400
X-MC-Unique: 3y8gcP5xPnyQyy5UjJQNLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C25A107464F;
 Mon, 12 Oct 2020 14:16:22 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4A945C225;
 Mon, 12 Oct 2020 14:16:07 +0000 (UTC)
Subject: Re: [PATCH 10/10] hw/isa: Add the ISA_IRQ_IDE_DEFAULT definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201011193229.3210774-1-f4bug@amsat.org>
 <20201011193229.3210774-11-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <705cd855-feeb-053f-86b3-981d98460229@redhat.com>
Date: Mon, 12 Oct 2020 10:16:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201011193229.3210774-11-f4bug@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Corey Minyard <minyard@acm.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 3:32 PM, Philippe Mathieu-Daudé wrote:
> The IDE controller uses IRQ #14 by default. Add this
> default definition to the IsaIrqNumber enum.
> 
> Avoid magic values in the code, replace them by the
> newly introduced definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/isa/isa.h | 1 +
>   hw/ide/isa.c         | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
> index 43cdc3c47b6..05622ee11e2 100644
> --- a/include/hw/isa/isa.h
> +++ b/include/hw/isa/isa.h
> @@ -17,6 +17,7 @@ enum IsaIrqNumber {
>       ISA_IRQ_RTC_DEFAULT =  8,
>       ISA_IRQ_NET_DEFAULT =  9,
>       ISA_IRQ_MOU_DEFAULT = 12,
> +    ISA_IRQ_IDE_DEFAULT = 14,
>       ISA_NUM_IRQS        = 16
>   };
>   
> diff --git a/hw/ide/isa.c b/hw/ide/isa.c
> index 6bc19de2265..2412d568937 100644
> --- a/hw/ide/isa.c
> +++ b/hw/ide/isa.c
> @@ -108,7 +108,7 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
>   static Property isa_ide_properties[] = {
>       DEFINE_PROP_UINT32("iobase",  ISAIDEState, iobase,  0x1f0),
>       DEFINE_PROP_UINT32("iobase2", ISAIDEState, iobase2, 0x3f6),
> -    DEFINE_PROP_UINT32("irq",    ISAIDEState, isairq,  14),
> +    DEFINE_PROP_UINT32("irq", ISAIDEState, isairq, ISA_IRQ_IDE_DEFAULT),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 

Acked-by: John Snow <jsnow@redhat.com>


