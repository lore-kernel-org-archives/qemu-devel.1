Received: from eggs.gnu.org ([2001:4830:134:3::10]:37201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQ4VN-0006hO-0i
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fQ4VJ-0005aC-2b
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:37 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fQ4VI-0005Zu-QM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 01:27:32 -0400
Received: by mail-pl0-x242.google.com with SMTP id z9-v6so782240plk.11
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 22:27:32 -0700 (PDT)
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <149da730-950c-a527-2373-9cb0433543b1@linaro.org>
Date: Mon, 4 Jun 2018 22:27:28 -0700
MIME-Version: 1.0
In-Reply-To: <788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, evgreen@chromium.org

On 06/03/2018 06:04 PM, Laurent Vivier wrote:
> On 01/06/2018 00:49, Richard Henderson wrote:
>> If the interp_prefix is a complete chroot, it may have a *lot* of files.
>> Setting up the cache for this is quite expensive.
>>
>> For the most part, we can use the *at versions of various syscalls to
>> attempt the operation in the prefix.  For the few cases that remain,
>> attempt the operation in the prefix via concatenation and then retry
>> if that fails.
>>
> 
> I like the idea, but it breaks real chroot.
> 
> You can test it with:
> 
> wget
> https://github.com/vivier/linux-user-test-scrips/raw/master/create_chroot.sh
> 
> then
> 
> sudo sh ./create_chroot.sh /path/to/static/qemu-s390x stretch

*shrug* Works for me, at least as far as I can test.

Your script doesn't work outside debian, lacking debootstrap.
At the moment, I can't build on debian *at all*.  Some bit of the build
infrastructure is off and QEMU_FULL_VERSION gets incorrectly defined.  I have
no idea how or why it is different than Fedora.

On Fedora 28, one can no longer build a static qemu.  We depend on libraries
for which Fedora no longer ships static versions.

Do you have some specific binary that fails?


r~
