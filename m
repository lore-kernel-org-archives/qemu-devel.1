Received: from eggs.gnu.org ([2001:4830:134:3::10]:35194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrIB-0005rQ-7e
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYrIA-0002on-9J
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:10:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYrIA-0002nr-12
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:10:18 -0400
References: <1530265890-17213-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-779p+=wkKaPa2LL4k6jAHx-K5fmXxwBhrjED5PjDnaw@mail.gmail.com>
	<fc567ee3-64fa-c812-f111-d75c49244218@redhat.com>
	<CAFEAcA8uN_PeciAiQmDhdUPVEO837+rwSxO5fBUAHyGCw1pWLA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f19125d5-079b-1f95-4ca3-fc83e19a1e4c@redhat.com>
Date: Fri, 29 Jun 2018 13:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uN_PeciAiQmDhdUPVEO837+rwSxO5fBUAHyGCw1pWLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/60] Misc patches for soft freeze
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

On 29/06/2018 13:02, Peter Maydell wrote:
>>> This still fails in the same way:
>>>   LINK    i386-linux-user/qemu-i386
>>> target/i386/cpu.o: In function `x86_cpu_realizefn':
>>> /home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4815:
>>> undefined reference to `enable_cpu_pm
>>> '
>>> collect2: error: ld returned 1 exit status
>> Uhm, it worked for me.  I'll just add a stub.
> Maybe you forgot to push something? I can't see anything
> in commit 6f131f13e68d648a8e4 in that merge branch which
> looks like it's trying to work around the undefined reference.

The problematic patch is the next one.  The change was to put the new
code under "if (!kvm_enabled()) goto out;" so that it becomes dead under
linux-user, but it still depends on how much dead code removal the
compiler is allowed to do at -O0.

Paolo
