Received: from eggs.gnu.org ([2001:4830:134:3::10]:34650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e2e3x-0006Mg-JQ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e2e3u-0001Nj-Cd
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1e2e3u-0001Mx-6p
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:02:10 -0400
Date: Thu, 12 Oct 2017 10:01:59 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171012140159.GA11619@localhost.localdomain>
References: <CAFEAcA81AZBaGu6nrLK51_6vWApMSpMDhb9OsnkdApMGebYK8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA81AZBaGu6nrLK51_6vWApMSpMDhb9OsnkdApMGebYK8w@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu.org: new git repos to be mirrored
 (qemu-palcode, capstone, keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Oct 12, 2017 at 01:42:54PM +0100, Peter Maydell wrote:
> On 12 October 2017 at 11:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> > On Thu, Oct 12, 2017 at 12:13:23PM +0200, Gerd Hoffmann wrote:
> >> On Thu, 2017-10-12 at 11:07 +0100, Daniel P. Berrange wrote:
> >> > On Thu, Oct 12, 2017 at 12:04:47PM +0200, Gerd Hoffmann wrote:
> >> > > Hmm, so maybe we should mirror the thing on git.qemu.org and use
> >> > > that?
> >> >
> >> > Can that be made 100% automated - I don't want to have to push
> >> > changes to
> >> > two different git repos.
> >>
> >> Yes, seabios works that way for example.
> >
> > Ok, lets do that mirror then we can use git:// and we're consistent with
> > other submodules we use
> 
> We also have RTH's capstone disassembler patchset which wants to
> use capstone as a more-or-less-required dependency, and we have
> the one loose end in our current submodules that the qemu-palcode
> rom is using a non-qemu.org URL.
> 
> So can we set up these repos to be mirrored on qemu.org:
>  * git://github.com/rth7680/qemu-palcode.git
>  * https://github.com/aquynh/capstone.git
>  * https://gitlab.com/keycodemap/keycodemapdb.git
> 
> please?
> 
> thanks

Done.

The git.qemu.org URLs are:

git://git.qemu.org/capstone.git
https://git.qemu.org/git/capstone.git

git://git.qemu.org/keycodemapdb.git
https://git.qemu.org/git/keycodemapdb.git

git://git.qemu.org/qemu-palcode.git
https://git.qemu.org/git/qemu-palcode.git


And of course they can also be viewed via the gitweb interface:

https://git.qemu.org/


I have NOT set these to push to our github mirror account, since I assume it
is read-only.  Would you prefer I go ahead and mirror them there as well,
anyway?


-Jeff
