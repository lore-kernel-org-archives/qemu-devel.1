Received: from eggs.gnu.org ([2001:4830:134:3::10]:36416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJQXO-0006DO-JE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJQXJ-0004Bo-Ke
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:34:14 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:36262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJQXJ-0004BQ-ES
	for qemu-devel@nongnu.org; Thu, 17 May 2018 17:34:09 -0400
Received: by mail-pl0-x241.google.com with SMTP id v24-v6so3299695plo.3
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:34:09 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-30-alex.bennee@linaro.org>
	<9b8a5a71-2071-ef5c-07b2-3797883ed22e@linaro.org>
	<87muwydlgc.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dd18fb0e-437e-d551-171e-a748ff3ede22@linaro.org>
Date: Thu, 17 May 2018 14:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <87muwydlgc.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 29/49] tests/tcg/arm: disable -p 32768
 mmap test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 02:24 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 05/17/2018 10:46 AM, Alex Bennée wrote:
>>> Broken since I updated to 18.04
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  tests/tcg/arm/Makefile.target | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>
>> Meh.  Most of these fail for hosts with 64k pages.
>> So, sure, disable this one, but I don't think that
>> the others are useful either.
> 
> I'm not entirely sure what the point of -p is meant to be. Is it just a
> performance hack for linux-user to have bigger pages? We are not using
> softmmu but I guess it affects the PageDesc structures?

I think it was just meant for testing, but I really have no idea.

If we actually had better support for mismatched host/guest page sizes, then
one could view -p as a way to choose between legitimate guest page sizes.  E.g.
8k, 16k, 64k are all legitimate for aarch64.


r~
