Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04BE20772
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2ZpFWmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04BE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhu4-0006GI-Vm
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfhtL-0005cC-1U
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:42:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jfhtK-0004jf-4G
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:42:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id j10so10956373wrw.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dDc1ZedJO1a2fWnm0vMKHkoCpxS/qbWDoc4Oh14dado=;
 b=K2ZpFWmA0BvOXyBeZGAgmHmhZOtgVQx+2ONV3ebF2vqPLIsedulBIakBlbV+jVzzzZ
 /x+BE0QIBGkSYnJf2Mh61e3eflNQJ3Oh/wqotiaHHknoH1LYPEvTRs2KXD+dFmCYl+AW
 JgS7Xah83XAocUt5Jyy4sEZHe8QaG2DhTqwXmnWCN2XT4UIHmvMR3Chn8jeeJKI7BJZT
 tex1pet/7KbBd0nx1YDYEbL+V7s80RnTQl/+5EnY6VMdaSKf9wNNGtE9UNkDZOJUmZwr
 LGJBhG31ov+X5i8LOt+Ibqp+ujPG8U4nXgq8SNoOEkza9CHCPLqndBkeh4y+vK7khSg7
 Q0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dDc1ZedJO1a2fWnm0vMKHkoCpxS/qbWDoc4Oh14dado=;
 b=g6Kp9r57bI44r8e1DsVzhL9AdqFVOMEuGULf0PthlZF3fk8HtbmzrcuUJcsE8JYezk
 Y2CVjPbVVidshtmOYX2jpBAwx2OIagkBYudjtbRN8mPTOtF/rrL2enUMNz5MofG1P9XC
 +tO5aV8Qww7SbEcWG41jqcia/QUshOOaV+JfdKBfE5srBizwZAPjQ7zUSkaL1M2QsVqM
 Gh4bf64dEqKK9Qiwj+tP/8Nh6vmehX83/8VK/r28KtiGPwLO+f0kGCuuvoMPlcMED3gm
 xIGJCL5wvw1KRmVNa7jrqwXnTcNEFgP6lafN7AHxJET+ln49cNnDLWCAomwuC8lGkF2H
 wBNw==
X-Gm-Message-State: AOAM532znZuUkTEmHyKZju0pWljFqVZ3e4ZWLt0t6z8jaMYP+VVWvpgO
 8XIGPZUrYCTUmqd439uHNyE=
X-Google-Smtp-Source: ABdhPJyMwAb39TjQhNZp9g/G+ezSicVH1Il1tKQQpzWMo6IsvEaUtRFhf5FtqavECSJ4c0ObnoyvVQ==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr20960274wrs.123.1591008120288; 
 Mon, 01 Jun 2020 03:42:00 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id z206sm12625860wmg.30.2020.06.01.03.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 03:41:59 -0700 (PDT)
Date: Mon, 1 Jun 2020 13:41:57 +0300
From: Jon Doron <arilou@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-5.0] gdbstub: Use correct address space with
 Qqemu.PhyMemMode packet
Message-ID: <20200601104157.GH3071@jondnuc>
References: <20200330153016.2959-1-f4bug@amsat.org>
 <CAFEAcA8i1W7ss2hQjaFbVHXzqhV81M8U4Fkaj_Te5JK8JO8+mg@mail.gmail.com>
 <f1fd3384-8653-c2e2-7248-457ae873cc27@redhat.com>
 <CAFEAcA_BJf3k-O4j73kNaPtSHfhqmgtm9LH=nAmNj46kMjbkCA@mail.gmail.com>
 <d5ce42bc-a236-512f-dbbe-7327527419e0@amsat.org>
 <20200531164236.GF3071@jondnuc>
 <CAFEAcA95hfnjBjUT0hCxPUzBnGL9xKDkEjBqDcyVBD6spVZ_4w@mail.gmail.com>
 <20200601072948.GG3071@jondnuc> <87r1uz6pe7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1uz6pe7.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/06/2020, Alex Bennée wrote:
>
>Jon Doron <arilou@gmail.com> writes:
>
>> On 31/05/2020, Peter Maydell wrote:
>>>On Sun, 31 May 2020 at 17:42, Jon Doron <arilou@gmail.com> wrote:
>>>>
>>>> On 31/05/2020, Philippe Mathieu-Daudé wrote:
>>>> >On 3/30/20 6:41 PM, Peter Maydell wrote:
>>>> >> PS: do we have any documentation of this new command ?
>>>> >> ab4752ec8d9 has the implementation but no documentation...
>>>> >
>>>> >Jon, do you have documentation on the Qqemu.PhyMemMode packet?
>>>
>>>> Hi, there is no documentation for this mode, but in general the idea was
>>>> very simple.
>>>>
>>>> I want to have GDB the option to see the physical memory and examine it
>>>> and have this option toggled.
>>>>
>>>> This was useful to me when I was working on nested virtual machine and I
>>>> wanted to examine different states of the VMCS12 and EPTs.
>>>>
>>>> I used this in the following commands:
>>>> // Enable
>>>> maint packet Qqemu.PhyMemMode:1
>>>>
>>>> // Disable
>>>> maint packet Qqemu.PhyMemMode:0
>>>
>>>docs/system/gdb.rst would be the place to document QEMU-specific
>>>extensions to the gdb protocol (there's an "advanced debugging
>>>options" section where we document things like the single-step
>>>stuff you can also change via 'maint packet').
>>>
>>>thanks
>>>-- PMM
>>
>> Thanks, I'll know for next time, when I did all that work and
>> re-factored gdbstub, that doc did not exist.
>
>The documentation existed in our old texinfo docs, however they have
>been recently updated to rst and are now considerably easier to find and
>hack on now.
>
>> Perhaps Peter can just add the documentation to this commit?
>
>Please don't impose extra burden on our overworked maintainer when he's
>already given review feedback. Generally maintainers have more work to
>do than time to do it in so the easiest way to expedite patches with
>features you want added is to send well formed complete patches which
>can be easily merged. Otherwise patches tend to end up deep in a pile of
>"must get around to that when I can".
>
>-- 
>Alex Bennée

No problem, I'll revise a patch to the rst and send it.

Thanks,
-- Jon.

