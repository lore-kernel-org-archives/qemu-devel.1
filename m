Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C21CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120EB20795
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smXX1+K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120EB20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGH97-0000Xr-2w
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGH8R-0008WR-R7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:36:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGH8M-000694-Q7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:36:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id a17so5541358wrn.6
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=06zSaGCWAaHSHk7CYbFzhnO7Xdx8sijG/ug5g6qGTpk=;
 b=smXX1+K3bMdUPkPkzn3GPYGqHpuKWUXvBeDmchPUUOGkRErGLZDzUtnwTPFGd7oB/S
 +D26RNLxXP0C9dII3+o1yY7RDKuYW+BnukZmOfp9mZWSKtzAGyMe3+96M7OIYHCBGzcS
 N5HitELEbT3X1u7TcqjH0+hMKkhzjz1qN/zQhLbKvX6QWFYsVUy1+JldzzpqZkde/wsr
 qLknFwmTG72fu5eMNzeS+ktE87kAIbm7G/95Uqcrb7IRKPKx1IV3EjZj6jaBtStrARjO
 a0b5T/mQEFKRDaeEUTmYuPqzqyaJI87VS1voAjzSuKl0VdPTKvaqAfoIXWYg10ul3qAy
 PpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=06zSaGCWAaHSHk7CYbFzhnO7Xdx8sijG/ug5g6qGTpk=;
 b=hxXr/zouLEJSUh4XO90xTwZJrvH7Rtl/1UAKhyjO2OBQVnDgz8ZSHXnKpayj2iY4Eo
 6Ibs7hyGv5VfNTYIwcZESEIJwQrB5779+6um1Hz1cX45zDtiJT1kS84N0kQDcKPTGRoS
 EIvrWK3CmhyqEgI5xGWHgF+KL/9Aog9xyfQ4f5dMWNeoLoc6DytxI+OOvdhtyLqGHar1
 0TyxToW8rCYa/x2XbfYZSEUY1kF3DgsF9I4NbcXjKictziktNhROAPCkC5PsfJ6goDKo
 T9GAOB1rozoPPJMA2i9XyMuQCGMcmPrG6/hOInSwobuUaZFRHBU8k01nq2pK67Wmti+Z
 eoUw==
X-Gm-Message-State: AOAM532F9s4NkUL1CCipnQSgce9Hyefmrq9uHbgYOlWDHeadX9oqX41l
 aPk20xPxv+53EpaajHP+WK0=
X-Google-Smtp-Source: ABdhPJwv3Xejrty0H8d1sVpbCdmfCO+TMeKgafDQNqr76jZkRR+aYdoVprA/8I5CqrKgu0QTouKbew==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr7615809wrp.370.1599723400724; 
 Thu, 10 Sep 2020 00:36:40 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id f6sm2808559wme.32.2020.09.10.00.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 00:36:39 -0700 (PDT)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <20191125104103.28962-1-philmd@redhat.com>
 <691a359f-f923-5e2d-6beb-2f9c0a0aca8c@redhat.com>
 <BN6PR2201MB1251317E014311162EDA9507C6500@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <5251201a-fa2c-bb55-01f1-863377b0f2cd@amsat.org>
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
Message-ID: <011d278b-4c94-d227-a4d4-703b968a1c03@amsat.org>
Date: Thu, 10 Sep 2020 09:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5251201a-fa2c-bb55-01f1-863377b0f2cd@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 6:57 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 12/17/19 7:43 PM, Aleksandar Markovic wrote:
>> From: Thomas Huth <thuth@redhat.com>
>> Sent: Tuesday, December 17, 2019 7:10 PM
>> To: Philippe Mathieu-Daudé; qemu-devel@nongnu.org
>> Cc: libvir-list@redhat.com; Hervé Poussineau; Aleksandar Markovic; Aleksandar Rikalo; Aurelien Jarno
>> Subject: [EXTERNAL]Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
>>
>>  Hi,
>>
>> On 25/11/2019 11.41, Philippe Mathieu-Daudé wrote:
>>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>>> index 4b4b7425ac..05265b43c8 100644
>>>> --- a/qemu-deprecated.texi
>>>> +++ b/qemu-deprecated.texi
>>>> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
>>>>
>>>>  @section System emulator machines
>>>>
>>>> +@subsection mips r4k platform (since 4.2)
>>>
>>> Since the patch has now been merged after the release of 4.2, the mips
>>> 4k platform will be deprecated in 5.0 instead. Could you send a patch to
>>> fix it up?
>>
>> OK, I'll send a patch that'll certainly be applied to the next MIPS queue.
>>
>> Thanks for spotting this, Thomas.
>>
>> Aleksandar
> 
> Any update on this?

Thomas told me this has been already merged as commit 2048d5d4bce
("target/mips: Rectify documentation on deprecating MIPS r4k machine").

I'm sorry I missed it.

> 
> Thanks,
> 
> Phil.
> 

