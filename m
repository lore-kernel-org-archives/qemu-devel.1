Received: from eggs.gnu.org ([2001:4830:134:3::10]:52724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQZbr-0002Pf-5n
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQZbn-0005Xq-9W
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:03:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQZbn-0005Xc-4D
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:03:31 -0500
References: <cover.1482164622.git.vpalatin@chromium.org>
	<85250fb0450b5b95232b39c82ab310a0632fd23f.1482164622.git.vpalatin@chromium.org>
	<fda5a694-d02f-269e-e155-1822276d74f6@redhat.com>
	<CAP_ceTxAn3tH-P8JjThXXeF7iYv5xFoVOzmjp5h8sHYsYzWTDQ@mail.gmail.com>
	<df2938db-dde1-633c-899d-646d62ec4780@redhat.com>
	<61d18d9c-32f1-983f-c237-3c28d31e2f23@redhat.com>
	<CAP_ceTx+SXzZeg1BrF9ibAEm6MvBma+aMseMzLMcrQV_JjeOXg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <459d4c70-aaa7-0d4d-e6c2-5a439243e481@redhat.com>
Date: Mon, 9 Jan 2017 14:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAP_ceTx+SXzZeg1BrF9ibAEm6MvBma+aMseMzLMcrQV_JjeOXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/4] Plumb the HAXM-based hardware
 acceleration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>



On 06/01/2017 15:08, Vincent Palatin wrote:
>>>>> Apart from the above change, can you check if there are some less
>>>>> heavyeight methods to force an exit?  I can think of QueueUserAPC w=
ith
>>>>> an empty pfnAPC here, and SleepEx(0, TRUE) in qemu_hax_cpu_thread_f=
n
>>>>> before qemu_wait_io_event_common.
>>>> Actually I don't know a good test case to verify such a change, any =
advice ?
>> In fact there is a race anyway:
> Thanks for the detailed examples and thoughts.
> The timing/benchmarking code might actually need some kind of per-vcpu
> time storage, but that's a detail.
> I have experimented with it and so far, I have mainly generated random
> numbers ...
> I have yet to find a use-case where the current code (with
> SuspendThread/ResumeThread) yields a better latency than just nothing
> instead :(

:)  Does QueueUserAPC generate better latency?

Windows delivers the scheduler tick to the first physical CPU.  Try
pinning QEMU away from the first CPU.

Paolo
