Received: from eggs.gnu.org ([2001:4830:134:3::10]:46814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZcbg-0006P2-9M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZcbf-0005Aj-GB
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:04 -0400
Received: from mail-yw0-x235.google.com ([2607:f8b0:4002:c05::235]:36417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZcbf-0005AM-C6
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 08:37:03 -0400
Received: by mail-yw0-x235.google.com with SMTP id a12so47458978ywh.3
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 05:37:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_teDg34FbzWYsC05utw8cx9S6=Xy1rZ=sQfuJr5CHedQ@mail.gmail.com>
References: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
	<CAFEAcA_TYFbv9EeafV8FZ=HEXx=kArVb2OYiC3mGQiP7_N1-UA@mail.gmail.com>
	<CAPTzt1ACBuwkY0YSjhMLrv+1OJyCLEM7xQZqTGKbxxsLfqVN=g@mail.gmail.com>
	<CAFEAcA9TUxr0ZfpNBuSc+jaz2e6mHtQwdo-s-DK=HjJe7bAFXA@mail.gmail.com>
	<CAPTzt1CYxudRK_TUVk2_=H0GHZxK5GDSaVzhQE9Pyw+=Jy-ajg@mail.gmail.com>
	<CAFEAcA8yzFNr1sGLgDq=u0naYhst5EstJxMje_8OvUN8CJ1AEg@mail.gmail.com>
	<CAPTzt1DDFomJ-c57_e5HXGUH3L=pR6jEGwkap6Wsr4Z04SmMjg@mail.gmail.com>
	<CAFEAcA8QnUN6ZRYSUR1GBMU_yfW0a3rWd5H8kmerrNhQ5rwbkg@mail.gmail.com>
	<CAPTzt1COW1yQs-1LE5TnUXf_v10jKvAU0wq=-7jK7S=fpuKh9Q@mail.gmail.com>
	<CAPTzt1CatyAKdeGdr1jp0xsudgrjKETA1MULj1oEcHkkyG99DA@mail.gmail.com>
	<CAFEAcA_teDg34FbzWYsC05utw8cx9S6=Xy1rZ=sQfuJr5CHedQ@mail.gmail.com>
From: Hua Yanghao <huayanghao@gmail.com>
Date: Mon, 24 Jul 2017 14:37:02 +0200
Message-ID: <CAPTzt1CXvspQnvqb3zX0PXOzcw7NOWL-fPRNYPci=BJ9LLuFeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

> In the bit of the spec you quote it says how p_memsz > p_filesz
> should be handled: "the 'extra' bytes are defined to hold the
> value 0". The segment itself is still p_memsz in size and the
> header defines that it has zeroes at the end of it. QEMU's loader
> needs to arrange that those zeroes are loaded.
>

Do we have a way for qemu to take a "binary" instead of elf with the
-kernel option?
I can create a binary out of the elf that does not have any
information about segments.

I tried to feed -kernel with the objcopy-created binary but it does
not work. :-(
