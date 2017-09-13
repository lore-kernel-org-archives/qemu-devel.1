Received: from eggs.gnu.org ([2001:4830:134:3::10]:58044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1ds277-00073i-B5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1ds272-0002Iw-Fl
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:29:37 -0400
Received: from bran.ispras.ru ([83.149.199.196]:35833 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <smolov@ispras.ru>) id 1ds272-0002IM-7T
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:29:32 -0400
Message-ID: <59B8DE5A.9000301@ispras.ru>
Date: Wed, 13 Sep 2017 10:29:30 +0300
From: Sergey Smolov <smolov@ispras.ru>
MIME-Version: 1.0
References: <59B7EBC5.9060908@ispras.ru>
	<CAFEAcA-to=vWWBHoxZRX-ExcbDe0OTMwpHunE7HXaYA0GE+ccw@mail.gmail.com>
	<59B7F503.8010703@ispras.ru>
	<CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
In-Reply-To: <CAFEAcA97i97_aoq8xNKtP8Z+i-u5Hq+_e6N80=T=WspSEW+A7A@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] MIPS 'move' insn emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On 12.09.2017 18:06, Peter Maydell wrote:
> On 12 September 2017 at 15:53, Sergey Smolov <smolov@ispras.ru> wrote:
>> Generally speaking, is it possible at "run time" to detect write accesses to
>> MIPS GPR registers?
>> If true, which parts of code should I look in?
> We don't currently support tracing at that level, I'm afraid.
> (There are some patches on list starting to explore providing
> an API for doing this kind of instrumentation, but they're
> still at the "working out a design" stage.)
> You might want to look at the -d options, which can give
> you register dumps before every executed instruction if
> you pick the right set of options (-d exec,cpu,nochain
> -singlestep is probably a start.)
>
> thanks
> -- PMM

-d options are a bit high-level for me, because I just see the execution 
result for every instruction. So it will be a mistake to think that 
every change of some register's value is just a new value writing.

As I understand, at "translate time" QEMU creates a TCG model that can 
be run as x86 code on the host machine. May be it is possible to find 
some mapping in this model between x86 and MIPS registers? Having such a 
mapping, one can detect that some value has been written in a x86 
register that conforms to some GPR MIPS register. Am I right?

-- 
Sincerely yours,
Sergey Smolov
