Received: from eggs.gnu.org ([2001:4830:134:3::10]:50213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cnthy-0008QZ-CA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cnthv-0005sd-6x
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:10:18 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:33917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cnthv-0005rC-1L
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 17:10:15 -0400
Received: by mail-pg0-x242.google.com with SMTP id b5so26094293pgg.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 14:10:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <87tw6y8bs8.fsf@secure.mitica>
	<CAFEAcA978SJemCfYJPa8jwtuhhi6JGh9pEDGYNJ1npJA3nvEQA@mail.gmail.com>
	<20170314081312.GB13140@stefanha-x1.localdomain>
	<CAFEAcA9F2BPexRieaEhu+UpJxoOdEfw8eggW8b2SjuoMMTNgog@mail.gmail.com>
	<87wpbstesf.fsf@secure.mitica> <20170314160113.GM2445@work-vm>
	<20170314162020.GT2652@redhat.com>
	<d9497461-e7c5-b914-362d-16b0cdea9fba@redhat.com>
	<CAFEAcA-Y=KNBTj32_C1HOuRcEL9vxMimxjPpwrQpG9apGqBjSQ@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5a03eebc-669c-c67b-d857-f4d1bbbeff36@twiddle.net>
Date: Wed, 15 Mar 2017 07:09:55 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Y=KNBTj32_C1HOuRcEL9vxMimxjPpwrQpG9apGqBjSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developer <qemu-devel@nongnu.org>, KVM devel mailing list <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

On 03/15/2017 03:07 AM, Peter Maydell wrote:
> On 14 March 2017 at 17:54, Thomas Huth <thuth@redhat.com> wrote:
>> Our ia64 host backend in QEMU (tcg/ia64) is still marked as maintained
>> ... so it's maybe not as dead as you think? Or should we rather get rid
>> of that soon, too?
>
> I don't actually mind whether we keep tcg/ia64 or drop it.
> But if we keep it then we must have a machine we can test
> it on -- that means one I have access to (and which we
> can otherwise use for central testing), not just one the
> maintainer might happen to have.
>
> Also, that MAINTAINERS entry was added in 2011, so it's
> probably about as out of date as the code :-)

Red Hat's last ia64 machine died a few years ago, so I haven't
been able to test it for quite some time.

I don't know if Aurelien can still test on ia64 or not.


r~
