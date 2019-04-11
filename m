Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C5C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 22:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128652146F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 22:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhNSjMxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128652146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEi0f-0004w1-V7
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 18:17:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhz3-0003bd-VC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hEhz0-0001Aa-NX
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:49 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hEhyx-00011v-DL
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 18:15:45 -0400
Received: by mail-ed1-x541.google.com with SMTP id w3so6595518edu.10
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 15:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=oy3WlVFoNBuFHKTQXULKz2rLZBfIRunXzYqzcqFX+Hk=;
	b=NhNSjMxEiVpGoq2z9B0XLgqE2WLx+sJ+RpoCJy2ea4bLNnwvHhHknxiNXnbrxO+GSr
	2rUs9KvxXraD5TZF88laFIG/6vpTz+PPPvsQnUJdeWHRiqasn6NdqG5AHdJrU6Vp6oCi
	Q5AdXx3JpIo6iTxsm3SVSFEc2iB68jkEUCLq/uSgHZHC37Ql14snZQUh0c3EgGRRHZhZ
	ChORhgVHyAfPztJvurdblckhlyfn29/oUHjjGdlYQ6MYt/V/LwNT7zKWvBxJ4ZxLNhci
	8n1uXS6DJeGENkd6pnRIgpWxXNtlme11Ohb7UgSj/skaUGdbpSZtqoTg2Ai/+X6exeey
	U10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=oy3WlVFoNBuFHKTQXULKz2rLZBfIRunXzYqzcqFX+Hk=;
	b=Q3AE2k9YR8mjrdGcAkQeiDU87H2M0MjGNdLpvdmOjPbbW4oh+BAmsOh2RCDq4mK7da
	NStV6iZ7xeAHzoh8ErdxotbDH6GsezGYN+Iqi8gwojPzlvb4sq2hT2DlSA4NEpW+ZUrv
	ghrmEG/pCoRRRUMdYnc1A9GCrgHlLO5iAZ5Hu9EGnlLzODaJaO5o+EaTzeWv5iZ0z+sy
	9vdTTAhZ1CGA/yXO70eGD9iFz6oSrFCifX7b/1X9qb7k0xN1fNcoh9REExnac8ypgqQ4
	fR/ntXyInCMwvLxn4enAmoQjO5OIVCOCiJRUjLuI+qPMtYXZB38IiKabuC+RBiYUY5p3
	CEOw==
X-Gm-Message-State: APjAAAW10A4uodCRYPKmO06ZQWSDTyvsK+15h+A4d273ibow5S9pJYfE
	/tW16BjJT4YfQ56M79pSVKI=
X-Google-Smtp-Source: APXvYqzMreqKDhfMlTmMpgpF1ZQusFI+UIH36yL8jYIDtreMuBLhcmUPqHt2Mvzm1ObCCZR4rWq/fw==
X-Received: by 2002:a50:a704:: with SMTP id h4mr31982154edc.7.1555020936405;
	Thu, 11 Apr 2019 15:15:36 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	w25sm11078315eds.39.2019.04.11.15.15.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 11 Apr 2019 15:15:35 -0700 (PDT)
Date: Thu, 11 Apr 2019 22:15:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190411221535.6oirewsnbmnhp2sk@master>
References: <1554822037-329838-1-git-send-email-imammedo@redhat.com>
	<20190410142756.GA3136@richard>
	<20190410170150.1c447b12@redhat.com>
	<20190411013211.GA8515@richard>
	<20190411134627.15d7c340@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411134627.15d7c340@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH for-4.1] q35: acpi: do not create dummy
 MCFG table
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411221535.eQ7jJnnbDyfIf3LahCXi1VyH6kQoRmfymz-yhvvfTjM@z>

On Thu, Apr 11, 2019 at 01:46:27PM +0200, Igor Mammedov wrote:
>On Thu, 11 Apr 2019 09:32:11 +0800
>Wei Yang <richardw.yang@linux.intel.com> wrote:
>

[...]

>> To be honest, this is what I feel confused in your previous reply.
>> 
>> First I want to confirm both fields in RAMBlock affects the migration:
>> 
>> * used_length
>> * max_length
>> 
>> Both of them should be the same on both source/destination, otherwise the
>> migration would fail.
>well, it works fine for me.
>Where do you see max_length being used during migration?
>

I asked my colleague, but seems you are right.

>
>> Then I thought the migration would be broken if source/destination has
>> different knowledge about acpi table size. Because this will introduce
>> different value of used_length, even we have resizable MemoryRegion.
>> 
>> The 1st time ACPI generation flow:
>> 
>>     acpi_add_rom_blob
>>         rom_add_blob
>>             rom_set_mr
>>                 memory_region_init_resizable_ram
>>                     qemu_ram_alloc_resizable
>>     		        new_block->used_length = size
>>     		        new_block->max_length = max_size
>> 
>> The 2nd time ACPI generation flow:
>> 
>>     acpi_ram_update
>>         memory_regioin_ram_resize
>>             qemu_ram_resize
>>                 block->used_length = new_size
>> 
>> The max_length is always the same, while used_length would be changed to the
>> actual table_blob size.
>> 
>> In case source/destination has different knowledge about acpi table size, the
>> table_blob size(even after aligned) could be different.
>> 
>> This is why I thought there is still some chance to break migration after
>> resizable MemoryRegion.
>> 
>> Do I miss something?
>yes, you did, max_length does not influence migration stream.
>see what above mentioned commits and ram_load() -> "if (length != block->used_length)" do.
>

I see this in the code.

So the destination will check length and adjust self's length if it
doesn't equal to the source.

Thanks :-)

-- 
Wei Yang
Help you, Help me

