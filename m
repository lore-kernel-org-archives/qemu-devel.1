Received: from eggs.gnu.org ([2001:4830:134:3::10]:56324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGv9-0001G1-LA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGv5-0000ae-4M
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:41:51 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpGv4-0000aK-U3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:41:47 -0400
Received: by mail-wr0-x22e.google.com with SMTP id p14so7953300wrg.3
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:41:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <efef0f71-7ae0-ff62-3b3c-8dabf3007d75@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-15-git-send-email-peter.maydell@linaro.org>
	<f7e28796-d080-f7bb-b283-6f78f404a36e@linaro.org>
	<CAFEAcA9eV2Fq3iAd=rc52UkzCfp7BamJut0AqAbrwBf4-0qOQA@mail.gmail.com>
	<efef0f71-7ae0-ff62-3b3c-8dabf3007d75@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 17:41:25 +0100
Message-ID: <CAFEAcA9R=V+cOwQtQupRr5y77uGsfns4DeTQy5rhcfc=J3g4xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 14/20] target/arm: Make MPU_RNR register
 banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 August 2017 at 17:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/29/2017 09:06 AM, Peter Maydell wrote:
>> On 29 August 2017 at 17:05, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>>>> +        env->pmsav7.rnr[M_REG_NS] = 0;
>>>> +        env->pmsav7.rnr[M_REG_S] = 0;
>>>>          memset(env->pmsav8.mair0, 0, sizeof(env->pmsav8.mair0));
>>>>          memset(env->pmsav8.mair1, 0, sizeof(env->pmsav8.mair1));
>>>
>>> Why some memset and some by-element?
>>
>> Roughly, memset where I would otherwise have to write a
>> for loop (ie where there's more than 2 elements).
>
> There's only 2 elements of mair0 and mair1...

So there are. Let's go with assignments for mair0/mair1 then.

thanks
-- PMM
