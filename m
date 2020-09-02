Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4892DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084562072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3Pwtv4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084562072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWfW-0004gW-7B
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWeF-0003iw-5t; Wed, 02 Sep 2020 13:34:15 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWeB-0004XX-RU; Wed, 02 Sep 2020 13:34:14 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so292261wrt.3;
 Wed, 02 Sep 2020 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s0VgyXfP+R/F5kl2gVVwTKI4VPQP4YQzxhNtON/DLiA=;
 b=u3Pwtv4NdTMyaXnfty657XQfbtKzTASnqfPW7M33ZLz5AG1OIU72/vXRKsf4csdLSs
 +w7AatpsAIBqZ8Jq6YyR6QJRn9cCPNGbBCsT8Z5VqkmogTsVy90AVnDN7cphaiAG9NRn
 AwCxxUuTCJw99mxhL1vQedFjXMAGuXWP2Nb6/Jc/LEtRuKDsKUFFp0fyEUQMjsbfz0Uo
 R/XVZ1Q3KpNF5a+rMQFTLGHGMyd6qISVvVxJbTMfWEJbmKBHt4xnAyxIMMNqtwzRo8mK
 PDQr7RZceDsWs6muaOxdBba0xbuspBHOrSFzarxb71TBgruzq/UlnobCyL9bxHUKZ+mU
 4VUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s0VgyXfP+R/F5kl2gVVwTKI4VPQP4YQzxhNtON/DLiA=;
 b=IsWlWzxVu1ZUo8hMYCF2+2r/SuxwRIJB+jfioyD4ah7W/bdI0czYbw6RQUp15dSFyn
 DKb8G5T4MZ8m5fY/DeUQ5zcEFfClucsD0Dd21ZWblUyjwccbORZgRxc4z6LJ3XMnkNgl
 NFEnIyPX+N7/1lhNEbsRxMn5zBE+jz31r9jSgdW1MR6FkEldW0vV7IdSLlImwcfTNdQk
 2FvPlwMi7TJaI5RxcV5XdIbMvVRs7MscO/U/LIBpiBjDaW+r7wbfbhHp+EMzWRWIrQVW
 AbtPAnpBy995aOzdWzRBe7mHmxadAC+SChoFXjipy0O+WihIoV6IEqPjKSZ732EsDJNZ
 PrDg==
X-Gm-Message-State: AOAM531khm1nVLh9uHKUEJf2PcjnrkPfrYWZZrrB3sKlf4TXuSh9x0BA
 SL7tLY6M8cpiweyUEAaW9eS1beCAT70=
X-Google-Smtp-Source: ABdhPJyI6GWXwfgC+ajCWuya/ImVDwIDHFkClNV8Y1aWd3UP40eF1J2OV0wEHxtsa5/MZrZ0U9qWOA==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr7979874wrt.125.1599068049426; 
 Wed, 02 Sep 2020 10:34:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l19sm543617wmi.8.2020.09.02.10.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:34:07 -0700 (PDT)
Subject: Re: [PATCH] sd: sdhci: check data_count is within fifo_buffer
To: P J P <ppandit@redhat.com>
References: <20200827115336.1851276-1-ppandit@redhat.com>
 <6337568d-e443-7107-9dcc-ab3ea2296525@amsat.org>
 <nycvar.YSQ.7.78.906.2009022213350.2047119@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d299f9f3-726a-80f9-e020-7d772b23ba1d@amsat.org>
Date: Wed, 2 Sep 2020 19:34:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2009022213350.2047119@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
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
Cc: Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 6:46 PM, P J P wrote:
> +-- On Wed, 2 Sep 2020, Philippe Mathieu-Daudé wrote --+
> | > +            if (s->data_count <= begin || s->data_count > s->buf_maxsz) {
> | > +                break;
> | > +            }
> | 
> | Thanks for your patch. Note however this kind of security fix hides
> | the bug in the model, furthermore it makes the model behaves differently
> | that the real hardware (which we aim to model).
> 
>   Right, got it.
> 
> | I posted a different fix for this problem (fixing the model bug):
> | https://www.mail-archive.com/qemu-devel@nongnu.org/msg735715.html
> | (you already reviewed it, thank you - I still comment it for the
> | other reviewers).
> | 
> | Can you replace by an assert() call instead? Since this should never
> | happen.
> 
>   Replace above check with an assert() call? Even with your revised fix above?

Well, there might be other bugs leading there...

> 
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

