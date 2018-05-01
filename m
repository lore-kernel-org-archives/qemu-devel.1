Received: from eggs.gnu.org ([2001:4830:134:3::10]:58187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDS9a-0004VH-70
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDS9V-0008Jx-8L
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:04:58 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDS9U-0008JS-Vz
	for qemu-devel@nongnu.org; Tue, 01 May 2018 06:04:53 -0400
Received: by mail-wm0-x232.google.com with SMTP id o78so18376978wmg.0
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 03:04:52 -0700 (PDT)
References: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1fa7369f-9c6d-73c6-77e1-7911a9538d82@gmail.com>
Date: Tue, 01 May 2018 11:04:49 +0100
Message-ID: <87vac7adz2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Translation block identification.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rafael Kioji <rafaelkioji@gmail.com>
Cc: qemu-devel@nongnu.org


Rafael Kioji <rafaelkioji@gmail.com> writes:

> Dear all,
>
> During translation how can I identify what is the basic block of the
> guest code? I wanted to know whether the block being translated is the
> beginning of a function and get its name.
>
> My current approach involves looking up the symbol associated with the
> first PC of the translation block. But no symbol is ever found. What I
> did was to add the following code in the function "translator_loop" at
> "accel/tcg/translator.c":
>
>  printf("sym: %lu %s\n", tb->pc, lookup_symbol(tb->pc));
>
> The function lookup_symbol is defined in the file "./disas.c". I am
> compiling my application with symbols (-g). My target arch is ARM.

If you run QEMU with the debug flags you should see name resolution for
each basic block. e.g.

  qemu-arm -d in_asm prog

--
Alex Benn=C3=A9e
