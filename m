Received: from eggs.gnu.org ([2001:4830:134:3::10]:57721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1co5l9-0002oE-SD
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1co5l5-0005HW-1B
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:02:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1co5l4-0005Go-PK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:02:18 -0400
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<20170314162020.GT2652@redhat.com>
	<d9497461-e7c5-b914-362d-16b0cdea9fba@redhat.com>
	<CAFEAcA-Y=KNBTj32_C1HOuRcEL9vxMimxjPpwrQpG9apGqBjSQ@mail.gmail.com>
	<5a03eebc-669c-c67b-d857-f4d1bbbeff36@twiddle.net>
	<20170315094055.GC7770@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bd6016ed-c3a8-8988-b4f8-2cd443874fd0@redhat.com>
Date: Wed, 15 Mar 2017 11:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <20170315094055.GC7770@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Obsolete QEMU host environments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>

On 15.03.2017 10:40, Daniel P. Berrange wrote:
> On Wed, Mar 15, 2017 at 07:09:55AM +1000, Richard Henderson wrote:
>> On 03/15/2017 03:07 AM, Peter Maydell wrote:
>>> On 14 March 2017 at 17:54, Thomas Huth <thuth@redhat.com> wrote:
>>>> Our ia64 host backend in QEMU (tcg/ia64) is still marked as maintained
>>>> ... so it's maybe not as dead as you think? Or should we rather get rid
>>>> of that soon, too?
>>>
>>> I don't actually mind whether we keep tcg/ia64 or drop it.
>>> But if we keep it then we must have a machine we can test
>>> it on -- that means one I have access to (and which we
>>> can otherwise use for central testing), not just one the
>>> maintainer might happen to have.
>>>
>>> Also, that MAINTAINERS entry was added in 2011, so it's
>>> probably about as out of date as the code :-)
>>
>> Red Hat's last ia64 machine died a few years ago, so I haven't
>> been able to test it for quite some time.
> 
> AFAIK, HP are the only major vendor who still sell new ia64 machines and
> that's high end stuff costing many $$$$$. Even they are pushing people to
> x86_64 unless they need ia64 for legacy reasons. Otherwise ebay and other
> secondhand marketplaces are the only way to get hold of ia64.

Unless Aurelien speaks up and says that it is still maintained, I'd say
we add a big fat "ia is deprecated and going to be removed" warning to
the configure script once we left the freeze state. If nobody then
speaks up within the next two or three releases of QEMU, we remove the
ia64 support from QEMU.

 Thomas
