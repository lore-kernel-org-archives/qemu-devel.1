Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B991C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6170F20866
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We7z8HtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6170F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPj90-0005xu-4x
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPj7H-0004zM-9R
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:18:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:38687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPj7F-0007Xu-FP
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 05:18:38 -0400
Received: by mail-wm1-x329.google.com with SMTP id v12so2284211wmh.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=C6qeUVxqlSpoRZn2lKUM6MZrZQfpAs8K/6HDbYrTQms=;
 b=We7z8HtKTUiS/6n51Vk0UV5QJbprJTdt7I9u+TwLTbprj0AOQZQETLOM7cH3KpFBTr
 QMYwZHnYKUm5wlmkckqbgXSOw7A+ucl/ETvdptWwpyyxSw0Ev5T5oOsJA+nMktd60932
 5iJllqQJTkjVMjmTZtiqtZEv3bkXB35x0sAk/sEG6wD2R0FpMUQpL8HOBD+6H5in+HCQ
 OetWc0iVTH8zZa7Ob+9xBf3KO1HqaDjW4SuOoGI9eNvriaqLFN8XaJ7y7lakNhg1mu8Q
 oug9BFAk8kuS8Qe2M08euYM46c/VIwwcg7Eo/m8Hsi4U/obA/+loh+Hb6UWUFrGymjVr
 qjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C6qeUVxqlSpoRZn2lKUM6MZrZQfpAs8K/6HDbYrTQms=;
 b=hMc5rOSriFDdmSBV1FTcAIg8vdkOnjEM1jecanjc1aiblBs7DBLpiPTrB+kMo4Ed5V
 ATBHW4zP5fC9lXJyodw9u5jXOIngYp0OQN8Wy0vv6n46lyGykJszLiyPy9DJ8N/Dr+o/
 V912I9fG2QcBBKABCpNBtCIFxa81BIUIBzqPUQ6TbzECtxvotoHGpDs2Ehh9h0VG3n0z
 k+QOqfBWzSXFc5S+tfB4UUiSne05+8vbXesyzgu9mJtP2Lid3XfFuqWXBv8o4afUFXed
 7qMIerQsrZCLP0T0lwnWmHb+bgg5eqokT006ZdCOPMEfUx/2cZHqT1QHK17L0lvtqMX9
 8RZA==
X-Gm-Message-State: AOAM531FLR3g0o+UjsnDPJ0xOCacH/zHQxwFeTHOQk1aEPYr+Xs6q/H4
 Ca0Zn4J5WEo7eja0QE4n+hc=
X-Google-Smtp-Source: ABdhPJxU08Fy/jOxfG2YfNcC2TvFMM1XeX6lsaY0OCoPMqk/F8Rg+vGBzxFDyidkVFEY6WfstAquKQ==
X-Received: by 2002:a1c:f208:: with SMTP id s8mr3848113wmc.85.1601975915606;
 Tue, 06 Oct 2020 02:18:35 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e18sm3457149wrx.50.2020.10.06.02.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:18:34 -0700 (PDT)
Subject: Re: [RFC PATCH 08/21] contrib/gitdm: Add Mentor Graphics to the
 domain map
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Joseph Myers <joseph@codesourcery.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-9-f4bug@amsat.org>
 <alpine.DEB.2.21.2010051327090.312@digraph.polyomino.org.uk>
 <87eemc3b1q.fsf@linaro.org>
 <alpine.DEB.2.21.2010052047250.11145@digraph.polyomino.org.uk>
 <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17920b87-8156-9a59-3fdd-6910f8e68f1b@amsat.org>
Date: Tue, 6 Oct 2020 11:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e1818fb3-4c63-6b2a-17cc-f3b7bc7d393b@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x329.google.com
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
 Thomas Schwinge <thomas@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 6:01 AM, Jan Kiszka wrote:
> On 05.10.20 22:52, Joseph Myers wrote:
>> On Mon, 5 Oct 2020, Alex Bennée wrote:
>>
>>> Joseph Myers <joseph@codesourcery.com> writes:
>>>
>>>> On Sun, 4 Oct 2020, Philippe Mathieu-Daudé wrote:
>>>>
>>>>> There is a number of contributors from this domain,
>>>>> add its own entry to the gitdm domain map.
>>>>
>>>> At some point the main branding will be Siemens; not sure how you want to 
>>>> handle that.
>>>
>>> We've already done something similar with WaveComp who have rolled up
>>> the various mips and imgtec contributions into
>>> contrib/gitdm/group-map-wavecomp.
>>>
>>> It's really up to you and which corporate entity would like internet
>>> bragging points. The only Siemens contributor I could find is Jan Kiszka
>>> but he has contributed a fair amount ;-)
>>
>> Given that the Mentor branding is going away (and the "Mentor Graphics" 
>> version largely has gone away, "Mentor, a Siemens Business" is what's 
>> currently used as a Mentor brand), probably it makes sense to use Siemens 
>> for both codesourcery.com and mentor.com addresses.
>>
> 
> I think the key question is what this map is used for: Is it supposed to
> document the historic status, who was who at the time of contribution?
> Or is its purpose to help identifying the copyright holder of a
> contribution today?

My understanding is it is useful to document the historic status
(who was who at the time of contribution). The tool support such
granularity [*]:

EmailMap file

    Map email addresses onto employers.  These files contain lines
    like:

            [user@]domain  employer  [< yyyy-mm-dd]

    If the "user@" portion is missing, all email from the given domain
    will be treated as being associated with the given employer.  If a
    date is provided, the entry is only valid up to that date;
    otherwise it is considered valid into the indefinite future.  This
    feature can be useful for properly tracking developers' work when
    they change employers but do not change email addresses.

[*] https://repo.or.cz/git-dm.git/blob/098408bc4d:/README#l122

Regards,

Phil.

