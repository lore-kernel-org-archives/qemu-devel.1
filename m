Received: from eggs.gnu.org ([2001:4830:134:3::10]:33997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7FdZ-0005wu-HD
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7FdY-0006wE-AX
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7FdY-0006vq-4Y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:58:00 -0400
Date: Wed, 25 Oct 2017 07:57:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171025065755.GB27237@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171024085853.32615-1-aik@ozlabs.ru>
	<20171024162752.GA21671@redhat.com>
	<ef1eab70-8c55-0d75-e516-16ef6a419d04@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef1eab70-8c55-0d75-e516-16ef6a419d04@ozlabs.ru>
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
Cc: qemu-devel@nongnu.org

On Wed, Oct 25, 2017 at 12:45:10PM +1100, Alexey Kardashevskiy wrote:
> On 25/10/17 03:27, Daniel P. Berrange wrote:
> > On Tue, Oct 24, 2017 at 07:58:53PM +1100, Alexey Kardashevskiy wrote:
> >> The new git-submodule.sh script writes .git-submodule-status to
> >> the source directory every time no matter what. This makes it conditional.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>
> >> I compile out of tree on a remote guest system where I mount the
> >> source directory as "readonly" and build directory as "rw" and
> >> scripts/git-submodule.sh tries writing to the source directory even when
> >> I manually update modules on a host machine which is quite annoying.
> >>
> >> Is this something acceptable? Or I am missing something here?
> > 
> > How did you update the modules - did you manually run  'git submodule update...'
> > or did you use the git-submodule.sh script on your host machine ?
> 
> 
> I run scripts/git-submodule.sh. Which is not thrilling either as I rather
> expect source tree not to be affected in any way when running "make".

Oh, did you pass the list of sub-modules to it when running

eg, ./scripts/git-submodule.sh update ui/keycodemapdb

the list of submodules you need is printed in the configure output summary.

> > If you run git-submodule.sh on the host, then it should save the status
> > file, and then when you run make on the guest system, it should notice
> > that you're already updated and never even invoke 'git-submodule.sh update'
> 
> 
> scripts/git-submodule.sh also tries writing to the source directory (I
> should probably have fixed that branch too) but this failure is not fatal
> for "make" but makes it want to try "update" and then "make" fails.

This shouldn't have happened in your case though, if you have already run
'git-submodule.sh update ...list of modules...' on the host machine, with
the same list of modules that the guest 'configure' printed out.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
