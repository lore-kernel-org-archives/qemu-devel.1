Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etbDS-0006lc-Qi
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etbDP-0004Pv-LN
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:42:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etbDP-0004Pm-GT
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:42:51 -0500
Date: Wed, 7 Mar 2018 16:42:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180307154240.j7wlisuo3q7zbgqg@sirius.home.kraxel.org>
References: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
	<20180305103307.GL17368@redhat.com>
	<20180307141118.cbgvj55p4wcrphyw@sirius.home.kraxel.org>
	<CAFEAcA-j_tZVKwnKzQP6bHahxHUge53vibgkVyVQFmDzS4F7Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-j_tZVKwnKzQP6bHahxHUge53vibgkVyVQFmDzS4F7Zg@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU fails to configure on non-x86 hosts with
 recent SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Mar 07, 2018 at 02:18:02PM +0000, Peter Maydell wrote:
> On 7 March 2018 at 14:11, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   Hi,
> >
> >> Drop -Wundef when running the configiure test, or override it with -Wno-undef
> >>
> >> If the actual ui/sdl* files fail for same reason, we could use a gcc
> >> pragma top disable -Wundef in just those files, or set -Wno-undef in
> >> CFLAGS on a per-.o file basis in Makefile.objs
> >
> > What is the status here?  Could you try this peter?  Don't have a test
> > box with SDL 2.0.8 at hand ...
> 
> Haven't tried it, but I'm pretty sure it would work. For the
> moment I just passed --disable-sdl to configure...

Ok, fedora rawhide has updated packages too.  With that recompiled I can
reproduce the issue.  The workaround is a one-liner, for both configure
and the sdl object builds.

cheers,
  Gerd
