Received: from eggs.gnu.org ([2001:4830:134:3::10]:55683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNf-0006O9-W2
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNb-0004SS-Sy
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:48 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57379 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbNb-0004Q2-8t
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:40:43 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615221911.GB26408@flamenco> <20170615232507.GA15332@flamenco>
	<20170617010913.GA27059@flamenco>
Date: Sun, 18 Jun 2017 17:24:08 +0300
In-Reply-To: <20170617010913.GA27059@flamenco> (Emilio G. Cota's message of
	"Fri, 16 Jun 2017 21:09:13 -0400")
Message-ID: <87lgope5mf.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 3/6] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Emilio G Cota writes:

> On Thu, Jun 15, 2017 at 19:25:07 -0400, Emilio G. Cota wrote:
>> Also, consider keeping the @is_jmp name instead of renaming it to
>> @jmp_type. (@jmp would be shorter but it would be confusing though,
>> e.g. cris has both dc->jmp and dc->is_jmp.)

> It turns out that keeping the original names also makes the diff's
> a lot more bearable.

> I have a WIP branch with further modifications to your patches; the goal
> is to break down the patchset to make it more easily reviewable, which
> hopefully will also prevent us from introducing bugs.

> You can see the WIP tree at:
>   https://github.com/cota/qemu/tree/trloop
> Note that I may rebase this branch any time.

Ok, I'll do that for both arm and x86.


Thanks a lot,
  Lluis
