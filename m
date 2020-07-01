Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E4CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA122067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESORqC4w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA122067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqa3D-0006Et-9s
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqa2D-0005Tl-1Q
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:32:09 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqa2A-0007Nf-Nc
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:32:08 -0400
Received: by mail-ed1-x543.google.com with SMTP id d16so12504860edz.12
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KyhPov47WKPLBsVHD+fob7WgLaC6KVjEyZ9mGoZmCUk=;
 b=ESORqC4w1x/M1uz88oYyXPuX/dLgJVcXO3m7up4MblgZwyIAQhGUH8HUMyiHa453dk
 ISGZglSoM/5i3v0wsFKsQF7XpBZsQeomU/RI6bvWuMrGSG6bWX6HxOp0BI/vcXWlGKCq
 lOcTRXLYPmBRINbsW6Czuu0doVR+4E4ulINBJui+lsRs2iciojZnz2xl95a7j1DPCgwV
 es+pHCkBRI1PDsMDy80cg2Vp9/jDcyU0IQ0/sdPkIHn0L8pdhyRYjWRwY4dxiNP8lSPg
 ifkYUV3zdR15q9OkUst6GTknuRx7WMj1juqxFbvKgFAU6CYM2wtWbM3XMmexX2g5pphu
 VMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KyhPov47WKPLBsVHD+fob7WgLaC6KVjEyZ9mGoZmCUk=;
 b=j/qt/A4n428xsZq9WrFG9+i+XnOeX56jSAvgkKV/Iuz/sSKb4OxNBxLUA1xqOQ/35P
 mBg0pktsvapeZOegvzHgWlb1u1lvMgWG3BBKC3tMIx+WgYONYFZDiLyEQtQjvXvpkwHu
 LFMRLYarqoAMn5xOMqxj+taksdja+PNTHC+VxA/pXvLkWJ5twxmDS0KKbki8kkM2BF3x
 zoFL6qqsxITaZsov0RgP9PXu/cKsfhRZsa3datjTzTTuaoxtWkft6yfM2ci3hdx1LwhM
 BW8xUfAS7/MBPpDFYNwAPnOPNdk8r3OJSPDPcWWmFRFrkyqqlS8MG5MUb21WZhLOGu5e
 qDqg==
X-Gm-Message-State: AOAM533M7+GsUp+ZB9F1QaWh8n/lFSzEHqLwxP8TMwWkETTU6u/O3C2l
 DYJLIz4QorqjJviWyBIGU5kbvhMffr4=
X-Google-Smtp-Source: ABdhPJzlZkPHBeNQu8zjuwHZaoi49JnoQhzlaWNKh1vuZEeDbDMfsUV3Qdw+Ih2R3KtZN+uSGFYPfw==
X-Received: by 2002:a50:aacc:: with SMTP id r12mr28055591edc.219.1593599523750; 
 Wed, 01 Jul 2020 03:32:03 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y7sm4213209ejd.73.2020.07.01.03.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 03:32:02 -0700 (PDT)
Subject: Re: [PULL 6/6] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-7-git-send-email-aleksandar.qemu.devel@gmail.com>
 <97eb7447-0453-2e2c-4003-a4de338ee11f@amsat.org>
 <CAHiYmc5XoQyCqVxNnWJ70HQPsD=RzTEFZ_aNn4KR+u2nDENZkA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b24fbc43-9979-5db2-ff17-64fb3afd572b@amsat.org>
