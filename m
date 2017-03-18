Received: from eggs.gnu.org ([2001:4830:134:3::10]:33425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpIHb-0005gl-0k
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpIHa-0000fT-4p
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:36:51 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpIHZ-0000eE-VB
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 13:36:50 -0400
Received: by mail-wr0-x22b.google.com with SMTP id u108so69174529wrb.3
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 10:36:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-j1NSm=_H=V5xJNx=Hv3_P7M+UdVB6gMpL-dS+5NXL1Q@mail.gmail.com>
References: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-j1NSm=_H=V5xJNx=Hv3_P7M+UdVB6gMpL-dS+5NXL1Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 17:36:28 +0000
Message-ID: <CAFEAcA8RHNf-f4iLOJ_i1r+5fAXdaGL4q7fPfzMgSZAf-T2DzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] arm: Fix M profile MSR/MRS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Michael Davidsaver <mdavidsaver@gmail.com>, "patches@linaro.org" <patches@linaro.org>

Last ping for review; otherwise I'll put them into rc1 anyway
since it's fixing a regression.

thanks
-- PMM

On 14 March 2017 at 11:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> Ping for review -- since this is a bugfix it should go
> into 2.9.
>
> thanks
> -- PMM
>
> On 20 February 2017 at 19:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>> This patchseries fixes up some deficiencies and one nasty
>> bug in the M profile MSR/MRS handling.
>>
>> The first three patches are just cleaning up the decode
>> so that we UNDEF where we should in the MRS/MSR space
>> for M profile -- this won't have caused any problems in
>> practice since real world code doesn't generally execute
>> UNDEFfing instructions on purpose.
>>
>> The fourth patch fixes a nasty bug that I introduced in
>> commit 58117c9bb429cd which broke APSR writes via MSR,
>> and brings them into line with the pseudocode by allowing
>> writes to the APSR GE[3:0] bits when the CPU implements
>> the DSP extensions.
>>
>> Alex -- I should have paid closer attention to your review
>> comments on the patch that became commit 58117c9bb429cd;
>> sorry about that. I knew we didn't get the GE[3:0] stuff
>> right yet but I didn't spot that we'd managed to invert
>> the sense of the SYSm bit 2 test in that patch :-(
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (4):
>>   arm: HVC and SMC encodings don't exist for M profile
>>   arm: Don't decode MRS(banked) or MSR(banked) for M profile
>>   arm: Enforce should-be-1 bits in MRS decoding
>>   arm: Fix APSR writes via M profile MSR
>>
>>  target/arm/helper.c    | 26 ++++++++++++++++++++++----
>>  target/arm/translate.c | 26 +++++++++++++++++++++++---
>>  2 files changed, 45 insertions(+), 7 deletions(-)
