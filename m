Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F95C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C699B206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/XxvpZ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C699B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joSnr-0001pA-1M
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 10:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joSnB-0001Il-0z; Thu, 25 Jun 2020 10:23:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joSn7-0003pK-BH; Thu, 25 Jun 2020 10:23:52 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so3051244wrw.1;
 Thu, 25 Jun 2020 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DOkuMH0u1JNw/AGyJCehpDnfZQBIqCCQkcaavVv6mic=;
 b=j/XxvpZ0JcMDP4MmUPmzbQGV2FDKWL83D8WHAYYaCvYe/CXdrxqTPbQnHO9nR4ohCO
 +dSo5M3Hb2gwdvzvpGYj2akV8HwG9UkktWJjNdcOy65+Ymk2vUFw4GkD++mZN/RTJb2N
 /PvChqMRmpzZAdobwagEUBXNiHaul0ujKAQUj8CngXwnCd/WqOYBE4zfHB9n4BM8M0SN
 zzDM/6V2hbtQUH2RrivXqt95SJXvPhY1OI9wPJQ+9TNyyE/CHN/lIELCllNenIo3D7rM
 X+LhgUgTfjUhqfPloqnrx0Ux17TLzFs+9tTuTwMvuZaTUHlz/3vzkWGDf9Mfo5Xnkm51
 3UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=DOkuMH0u1JNw/AGyJCehpDnfZQBIqCCQkcaavVv6mic=;
 b=bSUqxRS579/hJebmfu6pPv9qxGYCFBhWvil8nroYOHskVRL4O1eBqj2GIHwHxxVTZC
 Fr1UmQ7gpQmGZ/neFnsZefVXyljqYyg3WJe7n95EFILEMavpIKYtfLPtneGCRRAHkP5Q
 +SRJLaxdltMnPXQwtYbUMEyr24/o5d7T7/1sroT21STYGK6nor7tDFr/F6yJqODfCHyY
 42bYTUs9NyBsV+DFdR0LyB2k/trVI1c16a05sx5HmwPkPM2MPcrtlSNaUWgcCGL6mq6F
 ECsZ1bzyIOGKWkKMsybwvmJkMgc1w6IesNhnu/YRXocjyVt47ZrHyJS7+6c8QJBU5+2N
 /LXg==
X-Gm-Message-State: AOAM532mBfobqDCVV0jC8Zd/a8lkpu9xKm4xnE5w3RX0RTeK8kAi87KS
 TiqLc/jdmbUY2y/F93TkFQY=
X-Google-Smtp-Source: ABdhPJwtV15zsoOH1aNpCl/O2VlJTK5XbsaAq/s7rlxZIlXiJudO40vPsbdXo8J6wedtnwywKyGNQg==
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr39358205wrx.66.1593095026138; 
 Thu, 25 Jun 2020 07:23:46 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id j14sm31716005wrs.75.2020.06.25.07.23.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 07:23:45 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 <877dvv4pmg.fsf@dusky.pond.sub.org>
 <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
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
Message-ID: <03da95ed-399d-53e2-c946-a45f1a771701@amsat.org>
Date: Thu, 25 Jun 2020 16:23:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:12 AM, Philippe Mathieu-Daudé wrote:
> On 6/25/20 8:37 AM, Markus Armbruster wrote:
>> Cédric Le Goater <clg@kaod.org> writes:
>>
>>> On 6/22/20 10:31 AM, Philippe Mathieu-Daudé wrote:
>>>> On 6/22/20 8:27 AM, Cédric Le Goater wrote:
>>>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>>>>>> Add a description field to distinguish between multiple devices.
>>
>> Pardon my lack of imagination: how does this help you with debugging?
> 
> Ah, the patch subject is indeed incorrect, this should be:
> "... for *tracing* purpose" (I use tracing when debugging).
> 
> In the next patch, we use the 'description' property:
> 
> +# pca9552.c
> +pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs
> 0-15 [%s]"
> 
> So when the machine has multiple PCA9552 and guest accesses both,
> we can distinct which one is used. For me having "pca1" / "pca0"
> is easier to follow than the address of the QOM object.
> 
>>
>>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>>
>>>>> Could it be a QOM attribute ? 
>>>>
>>>> What do you call a 'QOM attribute'?
>>>> Is it what qdev properties implement?
>>>> (in this case via DEFINE_PROP_STRING).
>>>
>>> I meant a default Object property, which would apply to all Objects. 
>>
>> Good point.  Many devices have multiple component objects of the same
>> type.
>>
>>> What you did is fine, so :
>>>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>
>>> but, may be, a well defined child name is enough for the purpose.
>>
>> object_get_canonical_path() returns a distinct path for each (component)
>> object.  The path components are the child property names.
>>
>> Properties can have descriptions: object_property_set_description().
> 
> TIL object_property_set_description :>
> 
> Ah, there is no equivalent object_property_get_description(),
> we have to use object_get_canonical_path(). Hmm, not obvious.
> 
>>
>> Sufficient?
> 
> I don't know... This seems a complex way to do something simple...
> This is already a QDEV. Having to use QOM API seems going
> backward, since we have the DEFINE_PROP_STRING() macros available
> in "hw/qdev-properties.h".
> 
> Maybe I'm not seeing the advantages clearly. I'll try later.

The canonical path is not very helpful in trace log...

The description I set matches the hardware definitions
and is easier to follow, see patch #6 (where it is set)
where the description comes from:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg714658.html

  Description name taken from:
  https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

So in this particular case I don't find the canonical pathname
practical (from an hardware debugging perspective).

> 
> Thanks for your review,
> 
> Phil.
> 

