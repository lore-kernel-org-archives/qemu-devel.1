Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD58E2083B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bEfxMa3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD58E2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYcg-000110-Jm
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYYJ-0006Vy-JH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:36:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:41889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDYYG-00033S-T5
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599075368;
 bh=LQkW+r9YqgbDytYptSZTLhiBoQBmH6+EiFSjjByiT3g=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=bEfxMa3DgoKv35BUZqRNLJ6ue4r4y82mIjAeBJH5rEkPHyDI1YAxhORcrzdcZeP5C
 xftESOq0oUDzf/fz6lC8y2jOP701tXrhz0YGW6Np3DhASsug/kkG3EfvCuK6khpF3q
 blue9/n9Q99uF0wPzIDdefuKNbVrW5Del0I26NBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.155.63]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1k1MHM1ZSW-00Thdg; Wed, 02
 Sep 2020 21:36:08 +0200
Subject: Re: [PATCH 2/7] hw/hppa: Make number of TLB and BTLB entries
 configurable
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-3-deller@gmx.de>
 <e4627473-3272-59e7-a8b6-0f223e69b198@linaro.org>
 <162b573e-75d1-048b-4413-124e463c0942@gmx.de>
 <9c5f04c8-7312-4af2-c3c1-de8edc877bbb@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <44852d0b-d2cd-749b-5b1e-c3f785144661@gmx.de>
Date: Wed, 2 Sep 2020 21:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9c5f04c8-7312-4af2-c3c1-de8edc877bbb@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/v4BKU7IEYe0XY9QW5uRyuDnzuUM3wYPVpmVo1AiWBIyec72w+i
 SLTEtSQdl6TlcaONxKLv4wAIfyThzorkaMynXkZdWGRvO82zKMy4jJC3zqsj8zmvfuC+fZB
 /YFBK0YfK5rF69wXxcYRSkuqyGTd0dysYac7LFi7GgSLp/Z2hOVlFXp9ArterQm7iZoA8yY
 aFggHU/x817Mpqr+3BjAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kGGdnN6J+8c=:X1Fq4wp7NASplSzmXEWfew
 OEBq69HfxaLyPmqF9lQHEnDrU2G55kFfrH0ZZ7mtspaANTVg+sffw2fbOMv+3W1mUEhQSyGwD
 GdyTS25tvaHpkR0O9TbZj+VYrd9CVqbC7dQ6C7T95lZV8vxHyootl3RTZgQ+Nyom0DLnxzxg+
 AE5CXSJ/6j8EAPTRRk2fVFiUmK/L9eNqlFfOvP02+nmy+mJYtgrL1KSc5z4ekcsZhcoJ7lYvu
 RUUDVDJv6oUop30/08UgXw4v+BE5l3y1zvnZu/4MCOnBs9ND3LeYCXZrOYEiDnl8wPBgFVGXa
 bRLaGnFIx7UmWGV1LZ3puAnMz7CqL42eBzqPvXRN/Lc1kCjzCF2P1/MCAxZ7sPuHFLmQKRLgG
 S62Y/sY5o+tbSvqWREgAFwulqtJjBzDKI1+XtQwcE7h7IFDGfhtm/f2dnhAhOFOjvQnopokko
 3Fvm8vgdRRssOXavwWBsIbQ799GruEkDvIh85PhnzTEq6qkV7iz4XLZY8mCnn5VRfXMUnlUr4
 UtyCKmjpDTFb3mHfYrnybbKtPVF93Md4na3RhKHwpoBouLspNrM0SRv5gH/fURq9CRPG5ddNA
 j+YMg1MTkbWmN4v6vbaCUd1ic9JFOa7x6wNTcra1sCo2wPqeUvGzFOtKr4GBnuKU3a8Ybsp9B
 KAvgP2KZ2PGlytgqXbylkFGsWqzqghA4BAvFobihSJ8Lk1P/09rGGenSmznO7jasVNk8FJ+Ui
 9w6ASHMJSTJSbnJbMUbdXX/WRCGkNCTVyQ25oMXv0r8cgYMludNzdL6BkgSP2FlcSbCVnLbCG
 gnsezXq2I2Eac8jrMvkgmyGoygiCR4pcKQPL/DsVbzqzUhqUNLnjUsqFroCIn/h3F2Gv3KWYZ
 IzsnZ7OMK5ceabvvowVueOE9N4CPWHX6n4QImdthaIELe7/sE8V42RdY2iEwYCCI4ZAFNRgAE
 9Ua5zjeAzEXzy8SL29Bru9ujDsxfGfNePHg8YlHmyncM+iyNo+a/6oJCIBbZKrJNJDXx03IhC
 QETAyftGbFI/Q8FMXLH/mrcZYnQwyHdQUut4Dkey+y6lsLUx+K1e4uZJGUcTC6PVi28x5z6F3
 B4y/IxGW6lY6JlCsgfZP6GdcMYOCApdnqhkw4EIbLAQn8hv1Q1qfFJB5UZr5X8ZEdWaqOhZ2G
 HGK8+PlTPi8KNVSufzAKPnqVznGWaSrSHhhHvTfMzCa09i19AW+25AyP4l2gVqtelMTAtyOtz
 c+VEC/DMpU5cDgE5t
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 15:35:12
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

On 02.09.20 18:52, Richard Henderson wrote:
> On 9/2/20 4:16 AM, Helge Deller wrote:
>>>> +    val =3D cpu_to_le64(HPPA_TLB_ENTRIES);
>>>
>>> I guess you don't have a cpu structure here against which you could ap=
ply
>>> ARRAY_SIZE?
>>
>> You mean to calculate the number of TLB entries based on the static siz=
e
>> of an array, e.g. ARRAY_SIZE(struct CPUHPPAState.tlb[256]) ?
>> I've replaced it intentionally by a constant, because in a follow-up
>> patch to improve the TLB-lookup speed, the array gets replaced by a GTr=
ee.
>
> Ok.
>
>>> The indented defines are weird.
>>
>> How/Why?
>
> Because usually the # is at column 1.

I fixed that up in the last v3 version I just sent.

Helge

