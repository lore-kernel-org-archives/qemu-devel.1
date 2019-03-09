Received: from eggs.gnu.org ([209.51.188.92]:47464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h2fvA-0008NA-G4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:38:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h2fv8-0008AB-8l
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:38:04 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h2fv7-000882-J3
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 12:38:02 -0500
Date: Sat, 9 Mar 2019 12:37:56 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190309173756.GA1038@flamenco>
References: <5C8354E3.03C6BB.09225@m12-12.163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5C8354E3.03C6BB.09225@m12-12.163.com>
Subject: Re: [Qemu-devel] 'make check' error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Sat, Mar 09, 2019 at 13:53:32 +0800, Li Qiang wrote:
> Hi all, 
> 
> Today I ‘git clone’ && configure && make && make check 
> 
> And get following error, 
> 
> fp-test.c:50:10: fatal error: fail.h: No such file or directory
>  #include "fail.h"
>           ^~~~~~~~
> 
> I look at the commit:
> https://git.qemu.org/?p=qemu.git;a=commitdiff;h=3ac1f81329f4dfdc10a51e180f9cf28dbcb02a3c;hp=b44b5abeae4a3b54ccbd7137f59c0a8923cecec9
> 
> Seems it’s old commit, I think I got ‘make check’ work after this commit.
> So I don’t know anywhere wrong.
> 
> Any hints?

fail.h is part of berkeley-testfloat-3 -- I suspect the
berkeley-testfloat-3 git submodule wasn't checked out.

Make sure both berkeley-softfloat-3 and berkeley-testfloat-3 are
checked out at $src/tests/fp. If not, you can get them with
"git submodule init && git submodule update".

Hope that helps,

		Emilio
