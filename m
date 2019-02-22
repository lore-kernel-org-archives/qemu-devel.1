Received: from eggs.gnu.org ([209.51.188.92]:46296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gxBj0-0005vN-Dk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gxBis-0002f6-NS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:22:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gxBis-0002dL-9C
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:22:42 -0500
Date: Fri, 22 Feb 2019 15:22:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190222142235.42p7sijbbtpk2ysl@sirius.home.kraxel.org>
References: <cover.1550698466.git.DirtY.iCE.hu@gmail.com>
	<f262ecd7436fade16c88533f52c5ca4a08bc396d.1550698466.git.DirtY.iCE.hu@gmail.com>
	<20190222134042.GV25234@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222134042.GV25234@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org, "reviewer:Incompatible changes" <libvir-list@redhat.com>

  Hi,

> >     * deprecated QEMU_AUDIO_ env vars
> 
> Libvirt does currently use these, so we'll need to update libvirt
> code to use the new cli args

Note: The old vars will continue to work, and possibly it makes sense to
keep at least QEMU_AUDIO_DRV (which I think is the only one used by
libvirt) working a bit longer than the minimal deprecation period.

Also: This is a first step only, there is more in the pipeline, where
you can assign sound cards to backends (simliar to -netdev). You might
want wait for this to land before start working on libvirt support, or
at least keep in bind this is coming when designing things.

cheers,
  Gerd
