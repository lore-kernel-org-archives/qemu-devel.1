Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE3CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B08E206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tt4HB02K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B08E206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPp5k-0001VZ-BN
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPp4C-0000Lo-84
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:39:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPp4A-0007gE-Cy
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:39:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id n15so8252736wrq.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gPiSSVgrrZbCgGPuicyH53DRC6b+8r1bLnLpg2kOiPE=;
 b=tt4HB02KL1qAhScQBS+G+JVmCrGkbBMTEd0I1C24OJyKdQez3aYFDAGl+aUI2oQSL3
 Go3/oaUA6SDlUaw5KuT0V9jYkkMqgIqQBkXXG6IvIgtTqdR+3WDpl9fm92SSo8HwcMdx
 0eqFQNHXz6K9vXt+HS1NfmG7ah+NT1EXepNd3ZJldM/CoL7SIVhkHP3zERN6+9hInjWW
 QS7BnP4lH8f6rXD12T+Hr5MgYu01Bb/HgLrSXIKPBlQDv8JiL8SvBdJzliQ+hLu9hOM7
 M4KNBoJCZaksC4pf1h4KjtPtFRVMZT8r3KHptv6t2fOMAytetuwa+1d5ccb/NWVc7L3d
 MB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gPiSSVgrrZbCgGPuicyH53DRC6b+8r1bLnLpg2kOiPE=;
 b=GfDd9ystNJOASP1y60o18UCx1yL/zOESH5n55zY2+7Y1/KPiji49xMfJIWLYN+RMnr
 f/YKqU79qZAkiuwQL99e5b+d6hd4XGoOkBd0cPwxFmPQuTdI2LRfZmx0bb4J2j0Sa81O
 tOnbhgA6Z9STucibuon5xrIVxwajmjfaYQLWIgojDEuqi5XrQE+RaGm7+BcEP5rZ0Sp8
 utFfWyYayvddfMndx9CRhxE79gUoQbW0rkKEBb070jRKGrAKk+AsgpqYn1MBB83d46Tp
 lZmBVs6vzvzaUDnqa1nXwq3Y+OCX7WsUdXGPbUY8g3mgALQCQOEM8E+py4DS3Pih2UDO
 kgKg==
X-Gm-Message-State: AOAM532FbA6Dc1G51TnIyCizCQHwXJatNOnFDl1pDWr+quGQwXQ8qyqW
 sNOagqzo7gAYw0mj1jQdccU=
X-Google-Smtp-Source: ABdhPJzkpgDmifAEpussKx9heGmgZHboHZ7rsa40nmXvg381f2y9ZldXhh+OgLLhfYzhnTpRdVBd2g==
X-Received: by 2002:a5d:4981:: with SMTP id r1mr907315wrq.343.1601998788546;
 Tue, 06 Oct 2020 08:39:48 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a7sm4519274wmh.6.2020.10.06.08.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 08:39:47 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] contrib/gitdm: Add more academic contributors
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-2-f4bug@amsat.org>
 <CAMgSi0Hg4b_6MuPopG5YD-NL1OkhMsG1rUPKuuTmJJCBKXdZ0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b272745a-7803-5cdd-23b9-142e9ad5ef60@amsat.org>
Date: Tue, 6 Oct 2020 17:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMgSi0Hg4b_6MuPopG5YD-NL1OkhMsG1rUPKuuTmJJCBKXdZ0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pavel,

On 10/5/20 7:01 AM, Pavel Dovgalyuk wrote:
> On Sun, Oct 4, 2020 at 11:40 PM Philippe Mathieu-Daudé <f4bug@amsat.org
> <mailto:f4bug@amsat.org>> wrote:
> 
>     These academic contributors have a number of contributions,
>     add them to the 'academic' group map.
> 
>     Cc: Pavel Dovgaluk <pavel.dovgaluk@gmail.com
>     <mailto:pavel.dovgaluk@gmail.com>>
>     Cc: Jiaxun Yang <jiaxun.yang@flygoat.com
>     <mailto:jiaxun.yang@flygoat.com>>
>     Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com
>     <mailto:artem.k.pisarenko@gmail.com>>
>     Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>     To the developers Cc'ed: If you agree with your entry, please
>     reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
>     care, please either reply with Nack-by or ignore this patch.
>     I'll repost in 2 weeks as formal patch (not RFC) with only the
>     entries acked by their author.
>     ---
>      contrib/gitdm/group-map-academics | 5 +++++
>      1 file changed, 5 insertions(+)
> 
>     diff --git a/contrib/gitdm/group-map-academics
>     b/contrib/gitdm/group-map-academics
>     index 08f9d81d13..c7b0dd46a3 100644
>     --- a/contrib/gitdm/group-map-academics
>     +++ b/contrib/gitdm/group-map-academics
>     @@ -8,7 +8,12 @@
> 
>      # Institute for System Programming of Russian Academy of Science
> 
> 
> It's full name is: The Ivannikov Institute for System Programming of the
> Russian Academy of Sciences (ISP RAS)

OK.

>  
> 
>      ispras.ru <http://ispras.ru>
>     +pavel.dovgaluk@gmail.com <mailto:pavel.dovgaluk@gmail.com>
> 
> 
> Please change to pavel.dovgalyuk@ispras.ru
> <mailto:pavel.dovgalyuk@ispras.ru>

This is not to redirect your email, this is to count
the following commit as academic (I guess remember you
were having a problem with your pavel.dovgalyuk@ispras.ru
email at that time so you posted from GMail):

$ git log --oneline --author=pavel.dovgaluk@gmail.com
5fb0a6b5e7 icount: make dma reads deterministic
878ec29b9c replay: record and replay random number sources
fc6b2dbac1 replay: check other timers for icount limit
35e32d9e2e qapi: add support for blkreplay driver
86cf9e1546 replay: don't synchronize memory operations in replay mode
9e9b10c649 icount: remove unnecessary gen_io_end calls
89a44a1033 i386: Save EFER for 32-bit targets

>      # Columbia University
>      cs.columbia.edu <http://cs.columbia.edu>
>      cota@braap.org <mailto:cota@braap.org>
>     +
>     +jiaxun.yang@flygoat.com <mailto:jiaxun.yang@flygoat.com>
>     +
>     +artem.k.pisarenko@gmail.com <mailto:artem.k.pisarenko@gmail.com>
>     -- 
>     2.26.2
> 
> 
> 
> -- 
> Pavel Dovgalyuk

