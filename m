Received: from eggs.gnu.org ([2001:4830:134:3::10]:50464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d5Yu2-0007x2-8B
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d5Ytx-0003WJ-D1
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:46 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d5Ytx-0003Vy-40
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:35:41 -0400
Received: by mail-wm0-x22f.google.com with SMTP id w64so115064969wma.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 07:35:40 -0700 (PDT)
References: <20170428122444.23361-1-berrange@redhat.com>
	<a3f22a00-1f2e-6d22-f2a2-edc233cd6c64@twiddle.net>
	<8737cq4drt.fsf@linaro.org>
	<20170502140923.GF22502@stefanha-x1.localdomain>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170502140923.GF22502@stefanha-x1.localdomain>
Date: Tue, 02 May 2017 15:36:15 +0100
Message-ID: <87efw7nx5s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] (RFC) remove the GThread coroutine
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Sun, Apr 30, 2017 at 07:20:54AM +0100, Alex Bennée wrote:
>>
>> Richard Henderson <rth@twiddle.net> writes:
>>
>> > On 04/28/2017 02:24 PM, Daniel P. Berrange wrote:
>> >> At the 2016 summit it was suggested that we delete the GThread
>> >> coroutine impl since it is not fully functional, and you can
>> >> debug the ucontext impl with our GDB helper script.
>> >>
>> >> I don't recall the subject being raised again since the summit
>> >> so here's a proposal to delete the GThread impl, as a way to
>> >> trigger input from anyone who thinks we need to keep it......
>> >
>> > The last time this was mentioned, the reason that we were keeping it
>> > was to make clang's thread-sanitizer module happy.  Whether we can
>> > still find relevant bugs with that, I don't know.
>>
>> It's been a while since I last did a ThreadSanitizer run. The correct
>> fix is teaching the sanitizer about set context so we can use our normal
>> build - however this has been at the bottom of a pile for such a long
>> time.
>
> Any objections to merging this patch?

I shall not stand in its way ;-)

Acked-by: Alex Bennée <alex.bennee@linaro.org>

--
Alex Bennée
