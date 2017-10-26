Received: from eggs.gnu.org ([2001:4830:134:3::10]:55418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7dNl-00025I-6g
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:19:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7dNk-0001qJ-3m
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:19:17 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:46820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7dNj-0001nt-TU
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:19:16 -0400
Received: by mail-wm0-x236.google.com with SMTP id m72so6260215wmc.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 01:19:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6dbce328-c404-403f-a1ae-32de5fc742cf@ozlabs.ru>
References: <20171024085853.32615-1-aik@ozlabs.ru>
	<20171024162752.GA21671@redhat.com>
	<ef1eab70-8c55-0d75-e516-16ef6a419d04@ozlabs.ru>
	<20171025065755.GB27237@redhat.com>
	<6b823cd9-ef9d-a704-ed25-91f360018eca@ozlabs.ru>
	<20171025211129.GD30132@redhat.com>
	<a862a41b-45c6-7b3e-9290-92abfa856e76@ozlabs.ru>
	<20171026070253.GB5847@redhat.com>
	<6dbce328-c404-403f-a1ae-32de5fc742cf@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 09:18:54 +0100
Message-ID: <CAFEAcA9KCim0bwHU_CVc5bxteOKVtiZCTR0uaRqkvn1ENi0NeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] git-submodule.sh: Do not try
 writing to source directory if not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 08:45, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> Submodules change once/twice a year so we could live quite happily without
> this automation imho.

This is a significant underestimate. The openbios submodule alone
has been updated 12 times this year.

> What if I do not want submodules to be updated in
> order to reproduce some bug and confirm that the newer version of submodule
> has fixed it?

The only thing we support is "use the version of the submodule that
goes with the git commit of QEMU that they're supposed to go with".
The only reason we have this automation at all is that git submodule
is a broken design that doesn't update the submodule automatically
on git checkout/git branch etc.

I'm not a huge fan of this automation as we have it at the moment, but
we do need to do something just to work around the terrible terrible
stock git behaviour :-(

> btw I looked now to my tree with upstream QEMU and dtc in that tree is 8
> month old (v1.4.4 and there is v1.4.5 available). Is not it supposed to
> update to something more recent automatically? git-submodule.sh does not do
> checkout or pull.

We update the submodules when we need to update them (which for
dependencies like dtc is usually "when we have some requirement
that mandates a newer version".)

thanks
-- PMM
