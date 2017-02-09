Received: from eggs.gnu.org ([2001:4830:134:3::10]:35054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cboQT-00049A-Uv
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:06:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cboQQ-0003QI-OL
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 08:06:17 -0500
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
	<CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
	<87lgti1lta.fsf@emacs.mitica>
	<CAFEAcA9RXeubPXZhTS+FHyYVARvb=gVFOQxK8ZYt8OQnhe9WXw@mail.gmail.com>
	<f296fbdf-67c3-8891-e5ca-a25570e3e12f@redhat.com>
	<CAFEAcA9d9aoS=SaOghevNKTaX2V7Zu=jUev7UH1G4iSovT=_jA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <750291e6-5520-c7af-ffce-fb7c5f848761@redhat.com>
Date: Thu, 9 Feb 2017 14:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9d9aoS=SaOghevNKTaX2V7Zu=jUev7UH1G4iSovT=_jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc]  [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 09.02.2017 11:43, Peter Maydell wrote:
> On 8 February 2017 at 08:47, Thomas Huth <thuth@redhat.com> wrote:
>> How fast is that aarch64 machine?
> 
> It's a juno board, so it's not very fast, but I wouldn't
> have expected it to hit a 100 second timeout assuming
> the test isn't trying to do a ludicrous amount of work.
> 
>> The timeout of the prom-env test is
>> already 100 seconds, so that seems to be plenty to me (the test normally
>> finishes here on my laptop within 15 seconds).
>> OTOH, if it helps with the aarch64 machine, I'm also fine if we increase
>> the timeout further - but what value would be appropriate then? Could you
>> please run the following on that slow machine:
>>
>>  time QTEST_QEMU_BINARY=ppc64-softmmu/qemu-system-ppc64 tests/prom-env-test
[....]
> <qemu-system-ppc64 tests/prom-env-test -v -p /ppc64/prom-env/pseries
> /ppc64/prom-env/pseries: OK
> 
> real    1m24.362s
> user    1m23.572s
> sys     0m1.144s
> 
> pseries is much slower than the other two and at 85 seconds is
> not all that much below the 100s. Something's odd here.

SLOF (the firmware of the pseries machine) is known to perform quite bad
when running under TCG ... maybe it is even worse with the ARM version
of TCG? Or did you by any chance accidentially compile that version of
QEMU with "--enable-debug"?

Anyway, I've got some ideas how to speed up the test... and to be sure,
I'll also increase the timeout to 120 seconds instead. I'll send a patch
when it is ready...

 Thomas
