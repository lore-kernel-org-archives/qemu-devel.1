Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4YM-0008S6-B0
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:59:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ea4YI-000731-OB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:59:46 -0500
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:35382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ea4YI-00071p-JI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:59:42 -0500
Received: by mail-pg0-x22f.google.com with SMTP id d6so5146052pgv.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 10:59:42 -0800 (PST)
References: <20171218174552.18871-1-richard.henderson@linaro.org>
	<20171218174552.18871-3-richard.henderson@linaro.org>
	<CAFEAcA9igMy9u0WdTBvJWms1G4Cd2m0QXUucJeXCJ1Uo=7OAMw@mail.gmail.com>
	<300b87dc-7a0c-dda9-058d-674b115d06a1@linaro.org>
	<7bec8c5f-3454-374f-b2e9-f01890e1996b@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c5dec84d-9b22-7f26-49e6-8453ad613f31@linaro.org>
Date: Fri, 12 Jan 2018 10:59:38 -0800
MIME-Version: 1.0
In-Reply-To: <7bec8c5f-3454-374f-b2e9-f01890e1996b@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/23] target/arm: Add SVE decode skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 01/12/2018 08:12 AM, Bastian Koppelmann wrote:
> On 01/11/2018 08:12 PM, Richard Henderson wrote:
>> On 01/11/2018 10:20 AM, Peter Maydell wrote:
>>> On 18 December 2017 at 17:45, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>
>> I didn't want to attempt to generalize this until we have two users.
>> Particularly if we wind up with extra options to the script to change other
>> behavior.
> 
> I might be exactly the second user. I think there is little sense having
> two generator scripts (one for ARM, and one for RISCV). Unfortunately I
> missed the original mail of Richard and can't find it anywhere in my
> mailbox. What is the best way to leave some review comment's for
> Richards patch containing scripts/decodetree.py, since I cannot inline
> it in a mail?

I've halfway done with a conversion of target/hppa/translate.c to decodetree as
well.  PA-RISC decoding is particularly ugly, and I did it with tables the
first time around.

Just send mail with "decodetree.py" in the subject somewhere and remember to CC
me.  FWIW, the original mail is http://patchwork.ozlabs.org/patch/850325/.


r~
