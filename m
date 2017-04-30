Received: from eggs.gnu.org ([2001:4830:134:3::10]:49790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d4iDa-0004ab-Fu
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 02:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d4iDX-00048N-9u
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 02:20:26 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d4iDX-00047z-2O
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 02:20:23 -0400
Received: by mail-wm0-x22a.google.com with SMTP id r190so17593682wme.1
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 23:20:22 -0700 (PDT)
References: <20170428122444.23361-1-berrange@redhat.com>
	<a3f22a00-1f2e-6d22-f2a2-edc233cd6c64@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a3f22a00-1f2e-6d22-f2a2-edc233cd6c64@twiddle.net>
Date: Sun, 30 Apr 2017 07:20:54 +0100
Message-ID: <8737cq4drt.fsf@linaro.org>
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
To: Richard Henderson <rth@twiddle.net>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


Richard Henderson <rth@twiddle.net> writes:

> On 04/28/2017 02:24 PM, Daniel P. Berrange wrote:
>> At the 2016 summit it was suggested that we delete the GThread
>> coroutine impl since it is not fully functional, and you can
>> debug the ucontext impl with our GDB helper script.
>>
>> I don't recall the subject being raised again since the summit
>> so here's a proposal to delete the GThread impl, as a way to
>> trigger input from anyone who thinks we need to keep it......
>
> The last time this was mentioned, the reason that we were keeping it
> was to make clang's thread-sanitizer module happy.  Whether we can
> still find relevant bugs with that, I don't know.

It's been a while since I last did a ThreadSanitizer run. The correct
fix is teaching the sanitizer about set context so we can use our normal
build - however this has been at the bottom of a pile for such a long
time.

--
Alex Bennée
