Received: from eggs.gnu.org ([2001:4830:134:3::10]:41918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1eCP6s-0002mu-EH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1eCP6o-0002ky-Dz
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:57196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <msuchanek@suse.de>) id 1eCP6o-0002jz-6v
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 07:05:30 -0500
Date: Wed, 8 Nov 2017 13:05:27 +0100
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20171108130527.0afeb899@kitsune.suse.cz>
In-Reply-To: <20171108102529.GL12670@redhat.com>
References: <7967e55c-de72-6ef2-eb92-a85af8fc2552@redhat.com>
	<20171108102529.GL12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Yet another git submodule rant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, 8 Nov 2017 10:25:29 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Wed, Nov 08, 2017 at 10:57:21AM +0100, Thomas Huth wrote:
> > 
> > That automatic git submodule stuff now broke my workflow again. I
> > usually keep the git repository on my laptop and then simply rsync
> > the sources (without .git directories) to my target machine to
> > compile it there. Used to work great for years. Now it's broken,
> > the build process complains:  
> 
> Excluding the .git dir will be a problem - that needs to exist, unless
> you are building from tar.xz (where we will bundled all the submodule
> sources together in the tar.xz).
> 
> If you really want to exclude the .git directories, then instead of
> doing an rsync, then use the scripts/archive-source.sh tool to create
> an archive of all the sources (which bundles required submodules)
> and unpack that on your target machine. Then all submodule handling
> on the target will be skipped.

This probably does not work because it archives committed sources and
not actual sources.

> 
> > 
> > GIT submodule checkout is out of date. Please run
> >   scripts/git-submodule.sh update
> > from the source directory checkout /home/thuth/devel/qemu
> > 
> > Running "scripts/git-submodule.sh update" did not fix the issue at
> > all - I first had to tinker with it for a while to find out that I
> > simply have to delete ".git-submodule-status" in my git tree to fix
> > the issue.  
> 
> I think it got confused from you deleting the .git directory
> 
> > I've got the feeling that all this submodule crap is constantly
> > causing pain ... do we really need this? Can't we find another
> > solution instead? Or at least stop modifying files automatically in
> > the $SRC_PATH ?  
> 
> We *have* to modify SRC_PATH, as that's where git submodule checkouts
> live. If we didn't do that, then people would end up having failed
> build due to submodules not existing, or even worse, having a silently
> incorrect build due to using the wrong checked out version.

And that's another reason why submodules are bad thing.

So again, can this be done without submodules?

Let somebody else do the testing and polishing of this pre-alpha git
feature.

Thanks

Michal
