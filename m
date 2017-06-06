Received: from eggs.gnu.org ([2001:4830:134:3::10]:60216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIFOp-00011H-QS
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIFOm-0005fM-DR
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:23:59 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIFOm-0005fC-5X
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:23:56 -0400
Received: by mail-wr0-x22f.google.com with SMTP id q97so54879394wrb.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 07:23:56 -0700 (PDT)
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-9-alex.bennee@linaro.org>
	<CAFEAcA-ZYs-JHrK1S==UKmOD99CJOEHKPyHMHMkacNGh2XDguQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA-ZYs-JHrK1S==UKmOD99CJOEHKPyHMHMkacNGh2XDguQ@mail.gmail.com>
Date: Tue, 06 Jun 2017 15:24:19 +0100
Message-ID: <87o9u1chyk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 08/10] risu: add support compressed
 tracefiles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 2 June 2017 at 17:08, Alex Bennée <alex.bennee@linaro.org> wrote:
>> This uses the magic of zlib's gzread/write interface to wrap the
>> tracefile in compression. The code changes are tiny. I spent more time
>> messing about with the configure/linker stuff to auto-detect bits.
>>
>> As you need decent multi-arch support or a correctly setup cross
>> toolchain we fall back if we can't compile with zlib. This
>> unfortunately needs some #ifdef hackery around the zlib bits in
>> risu.c.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> --
>> v4
>>   - removed redundant config.h output, added HAVE_ZLIB
>>   - added BUILD_INC to deal with out-of-tree builds
>
> I thought the trace files were so enormous that zlib was
> basically mandatory for the record/replay to be useful?

It would still work. As mentioned on IRC we could look at streaming
through stdout if zlib is hard to do.

> I'm wondering if we should use a submodule for zlib and
> just build it locally. That would let us just make it a
> hard requirement (and avoid the need to do things with
> docker).

That would be another option. There doesn't seem to be a nice zlib
source repository and the license means having to mess about with
version markings if we import it into the tree.

>
> thanks
> -- PMM


--
Alex Bennée
