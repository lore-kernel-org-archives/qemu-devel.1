Received: from eggs.gnu.org ([2001:4830:134:3::10]:47549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eKnpV-000115-Mw
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eKnpS-0001tI-7G
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:21 -0500
References: <87po7zrq65.fsf@fifthhorseman.net>
	<f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
	<871ske63pu.fsf@linux-m68k.org>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <de4243ee-f6c3-dd52-ca58-8e5a83f2e18d@physik.fu-berlin.de>
Date: Fri, 1 Dec 2017 13:22:20 +0100
MIME-Version: 1.0
In-Reply-To: <871ske63pu.fsf@linux-m68k.org>
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
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Daniel Kahn Gillmor <dkg@fifthhorseman.net>, bug-m4@gnu.org, debian-superh@lists.debian.org, libc-alpha@sourceware.org, QEMU Developers <qemu-devel@nongnu.org>

On 12/01/2017 01:18 PM, Andreas Schwab wrote:
>> This isn't a bug in m4 or anything architecture-specific, it's a regression
>> that was introduced by an upstream change in glibc [1] and mainly affects
>> qemu-user which we are using for m68k and sh4 [2].
> 
> It's a bug in qemu-linux-user, which ignores CLONE_VFORK, turning vfork
> into fork.  This breaks the expected semantics of vfork (VM sharing and
> blocking the child until exec).

Yes, I wasn't really arguing that it's a bug in QEMU as Adhemerval had already
explained. The problem was just that apparently resolving the issue in
QEMU isn't trivial as Peter Maydell mentioned in [1].

That's why I was looking for a workaround. However, I have re-tested Florian's
patch and it works for me now, it didn't when I tested it for the first time.

So, we have a workaround for the time being until the bug is resolved in QEMU.

Adrian

> [1] https://bugs.launchpad.net/qemu/+bug/1673976

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
