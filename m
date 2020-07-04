Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3652C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A9D20870
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 11:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIRWzGW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A9D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrg9s-0002nu-1W
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 07:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrg92-0001zK-3p; Sat, 04 Jul 2020 07:15:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrg90-0001Lp-K1; Sat, 04 Jul 2020 07:15:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id z2so13128887wrp.2;
 Sat, 04 Jul 2020 04:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DxHG1Nn2j8/G2flMc0wwa8Ea9DC1rh/+fzTn6MURWWI=;
 b=FIRWzGW2I+KJ9KMMgH/Nqc7FYnwf5lV3ZC+Lea3ZYnTHF+D/axkYuOZo+i24xCaPrF
 QezPdH05902vwQD6S4BCet+lMUSFZqDDQV5VaBKQ40grFwbyl2Ahh7nHzTZbPfhLKkR+
 QvS3Pnr5oTsQAa0XpMZVRNyrYUi07go5Ub85bExoRd52fbSxw1TCTu5GW/ZkQjC7vHYq
 JpxAocWWz55hlDk3WEfmUpu+AB/IHyqRpyHAWd5QDXwk9eLZTAXCG65AhKNFg3dnN7PO
 uOBgM952ipCagJ3mbmg5kLa3Iw5ZgUQKxADaPFfiYEZ3VJaxILYLMRPoPbOboCozpnrE
 KYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DxHG1Nn2j8/G2flMc0wwa8Ea9DC1rh/+fzTn6MURWWI=;
 b=MkITKdqBaH9HNFniboIjHpLknhAJydOnc1jpyV/ulBrq964df5NKt6Wom5MbS2Otfm
 a7ydqPRKjBshtchFMHJkguyBtz7r9CR+vazKuNcb85mS4/vVShUMrg9G7GbnLquIYxXO
 +AEEDz038BbYnSeh6PGgH7gBQmQqD6LpLvLUbrA8ZTxZzQ1ktRzPu4e5GpMl/FYJMES5
 C4T8tx0jOsD4ORS8KW7yKxgmIGUo/tLaG83nAiTr1Q8WRTo666NtXkVt7bb5nSP8C+9H
 51kOEuZFnJiL6rYiKisMbhCHgdL1R4W9VOjXffrJucZb6/mhM9aMoAoJ64+ndXJ8iYlt
 xxCw==
X-Gm-Message-State: AOAM5330pLIWHU0kJe+zqb4BRpZTlykXD5EDbNgjr6QY2ANH9BZlCsWV
 D0g5snxT0UwW+yTx6RK8Oqk=
X-Google-Smtp-Source: ABdhPJwZ79wCFp8gNa5EGDstTYrZ4o4ZE8Nwy8ALntrtdY45s0WTz3G29VfuBqQ/F3GgrEHqBFA6qg==
X-Received: by 2002:a5d:408c:: with SMTP id o12mr40437247wrp.412.1593861340211; 
 Sat, 04 Jul 2020 04:15:40 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h2sm16570247wrw.62.2020.07.04.04.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 04:15:39 -0700 (PDT)
Subject: Re: [PATCH v3 14/19] .mailmap: Display correct email address for
 Michael Tokarev
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20200702173818.14651-1-f4bug@amsat.org>
 <20200702173818.14651-15-f4bug@amsat.org>
 <dc28e476-a39e-b300-6810-2ed08f3540e9@msgid.tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5cd68597-7e80-7eff-0f64-98ec5d4d535c@amsat.org>
Date: Sat, 4 Jul 2020 13:15:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dc28e476-a39e-b300-6810-2ed08f3540e9@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Alex/Laurent

On 7/2/20 8:45 PM, Michael Tokarev wrote:
> 02.07.2020 20:38, Philippe Mathieu-Daudé wrote:
>> Fix Michael Tokarev email address in the following commits:
>>
>>   $ git log --committer=mjt@gandalf --oneline
> 
> Heh. It was a misconfiguration on my part which I haven't noticed
> for quite some time.  Dunno if it's worth the effort to fix that
> now, since all the commits are old (in 2016), and all are trivial.

So this all started when Alex added the contrib/gitdm/ scripts,
I noted various encoding discrepancy. Alex merged the first patch
directly as commit 1fed8f0044 ("mailmap: Add many entries to
improve 'git shortlog' statistics"), then Markus asked me to
justify each alias fixed with a commit with a combination of
(broken author email + good S-o-b tag). Then Markus gave his
R-b tag, but Alex was busy so I asked it could go via the trivial
tree. Laurent said OK but I had to split in 1 patch per person,
and each person should Ack his own line.
With this v3 I complied with all previous reviews, but I guess
I failed at explaining why/how this started. As this is an
amazing use of my time, I wanted to get over it, maybe too
quickly. So now I'll respin a v4 with more detailed explanation,
suggesting each person to either Ack/Nack each patch, then give
up.

