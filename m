Received: from eggs.gnu.org ([2001:4830:134:3::10]:53162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejT1-0001I2-KX
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:29:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eejSz-0002bg-0k
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:29:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eejSy-0002ap-RM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:29:28 -0500
Date: Thu, 25 Jan 2018 16:29:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125152923.ehbu3yuqn3gth64g@sirius.home.kraxel.org>
References: <20171222152531.1849-1-miika9764@gmail.com>
	<20180115151853.iduknw4f4y26b4lt@sirius.home.kraxel.org>
	<20180115153233.GP8218@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115153233.GP8218@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Miika S <miika9764@gmail.com>, qemu-devel@nongnu.org

On Mon, Jan 15, 2018 at 03:32:33PM +0000, Daniel P. Berrange wrote:
> On Mon, Jan 15, 2018 at 04:18:53PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > Miika S (3):
> > >   input: add mouse side buttons to virtio input
> > >   input: virtio: don't send mouse wheel event twice
> > 
> > Cherry-picked these two ad the kbd update depends on the not-yet merged
> > keycodemapdb update for virtio-keyboard.
> 
> It is merged actually in, so you can include the keycode fix too:
> 
> https://git.qemu.org/gitweb.cgi?p=keycodemapdb.git;a=commit;h=05dad417e9d0b37ee1fba33056d91a6b734b3357

To be exact: it conflicts (and I think also is obsoleted by) your patch
"hw: convert virtio-input-hid device to keycodemapdb".

cheers,
  Gerd
