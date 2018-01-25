Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejX1-0003zn-Qw
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eejWx-0007Q4-0F
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eejWw-0007PK-RR
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:33:34 -0500
Date: Thu, 25 Jan 2018 15:33:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180125153320.GM1776@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20171222152531.1849-1-miika9764@gmail.com>
	<20180115151853.iduknw4f4y26b4lt@sirius.home.kraxel.org>
	<20180115153233.GP8218@redhat.com>
	<20180125152923.ehbu3yuqn3gth64g@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180125152923.ehbu3yuqn3gth64g@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] input: add keys and mouse buttons to
 virtio input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Miika S <miika9764@gmail.com>, qemu-devel@nongnu.org

On Thu, Jan 25, 2018 at 04:29:23PM +0100, Gerd Hoffmann wrote:
> On Mon, Jan 15, 2018 at 03:32:33PM +0000, Daniel P. Berrange wrote:
> > On Mon, Jan 15, 2018 at 04:18:53PM +0100, Gerd Hoffmann wrote:
> > >   Hi,
> > > 
> > > > Miika S (3):
> > > >   input: add mouse side buttons to virtio input
> > > >   input: virtio: don't send mouse wheel event twice
> > > 
> > > Cherry-picked these two ad the kbd update depends on the not-yet merged
> > > keycodemapdb update for virtio-keyboard.
> > 
> > It is merged actually in, so you can include the keycode fix too:
> > 
> > https://git.qemu.org/gitweb.cgi?p=keycodemapdb.git;a=commit;h=05dad417e9d0b37ee1fba33056d91a6b734b3357
> 
> To be exact: it conflicts (and I think also is obsoleted by) your patch
> "hw: convert virtio-input-hid device to keycodemapdb".

That patch doesn't touch keycodemapdb.

I did obsolete it though in an unrelated series:

  https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg03528.html

You should be fine to just include all 3 of the patches in this series,
if you do a pull request for this series, before that py3 series gets
pulled.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
