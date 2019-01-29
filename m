Received: from eggs.gnu.org ([209.51.188.92]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1goJrQ-0000lo-Kw
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1goJda-0002Bq-7F
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:00:36 -0500
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:39535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1goJdT-00028I-Bk
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 22:00:31 -0500
Received: by mail-vs1-xe43.google.com with SMTP id h78so11104769vsi.6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:00:16 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228220951.4962-1-jimw@sifive.com>
	<f3e26863-4624-2c8f-5a9d-f3e76b7e6f0e@linaro.org>
	<CAFyWVaYnSCDnX7j3XugT8zMw-wC=EdXiEJevb1pJkvzfD_qfGg@mail.gmail.com>
	<CAKmqyKP3wOiHvpqyFZZCzy3c7sJP86P30JXUA0P2jAvRL7QgbQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP3wOiHvpqyFZZCzy3c7sJP86P30JXUA0P2jAvRL7QgbQ@mail.gmail.com>
From: Jim Wilson <jimw@sifive.com>
Date: Mon, 28 Jan 2019 19:00:04 -0800
Message-ID: <CAFyWVaa-L4pZXtJpUu7hom08LMx0q5pFmRyhO0TrmATD7CoRoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/5 v2] RISC-V: Map gdb CSR reg numbers to
 hw reg numbers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Jan 22, 2019 at 1:45 PM Alistair Francis <alistair23@gmail.com> wrote:
> I think it makes more sense to just define the variable in the
> gdbstubs.c file then. Can you move it to patch 5?

Yes, that is no problem.  That makes patch 3 a lot smaller and patch 5
a lot bigger, but it is the same code as before, just arranged
differently, so this shouldn't complicate the review too much.

Jim
