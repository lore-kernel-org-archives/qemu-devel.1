Received: from eggs.gnu.org ([2001:4830:134:3::10]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgYXF-0007O7-NY
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgYXE-0004W5-Ut
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:45:41 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgYXE-0004Vl-DW
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 12:45:40 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so22432714oiw.8
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 09:45:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <40e694c6-9757-3f9e-b8c1-9d2fdd113328@linaro.org>
References: <20180720153932.8507-1-peter.maydell@linaro.org>
	<0b589622-ffaf-8ed7-c34b-77ada1d203fb@amsat.org>
	<CAFEAcA-Mc7S775QK5dt7+eqaZD0TSZhsNLrZauSNshfbQGx9fg@mail.gmail.com>
	<aa869c16-9577-bf7b-a5c7-b63673644a6f@linaro.org>
	<CAFEAcA9XXPsm8V45eYyK1kNdpOjS9gmrZM2MThu1VJ07dhwEPQ@mail.gmail.com>
	<40e694c6-9757-3f9e-b8c1-9d2fdd113328@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 17:45:09 +0100
Message-ID: <CAFEAcA_rsE7kNO7LkQhxcsMa9718c_kMYdgYAegesLmOFWWfMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0 ?] tests/libqtest: Improve
 kill_qemu() assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

On 20 July 2018 at 17:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/20/2018 09:25 AM, Peter Maydell wrote:
>> On 20 July 2018 at 17:14, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> You already print the file, just include the line.  Perhaps
>>>
>>>   fprintf(stderr,
>>>           "%s:%d: kill_qemu tried to terminate QEMU "
>>>           "process but it dumped core with signal %s\n",
>>>           __FILE__, __LINE__, strsignal(WTERMSIG(wstatus)));
>>>   abort();
>>
>> I wasn't convinced that strsignal() would be available
>> on all the host OSes we build on (we don't currently use
>> it outside linux-user/), and I definitely didn't think that
>> it merited a configure test for its presence just for a
>> test error message :-)
>
> Hmm.  It has been in _GNU_SOURCE since the dawn of time
> and in POSIX since 2008.
>
> For non-linux, I peeked at the OpenBSD man page, which says
>
>   The strsignal() function first appeared in AT&T System V
>   Release 4 UNIX and was reimplemented for NetBSD 1.0.
>
> That suggests all of the extant BSDs should have it.
>
> MinGW has had the function since 2008.
>
> What other hosts do we support?

OSX, but that's I think OK as it inherits it from BSD.
The configure script also has support for Solaris-variants
and Haiku...

thanks
-- PMM
