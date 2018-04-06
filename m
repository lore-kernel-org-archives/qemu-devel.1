Received: from eggs.gnu.org ([2001:4830:134:3::10]:55044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Fgj-0008SV-9v
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4Fgi-0006Da-AY
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:57:09 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4Fgi-0006Cs-3O
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 20:57:08 -0400
Received: by mail-pl0-x241.google.com with SMTP id 59-v6so18923837plc.13
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 17:57:07 -0700 (PDT)
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
	<20180404164908.GA7582@flamenco>
	<330b4559-52a5-50d6-3a85-da7bb0850107@linaro.org>
	<0f10b5a5-2be0-4b6b-3c58-e718a062f07d@linaro.org>
	<84a25fa4-d1a6-0e9c-a28f-770baeff0ce4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ea63966-1599-5bdd-3a31-d4a644c7bec1@linaro.org>
Date: Fri, 6 Apr 2018 10:56:58 +1000
MIME-Version: 1.0
In-Reply-To: <84a25fa4-d1a6-0e9c-a28f-770baeff0ce4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure
 for aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Emilio G. Cota" <cota@braap.org>
Cc: peter.maydell@linaro.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 04/05/2018 03:06 PM, Thomas Huth wrote:
> On 05.04.2018 02:54, Richard Henderson wrote:
>> On 04/05/2018 10:07 AM, Richard Henderson wrote:
>>> On 04/05/2018 02:49 AM, Emilio G. Cota wrote:
>>>> 1. grab this binary:
>>>>   http://cs.columbia.edu/~cota/qemu/nbench-aarch64
>>>> 2. run it on a PowerPC host with:
>>>>   $ aarch64-linux-user/qemu-aarch64 nbench-aarch64 -V
>>>>
>>>> Note: the "-V" (or "-v") flag is important! Without it, there's no segfault.
>>>
>>> How quickly?  I did not see one up until it exited for lack of NNET.DAT.
>>>
>>> I will note that I am using gcc 7.2 on gcc112 (/opt/cfarm/gcc-latest/bin/gcc).
>>>
>>> Are you using gcc 4.8.5, and is commit 74912f6dad in your tree?
>>> That commit might have made a difference...
>>
>> Bah.  I confirm that it doesn't, and that the test still fails.
>>
>> Since qemu does work on the same host when built with gcc 7.2, I can only blame
>> this failure on a compiler bug wrt gcc 4.8 on ppc64.
>>
>> I have not tracked down exactly what's going wrong, and probably won't unless
>> someone feels that it's worthwhile.  This only begs the question of whether we
>> should blacklist this compiler entirely.  Certainly it's old enough that it's
>> probably not worth fixing.
> 
> GCC 4.8 is still used in enterprise distros like RHEL7 and AFAIK also in
> SLES 12 ... so blacklisting this compiler does not sound like a good
> idea to me.

I have now tracked down this failure and it turns out not to be a compiler bug
at all; patch to follow.


r~
