Received: from eggs.gnu.org ([2001:4830:134:3::10]:55569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehdgH-00040V-E2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ehdfD-0002b7-F9
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:55:13 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:35406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ehdfC-0002aU-QL
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 10:54:07 -0500
Received: by mail-ot0-x230.google.com with SMTP id a2so9324004otf.2
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 07:54:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180202100843.GD13090@stefanha-x1.localdomain>
References: <CAPHFV4=P3viF0m0PtqFZZ8_JNxy7G6kXdysYAfSsOJZe=2j7gw@mail.gmail.com>
	<20180202100843.GD13090@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2018 15:53:45 +0000
Message-ID: <CAFEAcA-5PwhJw9epXh+0_oe3E-vsVKkQDX3s1Go-FBzO=FA3zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu Trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nesrine Zouari <nesrine.zouari@enis.tn>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>

On 2 February 2018 at 10:08, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Thu, Feb 01, 2018 at 04:30:10PM +0100, Nesrine Zouari wrote:
>> I am a computer engineering student and I am actually working on my
>> graduation project at Lauterbach company. The project is about Qemu Trac=
e
>> and as a future I would like to contribute this work to the main line.
>>
>> My project is divided into two parts:
>>
>> 1/ Collecting the Guest trace data : The trace solution should be able t=
o
>> provide:
>>
>>             a/ Instruction flow Trace
>>
>>             b/ Memory read/write access
>>
>>             c/ Time Stamps.
>>
>>             d/ For tracing rich operating systems that are using MMU, we
>> additionally need to trace the task switches.
>
> Llu=C3=ACs has done the most instrumentation work in qemu.git and can exp=
lain
> the current status.

I think at the moment the status is that we're still discussing
what the trace plugin API should be... there are some mailing
list threads on the subject from I think last year some time.

thanks
-- PMM
