Received: from eggs.gnu.org ([2001:4830:134:3::10]:36387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPR0B-0002DU-CL
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dPR0A-0001Ql-9L
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 06:12:15 -0400
Date: Mon, 26 Jun 2017 11:12:04 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170626101204.GF495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <0f83a15d-66b0-36aa-e5a4-d03cd37757c9@kamp.de>
	<20170626082838.GA4348@noname.redhat.com>
	<0e6586f9-85eb-efcd-4825-20066a7c869a@kamp.de>
	<20170626095719.GB4348@noname.redhat.com>
	<b82ab934-ddc3-2d50-09cf-764f2165f2c8@kamp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b82ab934-ddc3-2d50-09cf-764f2165f2c8@kamp.de>
Subject: Re: [Qemu-devel] QCOW2 support for LZO compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, den@openvz.org, Laszlo Ersek <lersek@redhat.com>

On Mon, Jun 26, 2017 at 12:08:01PM +0200, Peter Lieven wrote:
> Am 26.06.2017 um 11:57 schrieb Kevin Wolf:
> > Am 26.06.2017 um 11:20 hat Peter Lieven geschrieben:
> > > > So he chose a different algorithm (zstd). When I asked, he posted a
> > > > comparison of algorithms (however a generic one and not measured in the
> > > > context of qemu) that suggests that LZO would be slightly faster, but
> > > > have a considerable worse compression ratio with the settings that were
> > > > benchmarked.
> > > My idea to choose LZO was that it is widely available and available in
> > > any distro you can think of. We already have probing for it in configure.
> > > My concern with ZSTD would be that it seems there are no packages
> > > available for most distros and that it seems to be multi-threaded. I don't
> > > know if this will cause any trouble?
> > The availability and that we already link against LZO is a good point. I
> > think we want to avoid a situation where compressed qcow2 files can't be
> > read by binaries of popular distributions - after all, downloadable
> > images are an important use case for compressed images.
> 
> As long as the default remains gzip I don't see any issues. If you choose
> a different algorithm, you should know what you are doing.

The problem comes if Debian were to choose to only link in ZSTD, and RHEL
were choose to only link LZO. Images distributed by one distro, with this
new compression would be unusuable on other distros. So whatever compression
format we choose to add should be something we are confident that all distros
will be happy enabling by default. This favours libraries are already widely
included in distros, especially if QEMU already links to them indirectly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
