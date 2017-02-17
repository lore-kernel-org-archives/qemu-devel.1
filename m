Received: from eggs.gnu.org ([2001:4830:134:3::10]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceelD-0003sH-OX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceel9-0007I9-NL
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:23:27 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2a2570bf-2e4b-e793-4362-0a679b182b1e@redhat.com>
Date: Fri, 17 Feb 2017 10:23:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170217064327.GB21716@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Chad Joan <chadjoan@gmail.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 02/17/17 07:43, Fam Zheng wrote:
> On Thu, 02/16 12:47, Chad Joan wrote:
>> I am glad others are chiming in and might provide better solutions.
>>
>> Honestly, following the instructions at
>> http://wiki.qemu-project.org/Contribute/SubmitAPatch to-the-letter is quite
>> daunting to me, just to get one line of code changed.  It might help if
>> that page had some kind of dead-simple example for trivial patches;
>> something like:
>> $ cd <QEMU directory>
>> $ git format-patch blah blah blah
>> $ maybe-some-other-command
>> $ # Now copy the contents of file xyz.patch into your email client and send
>> to qemu-devel@nongnu.org and qemu-trivial@nongnu.org
> 
> Makes sense in general except for the sending part - email clients tend to
> damage the patch when you copy and paste by wrapping long lines or messing up
> other things. But your point is taken, we should make the first (or a one-shot)
> contribution as easy as possible.

I disagree (from the sidelines, that is; I'm not a QEMU maintainer --
I'm a co-maintainer elsewhere). The patch submission process exists for
a reason, the goal is to maximize the throughput of long-term
contributors and maintainers, because that's the best for the project's
overall health and progress.

It does not mean that one-off contributions are not welcome -- all
contributions are welcome that follow the process (and beyond that,
everyone is welcome to become a long-term contributor).

Just my two cents, of course; don't take this as an official standpoint
or whatever. (And, I'm saying this after having manually fixed up
garbled patches from one-off contributors.)

Laszlo
