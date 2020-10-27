Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704F0C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24A4207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qts58u/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24A4207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXKmT-0000RY-PW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 04:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKl6-0008C9-GF; Tue, 27 Oct 2020 04:55:12 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:40357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXKl4-0002S2-PT; Tue, 27 Oct 2020 04:55:12 -0400
Received: by mail-ej1-x642.google.com with SMTP id z5so1064266ejw.7;
 Tue, 27 Oct 2020 01:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ubmnbY3abywQoUdtv/SSGer9u/ZWhGOteWaQjl95mE4=;
 b=qts58u/nvC9K8rZ7TSk6rDJrqRLRHjqfS/LWHdz/1ESRwWEhVcL8NP5rEzj5GKpPvM
 jh7Qt3dN4d13bFTVea84uvfBi5HJxMwWRArQKLrvgc9+HEz8ASMGLkYMp0XqwngBZcm+
 9ajVSRLC6UH3+TZuogeH40elRe3IgXfOV+zVJOuicvQ3CTvj97qSGqJc5uwaFnncbaRw
 1AVTB+pmmp/J31YQsFMGXPwBYhzIh2kK61RDem0JXBvPZh5OqDUlvVBN5uKL51aH712i
 4GNIuhb7j5ZyozfTKtKwhL8mX7uXhnsmOynLw45/3GQlh6qRLarCNfDJtzvmAlh1KBAS
 2nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ubmnbY3abywQoUdtv/SSGer9u/ZWhGOteWaQjl95mE4=;
 b=f/QxLSgOrda6Tds4b/WWUOOvXQVRVZ55C/MUUtvJ7Gt7LdQAqmaC5mAwtkz/2/ou0q
 KwbJAeEvDVrOkDMFv0WVJOt/9zlP6axS6/VDw3ZQvwCB5qy5eFr1aRDNMgErQIYYIOGa
 dQEarZR4kOU9O4MkDR97ekucJMPqU2cggA4Ta3jOHak9HowcgN74kenrmkoIKoNDQ+xz
 vhcdrOeNbb0calzGMksIEH4yJoxHninkvZwigmrW53t7iniNGIHdeq2/3QMS629UPGjK
 y54js1QspWEwCnAmRWWG+9i9jHAoYnaWeOsPG0hbGA+ocfle0HmfmneSO0PduQPNX9RC
 davA==
X-Gm-Message-State: AOAM532XM+x6Mf2oSncKjA0C43N8SoYqPS0F/U0dBVLsgxaZ97dylR4A
 fSl2HjIa0srobnoNlf/xRt0=
X-Google-Smtp-Source: ABdhPJyRhQeWygPN6kywKHyojhuPVP7ux9gsDuJzWdiljb7+McFKqywBMiGZN9ZE6mA09H5FWc01oQ==
X-Received: by 2002:a17:906:7f05:: with SMTP id
 d5mr1266992ejr.362.1603788908508; 
 Tue, 27 Oct 2020 01:55:08 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h15sm582960ejf.50.2020.10.27.01.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 01:55:07 -0700 (PDT)
Subject: Re: [PATCH v3 00/15] raspi: add the bcm2835 cprman clock manager
To: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
 <CAFEAcA-F5WCv6We3V=kCV8vH79ko=KGHYWKLaxNVEd9HjFES3Q@mail.gmail.com>
 <CAFEAcA9fHTO2f_KdCnFvqhEOwTzOwtMf=EhKY=9S_5twpabaCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63d302c6-5cd8-e321-090f-7b1a5979788a@amsat.org>
Date: Tue, 27 Oct 2020 09:55:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fHTO2f_KdCnFvqhEOwTzOwtMf=EhKY=9S_5twpabaCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/19/20 9:31 PM, Peter Maydell wrote:
> On Mon, 19 Oct 2020 at 16:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Sat, 10 Oct 2020 at 14:57, Luc Michel <luc@lmichel.fr> wrote:
>>>
>>> v2 -> v3:
>>>   - patch 03: moved clock_new definition to hw/core/clock.c [Phil]
>>>   - patch 03: commit message typo [Clement]
>>>   - patch 10: clarifications around the CM_CTL/CM_DIBV mux registers.
>>>               reg_cm replaced with reg_ctl and reg_div. Add some
>>>               comments for clarity. [Phil]
>>>   - patch 10: fixed update_mux_from_cm not matching the CM_DIV offset
>>>               correctly. [Phil]
>>>   - patch 11: replaced manual bitfield extraction with extract32 [Phil]
>>>   - patch 11: added a visual representation of CM_DIV for clarity [Phil]
>>>   - patch 11: added a missing return in clock_mux_update.
>>
>>
>>
>> Applied to target-arm.next, thanks.
> 
> Dropped again due to segv in 'make check' when running with
> clang sanitizer, which I gather from irc that you're looking
> into.

The fix has been merged as commit a6e9b9123e7
("hw/core/qdev-clock: add a reference on aliased clocks")
and the series also got:
Tested-by: Guenter Roeck <linux@roeck-us.net>

Hopefully it will make it for 5.2 :)

Thanks,

Phil.

