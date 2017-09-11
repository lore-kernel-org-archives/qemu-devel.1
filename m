Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drQkY-0007qb-0F
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drQkS-0003D5-9H
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 11:35:50 -0400
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-3-lvivier@redhat.com>
	<CAFEAcA_G8mEzB0Mox0TTz578LQKXgvhNHeZ8Bk7OwC4NbqiXPg@mail.gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <309f01b9-3066-60fd-47d5-5206ae6360ed@redhat.com>
Date: Mon, 11 Sep 2017 17:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G8mEzB0Mox0TTz578LQKXgvhNHeZ8Bk7OwC4NbqiXPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On 11/09/2017 16:39, Peter Maydell wrote:
> On 11 September 2017 at 15:20, Laurent Vivier <lvivier@redhat.com> wrote:
>> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
>> fixes the problem for i386, do the same for arm.
>>
>> Running QEMU with
>>     qemu-system-aarch64 -M none -nographic -m 256
>> and executing
>>     dump-guest-memory /dev/null 0 8192
>> results in segfault
>>
>> Fix by checking if we have CPU.
>>
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> It seems a little arbitrary to assume that if there's no
> CPU what you wanted was a 32-bit little-endian dump.

We need a default value.  Is 64bit and/or big-endian better?

> Why do we have a machine without a CPU anyway ?

To hotplug it later?

As we can, we should avoid the segfault.

Thanks,
Laurent
