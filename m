Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1662CC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA82206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zisn4UNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA82206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmM8-0007yP-94
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPmHs-0003kB-5d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:41:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50948)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPmHq-0008Il-Be
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:41:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so2791183wmf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vSL7+pUjJg9SFcmauC5+/zB5+yuOe7oilrMsV+HsrV4=;
 b=Zisn4UNF8y6RqLc0czvK9u2J9o7axdvWV4fJ89E5EfmY6uBo1qRHLtRq9SjNSM82ha
 Vn6rOPsWRDS4H0U5B/9rqmeWTivSSF8hdF8SIlLdVVJa1JtwO7Kpu2Cg2LvSSBnqy/iu
 QqYiRLzT6lZUb/GgmcaKjlEk212/Qco3kF3I6p3Mmx1BVL9kqHaYVIyQDKIQpc080//4
 nIxvfakBD7QwzqkNuf/pXjlEM9p9ZhJMRbBsM+icI6rN1yqTjZ3Y65cUJkX6dDQQmM/d
 pc5cBIxpUMf9vWXFMEieNit5KHJPajMqU8Atbzrl1s7lY1oj9Y4SINEOdiqfzXt3E+R3
 B2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vSL7+pUjJg9SFcmauC5+/zB5+yuOe7oilrMsV+HsrV4=;
 b=Qaf2HJ2+Xu5JrBSnNrLa1ggqQSuaA/s6fFQp3QenL+/L5wUScJu2PM87BSGLYakos2
 mwLvffyOMBZSx8/IsWXAxiDVNnyBDmzhyzUixzqT2W0Fi804MZra0UEteecO5TYezyM+
 Ia2sAyCf7VVFi7+VzOsalRuIAizXARzZytcPk122JXsXzmXeOygSA2A+Iko1VEb8fmzy
 ZziJJLL70Z+UcHWBcvlT14Wa4+yWDckSstq4rhqRRxKsFY08QX/hQRU5qy511sZoa4tI
 xfoDr7hgSHsW0hagG2sMnbpbWMF3kYMRT4nUrrq7LwYR160SzxcmOhEVR1I71ld6HGUy
 Y+KA==
X-Gm-Message-State: AOAM530cnoESJ8BIDy70dtClH6033filDbbowFUlcWYTGa/2cxZPY3Er
 vYaAuxkm5x3NufLgUfAgrBU=
X-Google-Smtp-Source: ABdhPJwqqva5YKeZEXgI5sKuz9MZaAGnpZGOEj3h9gWmteK59x8V4NoOv6TbyXLUV3Gi5SXSR6KIBg==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr4679705wme.20.1601988104782; 
 Tue, 06 Oct 2020 05:41:44 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p9sm1253494wmm.4.2020.10.06.05.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 05:41:44 -0700 (PDT)
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
 <87eemc3b1q.fsf@linaro.org>
 <alpine.DEB.2.21.2010052047250.11145@digraph.polyomino.org.uk>
 <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
 <878scj3cyv.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bbe2408e-75bd-1a72-7d5e-acde1a5d5e21@amsat.org>
Date: Tue, 6 Oct 2020 14:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <878scj3cyv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Kwok Cheung Yeung <kcy@codesourcery.com>,
 Taimoor Mirza <tmirza@codesourcery.com>, qemu-devel@nongnu.org,
 Julian Brown <julian@codesourcery.com>,
 Sandra Loosemore <sandra@codesourcery.com>,
 Andrew Jenner <andrew@codesourcery.com>,
 Thomas Schwinge <thomas@codesourcery.com>,
 Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 11:44 AM, Alex Bennée wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 05.10.20 22:52, Joseph Myers wrote:
>>> On Mon, 5 Oct 2020, Alex Bennée wrote:
>>>
>>>> Joseph Myers <joseph@codesourcery.com> writes:
>>>>
>>>>> On Sun, 4 Oct 2020, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>>> There is a number of contributors from this domain,
>>>>>> add its own entry to the gitdm domain map.
>>>>>
>>>>> At some point the main branding will be Siemens; not sure how you want to 
>>>>> handle that.
>>>>
>>>> We've already done something similar with WaveComp who have rolled up
>>>> the various mips and imgtec contributions into
>>>> contrib/gitdm/group-map-wavecomp.
>>>>
>>>> It's really up to you and which corporate entity would like internet
>>>> bragging points. The only Siemens contributor I could find is Jan Kiszka
>>>> but he has contributed a fair amount ;-)
>>>
>>> Given that the Mentor branding is going away (and the "Mentor Graphics" 
>>> version largely has gone away, "Mentor, a Siemens Business" is what's 
>>> currently used as a Mentor brand), probably it makes sense to use Siemens 
>>> for both codesourcery.com and mentor.com addresses.
>>>
>>
>> I think the key question is what this map is used for: Is it supposed to
>> document the historic status, who was who at the time of contribution?
>> Or is its purpose to help identifying the copyright holder of a
>> contribution today?
> 
> I don't know what others use them for but for me it was just an easy way
> to get a survey of the companies and individuals involved over the last
> year (2y, 3y, 5y... etc) of development.

My personal interest is seeing how the corporate/academic/hobbyist
contributions are split, and how this evolves over time.

Since there were entries for some companies, I added more,
but this is not a requisite and we can drop the patches if
considered not useful or giving headaches to the contributors.

> The consolidation of
> contributions isn't overly distorting IMO. The biggest user is probably
> the end of year state of the nation surveys wanting to see what impact
> various organisations are having on a project and consolidation just
> helps push you up the table a little more.
> 
> The biggest counter example we have at the moment is RedHat/IBM which
> AFAICT is because the RedHat guys are treated as a separate business
> unit with their own unique identity.
> 
> Either way I don't think it's a major issue - hence it is up to the
> hackers to make the choice.

Totally. In this particular case, we could even keep "Codesourcery"
group separate, similarly to RH/IBM.

Regards,

Phil.

