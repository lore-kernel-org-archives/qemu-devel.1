Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAG3u-00059r-OD
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAG3n-000267-6H
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:01:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAG3m-00025W-QY
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:01:31 -0400
Message-ID: <1509631287.11873.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 02 Nov 2017 15:01:27 +0100
In-Reply-To: <9f8b07e3-2595-b6fe-17c2-b2b76bc2e65e@redhat.com>
References: <150960325077.8724.2785366469980820788.malonedeb@wampee.canonical.com>
	<9f8b07e3-2595-b6fe-17c2-b2b76bc2e65e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1729501] [NEW] qemu crashes with assertion
 error `off_cur_end >= off_cur' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Bug 1729501 <1729501@bugs.launchpad.net>, qemu-devel@nongnu.org

  Hi,

> > -device cirrus-vga,vgamem_mb=8

Don't do that.  cirrus has 4 MB video memory, like physical hardware
has.  And you can't change that (i.e. the guest wouldn't be able to use
it if you assign more).  The switch exists for live migration
compatibility only, because older qemu versions erroneously assigned
more than 4 MB to cirrus.

I expect you can't trigger the assert any more if you remove
"vgamem_mb=8".

cheers,
  Gerd
