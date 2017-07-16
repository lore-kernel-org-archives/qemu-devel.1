Received: from eggs.gnu.org ([2001:4830:134:3::10]:35384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWra5-0003eL-0a
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 18:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWra2-0000ZG-1M
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 18:00:01 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:33135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWra1-0000Ys-S1
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 17:59:57 -0400
Received: by mail-io0-x242.google.com with SMTP id z62so6214339ioi.0
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 14:59:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
	<65cb9165-42a1-9648-7519-0bd893c1ac13@twiddle.net>
	<20170716151802.cmaz3zhucqlgaq5r@aurel32.net>
	<e19112df-a491-2e34-61a7-3a514622df3e@twiddle.net>
	<20170716214345.n4ehbjkfq454bvwh@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7bbed7e-143a-1d30-ec14-4a921f534077@twiddle.net>
Date: Sun, 16 Jul 2017 11:59:50 -1000
MIME-Version: 1.0
In-Reply-To: <20170716214345.n4ehbjkfq454bvwh@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: bruno@clisp.org, qemu-devel@nongnu.org, glaubitz@debian.org, laurent@vivier.eu

On 07/16/2017 11:43 AM, Aurelien Jarno wrote:
> Indeed, if the same atomic code is used often it might be better to have
> it cached. That said it's only true for TB that are recognized, as IIRC
> TB with the exclusive lock are not cached.

At the moment they are not.

But in Emilio's multi-threaded tcg v2 patch set, posted just today, we change 
that by adding a CF_PARALLEL flag to TB->cflags, and incorporating that into 
the tb hash.


r~
