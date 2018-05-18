Received: from eggs.gnu.org ([2001:4830:134:3::10]:45220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJWN3-0004Yx-H5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJWN2-0000dz-NR
	for qemu-devel@nongnu.org; Thu, 17 May 2018 23:47:57 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-30-alex.bennee@linaro.org>
	<9b8a5a71-2071-ef5c-07b2-3797883ed22e@linaro.org>
	<87muwydlgc.fsf@linaro.org>
	<dd18fb0e-437e-d551-171e-a748ff3ede22@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <96968166-c412-bd9f-5b85-d6449308f895@amsat.org>
Date: Fri, 18 May 2018 00:47:41 -0300
MIME-Version: 1.0
In-Reply-To: <dd18fb0e-437e-d551-171e-a748ff3ede22@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 06:34 PM, Richard Henderson wrote:
> On 05/17/2018 02:24 PM, Alex Bennée wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> On 05/17/2018 10:46 AM, Alex Bennée wrote:
>>>> Broken since I updated to 18.04
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>  tests/tcg/arm/Makefile.target | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>
>>> Meh.  Most of these fail for hosts with 64k pages.
>>> So, sure, disable this one, but I don't think that
>>> the others are useful either.
>>
>> I'm not entirely sure what the point of -p is meant to be. Is it just a
>> performance hack for linux-user to have bigger pages? We are not using
>> softmmu but I guess it affects the PageDesc structures?
> 
> I think it was just meant for testing, but I really have no idea.
> 
> If we actually had better support for mismatched host/guest page sizes, then
> one could view -p as a way to choose between legitimate guest page sizes.  E.g.
> 8k, 16k, 64k are all legitimate for aarch64.

8k + 16k on aarch64:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
