Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6CC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016F821D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016F821D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bOx-0003mt-3c
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7bO3-0002sQ-TR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7bO2-0004RB-UA
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:20:31 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:40149)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7bO2-0004Q9-LZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:20:30 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlfCk-1iXckK3lCM-00ikc4; Tue, 10 Sep 2019 10:20:27 +0200
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190822185929.16891-1-richard.henderson@linaro.org>
 <CAFEAcA9=kx70rzbM_o98s-LEMcq2CRH5zwDPq4LForzyCAvoMg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b14721f8-8db1-f537-6d1c-abae7c18d786@vivier.eu>
Date: Tue, 10 Sep 2019 10:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9=kx70rzbM_o98s-LEMcq2CRH5zwDPq4LForzyCAvoMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SLl+yhPZVqkT2ta0Gn/djcFgbdXAVG7DWeJInoX06beTm4G3Sxu
 4HAxOH8T3OUmOELLEhpYDmkZ3+h4/SQ8w2XevQcVnFeR+jTQgg+P9d9lgejrUjJgKPsnKkm
 93NObHWnuJQ8w9zhUbMCESDOaBIylKv/7CXcd/3+IWs2ISzCumIyU5DFuKF1NFvBcqVyk3M
 Af+cbIUEE3Nwfayper1Ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zjMcN3PvFwY=:m7Z8I05dy0rYgK4AWjA3jf
 7K/zncD/d6ztQ07C5YS7tQ0DvRO8QOsbUJSwZMoUYPDwAosXv4mnzT7LxPPR5bulj0PavTJVr
 4XypbVVP1vhf+butKYJ0TtLioPTxp6/1E/RsFpcmIy5rRSv3BB39mKz1uojB2+QzgagkOYrdT
 iPycfrtkIKv/oDr+IogwEqwnLoEMH+RIyQpPBKTS7YD7igGqo9JOy+JYj71Bz100Zu8+Zt3gX
 0CdwNCFBlZV0bWWdIV/EqJ7FJC9sw2HGeaM8GZAOtr+B5tC0/y2fKauSc7D/ky/Nl9+EBR6dM
 qJgidWv3HKp7gujB1BOOb/18mXJn+/x6NlxqQ8ra0K67lApP/zTiE9xd31wzORMUB+fQ6yR4E
 atdt8K1U+Y46MqAtgZf9SDXSu6cVX3Tgp+RzvgO7bcf85YGdsNXIcJV3dauW/barnpBqACAap
 tRt0+f72guWtyD33wllUTALQkNMhi2nydPQRyrn0ymY2U8j6D7q4rTtLKYMynErBHJu3qwTNu
 fYBzZDShpxAhXchNeacAKc9yKdPRl2SgGWURdQDWK8KOt7BNnVid+y0c7JGjtewa0GX8od+CY
 j14LWf8YgZtKg/1W4lq1SzJt/vHiVnqcLwYVsLsEA8weA3aKvicieRoSulSKjLdWxCc3sif7C
 HNPH0fJp5DBNavZxchW2Z5ci2uaSbzfduiiDfoMxwI9pmqk2q+X/h1NmQ6j8ncRh2vJhkXJCe
 rq/a2Vo479TBpsZdXETvVXXmpOAmQC0B/olDL6aCjEd4JVHe4OH5GnfBvgBPcoBF9sY0Knbrp
 Y/PEqmi277cc7PhEoxw1ufXRuOXmLkSp7SHxpT7Y2PAMoUiZrE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user/arm: Adjust MAX_RESERVED_VA
 for M-profile
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

Le 03/09/2019 à 15:35, Peter Maydell a écrit :
> On Thu, 22 Aug 2019 at 19:59, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This is inspired by the discussion in
>>
>>    https://bugs.launchpad.net/qemu/+bug/1840922
>>
>> Previously I suggested a new CPUClass hook, but when I went
>> to implement that seemed like overkill.
>>
>>
>> r~
>>
>>
>> Richard Henderson (2):
>>   linux-user: Pass CPUState to MAX_RESERVED_VA
>>   linux-user/arm: Adjust MAX_RESERVED_VA for M-profile
>>
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Both applied to my linux-user branch.

Thanks,
Laurent


