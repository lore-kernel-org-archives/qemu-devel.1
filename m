Received: from eggs.gnu.org ([209.51.188.92]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtF9d-0002V6-0a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:14:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gtEv9-0007KI-KM
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:59:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gtEv8-0007Bj-93
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:59:03 -0500
Date: Mon, 11 Feb 2019 16:58:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190211165756.GN2627@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] virtio-blk io bar size changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, changpeng.liu@intel.com, mst@redhat.com, stefanha@redhat.com
Cc: ldoktor@redhat.com

Hi,
  Luk=C3=A1=C5=A1 reported that there's a migration breakage between 3.1 =
and
current head with virtio-blk;   it looks like the io bar changes from 64
to 128 bytes and my bisect suggests it's:

commit caa1ee43131c060347b32893abd41fe4865eaa2e (HEAD, refs/bisect/bad)
Author: Changpeng Liu <changpeng.liu@intel.com>
Date:   Wed Jan 16 13:19:30 2019 +0800

    vhost-user-blk: add discard/write zeroes features support


How do we fix that?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
