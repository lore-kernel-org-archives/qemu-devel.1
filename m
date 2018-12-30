Received: from eggs.gnu.org ([208.118.235.92]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gdgfH-0000eN-Eo
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jimw@sifive.com>) id 1gdgfG-0002Iy-PL
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:22:23 -0500
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:44068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jimw@sifive.com>) id 1gdgfG-0002IL-Kc
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 14:22:22 -0500
Received: by mail-ua1-x943.google.com with SMTP id d19so8203498uaq.11
	for <qemu-devel@nongnu.org>; Sun, 30 Dec 2018 11:22:22 -0800 (PST)
MIME-Version: 1.0
References: <CAFyWVaai=5K7j8w+Abpk9jxGyKuo4v9w2BgmDbY=_29+Q++Jyw@mail.gmail.com>
	<20181228220951.4962-1-jimw@sifive.com>
	<f3e26863-4624-2c8f-5a9d-f3e76b7e6f0e@linaro.org>
In-Reply-To: <f3e26863-4624-2c8f-5a9d-f3e76b7e6f0e@linaro.org>
From: Jim Wilson <jimw@sifive.com>
Date: Sun, 30 Dec 2018 11:22:10 -0800
Message-ID: <CAFyWVaYnSCDnX7j3XugT8zMw-wC=EdXiEJevb1pJkvzfD_qfGg@mail.gmail.com>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Sat, Dec 29, 2018 at 2:23 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 12/29/18 9:09 AM, Jim Wilson wrote:
> > +int csr_register_map[] = {
>
> static const?

If I add static const here, then I get a build error if this patch is
applied to the tree but the following patch #5 that uses the variable
is not applied.  Though I suppose I could fix that if I put the static
const in patch 5.  That would look a little funny but would work.

> Putting an initialized variable in a header file doesn't seem right.  Is this
> supposed to be a declaration that is shared between c files?

I did it this way for two reasons.  It makes it easier to keep the
register mapping consistent with the gdb csr file, if the gdb csr file
happens to change in the future.  We can just do a line by line
comparison of the gdb csr file against the csr-map.h file to verify
that the csr names match.  And it makes for a cleaner patch if the gdb
csr file register numbering gets fixed in the future, in that case we
can just delete this file and change a few lines to stop using this
variable.

This variable is only meant to be used in one file, the
target/riscv/gdbstubs.c file.

Jim
