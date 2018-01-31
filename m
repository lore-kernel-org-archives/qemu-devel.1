Received: from eggs.gnu.org ([2001:4830:134:3::10]:43993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eguwi-00032q-2X
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eguwY-0001xD-MI
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:09:12 -0500
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:39054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eguwY-0001wJ-EK
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:09:02 -0500
Received: by mail-lf0-x22b.google.com with SMTP id w27so21530461lfd.6
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 08:09:02 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
	<CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
	<CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
	<0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 08:08:30 -0800
Message-ID: <CAKmqyKMAy3qjjTFdtw4ksa=wJQYVzYZqvSopQ_cHbqwd0tr2cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Jan 30, 2018 at 8:26 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 30/01/2018 18:56, Alistair Francis wrote:
>>
>> I don't have a good solution though, as setting CPU_INTERRUPT_RESET
>> doesn't help (that isn't handled while we are halted) and
>> async_run_on_cpu()/run_on_cpu() doesn't reliably reset the CPU when we
>> want.
>>
>> I've ever tried pausing all CPUs before reseting the CPU and them
>> resuming them all but that doesn't seem to to work either.
>
> async_safe_run_on_cpu would be like async_run_on_cpu, except that it
> takes care of stopping all other CPUs while the function runs.
>
>> Is there
>> anything I'm missing? Is there no reliable way to reset a CPU?
>
> What do you mean by reliable?  Executing no instruction after the one
> you were at?

The reset is called by a GPIO line, so I need the reset to be called
basically as quickly as the GPIO line changes. The async_ and
async_safe_ functions seem to not run quickly enough, even if I run a
process_work_queue() function afterwards.

Is there a way to kick the CPU to act on the async_*?

Thanks,
Alistair

>
> Paolo
>
