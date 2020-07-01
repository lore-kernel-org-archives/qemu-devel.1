Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C423FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912E82074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCypopbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912E82074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaKg-0000Za-Sw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqaJT-000813-MT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:49:59 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:33028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqaJR-0001mX-Ic
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:49:59 -0400
Received: by mail-ed1-x541.google.com with SMTP id h28so19222318edz.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xp/25ZqMezROryHI2+O1y5qTD9PnXcOWQiXjGdX5B3s=;
 b=tCypopbVrcp+Me9YEFNhlmFJ8ZSXog0zmPw6l5Nhbm8ByEuvu2v0nsLKEbK0+GB0pt
 Y3X8UXDAH94lK4TM1jCdUJrKGZpYfasYPgfUHHvzPFktyiid+MIKb0AFxIUjXuS7zWZv
 R5RzfGi/38Km8yACLjN3BQ+YdZ/scXYPDrjY31cwK+cYsiHkAcRm4JdctO9B0mEK6j9d
 A6CVg2/lWl0kpENkB8DYbPVc+3lZ6RpH7FvehaNjtVQdqcvyl3/H+M0NHun6YndGb46b
 gw6CZG2OlZjeCTkKmwUBcJCurMUgQL/cGj9c50L8NWab+lreqcpPellONq7/yZ/+kdDr
 GyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Xp/25ZqMezROryHI2+O1y5qTD9PnXcOWQiXjGdX5B3s=;
 b=Jub0kjWEyISivWIWAY3AYc4KUxRy7MTQeeh/CN0TeKs348/Tqe+Cu0wEIBtzuazxeb
 BLzSwLYdUSsw5wFGRiL+MuOVlc+pk4+EeerzW/iuhUml8L57qtxYTryxaORaNFIxgTIs
 iIzJfG40Wr3ZQpDKwDSWqN298PpLze52vL1VNxA5yFkjvl1FTgjrcV6mEWvtYIbNkWtT
 Jxw0NYNN8WEuhcgC6QLU0ul0CRj/AHaBu74pO367Y//7ls61I5Cr5BJmagCpJTtfPrA/
 tsN67g0qAYBlnwdxJbYxjGmG/lYBISP7H4C9sV4KI9cgmN+3fMmh3XbXcSONJuaIPFLV
 3uiA==
X-Gm-Message-State: AOAM531ZfajiRLkcv/eYfVno8suukkBMzAwUS+OJQsHfwfdo3j3Ut8QS
 Hwa/xuqcSnvI9XqVJeq7iYl/ozd3jVI=
X-Google-Smtp-Source: ABdhPJzFYdW6H390Vb/gBOzHGlCfPy+80IB19z7882lZNGpZbRPbi2jLmo3FnR9vlDt1Z6tcnZ3HnA==
X-Received: by 2002:a50:ec8f:: with SMTP id e15mr27570606edr.70.1593600595717; 
 Wed, 01 Jul 2020 03:49:55 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id se16sm4290931ejb.93.2020.07.01.03.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 03:49:55 -0700 (PDT)
Subject: Re: [PULL 6/6] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1593287503-25197-7-git-send-email-aleksandar.qemu.devel@gmail.com>
 <97eb7447-0453-2e2c-4003-a4de338ee11f@amsat.org>
 <CAHiYmc5XoQyCqVxNnWJ70HQPsD=RzTEFZ_aNn4KR+u2nDENZkA@mail.gmail.com>
 <b24fbc43-9979-5db2-ff17-64fb3afd572b@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <dd2a402a-6a38-c38a-c21b-8e383ad9e57d@amsat.org>
