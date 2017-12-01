Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eKnpV-000118-PN
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eKnpR-0001rs-8X
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:21 -0500
References: <87po7zrq65.fsf@fifthhorseman.net>
	<f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
	<861bc28d-4009-d35e-c03b-8ae7b0ca8680@redhat.com>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <9608bcde-6bf8-dc36-a6b7-71cb8bc5c705@physik.fu-berlin.de>
Date: Fri, 1 Dec 2017 12:58:03 +0100
MIME-Version: 1.0
In-Reply-To: <861bc28d-4009-d35e-c03b-8ae7b0ca8680@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] /usr/bin/m4: internal error detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Florian Weimer <fweimer@redhat.com>, Daniel Kahn Gillmor <dkg@fifthhorseman.net>, bug-m4@gnu.org
Cc: debian-superh@lists.debian.org, libc-alpha@sourceware.org, QEMU Developers <qemu-devel@nongnu.org>

Hi Florian!

On 12/01/2017 11:40 AM, Florian Weimer wrote:
> Is this <https://sourceware.org/bugzilla/show_bug.cgi?id=22273>?  If yes, it
> should be fixed in master and on the 2.25 and 2.26 branches. 2.24 and earlier
> should not be affected.

You're right, this is indeed fixed by your patch.

I tried your patch first a few days ago but I my test setup was flawed so I
was still testing against the unpatched version of Debian's glibc package.

I now managed to test the patched version and this one does indeed work

Unpatched:

Generating locales (this might take a while)...
   en_US.UTF-8...localedef: ../sysdeps/unix/sysv/linux/spawni.c:366: __spawnix: Assertion `ec >= 0' failed.
qemu: uncaught target signal 6 (Aborted) - core dumped
Aborted
  done
Generation complete.
*** update-locale: Error: invalid locale settings:  LANG=en_US.UTF-8
(sid-m68k-sbuild)root@nofan:/tmp#

Patched:

Generating locales (this might take a while)...
   en_US.UTF-8... done
Generation complete.
(sid-m68k-sbuild)root@nofan:/tmp#

The fix is already in the packaging source of Debian's glibc [1] after
I reported the bug. But the updated package has not been uploaded
to the FTP servers yet. I'll ask Debian's glibc maintainers to push
it.

Adrian

> [1] https://anonscm.debian.org/cgit/pkg-glibc/glibc.git/commit/?id=0a94d5f3ce5785b07372a810f011c62679be910e

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
