Received: from eggs.gnu.org ([2001:4830:134:3::10]:43094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clXqw-0006kb-FV
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1clXqt-00053p-9A
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:25:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1clXqt-00051v-2q
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:25:47 -0500
Message-ID: <1488965141.6514.33.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 08 Mar 2017 10:25:41 +0100
In-Reply-To: <20170308085917.GC7135@pxdev.xzpeter.org>
References: <1488425538-13785-1-git-send-email-peterx@redhat.com>
	<20170302071100-mutt-send-email-mst@kernel.org>
	<213ff4bb-b3b9-fe00-6f0e-b75114e1a5ef@redhat.com>
	<1149211275.29885713.1488962150826.JavaMail.zimbra@redhat.com>
	<20170308085917.GC7135@pxdev.xzpeter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: check misordered init when
 realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, yi l liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

> Current QEMU should have no restriction on parameter ordering, right?
> Or do we have any existing case that:
>=20
>   "$QEMU -parameter1 -parameter2"
>=20
> will work, while...
>=20
>   "$QEMU -parameter2 -parameter1"
>=20
> won't work?

Well, we have.  If you, for example, add a scsi disk, you have to add a
scsi host adapter first.

cheers,
  Gerd
