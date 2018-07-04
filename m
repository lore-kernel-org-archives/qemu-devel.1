Received: from eggs.gnu.org ([2001:4830:134:3::10]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fakQC-00020O-Pg
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fakQB-0005ya-RD
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:14:24 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:37052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fakQB-0005xp-Cv
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 12:14:23 -0400
Received: by mail-oi0-x22e.google.com with SMTP id k81-v6so11644521oib.4
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 09:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180704133440.GE4334@localhost.localdomain>
References: <20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com>
	<20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
	<60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
	<20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jul 2018 17:14:02 +0100
Message-ID: <CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Krempa <pkrempa@redhat.com>

On 4 July 2018 at 14:34, Kevin Wolf <kwolf@redhat.com> wrote:
> Essentially, what is important to me isn't getting these options dropped
> exactly in 3.0, but not setting a bad precedence that deprecation isn't
> actually worth anything. We may easily end up with this deprecation
> process:
>
> depreate a feature
> release QEMU version n + 1
> release QEMU version n + 2
> remove the feature
> while libvirt hasn't removed use of the feature:
>     # ...and why should it when everything is still working?
>     reinstate the feature
>     release QEMU version n + x
>     remove the feature

My take on the deprecation policy essentially is that it gives
us a *minimum* bar for how soon we can drop something. We
shouldn't be using it as an "always target this speed for
dropping something" -- we ought to be pragmatic. We can
drop stuff that's unused quickly, but should be slower
for things that still have major users (or reconsider
the deprecation entirely, potentially). There should be
a balance between making our work as developers easier and
inconveniencing our users.

In this particular case, reverting this deletion seems like
a fairly easy call to me.

We should also definitely work on improving how we can
let management-layer developers easily test that they're
not accidentally relying on deprecated features, certainly
(and also on better documentation for command line users
of how to switch away from deprecated features -- for
instance I am still using -redir in some of my scripts
because the warning about it being deprecated is not
precise about what exact command line option can be used
instead, especially for the case where the ethernet device
is builtin rather than created with -device...)

thanks
-- PMM
