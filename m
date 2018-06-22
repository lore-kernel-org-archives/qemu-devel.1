Received: from eggs.gnu.org ([2001:4830:134:3::10]:47521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNLW-0002BR-RK
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:47:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWNLR-0005HP-B2
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:47:30 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWNLR-0005Gc-6X
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:47:25 -0400
Received: by mail-oi0-x241.google.com with SMTP id h79-v6so6325422oig.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:47:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <930d6481-0da2-f5cd-15bf-1f09a8769c76@de.ibm.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<930d6481-0da2-f5cd-15bf-1f09a8769c76@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 15:47:03 +0100
Message-ID: <CAFEAcA9ZAf53vmjT0EyMEOyGGte4=sMXaYjgLm0vbBQEER-PBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Libvirt <libvir-list@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>

On 22 June 2018 at 15:38, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> So if everyone has adopted we can certainly follow our deprecation policy.
> Now if deprecation breaks some real world cases it makes no sense to
> "insist" on that deprecation policy. Really: If latest greatest libvirt
> does not work 2 weeks before soft freeze I consider this too late.
>
> Why: This breaks MY regression test setup before softfreeze. So I will stop
> testing qemu in the most critical point in time.
>
> If you would come up with your statement (taking deprecation policy more
> serious than users) in the Linux kernel I can pretty much guarantee that
> Linus would call you names.

This is one of those areas where I like to think the QEMU
community is a more pleasant place to be than the kernel :-)

The fact we have a deprecation policy at all indicates that we
are (unlike the kernel) sometimes willing to break things that
previously worked for users; but I think we should be a bit
pragmatic as well. If one of our largest use cases (libvirt)
missed the memo on this one I don't think we do anybody any
favours by sticking to the letter of the rules.

thanks
-- PMM
