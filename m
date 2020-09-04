Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57EEC2BC84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9278320795
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSZ2dbZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9278320795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEF2d-0002NC-Pj
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEF27-0001wU-2o
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:57:51 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEF25-0002AP-HL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:57:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id a17so7393353wrn.6
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bsaFjeTmfuBQSA8+sRoLG+2Y9YwtoDRdOC/AIxHVF9w=;
 b=hSZ2dbZyLeSJvF+G8Qvx8oUzXObN9a95ozJaKnVA+OBXbHDxNt9p14WeZjA18zdeGm
 85intU//Gelt0aJ045TjXBkInbNBLPKee9LjdbgTmd+qGsf2z1bTSp+ZzPvjb8oeGu8f
 w06r0UR5N9ZiF0G1fsLbuhw7Yv86AkdaYTbk6jV1dwoosIaQcyr1TJRNNROwiDb0aQp+
 7okQlM//ZdqqPg95jyfkCr3AMtoQia4P6xPccOuAmglDPyTs1wiFwxqbBcHBAtPTU0vW
 gzpCdIWIeg65l0n4VVHGKDB9atQjU+q6AaIyvn0hGvp0rTmXkLCZ07GBCXPZz6kkzd07
 i1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bsaFjeTmfuBQSA8+sRoLG+2Y9YwtoDRdOC/AIxHVF9w=;
 b=pDtYu3WkgK72fhT25nh9RC2Ggr86sX4ozBDJFZE+L7Ticj1Ou0EB2MKf/3WoEcaENB
 et/5OQ29yWrdR44PCBJeiyidpqO7L3a0QvNE3TlKEsad3/ZIU3HT2FDWyrToB6rLseeC
 LJO5zgBTJ9MvHrYFXIk/yOC+/hSktwKv5FTHZlFs5csifcRaqx5HOnozDfdcQ4VWNA1p
 ANY/Lfudrbgl7pW/wJes/0Z1qkd3KGFm0iB22+h6QlwtxMG4OKlB92eI1YoUkw39eUXL
 XwrkGPRAykSqXdD2tjYcKCPsMC+tBm+0MQE8vMhNCoz0kdcHt6IzQ35zJekQXCHoH7GO
 lGhw==
X-Gm-Message-State: AOAM533dUUsTBsX1sWF2VPUg0G4lAMueaAu75RgG5YI8q+8H9IOq+1Qq
 TYjffhCe9XAQQap3RUhFing=
X-Google-Smtp-Source: ABdhPJzue9zZfQcMlYZS/ILekkoWhL8LUIWpMjgLuLrfZ5kcY4dCI9fnlr4tXFTsPTf9/e2V7z5wWg==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr9076639wrn.394.1599238665447; 
 Fri, 04 Sep 2020 09:57:45 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id u13sm4207745wrm.77.2020.09.04.09.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 09:57:44 -0700 (PDT)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20191125104103.28962-1-philmd@redhat.com>
 <691a359f-f923-5e2d-6beb-2f9c0a0aca8c@redhat.com>
 <BN6PR2201MB1251317E014311162EDA9507C6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5251201a-fa2c-bb55-01f1-863377b0f2cd@amsat.org>
Date: Fri, 4 Sep 2020 18:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251317E014311162EDA9507C6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.107,
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 12/17/19 7:43 PM, Aleksandar Markovic wrote:
> From: Thomas Huth <thuth@redhat.com>
> Sent: Tuesday, December 17, 2019 7:10 PM
> To: Philippe Mathieu-Daudé; qemu-devel@nongnu.org
> Cc: libvir-list@redhat.com; Hervé Poussineau; Aleksandar Markovic; Aleksandar Rikalo; Aurelien Jarno
> Subject: [EXTERNAL]Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
> 
>  Hi,
> 
> On 25/11/2019 11.41, Philippe Mathieu-Daudé wrote:
>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>> index 4b4b7425ac..05265b43c8 100644
>>> --- a/qemu-deprecated.texi
>>> +++ b/qemu-deprecated.texi
>>> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>>>
>>>  @section System emulator machines
>>>
>>> +@subsection mips r4k platform (since 4.2)
>>
>> Since the patch has now been merged after the release of 4.2, the mips
>> 4k platform will be deprecated in 5.0 instead. Could you send a patch to
>> fix it up?
> 
> OK, I'll send a patch that'll certainly be applied to the next MIPS queue.
> 
> Thanks for spotting this, Thomas.
> 
> Aleksandar

Any update on this?

Thanks,

Phil.

