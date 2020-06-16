Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D993C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC85B206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUJiZj1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC85B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6I5-00015f-1E
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jl6Gm-00009b-NW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:44:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52248
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jl6Gk-0006PC-Qa
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 03:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592293470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgfriCMWxKXhN41w6ynhCdCAP1e1TPfFRfFFftS5wWg=;
 b=dUJiZj1wpJsZNzimx9RJZUK8EYQRshtzC+sFksIqlMSbSIpsXXVYJmx8sWFTva/olZHufo
 ToiWSjZqq3Qq4kcXT9hp3gmGgc5gUA/qu5ebvOusNVPAqFgnNPew/lc3rG8FWyT0RHXAqK
 CEEILCeyOwBbgb7GbMuuH6HwfJ+g5Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-8pe5ztFHMr2ZSdEAKY3NEg-1; Tue, 16 Jun 2020 03:44:26 -0400
X-MC-Unique: 8pe5ztFHMr2ZSdEAKY3NEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E12F10506E2;
 Tue, 16 Jun 2020 07:44:25 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 895BC100164C;
 Tue, 16 Jun 2020 07:44:17 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] acpi: Enable TPM IRQ
To: Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-5-stefanb@linux.vnet.ibm.com>
 <CAMxuvaxm+5Nuv2_1UTXY+-kK1CYMkxqU2pfLOxMgeDEqOjhgZA@mail.gmail.com>
 <8e11e2d6-5e02-89c0-759f-d74189421eec@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1fb3b0bc-5654-9b18-6f58-6e32fd786035@redhat.com>
Date: Tue, 16 Jun 2020 09:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8e11e2d6-5e02-89c0-759f-d74189421eec@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Bonzini,
 Paolo" <pbonzini@redhat.com>, Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/15/20 7:11 PM, Stefan Berger wrote:
> On 6/15/20 11:13 AM, Marc-André Lureau wrote:
>>
>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>> index 1a2a57a21f..063a9eb42a 100644
>>> --- a/include/hw/acpi/tpm.h
>>> +++ b/include/hw/acpi/tpm.h
>>> @@ -24,7 +24,7 @@
>>>   #define TPM_TIS_ADDR_BASE           0xFED40000
>>>   #define TPM_TIS_ADDR_SIZE           0x5000
>>>
>>> -#define TPM_TIS_IRQ                 5
>>> +#define TPM_TIS_IRQ                 13
> 
> 
> Eric,
> 
>  does this change have any negative side effects on ARM? If you prefer,
> we can split this part here up into TPM_TIS_ISA_IRQ and TPM_TIS_SYSBUS
> IRQ and leave the latter at '5' because we know that this is working.

I just gave it a try and it does not seem to introduce any regression
with automatic LUKS decryption. I will take more time to review the code
though.

Thanks

Eric

> 
>    Stefan
> 
> 
>>>
>>>   #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>>>   #define TPM_TIS_LOCALITY_SHIFT      12
>>> -- 
>>> 2.24.1
>>>
> 
> 


