Received: from eggs.gnu.org ([2001:4830:134:3::10]:36509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1euPts-0001GZ-UE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1euPto-0001vx-2h
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:50:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1euPtn-0001vB-QO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 16:49:59 -0500
Date: Fri, 9 Mar 2018 16:49:57 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180309214957.GA32140@flamenco>
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
	<CAHNT7NtLVFU08oC0ReduK-2mFBwgwjvgfEWaZpYFY-GkjKWv=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHNT7NtLVFU08oC0ReduK-2mFBwgwjvgfEWaZpYFY-GkjKWv=g@mail.gmail.com>
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan O'Rear <sorear2@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Mar 09, 2018 at 11:34:56 +0000, Michael Clark wrote:
> BTW how does one hide signed-off-by or cc email addresses with the
> git-send-email workflow?

You just don't.

> Seems like editing the patch after git format-patch is likely the only way
> around for contributors whose wishes I might not have honoured, except
> originally when I was using an advoc albeit buggy workflow, where the Cc’s
> et all we’re later added to the patch headers and not the commits. I’ve
> probably inadvertently violated someone’s wish to keep their email address
> out of the list archives, which is an understandable wish.

If that's their wish I'd say just use the --cc flag; they get to keep
their address hidden from public commit messages, at the expense of (possibly)
being Cc'ed on more emails than they need to. I think it's a
reasonable trade-off.

That said, if they really want to hide their address from others,
you should use --bcc. But then they wouldn't receive the replies.

> This is not an issue with GitHub PR’s as they keep identity information
> differently however slicing up the port for upstreaming has lost some of
> our contributor history. I have made tags before every squash and rebase so
> we can find all history in the riscv repo, as well as previously trying to
> keep personal emails out of the cover letters in the first series. With the
> change to the git-sendemail  workflow i’ve likely regressed here.
> 
> I also probably have to manually edit patches to add ‘Cc to the
> riscv-patches mailing list, as it doesn’t seem right to put that email in
> the commit messages.

Isn't Cc'ing riscv-patches an obvious use case for using the --cc flag?
(BTW You can add as many --cc's as you want, and these apply to all patches
in a series.)

		E.

PS. As always, remember to use --dry-run =)
