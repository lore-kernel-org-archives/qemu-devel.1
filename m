Return-Path: <SRS0=kzat=2W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF92C2D0DC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 15:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF452072C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jan 2020 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hFdmtxZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF452072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1img5k-0006Ap-FP
	for qemu-devel@archiver.kernel.org; Wed, 01 Jan 2020 10:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1img56-0005kJ-Qa
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1img55-00061R-NX
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:38:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1img55-00060S-JD
 for qemu-devel@nongnu.org; Wed, 01 Jan 2020 10:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577893123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WwAL+bDZctfWAe7b+yuTRpzau5C5PrjwC5uXwQlg3Fk=;
 b=hFdmtxZ3vJjwOWg1V7yxZiFWedAwist80YDIf0qbomavS+sRVD125TPlg+g95T+/h4Vsbj
 VEfNSLln7MB/5NBfWLBcjLD5Wvkz/I8EB3wTO57H9+nb68/YEMwR65x0sSz5moVbYwiEKp
 T0hdyQX3EdCQyUBPV7+EHkvhrED4A3M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-zE_IDWK0Md-AmHWpAh3-7w-1; Wed, 01 Jan 2020 10:38:42 -0500
Received: by mail-wm1-f70.google.com with SMTP id t4so424525wmf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jan 2020 07:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u4HAX1gX8l4PUfsHDBmpqYR5eMRseEXfpvBMjnzD4WM=;
 b=RkwtvbzTE6ogldUsWMwFEhlxqpk/49H24pR1lb6Ser/B1EysYbiJaktFEz9Zs7ZAWk
 Z0lh6eQHpMLfWWFiMb//xW5K9BmmMIyQ0/sFYRoDu938/67EnINrRUQYGJaZT2kGgjxf
 FgNc9ol/F1zL6kuBsfJ6e7GjwplHFaTPQgLhwRfL36Itwa62XnacrupOyNE6y72zcT4R
 DqYYQzC3FQr+kGMbFYxQVdEeoEBzpg/Rogw2PfKn31v/lVY9Ek+eLM9aoVzh1OZEioiL
 eIHt6RzIMiL+8WaScEDyvCgxA0Edu+6Nb4JxBV8SnkwydWviC7ugKJRqXl9jrfTlsVzr
 ZP5A==
X-Gm-Message-State: APjAAAVGgH1dqi7R8SSEk6lcTw9+PkJDOP+RIhG+0p5OBVqtbEVbzd+l
 AhDdjz+uvggKl6DrPtet7ul3voax6InOEzBypOgpx8igWtmZDRioVFYtkg5pWDMSJgJc82FegGu
 EF+KoZMToWJqN//Q=
X-Received: by 2002:a1c:6588:: with SMTP id z130mr10066689wmb.0.1577893120789; 
 Wed, 01 Jan 2020 07:38:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2xRGdXUNrH9tCowVliRx+cPkluT1kG6tFotoUnlAlcQNIb9+QypGg+Vv0H9P8qWchAbFJRw==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr10066671wmb.0.1577893120514; 
 Wed, 01 Jan 2020 07:38:40 -0800 (PST)
Received: from [10.30.42.123] ([62.102.229.57])
 by smtp.gmail.com with ESMTPSA id s19sm5737982wmj.33.2020.01.01.07.38.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jan 2020 07:38:39 -0800 (PST)
Subject: Re: [PATCH 66/86] ppc:ppc440_bamboo/sam460ex: drop RAM size fixup
To: BALATON Zoltan <balaton@eik.bme.hu>, Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-67-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d440542-7a32-4e1d-6635-201d4535f91a@redhat.com>
Date: Wed, 1 Jan 2020 16:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.99999.352.2001011235410.5612@zero.eik.bme.hu>
Content-Language: en-US
X-MC-Unique: zE_IDWK0Md-AmHWpAh3-7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/1/20 12:54 PM, BALATON Zoltan wrote:
> On Tue, 31 Dec 2019, Igor Mammedov wrote:
>> If user provided non-sense RAM size, board will complain and
>> continue running with max RAM size supported.
>> Also RAM is going to be allocated by generic code, so it won't be
>> possible for board to fix things up for user.
>>
>> Make it error message and exit to force user fix CLI,
>> instead of accepting non-sense CLI values.
>>
>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> ---
>> include/hw/ppc/ppc4xx.h |=A0 9 ++++-----
>> hw/ppc/ppc440_bamboo.c=A0 | 11 ++++-------
>> hw/ppc/ppc4xx_devs.c=A0=A0=A0 | 26 ++++++++++++++++----------
>> hw/ppc/sam460ex.c=A0=A0=A0=A0=A0=A0 |=A0 5 ++---
>> 4 files changed, 26 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
>> index 7d82259..1a28127 100644
>> --- a/include/hw/ppc/ppc4xx.h
>> +++ b/include/hw/ppc/ppc4xx.h
>> @@ -42,11 +42,10 @@ enum {
>> qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint3=
2_t dcr_base, int has_ssr, int has_vr);
>>
>> -ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 MemoryRegion ram_memories[],
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 hwaddr ram_bases[],
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 hwaddr ram_sizes[],
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 const ram_addr_t sdram_bank_sizes[]);
>> +void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 MemoryRegion ram_memories[],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 hwaddr ram_bases[], hwaddr ram_sizes[],
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 const ram_addr_t sdram_bank_sizes[]);
>=20
> With this change this function does not adjust ram size any more so it=20
> may need to be renamed, e.g. ppc4xx_sdram_banks or something else.
>=20
> A better patch title may be
>=20
> ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup

Or split in 2 patches.


