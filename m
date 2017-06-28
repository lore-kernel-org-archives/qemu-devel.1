Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dQ7zZ-00061C-OU
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dQ7zU-0000NY-Qd
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dQ7zU-0000Mz-LC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:06:24 -0400
Message-ID: <1498637173.25123.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 28 Jun 2017 10:06:13 +0200
In-Reply-To: <b4bba4e4-0d69-095e-5fe2-0042bc414093@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
	<589b8e71-b025-a0ad-0621-d6827e31c90d@suse.de>
	<b4bba4e4-0d69-095e-5fe2-0042bc414093@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/14] Implement network booting
 directly into the s390-ccw BIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfreiman@redhat.com>, David Hildenbrand <david@redhat.com>

  Hi,

> > IMHO the only viable next step would be to support UEFI and build
> > on top
> > of that - either by porting edk2 or U-Boot to s390x.
> 
> I can't speak of U-Boot, but you certainly don't want to port edk2 to
> a big endian machine. Been there, seen that.

> would really be a knowledge sharing nightmare? I think they would be
> more common for "server" people than the U-Boot loader, which is
> likely
> only familiar to "embedded" folks.

Well, u-boot supports some[1] EFI interfaces these days, so you can run
standard efi grub2 on embedded arm boards.  From that point of view
porting uboot to s390 might not be as silly as it initially looks like.

cheers,
  Gerd

[1] barely enough to make grub2 happy.
