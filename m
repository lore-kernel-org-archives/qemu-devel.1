Received: from eggs.gnu.org ([2001:4830:134:3::10]:48302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTh-0008DY-Nn
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gHbTd-00064y-HR
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:44614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gHbTd-00064i-3K
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 17:23:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id j13-v6so2997662pff.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 14:23:04 -0700 (PDT)
Date: Tue, 30 Oct 2018 14:22:46 -0700
Message-Id: <20181030212249.7117-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PR RFC] RISC-V Patches for the 3.1 Soft Freeze, Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org

Since this is the first time I've actually done this for QEMU, I thought
I'd write up a bit of a header describing how I intend to handle RISC-V
pull requests.  This is modeled after how I've been doing things in
Linux, where it seems to work out fairly well.

My flow is to:

* Collect reviews over the course of the week.
* Tag what I intend to submit on Tuesday
* Push the tag up and send an RFC PR
* Assuming there's no major issues, actually send out the full pull
  request on Thursday

I've been doing this for a while (on Monday/Wednesday) and have found it
works well.  So far we've never had an issue where I had to pull back a
proposed PR, but I do like having the extra few days just so everyone
can stay on the same page as to what is going in.

---

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/riscv/riscv-qemu.git tags/riscv-for-master-3.1-sf1

for you to fetch changes up to a094b3544f2855c0489f5df3c938b14b9a5899e5:

  Add qemu-riscv@nongnu.org as the RISC-V list (2018-10-30 11:04:29 -0700)

----------------------------------------------------------------
RISC-V Patches for the 3.1 Soft Freeze, Part 2

This tag contains a few simple patches that I'd like to target for the
QEMU soft freeze.  There's only one code change: a fix to our PMP
implementation that avoids an internal truncation while computing a
partial PMP read.

I also have two updates to the MAINTAINERS file: one to add Alistair as
a RISC-V maintainer, and one to add our newly created mailing list.

----------------------------------------------------------------
Dayeol Lee (1):
      target/riscv/pmp.c: pmpcfg_csr_read returns bogus value on RV64

Palmer Dabbelt (2):
      Add Alistair as a RISC-V Maintainer
      Add qemu-riscv@nongnu.org as the RISC-V list

 MAINTAINERS        | 2 ++
 target/riscv/pmp.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)