Date: Wed, 1 Jul 2020 12:32:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5XoQyCqVxNnWJ70HQPsD=RzTEFZ_aNn4KR+u2nDENZkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x543.google.com
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 12:28 PM, Aleksandar Markovic wrote:
> понедељак, 29. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> је написао/ла:
> 
>     On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
>     > This commit creates a new 'Miscellaneous' section which hosts a new
>     > 'Performance Tools and Tests' subsection. This subsection will contain
>     > the the performance scripts and benchmarks written as a part of the
>     > 'TCG Continuous Benchmarking' project. Also, it will be a placeholder
>     > for follow-ups to this project, if any.
>     >
>     > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>     <mailto:ahmedkhaledkaraman@gmail.com>>
>     > Reviewed-by: Alex Bennée <alex.bennee@linaro.org
>     <mailto:alex.bennee@linaro.org>>
>     > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com
>     <mailto:aleksandar.qemu.devel@gmail.com>>
>     > Signed-off-by: Aleksandar Markovic
>     <aleksandar.qemu.devel@gmail.com
>     <mailto:aleksandar.qemu.devel@gmail.com>>
>     > Message-Id: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com
>     <mailto:20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>>
>     > ---
>     >  MAINTAINERS | 10 ++++++++--
>     >  1 file changed, 8 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/MAINTAINERS b/MAINTAINERS
>     > index fe925ea..dec252f 100644
>     > --- a/MAINTAINERS
>     > +++ b/MAINTAINERS
>     > @@ -1096,11 +1096,10 @@ F: hw/isa/vt82c686.c
>     >  F: hw/pci-host/bonito.c
>     >  F: include/hw/isa/vt82c686.h
>     > 
>     > -Loongson-3 Virtual Platform
>     > +Loongson-3 virtual platforms
>     >  M: Huacai Chen <chenhc@lemote.com <mailto:chenhc@lemote.com>>
>     >  R: Jiaxun Yang <jiaxun.yang@flygoat.com
>     <mailto:jiaxun.yang@flygoat.com>>
>     >  S: Maintained
>     > -F: hw/mips/loongson3_virt.c
> 
>     Ah, now I see, here you unlist the uncommited file.
> 
> 
> This file/machine, for multiple reasons, will not be accepted in 5.1.

Ah, so that confirms we have to revert commit c012e0b1f9 ("hw/intc: Add
Loongson LIOINTC support"). Can you send a patch please?

> The end user will not be able to see, let alone use the machine in
> question in 5.1. This is on purpose.
> 
> This will give enough development time to Huacai to implement missing
> bits and pieces, and to possibly improve the whole idea during 5.2
> development cycle.

Sounds reasonable.

> 
> Even though the support that Huacai introduced in 5.1 is, for many
> reasons, not completed, and even though Huacai and I had at times
> opposing views and fierce discussions and disagreements - I salute and
> support his work, and consider it, by far, the best and the most
> important contribution to QEMU for MIPS in years.
> 
>  
> 
>     It might be easier to manage sending 2 different pull requests,
>     on for MIPS and one for the performance tools.
> 
>     >  F: hw/intc/loongson_liointc.c
>     > 
>     >  Boston
>     > @@ -3026,3 +3025,10 @@ M: Peter Maydell <peter.maydell@linaro.org
>     <mailto:peter.maydell@linaro.org>>
>     >  S: Maintained
>     >  F: docs/conf.py
>     >  F: docs/*/conf.py
>     > +
>     > +Miscellaneous
>     > +-------------
>     > +Performance Tools and Tests
>     > +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>     <mailto:ahmedkhaledkaraman@gmail.com>>
> 
>     Aleksandar, don't you want to be listed here with Ahmed?
> 
> 
> Of course not. The project is student's. The mentor just helps and leads
> the student. The fruits of the project belong to the community and to
> the student - and not to the mentor.
> 
> If you were the mentor, my impression is that you would leave your name
> in MAINTAINERS whenever you see the slightest opportunity (I remember an
> occasion where you were saying "I worked six hours on this" and then
> proposing yourself as the maitainer for a particular segment (??)).

'??' means you are not sure? Please link reference to discussions.
I volunteered to help maintaining areas when nobody were doing anything,
if that forces others to step in because they are more qualified, I'm
glad I did it. See for example the Renesas ports have qualified
maintainers!

> I
> don't have such approach, and I oppose your approach, and I appeal to
> you to control your apetite for maintainership.

I am not looking for more maintenance, I'm looking to cover abandonned
areas I use. I have been taught by the do-ocracy principle. I'v not been
dropped in as replacement for someone else position, only trying to keep
things unmodified, scared a minimal change would break.

> 
> Regards,
> Aleksandar
> 
>  
> 
>     > +S: Maintained
>     > +F: scripts/performance/
>     >
> 

