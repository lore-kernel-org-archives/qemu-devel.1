Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E06C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56B120737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb4ohjlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56B120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNKK-0003s4-Uu
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrNJY-0003L3-OD; Fri, 03 Jul 2020 11:09:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrNJX-0001lF-4k; Fri, 03 Jul 2020 11:09:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so24996938wrs.0;
 Fri, 03 Jul 2020 08:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JDajLwdvBFzscJh4jaahhvM3Ipcty3a/ZR6mLHqTZM4=;
 b=Jb4ohjlWeeE8Hrtl60seV4jFTTeTebJy72VO573EzUS93XBc5+AQ5IE/TrYyj42GdG
 qALiKa/7wubi0nvPBT/y1kw9SjyG2YzONYrCBaROOGhYEzwzdSmTuWI2Ru9mEZ+T5TiO
 GVw/7TmsjImBu3v86I0KyN4px0A6isVPBAe2uHjHfQPOSnfmt3K0mGKsmpBo/sbQlbRq
 tksU/rk3r4G406rdEhjpJW5KjtbSCxg0Sj9XDiCE0s1Ktmc4vw9Z8jJu8tEFQYrwgNeU
 y0X9hSLZfGZBoSw3GjxKA9s+w7w90ytCX2fMMl2zVqC3H4wV56OHUznRB6aDuXw2aqMI
 +Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JDajLwdvBFzscJh4jaahhvM3Ipcty3a/ZR6mLHqTZM4=;
 b=WZXpEaJOBsMNdHp1i3IHXyDtkVGAti5c8lC8jK+X8DAg90SdNG5x1zJC0JCCr70yFF
 TUZk29nXm4VTRfFjCkHn1K7tRFkAvvfKvzhc/t4vCIUVDYij77Eq4UTSgz93jwb+9nvT
 E6ilvvNe/w9ZimIDgA0iKKTqCjrxn9878A4GmoPpxdUURVRY49u+vhCm8fLl0RRwlQ5w
 FwdvLqMe0KsMwn80bsRj6pvOMuAt4bBwoi9XUlvKRmpnl1atXxEDIong7c5R8EycCoqH
 ppFRQZv7La0YbSUo1sAQAkMbFjp+iygjgE/B3CPODz0YzO4n2hDE7JU+DE7hlmpftrv9
 OWWg==
X-Gm-Message-State: AOAM532e+1rDHWdxWFlrZ+bb5nu7yksRRcGSTKC2FJQOwyQTq39oTYAB
 2pBbAM6SzRBHCQ6ibAlLlhLbRILulOI=
X-Google-Smtp-Source: ABdhPJymM9ac8KeiJDwx25MDu2GRO476JZ4HWOKsnsPSRWnIES/ia1LU/lUOApYyrAVfmyzEVnKIiA==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr2500730wrv.328.1593788957015; 
 Fri, 03 Jul 2020 08:09:17 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g14sm14037664wrm.93.2020.07.03.08.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 08:09:16 -0700 (PDT)
Subject: Re: [PATCH v7 15/17] hw/sd/sdcard: Correctly display the command name
 in trace events
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-16-f4bug@amsat.org>
 <CAFEAcA8tWKTq5qe8_JufgxhZo1X_CuCUCoO1HsEyxOSbzWDOhg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <447072b9-9e3e-7f49-2ea3-911cd1675612@amsat.org>
Date: Fri, 3 Jul 2020 17:09:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8tWKTq5qe8_JufgxhZo1X_CuCUCoO1HsEyxOSbzWDOhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 3:28 PM, Peter Maydell wrote:
> On Tue, 30 Jun 2020 at 14:39, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Some ACMD were incorrectly displayed. Fix by remembering if we
>> are processing a ACMD (with current_cmd_is_acmd) and add the
>> sd_current_cmd_name() helper, which display to correct name
>> regardless it is a CMD or ACMD.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> I think my comments on v3 of this patch still apply:
> https://patchew.org/QEMU/20200605102230.21493-1-philmd@redhat.com/20200605102230.21493-10-philmd@redhat.com/

I agree with your comments. I didn't addressed them because for some
unknown reason this mail ended tagged as spam. I'll address that now.

Thanks for reviewing the rest of this series!

> 
> thanks
> -- PMM
> 

