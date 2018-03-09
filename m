Received: from eggs.gnu.org ([2001:4830:134:3::10]:33481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1euJ82-0000DB-02
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1euJ7y-00032A-Q8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:13 -0500
Received: from [162.105.89.7] (port=40794 helo=mprc.pku.edu.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gxt@mprc.pku.edu.cn>) id 1euJ7x-000300-MZ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 09:36:10 -0500
Message-ID: <50305.222.29.22.133.1520604516.squirrel@mprc.pku.edu.cn>
In-Reply-To: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
Date: Fri, 9 Mar 2018 22:08:36 +0800 (CST)
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Proposal: deprecate and remove QEMU's unicore32
 target code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Richard Henderson <rth@twiddle.net>

> I propose that we deprecate and plan to remove the unicore32 code:
>
>  * It has had no changes since 2012 that were not tree-wide
>    maintenance/API changes/other global updates
>  * We dropped the linux-user unicore32 support in 2016 because of
>    a clash between the 'old ABI' that it was implementing and the
>    ABI that's actually in the upstream Linux kernel, and there have
>    been no moves to get this fixed so we could re-enable it, nor
>    any complaints when it went away
>  * Linux is now planning to drop unicore support
>    (https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1619640.html)
>  * there is apparently no upstream gcc support for the architecture
>  * nobody has ever reported a bug or problem to us about it
>
> Essentially, it seems to be a largely-inactive university R&D project,
> it's costing us in maintenance effort every time we have to touch it,
> and I don't think it has any real users.
>
> Does anybody disagree?
>
> If we go ahead with deprecating then we should:
>  * add a note to Changelog that we're deprecating the target
>  * ditto qemu-doc.texi's deprecation section
>  * patch hw/unicore32/puv3.c to warn on startup that it's deprecated
>  * remove it entirely for the 2.14 release
>
> We could also remove linux-user/unicore32 immediately, since
> the linux-user target has been disabled for some time.
>
> Possibly there are other target architectures we could reasonably
> deprecate-and-remove (though none of the other ones Linux is dropping
> in this round are ones we support)...
>
> thanks
> -- PMM
>

Hi, Peter
I am really sorry to reply so late, since I seldom use this email account
in recent years. I will add my new email account to related bits.

I had sent email to clarify the status of UniCore to Arnd and lkml. In a
word, UniCore is a real product and we still use the port internally. So,
I really appreciate having unicore32 port in the tree.

Thanks,
Guan Xuetao
