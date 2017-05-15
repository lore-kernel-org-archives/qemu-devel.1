Received: from eggs.gnu.org ([2001:4830:134:3::10]:36535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dAHT3-00073B-3S
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dAHT2-0003km-7C
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:59:25 -0400
Received: from mail-yb0-x22c.google.com ([2607:f8b0:4002:c09::22c]:33200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dAHT1-0003ke-Re
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:59:24 -0400
Received: by mail-yb0-x22c.google.com with SMTP id j17so28224654ybj.0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 07:59:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a4f70b68-ec18-4237-79fa-b106bc3e29d0@twiddle.net>
References: <20170513155816.17294-1-bobby.prani@gmail.com>
	<a4f70b68-ec18-4237-79fa-b106bc3e29d0@twiddle.net>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 15 May 2017 10:58:52 -0400
Message-ID: <CAJhHMCC+1UA10c+2xT_BWhK-Aw6W2Z+5tTbtXyJG4rwBkY4MZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: 'nop' instruction with 'lock'
 prefix is illegal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On Sun, May 14, 2017 at 5:12 PM, Richard Henderson <rth@twiddle.net> wrote:
>>
> Surely you'd also want to make this change for 0x11a and 0x11b.  Which would
> also simplify that code a bit.
>
> That said, there's *lots* of missing LOCK prefix checks.  What brings this
> one in particular to your attention?
>

The motivation for this change is here:
https://github.com/aquynh/capstone/issues/915

Apparently LLVM generates it in certain scenarios when padding with
multi-byte nop (it shouldn't).

>From what I understand, a proper instruction like "lock; <valid inst>"
is converted to "lock; multi-byte nop; <valid inst>" due to code
alignment.

There were bugs reported regarding this:
https://bugs.chromium.org/p/nativeclient/issues/detail?id=3929

I am not sure we want to fix this, but I thought it would be easy
enough to cover this case.

Thanks,
-- 
Pranith
