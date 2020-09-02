Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F68C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2452720758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="W3GYQi4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2452720758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYi0-0004QN-3q
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYZI-0007jY-Q0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:37:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:36731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYZC-00036G-UQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075426;
 bh=gCtf7zzJnx8jRh4o/2+HZoGhjIDAANmAOc4gPEjtUpE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=W3GYQi4ApBY5trFtyX13JU7oprzMG79IFFIG65dJXNimO3RJX8uAZGv8ab8gZLIY6
 3FIXYDsFNidxDWIgf94BFyi1Jk2FzeL3+JLUAGC3OSTwvnMOEmy9MISD9JR1AkD3wJ
 Lf3UKhRFGsEWKvB1xBi6sWEIISJWtTBhIt9rBp4A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1kKfZ61YyU-00AWuC; Wed, 02
 Sep 2020 21:37:06 +0200
Subject: Re: [PATCH 4/7] hw/hppa: Inform SeaBIOS about fw_cfg port address
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-5-deller@gmx.de>
 <6385bd44-9cf8-95c3-1e59-0e1fb209863f@linaro.org>
 <a56b96b3-9afc-0708-27bf-97d8095bde07@gmx.de>
 <853e1911-81c3-709b-6a9c-b1f7ffd8f826@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <5adfd795-3d82-29e7-c4f8-e4c785233c89@gmx.de>
Date: Wed, 2 Sep 2020 21:37:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <853e1911-81c3-709b-6a9c-b1f7ffd8f826@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ad5PJapcoFRqHqbXcw3XZJRIICYP484zFAK4qkzI0+LAr1g0jym
 HFbO4IVjoeiMdzwotIIo+E9JVG4M3o7lLXs7PsMCRyULCzXlJBj4+oPzkD95GQMUoGPSMGv
 O+JRyNpIlVQ+/grBH4S6YfUVdtO6W2y00i5dYszVOM5lrkcnOBQwEw8lIY2xKQWOnoJ/L9U
 SfYpYCAjCBHMES9ii4UHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UhdeB29tV7Q=:fP6kkS4aUc+w9jU4/gqFCn
 aNUeK6KNHWTWDSuRSMjSxeV1rOMyeEMLfoBEXrJEWyVClMp9+5K/dlQ2G4SFLEznuPYgVhKLG
 IaVWc2B6j3+NrAfUVxVoekjFJDK8XTMIaNSwUOA0beUTSBvb6ag0B4pySfgtVkH7Qs/rVFGIB
 nXaWplW7b7vatVSTz9LAFutM59+jC2RdQJGXsJsZ7bYbej4E1En+f8u3lGejB5Ss0bBuL0Q4e
 PAcui6IJq7/W+Tc3zdJKv4+88QNtQa8LcsM2xhjRLW2L5LqP2eMd2qNTS9Jpt1lBPI++bzKZK
 hibgOcX0ArGo590u81qRu7VPeHzM/F0obtOggH2eiyGwlk5PKZQPXkbqjAK8XXTE+nuHBUp/o
 NjRXCB5OPAA1ogGry5cALgsQmTll+VjPhOnAX9SL7peljZVRJjp9Jei/Zm4q6w2C2pwTCU5/i
 CuB0BI2da1TRdCdCQj8GYT1ItLI42OV1utjO9fOCP/j43okRgJ5hdtjlUa1w0ea9/tKk1Gzvw
 suPPuDg785hWiXqPoV9CWsCTyI1buWe9IGBU6/evHJsQGUg2xsChqdogDZsUJSbwbKZPJEDek
 bOiISaOXH4mgyAZOahSwovnPwUFTP0K2xGud5UpbxhAtyVqXjF0u0GyyDKXufGPIX3O4dSSYB
 HE74acYB8YojXvnpZmPyYAy5hv3mU3bgrJhRJQpgyCpw/9CPaYlVclqUaHrF9MURd9BalYoiT
 Lwv4XgHI2bArX9XCPBU8lzDxrUseOJnq9o5Q4HfFyRTVcxYGrCixYDGq01RepbZGlscgcb78s
 NC5NLQSY3PKKpdT5ru3TDwoQyyN4VtBqQjo8pa+pjZt0O6a03vM6BlS+aLhLb2SqxuNrpPROw
 ZwEityj+ftpWffqjF2VkXu0SDi0xUI8TXwb3jrEGrjnV72nt9E8MWJC7zmaCJhos5s3sLoLyH
 04hWE1P/aQIJTYe1RF1LjwYEIMt62GdS6nyND5HG6VG9ui/Wz0mcWPUCHeMLVhtIy1uc97BOQ
 Q2GACyh77Id96OtIeFDXFB74LymZ/hH9epOAFrIOH9l2Ki6SPHWEXIURSX83MqGw8R4M4h24s
 sJApycu5/VXMIgSh9VsffMS/AT1KYe+LsYTTe6D7w0lXkSYxexvG3hpVaaUMqI5Rm8srRm8ht
 CvgYjUkJPMgcepKE2d6sxcayB/l5icYwIK2YxN4ljk56UFbO7V9C2MaBZIcDVY4P/uEqEe0Cc
 FJk9ox+uv8YQar7BC
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.09.20 18:46, Richard Henderson wrote:
> On 9/2/20 4:24 AM, Helge Deller wrote:
>> On 01.09.20 23:39, Richard Henderson wrote:
>>> On 9/1/20 11:34 AM, Helge Deller wrote:
>>>> -/* QEMU fw_cfg interface port */
>>>> -#define QEMU_FW_CFG_IO_BASE     (MEMORY_HPA + 0x80)
>>>> +#define FW_CFG_IO_BASE  0xfffa0000
>>>
>>> Why is this value changing?
>>
>> Devices on hppa occupy at least 4k starting at the HPA,
>> so MEMORY_HPA+4k is blocked (by Linux) for the memory module.
>> I noticed this when testing the new Linux kernel patch to
>> let the fw_cfg entries show up in Linux under /proc:
>> https://patchwork.kernel.org/patch/11715133/
>> The Linux kernel driver could not allocate the region for fw_cfg.
>> This new base address seems to not conflict.
>
> Then that information should be in a patch description, and the change s=
hould
> be a completely separate patch.

Ok, I've splitted that patch up and added the description in
the last v3 version I just sent.

Helge

