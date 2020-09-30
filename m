Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E7C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFBD2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKoJxlyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFBD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZW2-0002gl-5Y
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZGg-0000NM-LT; Wed, 30 Sep 2020 06:23:26 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZGf-0006dl-56; Wed, 30 Sep 2020 06:23:26 -0400
Received: by mail-wm1-x344.google.com with SMTP id q9so1105079wmj.2;
 Wed, 30 Sep 2020 03:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xQu+dScxbRkUiZEtBt3w+MvLrBONcxozms+9gh/fMos=;
 b=UKoJxlyv6jM709ox2oZ7FfFSuu8HXPlQBGfKV1aEH9t3TIX00ehMjxw1kJaRO9XSoa
 Iy/7PLhbtVUY15OOjoMbP6TJodgIjIR6dmouOxeQzNqT/1iUKCoMzlmLPmsye/tN7qxp
 8Sv/8SdHnU5ekVdANeyWV+niyhJk07FvQZoBzAX5/OdpTQVXfQWqC7CcTonlrIGjKd3c
 yAGG5d+Oy6SC0FPB1xKkSuoxnDinB+Bhd/Cv25aowdMjkE62Vg0QQKBfKggoL+DldH7S
 HlgXWnySI7P5BwgKNudWaK5dWMrAmZ07+ozMuViZv+Mu/ZiOuXXTv0TcIPaEz8wNjIkh
 zJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xQu+dScxbRkUiZEtBt3w+MvLrBONcxozms+9gh/fMos=;
 b=BN8dRWJDEdv35e6g8+sMe6elR729EIwdicHqd/8aeN2hg5oaoPloTEg3Bn/BX+LcCG
 UT2ldBIJRUteJMje7MDs2+LgOPm02NufUNVAt03wi8FSDhUIhJm0dVSfZG5p34x6vpyU
 4pKacInDpUW4HsszzrfLS63Iq3emP48eHjVaYNWJT+lylsymPb/VYULMseE6MXqnqRH4
 IDk46XbLK0do7y/JGhoDWhQ8mAML2dZGPocmIVwj7YMc2Ip/ioDzWSFLaDsLk97Jwh7+
 k3MyPvrL0wXZF0JCWJoZ8CbWi75xBkMlpathMq1TtZLwKzByOM7ns1tV3BCAjwxNFBZO
 2LdA==
X-Gm-Message-State: AOAM533r+W/jMkwUyEeeL9nqf8T0XTiuS/atAcgMJwcsVyzXU6/SZibG
 CKV6hpj4+vvqL/NIEwYoUMuaSV605OA=
X-Google-Smtp-Source: ABdhPJzG3vjq9Gkc14XkTiVngNycKikXuZBbCTOPAj8rMrefslPuK0JIrk1+xRfm486pRbXLoH2iSg==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr2095313wmb.129.1601461403124; 
 Wed, 30 Sep 2020 03:23:23 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id s26sm1952806wmh.44.2020.09.30.03.23.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:23:22 -0700 (PDT)
Subject: Re: [PATCH RFC 06/14] mips/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20200930095321.2006-1-zhaolichang@huawei.com>
 <20200930095321.2006-7-zhaolichang@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <220f3754-7599-3e45-32e7-20fa1322ce85@amsat.org>
Date: Wed, 30 Sep 2020 12:23:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930095321.2006-7-zhaolichang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 11:53 AM, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/mips.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> ---
>  target/mips/internal.h           |  2 +-
>  target/mips/translate.c          | 10 +++++-----
>  target/mips/translate_init.c.inc |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

