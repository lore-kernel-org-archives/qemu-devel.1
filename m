Received: from eggs.gnu.org ([2001:4830:134:3::10]:36056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e08UY-0006P8-F5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e08US-0002V1-Ht
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e08US-0002Te-A1
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:55:12 -0400
Date: Thu, 5 Oct 2017 16:55:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171005155504.GK12106@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171005100106.30118-1-kraxel@redhat.com>
	<CAFEAcA-9F++KngXrHGE=t7qZhdU2gCGKKSwHXYdLR6EhEfO4Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-9F++KngXrHGE=t7qZhdU2gCGKKSwHXYdLR6EhEfO4Qg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/6] Ui 20171005 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 05, 2017 at 04:12:12PM +0100, Peter Maydell wrote:
> On 5 October 2017 at 11:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
> >
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kraxel.org/qemu tags/ui-20171005-pull-request
> >
> > for you to fetch changes up to 47247520ac44592cc7343138380bd6099f83262f:
> >
> >   ui: don't export qemu_input_event_new_key (2017-10-05 11:21:51 +0200)
> >
> > ----------------------------------------------------------------
> > ui: use keycodemapdb for key code mappings, part one
> >
> > ----------------------------------------------------------------
> 
> Fails to build, all platforms:
> 
> make: Entering directory `/home/pm215/qemu/build/all'
> config-host.mak is out-of-date, running configure
> make: *** No rule to make target `ui/input-keymap-linux-to-qcode.c',
> needed by `Makefile'. Stop.
> make: *** Waiting for unfinished jobs....
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> firmware path     /usr/local/share/qemu-firmware
> binary directory  /usr/local/bin
> library directory /usr/local/lib
> module directory  /usr/local/lib/qemu
> [etc]
> replication support yes
> VxHS block device no
> make: Leaving directory `/home/pm215/qemu/build/all'
> 
> That make complains about the missing .c file before it has
> finished running configure looks suspicious. I think there's
> a race here with parallel make.

Am I right in thinking from this snippet, that you applied the patch
series to an existing checkout with built files and then just did a
'make', as opposed todoing a git clean + configure + make sequence.

That would explain why this failed - the list of submodules is not
populated in the pre-existing config-host.mak. So we wouldn't checkout
the new submodules, and so the deps in the GENERATED_FILES list won't
be satisfied.  I'll figure out how to make this correctly cope with
gracefully upgrading from a dev's existing checkout...

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
