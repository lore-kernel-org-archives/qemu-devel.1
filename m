Received: from eggs.gnu.org ([2001:4830:134:3::10]:43344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Qu-00080R-Ui
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ds5Qo-0000bj-SA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:16 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ds5Qo-0000Z8-MT
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:02:10 -0400
Received: by mail-wr0-x236.google.com with SMTP id o42so27957069wrb.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 04:02:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <59B8DE5A.9000301@ispras.ru>
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
	<59B8DE5A.9000301@ispras.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Sep 2017 12:01:48 +0100
Message-ID: <CAFEAcA8UTVr-jO4Eh=uaUokYBhF0EYTuBoXdLyrKZ=GrjPFtmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 September 2017 at 08:29, Sergey Smolov <smolov@ispras.ru> wrote:
> -d options are a bit high-level for me, because I just see the execution
> result for every instruction. So it will be a mistake to think that every
> change of some register's value is just a new value writing.
>
> As I understand, at "translate time" QEMU creates a TCG model that can be
> run as x86 code on the host machine. May be it is possible to find some
> mapping in this model between x86 and MIPS registers? Having such a mapping,
> one can detect that some value has been written in a x86 register that
> conforms to some GPR MIPS register. Am I right?

No. The process of code generation does not care about
having consistent mapping between MIPS registers and
x86 registers -- all it does is ensure that architecturally
the right values are in the guest-visible registers when
they are visible to the guest.

As I say, we may some day have a tracing API that allows you
to look at things at the level of detail that you want;
for now -d is the best we have.

thanks
-- PMM
