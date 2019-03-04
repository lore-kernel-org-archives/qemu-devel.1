Received: from eggs.gnu.org ([209.51.188.92]:59187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0l9L-0003E5-VQ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h0l9H-0006of-7m
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:48:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h0l9E-0006lg-Q3
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:48:41 -0500
Date: Mon, 4 Mar 2019 10:48:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190304104831.GI4239@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA_-wNGz_ftDziARUwzL2Lc+1kkoMTo0OxV4UVwbTr8EaQ@mail.gmail.com>
	<9b211327-06a8-9739-e984-4b05557c12b4@suse.de>
	<20190104050301.GB2801@umbus.fritz.box>
	<CAFEAcA9fyHiKOA7bDr8c_05C6rX_CYdj8nP+xFFSH_4uWbokhQ@mail.gmail.com>
	<20190304083806.GA12893@umbus.fritz.box>
	<2909f1ff-4714-50f5-64c6-2a0712510837@csgraf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2909f1ff-4714-50f5-64c6-2a0712510837@csgraf.de>
Subject: Re: [Qemu-devel] can we update QEMU's version of u-boot.e500 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@csgraf.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Mar 04, 2019 at 11:41:50AM +0100, Alexander Graf wrote:
> 
> 
> On 04.03.19 09:38, David Gibson wrote:
> > On Thu, Feb 28, 2019 at 01:23:38PM +0000, Peter Maydell wrote:
> >> On Fri, 4 Jan 2019 at 05:22, David Gibson <david@gibson.dropbear.id.au> wrote:
> >>>
> >>> On Fri, Jan 04, 2019 at 12:44:59AM +0100, Alexander Graf wrote:
> >>>>
> >>>>
> >>>> On 03.01.19 18:38, Peter Maydell wrote:
> >>>>> Hi; currently we ship with a u-boot.e500 which is from u-boot
> >>>>> v2017.07. It would be nice to move that forward, specifically
> >>>>> to at least v2017.11, which contains upstream u-boot's part of the
> >>>>> fix for https://bugs.launchpad.net/qemu/+bug/1714750 .
> >>>>> (There are more recent releases than that; it's just the first
> >>>>> that contains the fix.)
> >>>>>
> >>>>> Then we could remove the workaround in scripts/make-release and
> >>>>> close out the bug.
> >>>>>
> >>>>> I've cc'd David as the current maintainer of pc-bios/u-boot.e500
> >>>>> and Alex as the last person who did an update.
> >>>>
> >>>> I think it's a great idea to update it.
> >>>>
> >>>> David, do you want to do that or rather have me send a patch?
> >>>
> >>> Please send a patch.
> >>>
> >>> I'm maintainer of all the ppc boards by default, but I really don't
> >>> know anything much about e500 or u-boot.
> >>
> >> Hi -- any progress on this ? It would be nice to update the u-boot
> >> blob before QEMU hits softfreeze for the next release in a
> >> couple of weeks...
> > 
> > It would.  If there's been another patch, I haven't seen it though.
> 
> I wanted to build that on a PPC machine, but then realized I'd first
> have to set up a PPC VM to actually build on (as the host is LE), and
> that then somehow never happened.
> 
> Either way, I set myself up with a local cross compilation setup now, so
> you should ideally have a patch that bumps U-Boot on e500 to 2019.01.

FWIW, qemu source tree includes a dockerfile for cross-builds of QEMU
itself, perhaps it is useful for u-boot builds too:

   tests/docker/dockerfiles/debian-ppc64el-cross.docker

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
