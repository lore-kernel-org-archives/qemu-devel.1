Received: from eggs.gnu.org ([2001:4830:134:3::10]:35896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5Rc-00046x-OW
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fS5RZ-0000nC-LL
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:52:04 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fS5RZ-0000mi-Dv
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:52:01 -0400
Received: by mail-pf0-x243.google.com with SMTP id a22-v6so9067998pfo.12
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 11:52:01 -0700 (PDT)
References: <20180610030220.3777-1-richard.henderson@linaro.org>
	<CAFEAcA83SodNB16GCk_SAjmWE1fZ77ypbFPuRr9A5A=n0ocqwA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d6dcaf43-3078-1fea-ca37-f67cf4643b8d@linaro.org>
Date: Sun, 10 Jun 2018 08:51:54 -1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83SodNB16GCk_SAjmWE1fZ77ypbFPuRr9A5A=n0ocqwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 000/108] linux-user: Split do_syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 06/10/2018 02:34 AM, Peter Maydell wrote:
> It's still a stupidly large source file -- is it worth taking
> advantage of the split into multiple implementation functions
> to break it up into multiple source files? (We could group
> related syscalls together.)

It's possible.  Any suggestions for groupings?  I can think of files,
networking, memory (mmap &c), signals, session (getuid &c), ipc.

I've also wondered about cutting down on ifdef boilerplate.  There's nothing
more that I can do about it within the C preprocessor.

I'd have to wire up something else via the makefiles, but haven't thought about
what form that should take.  Likely it ought to be something that can be
massaged into both syscall dispatch and strace tables.


r~
