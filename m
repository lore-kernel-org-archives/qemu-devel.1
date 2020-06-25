Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79DD2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppi6CYKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79DD2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joHYW-0008KP-SI
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 22:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joHXq-0007uD-Cc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:23:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1joHXo-0002iA-RM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:23:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so4040794wme.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 19:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ULTg9UyWOXgF9C/tXxMXVqM1cSKZ/nseYlm/7h6hF6A=;
 b=ppi6CYKAYxRJCN2JJeZMbNKGQEOP6gTCYhSRJhf9JHwFIurtI2iD4qMV84hjaEH22+
 vTcM52wB2Ax0Qgdst1AHVxSJVXB3qtbC/km3pQeanor7HBtTYOBRiDmDTE8mkwB4kVDB
 z5204WOYZIzHI+anVOB7iGytUDK1G+nItYLfDz9Cg5KadkYFq7PS1MCVjCRSAsFtt7hq
 8NW6f8dy8sjLaUPA6HJldpeXFn55XDyGFLTY3MFxvrtsn1a3+lqvkiOO2CEp9s4p457Z
 cCZtzKAiwCsiGEpIZuZKVLfSQkFVssrksPM49Mcf4dIobJtsl8i5zV6nf/t6m9oI4QnW
 Kbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ULTg9UyWOXgF9C/tXxMXVqM1cSKZ/nseYlm/7h6hF6A=;
 b=omRLMuizFFb0uluJ4NXc2tx1s1p17l640iZxsZ0EoZucIQr8DMRwedIfKEQe2TYxvF
 jkY+Oumgm45KPQPbV+dZ0mOctwoTItl1X5bYCbzued8+KmVZQ5F5nB1ZvocDrBrDrgX7
 8HcNip7/sUgnjvW2u23m3jwFfU6c5pOkv/Rw9U2JSP1SjjIezxIRyLS//lFgjHxZMLlF
 bTSe/oHa3bJiURIEE4bX//rtPcnlK94Zv6VVhPjNu5nVSQZ6b/UVYGEr0UDs9Hku+vYD
 oYBkY7o7EwjQpaZodt+m3pMAUReU6SGt3GjRgfvOeeIFcYTut6XjIH4xo1HtIu36HzlR
 mwOw==
X-Gm-Message-State: AOAM530wepE0asYVlpeqVoCMLJkaXWyTJw8ALaa6DEyCJm2xFFa6ik/n
 Y82366RM1gQA3bg6SnUUSR4=
X-Google-Smtp-Source: ABdhPJz0pSv8/3GFp5/bXx2Hlx9c4sXP+Zal9B84wbBWmI0QJvjb87myCHHymtKcK4qYt6619j8Q8g==
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr756553wmf.162.1593051794768; 
 Wed, 24 Jun 2020 19:23:14 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-155-64.inter.net.il. [84.229.155.64])
 by smtp.gmail.com with ESMTPSA id z16sm19719024wrr.35.2020.06.24.19.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 19:23:13 -0700 (PDT)
Date: Thu, 25 Jun 2020 05:23:12 +0300
From: Jon Doron <arilou@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v3 2/3] i386: acpi: vmbus: Add _ADR definition
Message-ID: <20200625022312.GA5487@jondnuc>
References: <20200618030027.759594-1-arilou@gmail.com>
 <20200618030027.759594-3-arilou@gmail.com>
 <20200623170605.08e46f87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200623170605.08e46f87@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, vkuznets@redhat.com,
 mail@maciej.szmigiero.name, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/2020, Igor Mammedov wrote:
>On Thu, 18 Jun 2020 06:00:26 +0300
>Jon Doron <arilou@gmail.com> wrote:
>
>> It seems like latest HyperV sets _ADR to 0 in the ACPI for the VMBS
>
>that's a hardly a good reason to add this.
>To me looks like a pointless addition,
>_ADR mostly is used when device resides on a bus with standard ennumeration
>algorithm (i.e. PCI, ...).
>
>Value is also wrong  for the bus it's placed currently,
>and with the next patch it won't make a sense altogether.
>
>Pls, drop this patch unless Windows refuses to work without it.
>

Windows seems to handle fine without this.

>>
>> Signed-off-by: Jon Doron <arilou@gmail.com>
>> ---
>>  hw/i386/acpi-build.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 91af0d2d0d..6d9df38e31 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1061,6 +1061,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>>
>>      dev = aml_device("VMBS");
>>      aml_append(dev, aml_name_decl("STA", aml_int(0xF)));
>> +    aml_append(dev, aml_name_decl("_ADR", aml_int(0x0)));
>>      aml_append(dev, aml_name_decl("_HID", aml_string("VMBus")));
>>      aml_append(dev, aml_name_decl("_UID", aml_int(0x0)));
>>      aml_append(dev, aml_name_decl("_DDN", aml_string("VMBUS")));
>

