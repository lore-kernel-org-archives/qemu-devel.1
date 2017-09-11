Received: from eggs.gnu.org ([2001:4830:134:3::10]:49355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drRlf-0003fp-JR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drRle-0005BU-PK
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:41:03 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:44516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drRle-0005Ak-Ic
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 12:41:02 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 189so9972245wmh.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:41:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <889d6ce7-073f-7860-e091-619c1202b1cd@redhat.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-3-lvivier@redhat.com>
	<CAFEAcA_G8mEzB0Mox0TTz578LQKXgvhNHeZ8Bk7OwC4NbqiXPg@mail.gmail.com>
	<889d6ce7-073f-7860-e091-619c1202b1cd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2017 17:40:40 +0100
Message-ID: <CAFEAcA9Wmq+G6H78NdsVs5mKDrMcUkB30yY2d=3+KOnbT-pmAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] hmp: fix "dump-quest-memory"
 segfault (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On 11 September 2017 at 15:45, Thomas Huth <thuth@redhat.com> wrote:
> On 11.09.2017 16:39, Peter Maydell wrote:
>> On 11 September 2017 at 15:20, Laurent Vivier <lvivier@redhat.com> wrote:
>>> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
>>> fixes the problem for i386, do the same for arm.
>>>
>>> Running QEMU with
>>>     qemu-system-aarch64 -M none -nographic -m 256
>>> and executing
>>>     dump-guest-memory /dev/null 0 8192
>>> results in segfault
>>>
>>> Fix by checking if we have CPU.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>
>> It seems a little arbitrary to assume that if there's no
>> CPU what you wanted was a 32-bit little-endian dump.
>>
>> Why do we have a machine without a CPU anyway ?
>
> The "none" machine is always started without a default CPU.

If it has no CPU then how can we create a core dump for it?
We don't (in theory) even know whether it's x86 or ARM.
(One day we may support multiple CPU architectures in
one QEMU binary...)

If the theory is hotplug-later then we're a bit stuck
because we need to know information now that we can't
know until the CPU is actually hotplugged.

thanks
-- PMM
