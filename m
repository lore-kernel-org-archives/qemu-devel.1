Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F45DC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A87062076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHOtSjob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87062076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCml-0003ba-EP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNClp-0002eE-6E; Tue, 29 Sep 2020 06:22:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNCln-0004nw-DE; Tue, 29 Sep 2020 06:22:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id e17so4063364wme.0;
 Tue, 29 Sep 2020 03:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CxFKuzpm1OwRH+Wg8lMsITpenR2tWn/Ge+EjRA5k0Co=;
 b=EHOtSjob03zStwGtu+qfa4eQtTNw3eh2DgVmmOyrmjuJgknVj1sCf5aB0BJ9x/ScGe
 LBBhYbfF0FS/MCOhQDUSyTiknlPLmwGIgvA5++MOl1ZE18qhO7G3sEDzIknpgZ/XJojO
 xUvp5DDoLG5XBpwH4MNfFlU+Pjh16GpLTyeKNcSDiQ9JfD7JBgmPsBu8cqXgmjhLCtmO
 LLX2R1OjKDmCzypCQSj1LO7vuX1IMtY0+YNQYybHarBmO4EXztnoK29JkwzB2KkSFnRu
 CRgaML3eNKsjvxIUuRRSPOA6C/CACbPjoGkGYEESqGvSAhswdohmySPs7QJWEmzdJYt6
 uo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CxFKuzpm1OwRH+Wg8lMsITpenR2tWn/Ge+EjRA5k0Co=;
 b=MTzdhhzuO+wCWnujyWfoZFm+qnmHIdTDa8eJpI/OxXuM7jWuEixvlXowQlJpEL+0c3
 /u127OF2QVmvT280o0GpMoMOi7mFCj02aWD2b5I5IvyRRCamrFpudK2rUKCvvvZ/paa2
 dyzFBOgtrlO3tw80qFuIj3SH1YXUpjv4A2MZirSejfWslTSIZISyABq3JdVBhmyEqUPK
 HWgg8HOwutGL3fqKjRJ3rvfsos0lMdoKsMEFao6i2yNu9eB4AOj0C2Tkla9k238EfFgu
 pfMZ1mF75ar2aNJduvQZRW+I2eDIw/5lY2pV9MpkUnaRGxAkmYYevVpSoCPaUIIgNc6l
 shng==
X-Gm-Message-State: AOAM5310t/LwnA2xaNS8/4Atcxpe3um4XgnYzuXuPKOZ1SkuRs2fklDc
 dGvylbBQiEul/plkDNPClqQ=
X-Google-Smtp-Source: ABdhPJzbsHl1JDMpYI7oCtztr6bD1IbS+oZyTjSjUyCrYzVI8HGi6Vevp9PLOjRkRx775RNfqq+tVA==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr3919527wmj.163.1601374920402; 
 Tue, 29 Sep 2020 03:22:00 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d19sm4445403wmd.0.2020.09.29.03.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 03:21:59 -0700 (PDT)
Subject: Re: [PATCH] hw/rtc/m48t59: Simplify m48t59_init()
To: Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200914102425.1152962-1-f4bug@amsat.org>
 <20200916025022.GE5258@yekko.fritz.box>
 <de2b5d0c-fcc4-a26c-5fda-610b7fa75862@amsat.org>
 <cc4d5239-636c-f01a-d822-97ea60ee303c@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <480ac05a-41b0-e857-a151-3063f6a56265@amsat.org>
Date: Tue, 29 Sep 2020 12:21:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cc4d5239-636c-f01a-d822-97ea60ee303c@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 5:00 PM, Laurent Vivier wrote:
> Le 24/09/2020 à 16:53, Philippe Mathieu-Daudé a écrit :
>> On 9/16/20 4:50 AM, David Gibson wrote:
>>> On Mon, Sep 14, 2020 at 12:24:25PM +0200, Philippe Mathieu-Daudé wrote:
>>>> As the 'io_base' argument of m48t59_init() is unused (set to 0),
>>>> remove it to simplify.
>>>> To create a device on the ISA bus, m48t59_init_isa() is the
>>>> preferred function to use.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  include/hw/rtc/m48t59.h |  2 +-
>>>>  hw/ppc/ppc405_boards.c  |  2 +-
>>>>  hw/rtc/m48t59.c         | 10 ++--------
>>>>  hw/sparc/sun4m.c        |  2 +-
>>>>  hw/sparc64/sun4u.c      |  2 +-
>>>>  5 files changed, 6 insertions(+), 12 deletions(-)
>>>
>>> ppc part
>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Thanks!
>>
>> Can this go via qemu-trivial@?
> 
> Yes, but more reviewers would help. Mark?

Or Artyom :)

> 
> Thanks,
> Laurent
> 

