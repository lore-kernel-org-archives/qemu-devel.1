Received: from eggs.gnu.org ([2001:4830:134:3::10]:47232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9oHs-0005yp-OW
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9oHo-00084n-4h
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:26:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:55952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9oHn-00083Q-Ng
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 05:26:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id 206-v6so1092729wmb.5
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 02:26:39 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<001201d45f99$4f710930$ee531b90$@ru> <87tvlvmsgg.fsf@linaro.org>
	<002501d45fab$71487f90$53d97eb0$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <002501d45fab$71487f90$53d97eb0$@ru>
Date: Tue, 09 Oct 2018 10:26:36 +0100
Message-ID: <87sh1fmpwz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
>>
>> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
>> >> Any serious analysis tool should allow for us to track all memory
>> >> accesses so I think the guest_mem_before trace point should probably
>> >> be split into guest_mem_before_store and guest_mem_after_load. We
>> >> could go the whole hog and add potential trace points for start/end of
>> >> all memory operations.
>> >
>> > I wanted to ask about memory tracing and found this one.
>> > Is it possible to use tracepoints for capturing all memory accesses?
>> > In our implementation we insert helpers before and after tcg
>> > read/write operations.
>>
>> The current tracepoint isn't enough but yes I think we could. The first
>> thing I need to do is de-macrofy the atomic helpers a little just to
>> make it a bit simpler to add the before/after tracepoints.
>
> But memory accesses can use 'fast path' without the helpers.
> Thus you still need inserting the new helper for that case.

trace_guest_mem_before_tcg in tcg-op.c already does this but currently
only before operations. That's why I want to split it and pass the
load/store value register values into the helpers.

>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
