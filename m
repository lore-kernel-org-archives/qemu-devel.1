Received: from eggs.gnu.org ([2001:4830:134:3::10]:45730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gA9zP-00083V-99
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gA9zM-0004p3-3u
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:37:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gA9zL-0004dQ-T6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 04:37:04 -0400
Date: Wed, 10 Oct 2018 10:37:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181010083700.za5zdwpxpvefalbn@sirius.home.kraxel.org>
References: <CAKXe6SJVhc6Nyz+kUVk5NK9nfN=PN2pTB-bZyOeVY2SP+POtqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXe6SJVhc6Nyz+kUVk5NK9nfN=PN2pTB-bZyOeVY2SP+POtqw@mail.gmail.com>
Subject: Re: [Qemu-devel] Strange behavior abount bootindex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, arei.gonglei@huawei.com, Qemu Developers <qemu-devel@nongnu.org>

  Hi,

> However, when I launch a VM with two virtio-blck-pci device:
> disk1.test, bootindex=1
> disk1, bootindex=2
> 
> I see the above picture alternately. Sometimes the hostname is "localhost",
> sometimes the hostname is "nimlite-test". Seems the bootindex has no effect.

I'd bet the root filesystem identity (uuid or lvm volume) is the same on
both disk images.  So whe linux looks for the root filesystem it may
pick the one or the other depending on which is initialized first.

cheers,
  Gerd
