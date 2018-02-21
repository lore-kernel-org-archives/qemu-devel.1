Received: from eggs.gnu.org ([2001:4830:134:3::10]:35473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eoMwf-0007U2-MF
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 00:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eoMwc-0005bv-D5
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 00:27:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1eoMwc-0005bc-7R
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 00:27:54 -0500
Date: Wed, 21 Feb 2018 00:27:35 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180221052735.GA2919@localhost.localdomain>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, BALATON Zoltan <balaton@eik.bme.hu>

On Tue, Feb 20, 2018 at 06:43:22PM +0000, Peter Maydell wrote:
> I just noticed that we seem to have acquired another git
> submodule that isn't pointing to a qemu.org git url:
> 
> [submodule "roms/seabios-hppa"]
>         path = roms/seabios-hppa
>         url = git://github.com/hdeller/seabios-hppa.git
> 
> Jeff, could we set up so we can mirror this repo on qemu.org?
> Then we can send a patch to update the .gitmodules to point to it.
> 

Yes, of course... Although Paolo has suggested making it a branch of the
existing SeaBIOS repo instead.  But I can go ahead and get the clone setup,
in case we go that route.

> (There's also a patchset on list that wants to add a
> submodule for git://github.com/zbalaton/u-boot-sam460ex
> but I don't know if that will go in or not yet. Should
> we insist that we set up the mirror first for new
> submodules, or allow them in and fix things up after?
> By default we're doing the latter at the moment; the
> former seems cleaner but makes it more painful for
> contributors to get things added which need new
> submodules.)
> 

My thought: while not as clean, I think it makes sense in general to allow a
patchset in first, and then switch it over later.  If we require a mirror on
qemu.org first, then we could end up creating mirrors that are never used,
if patches are rejected for some other reason and the submodule goes unused.
By doing the mirror later, the patchset goes through normal review and the
submodule is committed, and so we know for sure at that point we want the
mirror.


-Jeff
