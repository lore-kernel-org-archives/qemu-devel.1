Received: from eggs.gnu.org ([2001:4830:134:3::10]:56923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ey07r-0001Aq-7I
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:07:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ey07o-0007Nj-2n
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:07:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1ey07n-0007Ji-TN
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 15:07:15 -0400
Date: Mon, 19 Mar 2018 15:06:56 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180319190656.GK12302@localhost.localdomain>
References: <CAFEAcA887ukS-r6ECRG7rrCMzXO8PpJqjevR=sELc_LNfRazLA@mail.gmail.com>
	<20180221052735.GA2919@localhost.localdomain>
	<CAFEAcA8AA643WJGwF3fHEOtjw_Sx_1TeOf5UZFg9x_L2Ot6XYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8AA643WJGwF3fHEOtjw_Sx_1TeOf5UZFg9x_L2Ot6XYw@mail.gmail.com>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, BALATON Zoltan <balaton@eik.bme.hu>, pbonzini@redhat.com

On Mon, Mar 19, 2018 at 01:19:36PM +0000, Peter Maydell wrote:
> On 21 February 2018 at 05:27, Jeff Cody <jcody@redhat.com> wrote:
> > On Tue, Feb 20, 2018 at 06:43:22PM +0000, Peter Maydell wrote:
> >> I just noticed that we seem to have acquired another git
> >> submodule that isn't pointing to a qemu.org git url:
> >>
> >> [submodule "roms/seabios-hppa"]
> >>         path = roms/seabios-hppa
> >>         url = git://github.com/hdeller/seabios-hppa.git
> >>
> >> Jeff, could we set up so we can mirror this repo on qemu.org?
> >> Then we can send a patch to update the .gitmodules to point to it.
> >>
> >
> > Yes, of course... Although Paolo has suggested making it a branch of the
> > existing SeaBIOS repo instead.  But I can go ahead and get the clone setup,
> > in case we go that route.
> 
> Hi; can we get the mirror set up for seabios-hppa, and also for
> the other new repo:
>  git://github.com/zbalaton/u-boot-sam460ex
> 
> please?
> 
> (I've just sent a patch which moves the qemu-palcode module
> to the already-existing mirror.)
> 
> thanks
> -- PMM


Hi,

Both of these mirrors have been created, and are set to automatically
refresh like the other mirrors on qemu.org:

git://git.qemu.org/u-boot-sam460ex.git
https://git.qemu.org/git/u-boot-sam460ex.git


git://git.qemu.org/seabios-hppa.git
https://git.qemu.org/git/seabios-hppa.git


Let me know if there are any issues.


Paolo or Stefan,

If you create the repos for each of these under the qemu user on github,
I'll also enable pushing of these two mirrors to github (like we do with
other mirrors).


-Jeff
