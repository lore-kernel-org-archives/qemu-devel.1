Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51DFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40972078A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDR1HwTT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40972078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqg1G-0000yF-Uh
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqg0L-0008TT-Th
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:54:37 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqg0K-0005es-2L
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:54:37 -0400
Received: by mail-ed1-x542.google.com with SMTP id b15so20655969edy.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 09:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i48S9WMtcgdjRahYRCye5AvSj/FAyDBQc7Tp8q6azVc=;
 b=fDR1HwTTrXK67in0YmW0UPebgGOPQ3jRCAiyyiak0nceEtpnls7zWLIKjw/Vv6ccca
 Y38NYMG5eHbWbmiwEsYYY4tWLQLObkT1td31SyLXUib3JBqTcSdLp4YreS0lEdyarkS+
 J94xPoqAdPJ99kxL+lKB8RVnwZln63oysDo+CTFS6MIN3j+eg5OTvbI669A0ntXLLRfl
 L/5WxFtEeKz1DKw5Bd9WkfsOGoU3l2sxUYF3N+Lf12pFT+UQVIg2igIMePsX74JMCpX9
 KWE4FKQvRQcn2tnFlXcEtYzcoVJYZ0WmBMg9/SK6EOSb4nqEDDr/gEKE6AEafI1f+Jsk
 LHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i48S9WMtcgdjRahYRCye5AvSj/FAyDBQc7Tp8q6azVc=;
 b=La9KQjeRX/9sCxsHEkzZiWrbfkenzJv2sFNaowgtRZMoi8ytLoOKq7l48Qy9oPxgrA
 4X1M+//HH8vUG+LiAFe3fc15/soZbSAZHoycv6qv6jzbwEIe8+Vo9IXGRtCHYnvAiy92
 SecyA2eydtMpKDiPQIQWc0ct0ggGvWSssq+tfIXtpMP2aN2kJm1vw7RWUvoA/GDOl3nw
 rkHg73BuMGV/BmL2tIv/8PptzuJfd8kS1prrTNFs4ntjpN6EHMJV+CCeRuMw3QYGT+xS
 /Ak2nysOPIHaY0LdGg9d/q3ZOWyMWKf8SLTFC6X5ULs3R5fAX3vrfAciqxDfZChxoOLu
 a4kg==
X-Gm-Message-State: AOAM533QQKk0ClMM9NAjDn8ElL9NYZMvVSVOqREvIoW6CR0Ww5kl1Acs
 zktQFkqeHWD1GQz2z/nBXxk=
X-Google-Smtp-Source: ABdhPJzfeRaJ4XHzkz0FMt83wGcy3hq7kOt918h/C8E1Vuxf/O8NoVPgXr6OcgA2L9qWR6mxxyvVwg==
X-Received: by 2002:a05:6402:f:: with SMTP id d15mr7991969edu.25.1593622474659; 
 Wed, 01 Jul 2020 09:54:34 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id da20sm6467365edb.27.2020.07.01.09.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 09:54:33 -0700 (PDT)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
 <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
 <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
 <70e3b721-4515-352a-1f9a-0638ee19b784@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <94527813-1a04-16d7-4449-f583b356a76e@amsat.org>
Date: Wed, 1 Jul 2020 18:54:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <70e3b721-4515-352a-1f9a-0638ee19b784@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Alexander Graf <graf@amazon.com>, Paul Burton <paulburton@kernel.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Pavel/Paul/Alexander

On 7/1/20 5:12 PM, Paolo Bonzini wrote:
> On 01/07/20 17:07, Philippe Mathieu-Daudé wrote:
>> $ cat .ignoredmailmap
>> #
>> # From man git-shortlog the forms are:
>> #
>> #  Proper Name <commit@email.xx>
>> #  <proper@email.xx>
>> #
>> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>> Caio Carrara <ccarrara@redhat.com>
>> Yongbok Kim <yongbok.kim@mips.com>
>> James Hogan <james.hogan@mips.com>
>> Paul Burton <pburton@wavecomp.com>
>> Alexander Graf <agraf@suse.de>
>> Roy Franz <roy.franz@linaro.org>
>> Dmitry Solodkiy <d.solodkiy@samsung.com>
>> Evgeny Voevodin <e.voevodin@samsung.com>
>> Serge Hallyn <serge.hallyn@ubuntu.com>
>> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>
> 
> For at least Paul Burton, Pavel Dovgalyuk and Alex Graf we should just
> use .mailmap, anyway I think the concept of the patch is okay.

Pavel has been using a GMail account, but seems to be back to
ispras.ru, so it might have be a temporary failure (over few
days although).

I can send a pair of patches for Paul and Alexander if they
are OK. The others seem MIA.

> 
> Paolo
> 
> 