Date: Wed, 1 Jul 2020 12:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <b24fbc43-9979-5db2-ff17-64fb3afd572b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 12:32 PM, Philippe Mathieu-Daudé wrote:
> On 6/29/20 12:28 PM, Aleksandar Markovic wrote:
>> понедељак, 29. јун 2020., Philippe Mathieu-Daudé <f4bug@amsat.org
>> <mailto:f4bug@amsat.org>> је написао/ла:
>>
>>     On 6/27/20 9:51 PM, Aleksandar Markovic wrote:
>>     > This commit creates a new 'Miscellaneous' section which hosts a new
>>     > 'Performance Tools and Tests' subsection. This subsection will contain
>>     > the the performance scripts and benchmarks written as a part of the
>>     > 'TCG Continuous Benchmarking' project. Also, it will be a placeholder
>>     > for follow-ups to this project, if any.
>>     >
>>     > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>>     <mailto:ahmedkhaledkaraman@gmail.com>>
>>     > Reviewed-by: Alex Bennée <alex.bennee@linaro.org
>>     <mailto:alex.bennee@linaro.org>>
>>     > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com
>>     <mailto:aleksandar.qemu.devel@gmail.com>>
>>     > Signed-off-by: Aleksandar Markovic
>>     <aleksandar.qemu.devel@gmail.com
>>     <mailto:aleksandar.qemu.devel@gmail.com>>
>>     > Message-Id: <20200626164546.22102-4-ahmedkhaledkaraman@gmail.com
>>     <mailto:20200626164546.22102-4-ahmedkhaledkaraman@gmail.com>>
>>     > ---
>>     >  MAINTAINERS | 10 ++++++++--
>>     >  1 file changed, 8 insertions(+), 2 deletions(-)
>>     >
>>     > diff --git a/MAINTAINERS b/MAINTAINERS
>>     > index fe925ea..dec252f 100644
>>     > --- a/MAINTAINERS
>>     > +++ b/MAINTAINERS
>>     > @@ -1096,11 +1096,10 @@ F: hw/isa/vt82c686.c
>>     >  F: hw/pci-host/bonito.c
>>     >  F: include/hw/isa/vt82c686.h
>>     > 
>>     > -Loongson-3 Virtual Platform
>>     > +Loongson-3 virtual platforms
>>     >  M: Huacai Chen <chenhc@lemote.com <mailto:chenhc@lemote.com>>
>>     >  R: Jiaxun Yang <jiaxun.yang@flygoat.com
>>     <mailto:jiaxun.yang@flygoat.com>>
>>     >  S: Maintained
>>     > -F: hw/mips/loongson3_virt.c
>>
>>     Ah, now I see, here you unlist the uncommited file.
>>
>>
>> This file/machine, for multiple reasons, will not be accepted in 5.1.
> 
> Ah, so that confirms we have to revert commit c012e0b1f9 ("hw/intc: Add
> Loongson LIOINTC support"). Can you send a patch please?
> 
>> The end user will not be able to see, let alone use the machine in
>> question in 5.1. This is on purpose.
>>
>> This will give enough development time to Huacai to implement missing
>> bits and pieces, and to possibly improve the whole idea during 5.2
>> development cycle.
> 
> Sounds reasonable.
> 
>>
>> Even though the support that Huacai introduced in 5.1 is, for many
>> reasons, not completed, and even though Huacai and I had at times
>> opposing views and fierce discussions and disagreements - I salute and
>> support his work, and consider it, by far, the best and the most
>> important contribution to QEMU for MIPS in years.
>>
>>  
>>
>>     It might be easier to manage sending 2 different pull requests,
>>     on for MIPS and one for the performance tools.
>>
>>     >  F: hw/intc/loongson_liointc.c
>>     > 
>>     >  Boston
>>     > @@ -3026,3 +3025,10 @@ M: Peter Maydell <peter.maydell@linaro.org
>>     <mailto:peter.maydell@linaro.org>>
>>     >  S: Maintained
>>     >  F: docs/conf.py
>>     >  F: docs/*/conf.py
>>     > +
>>     > +Miscellaneous
>>     > +-------------
>>     > +Performance Tools and Tests
>>     > +M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com
>>     <mailto:ahmedkhaledkaraman@gmail.com>>
>>
>>     Aleksandar, don't you want to be listed here with Ahmed?
>>
>>
>> Of course not. The project is student's. The mentor just helps and leads
>> the student. The fruits of the project belong to the community and to
>> the student - and not to the mentor.
>>
>> If you were the mentor, my impression is that you would leave your name
>> in MAINTAINERS whenever you see the slightest opportunity (I remember an
>> occasion where you were saying "I worked six hours on this" and then
>> proposing yourself as the maitainer for a particular segment (??)).
> 
> '??' means you are not sure? Please link reference to discussions.
> I volunteered to help maintaining areas when nobody were doing anything,
> if that forces others to step in because they are more qualified, I'm
> glad I did it. See for example the Renesas ports have qualified
> maintainers!
> 
>> I
>> don't have such approach, and I oppose your approach, and I appeal to
>> you to control your apetite for maintainership.

Now I understand your comment here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg711448.html

"I guess it is just a matter of time Philippe would ask for SPARC
 maintainership. Mark, would you perhaps accept Philippe as a
 co-maintainer?"

It was not ironic, it was a trap. I already asked you why you keep
tracking my contributions, trying to demotivate me. Is this personal?

> 
> I am not looking for more maintenance, I'm looking to cover abandonned
> areas I use. I have been taught by the do-ocracy principle. I'v not been
> dropped in as replacement for someone else position, only trying to keep
> things unmodified, scared a minimal change would break.
> 
>>
>> Regards,
>> Aleksandar
>>
>>  
>>
>>     > +S: Maintained
>>     > +F: scripts/performance/
>>     >
>>
> 

