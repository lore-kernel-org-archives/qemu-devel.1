Received: from eggs.gnu.org ([2001:4830:134:3::10]:53039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc6PT-0005bc-4s
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dc6PS-00086F-Dh
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:50:43 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:32787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dc6PS-00085Z-1H
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 04:50:42 -0400
Received: by mail-wr0-x229.google.com with SMTP id v105so145990567wrb.0
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 01:50:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
References: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2017 09:50:20 +0100
Message-ID: <CAFEAcA8N_JyMVtLPdSFEUUgmJ0OG6AbHuD=5KhO8kv3fJDLwGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to make ELF headers/symbol sections available
 for multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 28 July 2017 at 22:28, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> So I need to perform 2 things:
>
>  - Load ELF section headers into target's memory. I did by appending
> additional space to mbs.mb_buf and copying header data. Is it the best
> way to do?
>
>  - Next I need to load other ELF sections such as symbols (e.g.
> .shstrtab) that store section names. What is the best way to do in
> multiboo.c code? Would it make sense to load all ELF sections?

This seems a bit odd, because in general an ELF loader should
not care at all about sections and the section header. It
should only need to look at the program header, which defines
which segments to load. If the guest binary needs some things
to be loaded then I would expect that it is the job of the linker
that produces the guest binary to make sure those things are in
segments which are marked as LOAD.

thanks
-- PMM
