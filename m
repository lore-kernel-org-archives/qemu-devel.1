Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D203C352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2608420733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 12:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2608420733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17pa-00043E-8I
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 07:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j17oo-0003eF-DA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j17on-00033J-48
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:05:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:41305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j17om-00032M-RS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 07:05:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M2fM1-1j4hhr1Vdf-0049RU; Mon, 10 Feb 2020 13:00:20 +0100
Subject: Re: [PULL 2/4] q800: add a block backend to the PRAM
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200107132715.722101-1-laurent@vivier.eu>
 <20200107132715.722101-3-laurent@vivier.eu>
 <CAFEAcA9pizjyZbNB1mhUTn40nRpzHw=GLMWRtYhra5G-ijDmSA@mail.gmail.com>
 <CAFEAcA_FZKgyJzKxX-Tvbsu1qZpqD58k+OpJr_YrY8_oUbBttg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bb55b22b-3a38-bd19-1926-53c00ac46ade@vivier.eu>
Date: Mon, 10 Feb 2020 13:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_FZKgyJzKxX-Tvbsu1qZpqD58k+OpJr_YrY8_oUbBttg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nt47DeHic3uiteVRub6YiDWiRqG7HO8MYLHt1TQSlKBMAS4jjFg
 U9TOsK5v9q2s39Y6/b5Tbxbw923fLtaO6Rrj6MXyDHgfPskQVzqaH4FPct1mS115brQd4yS
 3Ru92IvVeRXlYDbY1FB/J+G/KRvWk2JH7AiKv3uIAUxkzWWyjymBCbn2gkx5b9BmxwImHaF
 qF1hX6zvsUMaDP/XYuB7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dWu7JXdeMmY=:+hwQrldMCrhzDIEP+6bZ7/
 934/9F76AEV5+KoYavPK+UaOsAHM0wTc0MHWKvCovMCejwCz5K3PY91kJITI1SSGHpSgADReN
 a3QBjrp74S49WbuH88pvQ+9hjgcljNnlGRMz6s2UWWhlav2NJ8/vTqqza/YscGph2usUh9C/Q
 jOd7tU/sZ10pDUqnd9I2MWtzdK7rn76uVhyJsdUYo7idF1AIpney77y+U+O17WaavP+rqHkV0
 kVorQ1V91cjaBvT5z3CuAa8XcDoLGJnTxDXmenvvV/HhhiGjUtD2ifI10u99YkuSMUJIMcx2J
 1qRiSV4VmdBdkBhC1aogRx2IcWnlhgiRaNCiqHLIqVwL18h093cLWczq8CZghqdhB4wWS/kvI
 fL+68GyzXTvrZWsd+su4sSbQfdQRyCXIDqAY5OfQucZ5V1On0lFB0NsNVV+sLOJ3kmywwUak/
 nSbSjzWZg757kg6pMckRadyNaBvXJNFEmfBAWSZpvARkUD1gUkl3Ebe+D3mds05IqK1aJZ1tu
 qk/zkq9XETDqlDBzsEfr/uMqc85G1tPqZcY4v9qstmL0MCnZOXKhdVvrKSLKOoU5V3DsqFmqa
 jd1SYE2TJaj6mFlKMteYi7JeIPcL0uteuSsrZpnF4T7+JepURsRvFGjyEKYYmN63B8eGcFLOf
 Gi6WBf/b4jRXNAoH+hnm3JiK/BAkjbtNsKSW+ZtzTSfk0qWqZfN7XWQZ+XOSkxPgIk15dC+tC
 ZoJDXoFufXPMJaGz93Gefoolo3KefYxfYnYRaXD+ezzTGIJYWwKyWREha2ajJyQp76ivZ1DHW
 IqxS7ZmA23QUi/mjf7l+QASXWYT8N8VxqJMtS+pTg15rxaUODoDsiBpIas04Ak9Ud4TXyb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/02/2020 à 12:51, Peter Maydell a écrit :
> On Fri, 24 Jan 2020 at 12:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Tue, 7 Jan 2020 at 14:40, Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> This allows to save and restore the content of the PRAM.
>>> It may be useful if we want to check the configuration or to change it.
>>>
>>> The backend is added using mtd interface, for instance:
>>>
>>>     ... -drive file=pram.img,format=raw,if=mtd ...
>>>
>>> where pram.img is the file where the data will be stored, its size must
>>> be 256 bytes.
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> Message-Id: <20191219201439.84804-3-laurent@vivier.eu>
>>> +static void pram_update(MacVIAState *m)
>>> +{
>>> +    if (m->blk) {
>>> +        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
>>> +                   sizeof(m->mos6522_via1.PRAM), 0);
>>> +    }
>>> +}
>>
>> Hi -- Coverity warns (CID 1412799) that this isn't checking
>> the return value from blk_pwrite().
> 
> Ping -- what should we do about this Coverity issue ?

Sorry, I didn't see your first mail.

I have a look.

Thanks,
Laurent


