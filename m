Received: from eggs.gnu.org ([2001:4830:134:3::10]:49190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS0uI-0004ZT-C2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gS0uG-0001yV-SY
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gS0uG-0001xh-LG
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:36 -0500
Date: Wed, 28 Nov 2018 15:33:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181128143309.GA4222@dhcp-200-186.str.redhat.com>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133408.24538.77033.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010133408.24538.77033.stgit@pasha-VirtualBox>
Subject: Re: [Qemu-devel] [PATCH v7 06/19] qcow2: introduce icount field for
 snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dovgaluk@ispras.ru, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

Am 10.10.2018 um 15:34 hat Pavel Dovgalyuk geschrieben:
> This patch introduces the icount field for saving within the snapshot.
> It is required for navigation between the snapshots in record/replay mode.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> --
> 
> v2:
>  - documented format changes in docs/interop/qcow2.txt
>    (suggested by Eric Blake)

Acked-by: Kevin Wolf <kwolf@redhat.com>
