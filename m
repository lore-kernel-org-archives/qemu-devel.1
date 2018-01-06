Received: from eggs.gnu.org ([2001:4830:134:3::10]:57998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXrre-0007J3-3H
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riemensberger@cadami.net>) id 1eXrrZ-0006JF-8B
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:02:34 -0500
Received: from dd7730.kasserver.com ([85.13.132.46]:58374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riemensberger@cadami.net>)
	id 1eXrrZ-0006I4-0i
	for qemu-devel@nongnu.org; Sat, 06 Jan 2018 12:02:29 -0500
From: Maximilian Riemensberger <riemensberger@cadami.net>
References: <a979d8c1-2b2a-9ccd-5e51-bfef8292e571@cadami.net>
	<CAFEAcA9Hg4-ZABXZXi8Rxs+nvVpMh+95nY-VLNsxzCRrj1srzQ@mail.gmail.com>
	<ad9e4d2e-7169-f8ec-792c-5b2c242fdac5@cadami.net>
Message-ID: <061da339-6d34-c033-5bfa-53534f57a284@cadami.net>
Date: Sat, 6 Jan 2018 18:02:26 +0100
MIME-Version: 1.0
In-Reply-To: <ad9e4d2e-7169-f8ec-792c-5b2c242fdac5@cadami.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] linux-user/mmap: Should not return NULL on guest
 call mmap(NULL, ...), causes crash inside glibc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 05.01.18 22:13, Maximilian Riemensberger wrote:
> On 05.01.18 19:38, Peter Maydell wrote:
>> On 5 January 2018 at 18:13, Maximilian Riemensberger
>> <riemensberger@cadami.net> wrote:
>>> Hi,
>>>
>>> yesterday I hit the following problem when running an arm linux executable on
>>> qemu-2.10 (qemu-arm-static through binfmt_misc)
>>>
>>> 1879 mmap2(NULL,8388608,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|0x20000,-1,0) = 0x00000000
>>> 1879 write(2,0xf6fd39d0,79) stx_test: allocatestack.c:514: allocate_stack: Assertion `mem != NULL' failed.
>>>
>>> The issue comes up when the executable creates and joins lots of
>>> threads in a loop (it's a unit test).  Eventually, glibc allocatestack
>>> hits the mmap(NULL, ...) == NULL.  Judging from the posix and linux
>>> manuals mmap(NULL, ...) never returns NULL.  Either it fails with MAP_FAILED
>>> or it succeeds and returns non-NULL address.
>>
>> Given the heavy use of threading, can you retest with QEMU 2.11,
>> please? We fixed a couple of threading issues in linux-user there.
> 
> Same error with fresh qemu-2.11 build.

I just sent out a online patch that fixes the issue for me.

Cheers
	Max
