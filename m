Received: from eggs.gnu.org ([2001:4830:134:3::10]:59394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPxt-0004SK-0C
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drPxs-0003DJ-9d
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:45:33 -0400
References: <20170911142056.15643-1-lvivier@redhat.com>
	<20170911142056.15643-3-lvivier@redhat.com>
	<CAFEAcA_G8mEzB0Mox0TTz578LQKXgvhNHeZ8Bk7OwC4NbqiXPg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <889d6ce7-073f-7860-e091-619c1202b1cd@redhat.com>
Date: Mon, 11 Sep 2017 16:45:22 +0200
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
To: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>

On 11.09.2017 16:39, Peter Maydell wrote:
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
> 
> Why do we have a machine without a CPU anyway ?

The "none" machine is always started without a default CPU.

 Thomas
