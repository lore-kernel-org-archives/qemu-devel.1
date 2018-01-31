Received: from eggs.gnu.org ([2001:4830:134:3::10]:49255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egjyK-0004Uv-5W
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egjyF-0002pg-7q
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:26:08 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egjyF-0002pM-2e
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 23:26:03 -0500
Received: by mail-qk0-f181.google.com with SMTP id d21so13143592qkj.3
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 20:26:03 -0800 (PST)
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
	<CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
	<CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
Date: Tue, 30 Jan 2018 23:26:00 -0500
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 30/01/2018 18:56, Alistair Francis wrote:
> 
> I don't have a good solution though, as setting CPU_INTERRUPT_RESET
> doesn't help (that isn't handled while we are halted) and
> async_run_on_cpu()/run_on_cpu() doesn't reliably reset the CPU when we
> want.
> 
> I've ever tried pausing all CPUs before reseting the CPU and them
> resuming them all but that doesn't seem to to work either.

async_safe_run_on_cpu would be like async_run_on_cpu, except that it
takes care of stopping all other CPUs while the function runs.

> Is there
> anything I'm missing? Is there no reliable way to reset a CPU?

What do you mean by reliable?  Executing no instruction after the one
you were at?

Paolo
