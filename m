Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DCC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEB2221ED
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa6p4SxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEB2221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGmor-00050Z-Ie
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGmmZ-0003C4-En
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:24:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGmmX-0008MW-Cr
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:24:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id a17so12235110wrn.6
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0ELJM98OxQdLiUhEIyNXcCtlH4fkIotnYMoGXoGhR2c=;
 b=Xa6p4SxDiNK2o4Jet120k1F7dAz9F471lenmXD/RbfBGlej8vhOK41ynknfyphMyGm
 TZLGQrkxZ0w+HPJ+ZNzmRyw1P4ycw0rRdlH5V6+UbwalNkSqmeflKiu2w+QIxWUowgWy
 XIQ3b1hLboTAAQq269ZW34n4ZAwuzT+XjL8MldyJNu//iLxt2r2cD/F4pM7LCI43TcCD
 2VSp6zIj8SsbthNgqHaZzS1uN61IsgnAS2XZWnUjkPWQw5bgozeEOypNpdZqatMcLgf8
 mANhhDo/EEp7bNIbDMLiJ5rfg6ip/EXcYH+qkrIuyyrG4obRJHeTdtuFy6gh3smAuk1d
 pFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ELJM98OxQdLiUhEIyNXcCtlH4fkIotnYMoGXoGhR2c=;
 b=pjY/6kbFz91yO+7fe8WkbqZbxxpCIylVVV9jS2zEsPb2QcJ9ROpNZencF2YnEuzf2M
 1omUGPKSDLrsBoeakAwFrCpcrfV4k86MRdeZIQW7PkmTl1eOTQA8XY/rtxgoytHNdcFI
 PML0pSL51noATXkGSvUPHx9mjJWInvNPgVM96YGU0J/VmlwAuhxDX8A3WMOcRcR3miYu
 YW8Xhtki3D5ElfuU/U8o47DRbyG7RiA1sIoOazPyZjqs1BQuSHTs7jEVJlHIWXLAMcdW
 dt8FLN6p6X+Ll5KAyiobioYFAkbyJ/3x4G2cg6o3iLRoD147NdiFHHXT5ka0QbfkF7IU
 6NTA==
X-Gm-Message-State: AOAM532Iz0rweWWriJsEctMTzDks06dRMFxH1SKS/FWN3CYm0WTn9cGC
 vBHIbX47V+bFLKSC9/fELDY=
X-Google-Smtp-Source: ABdhPJyWf3G84HBB4WneuktVoatbbSYgn7SYOIg6crPyliCbEhaA1L4RCkpPSJveQgBCA6t2i9HqLA==
X-Received: by 2002:adf:8405:: with SMTP id 5mr3230593wrf.143.1599845055899;
 Fri, 11 Sep 2020 10:24:15 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm5960528wmd.0.2020.09.11.10.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 10:24:15 -0700 (PDT)
Subject: Re: [PATCH v2] configure: Do not intent to build WHPX on 32-bit host
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200910054516.405777-1-f4bug@amsat.org>
 <a4c3ac58-ee56-2ebe-fe2b-43c59640d56e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2b107fe4-903e-2a1b-d09c-cf4e50324962@amsat.org>
Date: Fri, 11 Sep 2020 19:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a4c3ac58-ee56-2ebe-fe2b-43c59640d56e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/20 7:18 PM, Eric Blake wrote:
> On 9/10/20 12:45 AM, Philippe Mathieu-Daudé wrote:
> 
> In the subject, s/intent/attempt/

Oops thanks... Paolo can you fix that directly,
or should I repost?

> 
>> Hyper-V is available on 64-bit versions of Windows,
>> do not try to build its support on 32-bit versions.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Since v1: Handle MinGW automatic detection (Thomas, Stefan)
>> ---
>>   configure | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
> 

