Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A897B2192A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 22:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCRFf7T4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A897B2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrUFo-0004AP-02
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 18:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrUF5-0002uI-2T; Fri, 03 Jul 2020 18:33:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrUF3-0004pA-GK; Fri, 03 Jul 2020 18:33:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id k6so34226371wrn.3;
 Fri, 03 Jul 2020 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=f3cnz/YdMfoRiAunj20F64gea0b51+Mk9r7EXe2xnjQ=;
 b=TCRFf7T4UxLPaIK0KMQVAwHblU3OGn+xNgLlz3l20TfYrY7Qc+uezmjl/OwkIo3oG9
 eyBlFS/CpmDxETeqJ21Kl5ZNBIxs3WKKzNniYXSM6Vg38r3cTLpz/Gxf0e7rXxgidvcF
 GFjNFV7l9nUItjU9bpeAGTCai562RDwLx+hrRHoxLacS11pLDxsOy3IVzpWpbCITQQ7a
 oy5r1nwhGZ2Xc2R/VwGwljj5BGLDNj5Z9hQPwm7av7nzymMCJh9f7116tjeXc0zOEE4+
 ZV0GyWn1F8Ffr7d6fDMYQXinjzjHvBRPXhsNkdHnpeskjcjfRU2dha8IEB0PC509VkJ2
 uGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f3cnz/YdMfoRiAunj20F64gea0b51+Mk9r7EXe2xnjQ=;
 b=FL38RDDpRtZ0d6g/JjEnXOej1rNHj9I/n9JsQa53VJE58cYYXQwkRiGMBhrsHYvAMx
 Y2KFQBG8W8AlG9MWmZnVRBNhR5KbpeuSwFQV6+EYPyBhFphyblNAbpgF4BoiohhN3Mu5
 VKGml0HSQQh3HcHUW9pkJFUiF0/OO2wDhHYEzR95ikFmGchm1rXdquyzCSetpNb/JImf
 a24niL5+4imbfyUF/5dGBiRgTFVAfgwwyBU2dLyKHJ7ac35DjHWt3EfIM+TYQ5Rop44N
 6QyZ1g2je96t/J5U6DjI8hW8Hv0U9VecYvJf3CTeXJimT3jN9aYIk7Kb2f8hHht9SiIA
 qoog==
X-Gm-Message-State: AOAM531GdhxeE2ntwmgiCehT+5HZAc4SogLXUGdVEbD5fxnVFe8px5dj
 K2MrEb3KvjcS37Slv013SlA=
X-Google-Smtp-Source: ABdhPJwrn12Y8XmWuT5L+Pcx4eaDRASoLHvibYiqTt+D+si3a4nzD3ZaBIXQXsPoAjAE9VwDiWXMtw==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr36900694wrw.145.1593815587476; 
 Fri, 03 Jul 2020 15:33:07 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w17sm16579239wra.42.2020.07.03.15.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 15:33:06 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] Add Nuvoton NPCM730/NPCM750 SoCs and two BMC
 machines
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <CAFEAcA_3y3XoF6BsYUt19f2CvyseahSEZWfY0iQxByJKaMA29w@mail.gmail.com>
 <296f281f-e045-e794-1a1b-4e311b6408b2@redhat.com>
 <CAFQmdRbOKFxxxgR0hqcnABxn+jSBr349159m45TJLawVmnhR3Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1c3ac2aa-42f6-943a-44b0-11ed4ef4d115@amsat.org>
Date: Sat, 4 Jul 2020 00:33:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRbOKFxxxgR0hqcnABxn+jSBr349159m45TJLawVmnhR3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 11:15 PM, Havard Skinnemoen wrote:
> On Fri, Jul 3, 2020 at 6:35 AM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> On 7/3/20 2:27 PM, Peter Maydell wrote:
>>> On Sat, 27 Jun 2020 at 00:55, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>>>>
>>>> Time for another refresh of this patchset. Sorry it took so long -- I've been
>>>> trying to figure out why the Winbond flash model isn't working with
>>>> npcm750-evb, and I'm fairly convinced the number of dummy cycles in DIO mode
>>>> should be 4, not 1. Unfortunately, I don't see any other machines using Winbond
>>>> flash in DIO mode, so it's hard to prove that it's correct. I'm planning to
>>>> post a libqos-based test suite separately.
>>>>
>>>> I'm also planning to add the vbootrom to qemu as a submodule, similar to the
>>>> other roms, but not in this pathset (let me know if you do want me to include
>>>> this in the series).
>>>
>>> Hi; it looks like codewise this patchset is ready to go in
>>> and it's all been reviewed. I see however that all the
>>> new files are GPL-v2-only. We usually prefer GPL-v2-or-later
>>> for new code: is it possible to use that license instead ?
>>
>> This series has been posted before Markus qdev & error cleanups.
>> Maybe some newer error patterns should be used now instead?
> 
> I'm not sure if I understand exactly what you're referring to, but
> I'll do 'git log origin/master --author=armbru@redhat.com' to see if I
> can apply any similar fixes or cleanups to this series.

Sorry this was a quick comment for Peter, that he might get conflicts
when applying.

See Markus "Fix realize error API violations" commits:
7cd1c981eb, b40181942e & 3e9a88c372, and commit 123327d14
"Clean up roundabout error propagation".

