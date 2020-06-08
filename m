Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B73C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88246206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+uM3gyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88246206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiJaf-0000rH-Mj
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiJZe-0000BJ-Om; Mon, 08 Jun 2020 11:20:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiJZd-0007qo-KS; Mon, 08 Jun 2020 11:20:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id g10so15710619wmh.4;
 Mon, 08 Jun 2020 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K3m9FTYd02yNNr/jFG5PbwI3xA4ItGt31NqWxJ0DS/Y=;
 b=U+uM3gyIiI+PXyIBnlgM8J/E9zxp1rlZ83tT5cHLPhhl6Bz/VeCVuKE2ZwGidpkUzE
 0PKZmmfdQ2kza7xZOL9Mkj9GXn1s5A1+24RhROX8Ok5e9U8NyzzPgQB99XWFkc7Lv5Ja
 1bFnmtsyRFOJwXed9gQHMVXL2SpwmOksCG88oD5vAe1K1d42zGiNfOifeeLiP2x/7t8D
 HV6j9f4BT9hhiPXS4VckfCQTOrUvc7mkGVu5YUElp6Zq2U2jZJ0RdFXdULSBTWIBt4CO
 FZJQlh2lAi8JWHosuxgslRAzb8a5+N9jGzkTRqk3j/k8SUvYQFicsNhvVIVM7GDgLmSW
 30ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=K3m9FTYd02yNNr/jFG5PbwI3xA4ItGt31NqWxJ0DS/Y=;
 b=ncxeDxIJ6uQQUdsdPPipYbIzcS180YF+LJbv84ZViueMYCK1SM1r/EChRgF9r7RJLZ
 YSn2tRa5CPzR5I8wSAwfqnNWenOapNB/UvDNQi2JRG61khXsmP9BWCWyY1puuJoIsm7o
 8iHWnAFlrDftjWePnk4HZmYA1vEGKCFbCqQDQ9FVVGNi48HN8/ywepcUsMJIVTSIYHOY
 SGACtzIpM3Qzz5xcF502Ju2eVK9BmLIcLyZ/kICAM6QfSXD/zm+2J37YitW4oT5Q+s7D
 04Tl56xzR81QM520u51cKf7pq3PDH6CObZ4N7X2e6qdL2LugeXWnAbk7wEDYUHhAP2oq
 WHeQ==
X-Gm-Message-State: AOAM532dFhF64UpUthQ8cmGoD4M5ISTY9P14X/Kgz0fJIiI69lujS7vs
 LT++RrB8/WvIGz4u2xQFjvk=
X-Google-Smtp-Source: ABdhPJwqtgQPGVEo4qgWag43FsmuGnOYhMN+IEijIZSt7fc4CReJSEn4y4dXV7m/OIfAsFFp2ZhO8g==
X-Received: by 2002:a7b:c0c5:: with SMTP id s5mr15881891wmh.166.1591629627349; 
 Mon, 08 Jun 2020 08:20:27 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v28sm34707wra.77.2020.06.08.08.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 08:20:26 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
 <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
 <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
 <23588fda-b95b-45a9-b788-e846d26a3bc3@amsat.org>
 <7f673b61-7565-f79a-0ec6-043c44d1df77@amsat.org>
 <08b73f34-4cab-1133-e5e5-5b1e9fc7b5d0@adacore.com>
 <344c9260-e448-feea-3b37-7860dd09cd8a@amsat.org>
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
Message-ID: <56e92e1c-6f89-5359-53bc-57c529743d5e@amsat.org>
Date: Mon, 8 Jun 2020 17:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <344c9260-e448-feea-3b37-7860dd09cd8a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fred Konrad <konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 11:50 AM, Philippe Mathieu-Daudé wrote:
> On 5/25/20 1:02 PM, Fred Konrad wrote:
>> Sorry Philippe I missed that.
>>
>> Would be happy to do a PR if needed but:
>>   * I never did that.
>>   * Looking at https://wiki.qemu.org/Contribute/SubmitAPullRequest, I
>> don't have
>>     the signed GPG key either.
> 
> Thanks Fred for following this series.
> 
> I am not insisting for you to do the pull request, I was waiting for
> Artyom (sparc32) and Mark (sparc64) who usually handle the pull requests.
> 
> Artyom seems busy lately.

Artyom, if you agree I can send a pullreq with this series and the
empty_slot one.

> 
> Mark, do you plan to send a hw/sparc* pull request soon? Do you prefer I
> ask to trivial@ for this series?
> 
> FYI there is another sparc32 candidate patch:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg701850.html
> 
> Regards,
> 
> Phil.
> 
>>
>> Cheers,
>> Fred
>>
>> Le 5/23/20 à 7:26 PM, Philippe Mathieu-Daudé a écrit :
>>> ping?
>>>
>>> On 5/11/20 9:03 AM, Philippe Mathieu-Daudé wrote:
>>>> On 4/14/20 12:00 PM, KONRAD Frederic wrote:
>>>>> Le 4/13/20 à 11:07 PM, Philippe Mathieu-Daudé a écrit :
>>>>>> [Cc'ing Peter]
>>>>>>
>>>>>> On 4/13/20 12:12 PM, KONRAD Frederic wrote:
>>>>>>> Le 4/11/20 à 7:30 PM, Philippe Mathieu-Daudé a écrit :
>>>>>>>> On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>>>>>>>>> Philippe Mathieu-Daudé (7):
>>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>>>>>>>>        registers
>>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>>>>>>>
>>>>>>>> Ping ^^^ for 5.0?
>>>>>>>
>>>>>>> Hi Philippe,
>>>>>>>
>>>>>>> You already have my rb tag for those one, and IMHO they should be
>>>>>>> good
>>>>>>> candidate
>>>>>>> for 5.0 (if it's not too late).
>>>>>>
>>>>>> Yes, thanks for the reviews. I see Mark Cave-Ayland merged this file
>>>>>> first, but you are listed as maintainer :) I was hoping you could
>>>>>> send a
>>>>>> pull request.
>>>>>
>>>>> Yes that's usually Mark who take the patches, sorry I didn't get it.
>>>>
>>>> No worries. As there are other sparc64 patches on the list, maybe Mark
>>>> will prepare a pull request now.
>>>>
>>>>>
>>>>>>
>>>>>> $ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
>>>>>> Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>>>>>> KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
>>>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>>>
>>>>>
>>>>>> This is a bug but not 'security critical', so it might wait 5.1 and go
>>>>>> via qemu-trivial tree.
>>>>>
>>>>> Well let's do that then if you're ok.
>>>>
>>>> OK, then ping? :)
>>>>
>>>>>
>>>>> Best Regards,
>>>>> Fred
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>>
>>>>>> Phil.
>>>>>>
>>>>>>>
>>>>>>> Cheers,
>>>>>>> Fred
>>>>>>>
>>>>>>>>
>>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>>>>>>>>      hw/timer/grlib_gptimer: Display frequency in decimal
>>>>>>>>>      target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>>>>>>>>      target/sparc/int32_helper: Extract and use excp_name_str()
>>>>>>>>>
>>>>>>>>>     hw/misc/grlib_ahb_apb_pnp.c             | 24
>>>>>>>>> ++++++++++++++++++++++--
>>>>>>>>>     target/sparc/int32_helper.c             | 23
>>>>>>>>> ++++++++++++-----------
>>>>>>>>>     hw/misc/trace-events                    |  4 ++++
>>>>>>>>>     hw/timer/trace-events                   |  2 +-
>>>>>>>>>     tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>>>>>>>>     5 files changed, 43 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>
>>>>>
>>>>
>>
> 

