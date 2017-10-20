Received: from eggs.gnu.org ([2001:4830:134:3::10]:50662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Wfo-00074f-0E
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5Wfm-000716-RK
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5Wfm-00070R-JJ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:45:10 -0400
Date: Fri, 20 Oct 2017 13:45:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171020124501.GL21172@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
	<CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Chen, Farrah" <farrah.chen@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hu, Robert" <robert.hu@intel.com>

On Fri, Oct 20, 2017 at 01:41:59PM +0100, Peter Maydell wrote:
> On 20 October 2017 at 13:13, Chen, Farrah <farrah.chen@intel.com> wrote:
> > Hi,
> >
> > When I build qemu with commit from aef45d51d1204f3335fb99de6658e0c5612c2b67 to the latest one, the following error occurred:
> >
> > tsocks git clone git://git.qemu.org/qemu.git
> > cd qemu
> >
> > ./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --disable-gtk --enable-libusb --enable-numa --disable-sdl
> > make
> >   GEN     config-host.h
> >   GIT     dtc
> >   GEN     trace/generated-tcg-tracers.h
> >   GEN     trace/generated-helpers-wrappers.h
> >   GEN     trace/generated-helpers.h
> >   GEN     module_block.h
> >   GEN     trace/generated-helpers.c
> > make: *** [git-submodule-update] Error 1
> 
> Dan -- I thought we were going to not have the git-submodule.sh
> script throw away the errors from git, but the version in
> master still seems to do that...

Urgh, yes, we did fix that, but it seems it got lost in one of the
rebases somewhere along the way. I'll send a patch to fix it.

> (The fact you needed to say 'tsocks git clone...' on your
> original command suggests to me that the problem is that
> plain 'git submodule update' can't access the git repo.)

Yep, creating the wrapper script called 'git' that runs
'exec tsocks /usr/bin/git "$@"'  is the way to deal with this for
QEMU, and indeed any project using git.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
