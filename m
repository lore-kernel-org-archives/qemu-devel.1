Received: from eggs.gnu.org ([209.51.188.92]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3er-0004fW-4L
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gx3eq-0005Mu-2s
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:46:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gx3ep-0005AM-PS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 00:45:59 -0500
Date: Fri, 22 Feb 2019 06:45:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190222054537.eisshk2bg73pcd5p@sirius.home.kraxel.org>
References: <20190220084753.9130-1-kraxel@redhat.com>
	<20190220084753.9130-2-kraxel@redhat.com>
	<20190220145435.1881d7a8@w520.home>
	<20190221073850.rgygkl3uyn4rxswl@sirius.home.kraxel.org>
	<20190221103450.4f37e60f@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221103450.4f37e60f@w520.home>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] vfio/display: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, intel-gvt-dev@lists.freedesktop.org

  Hi,

> This is the vdagent using installation like this:
> 
> https://www.ovirt.org/develop/infra/testing/spice.html
> 
> ie. vdservice install, net start vdservice?

If the page says so, probably.

I've tested the agent setup with linux only, where everything happens
automatically, you only have to make sure spice-vdagent.rpm is installed.

> I'm not seeing anything magically change when I do that.  I do have the
> default serial and redirection devices installed by virt-manager:

This one too?

    <channel type='spicevmc'>
      <target type='virtio' name='com.redhat.spice.0'/>
      <address type='virtio-serial' controller='0' bus='0' port='2'/>
    </channel>

cheers,
  Gerd
