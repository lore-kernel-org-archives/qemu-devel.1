Received: from eggs.gnu.org ([2001:4830:134:3::10]:52629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ctuffli@gmail.com>) id 1d1P5y-0006wc-MH
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ctuffli@gmail.com>) id 1d1P5x-0005sV-Ty
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:18:54 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:33592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ctuffli@gmail.com>) id 1d1P5x-0005ql-Ox
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 23:18:53 -0400
Received: by mail-qk0-x22c.google.com with SMTP id h67so62854686qke.0
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 20:18:53 -0700 (PDT)
MIME-Version: 1.0
From: Chuck Tuffli <ctuffli@gmail.com>
Date: Thu, 20 Apr 2017 20:18:51 -0700
Message-ID: <CAKAYmMJC=pTKSrLQBaU_3m33gKNoeSTxqjGFAQXC6--ZOY9JPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] AccelClass initialization order question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

While debugging an issue, I ran across something in the initialization
sequence of hardware accelerators. Being a noobie qemu developer, it's
hard to tell if I simply don't understand how AccelClass works or if
this is a bug.

The init_machine function for hardware accelerators is passed a
MachineState pointer via configure_accelerator(), but several elements
of the structure (e.g. ram_size, maxram_size, etc.) are not
initialized until well after this call. Should hardware accelerator
modules not look at MachineState and instead grab the global versions
of variables like ram_size? TIA.

--chuck
