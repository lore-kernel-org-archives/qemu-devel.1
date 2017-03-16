Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coYov-0003DV-08
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1coYoq-0000sn-TC
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:13 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1coYoq-0000sh-LC
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 13:04:08 -0400
Received: by mail-wm0-x229.google.com with SMTP id t189so53348823wmt.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 10:04:08 -0700 (PDT)
References: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8fb8ed45-6de3-2b74-f5ea-44b374cabcbd@gmail.com>
Date: Thu, 16 Mar 2017 17:04:26 +0000
Message-ID: <87ziglnof9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Make qemu_thread_create return a flag to indicate
 if it succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Achilles Benetopoulos <abenetopoulos@gmail.com>
Cc: qemu-devel@nongnu.org


Achilles Benetopoulos <abenetopoulos@gmail.com> writes:

> I am interested in working on the BiteSized Task mentioned in the
> subject line. However, I have a question: Since the current behaviour
> of qemu_thread_create is to fail in the case of an error, then it
> seems logical to make the caller exit (in the patched version) if the
> return value of the call to qemu_thread_create indicates an error. Is
> this desirable? If so, how detailed should the error messages reported
> be? If not, then I'm guessing that the desired behaviour is a more
> graceful handling of the error on a case-by-case basis?

It will depend on a case-by-case basis. For example failing to create
threads for a TCG vCPU don't really leave much for you to do expect
complain loudly and exit. I assume the more graceful handling is for
things like thread-pools where you can continue to run even without a
fully populated pool.

--
Alex Bennée
