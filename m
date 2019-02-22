Received: from eggs.gnu.org ([209.51.188.92]:49839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxBq4-0003RL-Kh
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:30:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxBq3-0002n4-Nl
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:30:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gxBq3-0002DB-Fn
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:30:07 -0500
Date: Fri, 22 Feb 2019 14:29:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222142921.GA25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<f262ecd7436fade16c88533f52c5ca4a08bc396d.1550698466.git.DirtY.iCE.hu@gmail.com>
	<20190222134042.GV25234@redhat.com>
	<20190222142235.42p7sijbbtpk2ysl@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190222142235.42p7sijbbtpk2ysl@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [libvirt] [PATCH v5 03/14] audio: -audiodev
 command line option: documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org, "reviewer:Incompatible changes" <libvir-list@redhat.com>

On Fri, Feb 22, 2019 at 03:22:35PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > >     * deprecated QEMU_AUDIO_ env vars
> > 
> > Libvirt does currently use these, so we'll need to update libvirt
> > code to use the new cli args
> 
> Note: The old vars will continue to work, and possibly it makes sense to
> keep at least QEMU_AUDIO_DRV (which I think is the only one used by
> libvirt) working a bit longer than the minimal deprecation period.

We can do the trivial replacement of QEMU_AUDIO_DRV with -audiodev
without much difficulty - just a matter of tweaking the CLI generator
and tests.

The full support with XML configurability doesn't need to block us
dropping use of QEMU_AUDIO_DRV.

> Also: This is a first step only, there is more in the pipeline, where
> you can assign sound cards to backends (simliar to -netdev). You might
> want wait for this to land before start working on libvirt support, or
> at least keep in bind this is coming when designing things.

Libvirt lacks proper support for the existing multi-seat features in
QEMU. This audio stuff might be a good motivation to finally implement
the full multi-seat feature set.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
