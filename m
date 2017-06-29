Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQgom-0000gU-DD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dQgol-0005DS-JT
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 17:17:40 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <991581394.12897770.1498765659699.JavaMail.zimbra@redhat.com>
References: <cover.1498607452.git.alistair.francis@xilinx.com>
	<4b48ca3f3c45bee1103bcb50d87e6d5cadc88d6f.1498607452.git.alistair.francis@xilinx.com>
	<b959c21f-1c3e-e3ed-3012-24ef53cb8ff4@redhat.com>
	<CAKmqyKNS5D0pV-zspRX8fHE9fhxXmR-v4znAX3_-rdP9su+RJg@mail.gmail.com>
	<991581394.12897770.1498765659699.JavaMail.zimbra@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 29 Jun 2017 14:17:05 -0700
Message-ID: <CAKmqyKPbUvCQ1p1EmcBZBF79PajB4_mMNihA-Jz++VSHHt6X6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 4/4] util/oslib-win32: Recursivly pass the
 timeout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jun 29, 2017 at 12:47 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On Thu, Jun 29, 2017 at 5:34 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > On 28/06/2017 01:57, Alistair Francis wrote:
>> > I'm not sure I agree with this change, which is effectively delaying the
>> > processing of events.  The question to me is which handles are
>> > triggering so fast that QEMU effectively busy waits.
>>
>> Yeah, that is what I was trying to figure out, but didn't make much headway.
>>
>> I kept seeing zero timeouts, which means that the thread never blocks
>> and this patch helps a lot.
>
> Perhaps you can use tracepoints?  There shouldn't be many handles registered,
> since on Windows even the GUI actions all go through messages.
>
>> > Maybe your QEMUs can get some breath with commit 12f8def0e0 ("win32:
>> > replace custom mutex and condition variable with native primitives",
>> > 2017-03-27), since the native primitives are more efficient and TCG 2.8
>> > used condvars a lot for qemu_io_proceeded_cond.
>>
>> Ok, I will try that.

No luck, I tried applying that and it didn't make any difference.

>>
>> Does this mean you don't see the same slowness on QEMU 2.9?
>
> I have not tried, but the patch is only working around the real issue,
> as Fam pointed out.

Agreed. I'll keep digging and see what I can find.

Thanks,
Alistair

>
> Paolo
>
