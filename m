Received: from eggs.gnu.org ([2001:4830:134:3::10]:56413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eKoKM-00065S-89
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eKoKI-0004OU-0z
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fweimer@redhat.com>) id 1eKoKH-0004Mz-SA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:38:09 -0500
References: <87po7zrq65.fsf@fifthhorseman.net>
	<f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <861bc28d-4009-d35e-c03b-8ae7b0ca8680@redhat.com>
Date: Fri, 1 Dec 2017 11:40:29 +0100
MIME-Version: 1.0
In-Reply-To: <f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] /usr/bin/m4: internal error detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Daniel Kahn Gillmor <dkg@fifthhorseman.net>, bug-m4@gnu.org
Cc: debian-superh@lists.debian.org, libc-alpha@sourceware.org, QEMU Developers <qemu-devel@nongnu.org>

On 12/01/2017 10:51 AM, John Paul Adrian Glaubitz wrote:
> Hi Daniel!
> 
> On 12/01/2017 06:08 AM, Daniel Kahn Gillmor wrote:
>> ------------
>> Copying file po/Makefile.in.in
>> Copying file po/Makevars.template
>> qemu: Unsupported syscall: -1
>> m4: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `ec 
>> >= 0' failed.
>> /usr/bin/m4: internal error detected; please report this bug to 
>> <bug-m4@gnu.org>: Aborted
>> -----------
> 
> This isn't a bug in m4 or anything architecture-specific, it's a regression
> that was introduced by an upstream change in glibc [1] and mainly affects
> qemu-user which we are using for m68k and sh4 [2].
> 
> While the change in glibc is most certainly correct (I don't have enough
> background knowledge to comment on that), it broke qemu-user for everyone
> and so far there is no possible fix in sight.
> 
> I am CC'ing this to libc-alpha in the hope that someone from glibc upstream
> might give us a tip on how to resolve the issue. Not being able to use 
> qemu-user
> anymore is quite a deal breaker because lots of people use qemu-user for
> debugging issues on foreign architectures which is now no longer possible.

Is this <https://sourceware.org/bugzilla/show_bug.cgi?id=22273>?  If 
yes, it should be fixed in master and on the 2.25 and 2.26 branches. 
2.24 and earlier should not be affected.

Thanks,
Florian
