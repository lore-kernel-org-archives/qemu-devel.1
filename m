Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D7C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A34120674
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGEVlFC2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A34120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQTO-0003DJ-Ay
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYQSn-0002mS-0J
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:40:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYQSm-0008UW-64
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:40:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id e26so20773344wmk.5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 01:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P4iqEMJ/IfK5g2Gue0REHbulsoz8kZyJp1gbofCPT9c=;
 b=dGEVlFC2mKniu0a8/vuZe7iIRwe/jBQB3ZmQYoOfR174lvZIzSaqmClcHVDBSOOZyM
 tjP13IeIIRYdGfWUzePgxRAiRIXYJ3MIphh+QQRXKgDUnci83ELFhqely/l2YrbzVNRK
 EwB4uf91hZTmTs64gGWC55ZLovtpyRAXoFMRwQXXlW3ptVzl5oT1rRWibyYmx9e4B7Mn
 KBBsdDKHjqpFFnIIJBLoY62MAijBg9Pzei66DkHuii2PVfbFZw+753Bn3kzKyYwcRaUi
 MLcE3B0RnG8q4aBP9x1Vjy7ao3HYaGqmwwJiZx1oCB9Sx4+1eMVfsGsdTqPG0gz4ij1P
 XVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P4iqEMJ/IfK5g2Gue0REHbulsoz8kZyJp1gbofCPT9c=;
 b=ZU/CkbaWvdsThX0+A9yVgAnPoPwQOS41WIykEvGxeSraI5zlzwQuknaAasIJTpKS6s
 PWLUUvOUj5i4qRhZ3UMVqX1TWJ2nrLThIXx4v/GJVC0Ma5lL+QUZLCOwop7egmPRyzjt
 7ThY48+aYkEispbFO7QaZvkgvR+s+ri58JrYJf+gm33MOn5ahVg9sxMYZRvgRp+vW3S5
 1MzoRCBw+gSoe1KBIwuaChU60DevclqnlkDEg/ycNcb5sIMdTwcnY0oNQhxTYTONqAfl
 hDaa0rAxrokkBGf9JcDHSP60L2HCflomA7ZxXACSXEGbharMlDGO9hKjqVXnwbqOmDLg
 +yLQ==
X-Gm-Message-State: AOAM5311Y2T+cuRevcGbQv7zWI+fKKnUGf52auYrifS323qpaUbq31Ua
 JCM4TQtbCaryl89r9BglN0U=
X-Google-Smtp-Source: ABdhPJw9XkJI/J5KCWroywIEDtPbot/PN3rNegDFPRlL2gEp7JWve/CfVNHY+jlU1VLXzpqVF1J+YQ==
X-Received: by 2002:a05:600c:206:: with SMTP id
 6mr1945619wmi.170.1589272830642; 
 Tue, 12 May 2020 01:40:30 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 2sm21471475wre.25.2020.05.12.01.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2020 01:40:29 -0700 (PDT)
Subject: Re: AW: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
To: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20200511122159.7260-1-david.brenken@efs-auto.org>
 <20200511122159.7260-2-david.brenken@efs-auto.org>
 <a0ccf008-cd88-633b-d22c-9528d17e0c6f@redhat.com>
 <F5B10EA5F04CF44F81B685A0E281578724EA08C9@AUDIINSX0385.audi.vwg>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4abd52d7-a30a-2d97-e754-75af25d7a019@amsat.org>
Date: Tue, 12 May 2020 10:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <F5B10EA5F04CF44F81B685A0E281578724EA08C9@AUDIINSX0385.audi.vwg>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>, "Brenken,
 David \(EFS-GH5\)" <david.brenken@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter,
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Biermanski,
 Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 10:32 AM, Konopik, Andreas (EFS-GH2) wrote:
> Hello Philippe,
> 
> thank you for your feedback, implementing the TriBoard within an SoC structure seems to be best practice.
> We will rewrite the patch accordingly.
> 
> I also attached an elf with an empty main-function to test the Machine.

Thanks, I am getting:

$ qemu-system-tricore -M AURIX_TriBoard_TC277D \
   -kernel hello_world.elf -d unimp,in_asm
qemu-system-tricore: function cpu_get_phys_page_attrs_debug not 
implemented, aborting

> 
> Best regards,
> 
> Andreas
> 
>> -----Ursprüngliche Nachricht-----
>> Von: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Gesendet: Montag, 11. Mai 2020 15:48
>> An: David Brenken <david.brenken@efs-auto.org>; qemu-devel@nongnu.org
>> Cc: kbastian@mail.uni-paderborn.de; Biermanski, Lars (EFS-GH3)
>> <lars.biermanski@efs-auto.de>; Hofstetter, Georg (EFS-GH2)
>> <Georg.Hofstetter@efs-auto.de>; Brenken, David (EFS-GH5)
>> <david.brenken@efs-auto.de>; Rasche, Robert (EFS-GH2) <robert.rasche@efs-
>> auto.de>; Konopik, Andreas (EFS-GH2) <andreas.konopik@efs-auto.de>
>> Betreff: Re: [PATCH 1/1] tricore: added AURIX TC277 D-Step TriBoard
>>
>> Hello David,
>>
>> On 5/11/20 2:21 PM, David Brenken wrote:
>>> From: Andreas Konopik <andreas.konopik@efs-auto.de>
>>>
>>> Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
>>> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
>>> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
>>> Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
>>> Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
>>> ---
>>>    hw/tricore/Makefile.objs           |   1 +
>>>    hw/tricore/aurix_triboard_tc277d.c | 240
>> +++++++++++++++++++++++++++++
>>>    2 files changed, 241 insertions(+)
>>>    create mode 100644 hw/tricore/aurix_triboard_tc277d.c
>>>
>>> diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs index
>>> 5501f6c1a8..e4a2106dd9 100644
>>> --- a/hw/tricore/Makefile.objs
>>> +++ b/hw/tricore/Makefile.objs
>>> @@ -1 +1,2 @@
>>>    obj-$(CONFIG_TRICORE) += tricore_testboard.o
>>> +obj-$(CONFIG_TRICORE) += aurix_triboard_tc277d.o
>>> diff --git a/hw/tricore/aurix_triboard_tc277d.c
[...]

