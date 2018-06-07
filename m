Received: from eggs.gnu.org ([2001:4830:134:3::10]:38987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQprj-0003qF-1G
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fQprf-0005st-2Z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:01:51 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48293)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fQpre-0005ri-OL
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:01:47 -0400
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <d9298b1e-d600-879b-b19d-0e38e15dbbd6@vivier.eu>
Date: Thu, 7 Jun 2018 10:01:43 +0200
MIME-Version: 1.0
In-Reply-To: <149da730-950c-a527-2373-9cb0433543b1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

Le 05/06/2018 à 07:27, Richard Henderson a écrit :
> On 06/03/2018 06:04 PM, Laurent Vivier wrote:
>> On 01/06/2018 00:49, Richard Henderson wrote:
>>> If the interp_prefix is a complete chroot, it may have a *lot* of files.
>>> Setting up the cache for this is quite expensive.
>>>
>>> For the most part, we can use the *at versions of various syscalls to
>>> attempt the operation in the prefix.  For the few cases that remain,
>>> attempt the operation in the prefix via concatenation and then retry
>>> if that fails.
>>>
>>
>> I like the idea, but it breaks real chroot.
>>
>> You can test it with:
>>
>> wget
>> https://github.com/vivier/linux-user-test-scrips/raw/master/create_chroot.sh
>>
>> then
>>
>> sudo sh ./create_chroot.sh /path/to/static/qemu-s390x stretch
> 
> *shrug* Works for me, at least as far as I can test.
> 
> Your script doesn't work outside debian, lacking debootstrap.
> At the moment, I can't build on debian *at all*.  Some bit of the build
> infrastructure is off and QEMU_FULL_VERSION gets incorrectly defined.  I have
> no idea how or why it is different than Fedora.

I had this problem on Fedora building in a separate directory, "make
distclean" at the top source directory fixed the problem for me.

Thanks,
Laurent
