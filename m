Received: from eggs.gnu.org ([2001:4830:134:3::10]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dbCoI-000606-S3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatol.pomozov@gmail.com>) id 1dbCoH-0000RF-Vb
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:28:38 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:35125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatol.pomozov@gmail.com>)
	id 1dbCoH-0000QC-Qu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 17:28:37 -0400
Received: by mail-io0-x236.google.com with SMTP id m88so85531619iod.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 14:28:36 -0700 (PDT)
MIME-Version: 1.0
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Fri, 28 Jul 2017 14:28:34 -0700
Message-ID: <CAOMFOmXXRN02BT+8M+iKnrGmaTSR8uWoTYCu5A5gv+KTe9xAqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to make ELF headers/symbol sections available for
 multiboot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Hi

I am looking at x86 multiboot code and trying to add "ELF section
header" info feature. This will let target to learn more about booted
binary and its sections.

I have a draft here
https://github.com/anatol/qemu/commit/ad943a6eb78feee048b6bb2a1e5f49f5b686e24c

My understanding is that qemu multiboot loads only TEXT/BSS/DATA
sections. Other stuff like symbols sections and ELF headers are not
available for target.

So I need to perform 2 things:

 - Load ELF section headers into target's memory. I did by appending
additional space to mbs.mb_buf and copying header data. Is it the best
way to do?

 - Next I need to load other ELF sections such as symbols (e.g.
.shstrtab) that store section names. What is the best way to do in
multiboo.c code? Would it make sense to load all ELF sections?

Thanks in advance.
