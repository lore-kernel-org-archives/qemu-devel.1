Received: from eggs.gnu.org ([2001:4830:134:3::10]:47637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoFfP-0005J0-Nh
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eoFfL-0004O3-Pw
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:41:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:49575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eoFfL-0004Mz-Ey
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 16:41:35 -0500
Date: Tue, 20 Feb 2018 22:41:33 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1802202225190.89213@zero.eik.bme.hu>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Moving seabios-hppa git submodule to use a
 qemu.org mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 20 Feb 2018, Peter Maydell wrote:
> I just noticed that we seem to have acquired another git
> submodule that isn't pointing to a qemu.org git url:
>
> [submodule "roms/seabios-hppa"]
>        path = roms/seabios-hppa
>        url = git://github.com/hdeller/seabios-hppa.git

And there's also

[submodule "roms/qemu-palcode"]
         path = roms/qemu-palcode
         url = git://github.com/rth7680/qemu-palcode.git

if that matters.

> Jeff, could we set up so we can mirror this repo on qemu.org?
> Then we can send a patch to update the .gitmodules to point to it.
>
> (There's also a patchset on list that wants to add a
> submodule for git://github.com/zbalaton/u-boot-sam460ex
> but I don't know if that will go in or not yet. Should

I think the patches that add the board are queued in the PPC tree and may 
be in next pull request (unless they have to be dropped for some reason) 
so it would be nice if this firmware could go in with that as well for the 
board to be usable without getting the firmware binary separately.

> we insist that we set up the mirror first for new
> submodules, or allow them in and fix things up after?
> By default we're doing the latter at the moment; the
> former seems cleaner but makes it more painful for
> contributors to get things added which need new
> submodules.)

I don't mind either way and don't expect to change this u-boot source too 
much in the future so if you just copy it to the qemu repo without 
mirroring my repo that's fine as well. (If any change will be needed I can 
submit patches for it like for other QEMU parts but this should not be 
needed too frequently as this firmware is not developed any further by 
upstream so only changes may be bugfixes from QEMU contributors.) But I 
can't do that myself so I need help with that. All I could do is to 
provide my own repo and refer to that for all else I need your help.

Thank you,
BALATON Zoltan
