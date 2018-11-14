Received: from eggs.gnu.org ([2001:4830:134:3::10]:57223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMsWy-0004h2-Q5
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMsWr-0007DD-Lf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:36:18 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMsWr-0007Cs-D7
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:36:13 -0500
References: <20181113175437.26492-1-laurent@vivier.eu>
	<87a7mcdkjs.fsf@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f3d542b6-0871-d5e1-8df2-27834a5a629d@vivier.eu>
Date: Wed, 14 Nov 2018 11:36:06 +0100
MIME-Version: 1.0
In-Reply-To: <87a7mcdkjs.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/multiarch: fix 32bit linux-test
 on 64bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 14/11/2018 11:23, Alex Bennée wrote:
> 
> Laurent Vivier <laurent@vivier.eu> writes:
> 
>> Fix:
>>
>>   TEST    linux-test on i386
>>   .../tests/tcg/multiarch/linux-test.c:201: readdir
>>
>> readdir() calls getdents64() to have the list of the entries in a
>> directory, and getdents64() can return 64bit d_off values (with ext4,
>> for instance) that will not fit in the 32bit d_off field of the
>> readdir() dirent structure.
>>
>> To avoid that, use readdir64() to use a 64bit d_off field too.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> I guess the only remaining question is do we want to defend the other
> case or just say it's not supported and all binaries are expected to use
> modern-ish libcs with getdents64?

IMO, linux-test is only a smoke test to check basic behaviour of qemu
usermode. So it's not really important on what readdir() relies on.

On my side, I generally run full LTP test on x86_64 and ppc64 hosts with
several debian distros and ubuntu guests, so the other cases should be
tested at one point.

> Anyway:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> I'm preparing a pull-req with a travis patch, would you like me to
> include this as well?

Yes, please.

Thanks,
Laurent
