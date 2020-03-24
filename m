Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB945C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C4D208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C4D208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjVw-0006eW-Qr
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jGjV5-0005hi-QN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jGjV3-000282-Mf
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:21:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jGjV1-00027K-6q; Tue, 24 Mar 2020 09:21:43 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M6UuX-1jAPpY1SFF-006uvj; Tue, 24 Mar 2020 14:21:29 +0100
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20200324082235.27980-1-kuhn.chenqun@huawei.com>
 <20200324082235.27980-4-kuhn.chenqun@huawei.com>
 <b1e4dbf2-842a-dedd-819e-4f2b272dcfb9@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B6BF788@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant statement
 in exynos4210_mct_write()
Message-ID: <5de513c0-9b32-3a5f-ad63-06e4ce342693@vivier.eu>
Date: Tue, 24 Mar 2020 14:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B6BF788@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jB7J043Nhz0VqMFaNUgMqZG7Cy95R4E8YubhOpp67uyfr9CkRs5
 bpwSYiIHz8/khMPigEob0Ko8xKtOhcLZiYrriQIizKghbbkCzHmslCcllJiuGXDAseEoFWy
 r5XPNxVchHotnTrrbWcwHnCve0tdNtCuWszyDccnbldNPo33ZJ1pQjgv7sCxMnjPIkKVLv9
 IPTbFqkKYOzlB+10qOF6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zj17ohsPvdw=:368tUY0eTzczKQtBtZYGAX
 URBUs4IfGcQ3YrZlsG/l9sFDWiY6lFdcydkm99NV69Y9yrxbiA0mUP3duUq7K0b0BfnYfr/dN
 3XKvX2o7YhN3YZax3kin/NQ0k7drQvu+tmmykEymDh/ORzTUMCYKtLgPLWj8OrmZAlCWmpKh+
 Bx+hwnnf8w1VfjzFSbH/vlbsDKnphp2SS2e4jdI+gKj2L0hKj+QSKWi9kVLu8XVZHxwJr8fUd
 uxAmlmt7EgQ16MsdPsicaJN3tVi8Ekh74OskYGJim9EQj811InAH48gfJ3sselqR0L2aCbY8q
 UHfgpobfoRJg6MFOHi80aYt1i7LCh/r8VrBEyn0uw508iOid0xjP+Qyrrmq6HbJQEVRpRnuC4
 NRIaB2GffeWOwGwPiUE+gkejYFfPq3dyZ7pG0H4jZxcYNoVeKJpaLZagrEMXy/C1StVclygUE
 6hR3D9Zz5PIJ+A5zLjcQoCUvizaaMvnrJugYYEylWHZOKUo4pPXuiAo6G/iGcWbk6IGlrqzEf
 gUW32DyR6vdMsyc3zHsdI3D0GTR66wqEAD0fNSYa7PZd7KeUouOBgRKmpyquoW6juc5Jt0+dX
 9QAstgIdE6a9hvLkZcOTpOlbexo0GMJckF1F9YoTkqFevP7XWkQ9I1Za1/xTHfomFFLeyHW8G
 N8ERXmkyuf2VkbiEczWtOyBRI48c0laZIsHpihVu5ltnuxEy5vhVUpL5BvxMAr8GNKce4Rwe1
 HjVwt/AKAIzwraIo8SYa0l6Sj4G86eFJuIwHMJ6kU2UhkYGcLxDhZ3AK3Cb48qUynfND1QTzj
 KlB278JzzscywoZUPK7ly/x6pkZYr2aEVVbC6Un7+8mLsYLucKmSsNKau0IpQQjeXztpWap
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 24/03/2020 à 13:22, Chenqun (kuhn) a écrit :
>> -----Original Message-----
>> From: Laurent Vivier [mailto:laurent@vivier.eu]
>> Sent: Tuesday, March 24, 2020 6:59 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>> qemu-trivial@nongnu.org
>> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; philmd@redhat.com;
>> Euler Robot <euler.robot@huawei.com>; Igor Mitsyanko
>> <i.mitsyanko@gmail.com>; Peter Maydell <peter.maydell@linaro.org>
>> Subject: Re: [PATCH v4 3/3] timer/exynos4210_mct: Remove redundant
>> statement in exynos4210_mct_write()
>>
>> Le 24/03/2020 à 09:22, Chen Qun a écrit :
>>> Clang static code analyzer show warning:
>>> hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is never
>> read
>>>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>>>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is never
>> read
>>>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>>>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is never
>> read
>>>         index = GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>>>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> It would be interesting to understand why we need the index for these registers
>> in exynos4210_mct_read() and not in exynos4210_mct_write().
>>
> I think the index can also be used in exynos4210_mct_write(), but the original author used a more obvious reg name instead of it.
> 
> The obvious reg name:
> case L0_TCNTB: case L1_TCNTB:
>            reg name is :  L_REG_CNT_TCNTB 
> 
> case L0_ICNTB: case L1_ICNTB:
>            reg name is :   L_REG_CNT_ICNTB
> 
> case L0_FRCNTB: case L1_FRCNTB:
>            reg name is :   L_REG_CNT_FRCCNTB
>

Yes, you're right.

Computed index gives the value used with s->l_timer[lt_i].reg.cnt[].

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks,
Laurent


