Received: from eggs.gnu.org ([2001:4830:134:3::10]:40766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwDU-0001Wm-FA
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUwDP-0004A5-Jn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUwDP-00049t-DV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:32:39 -0400
Date: Tue, 11 Jul 2017 16:32:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711163228.651abd7f@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499781397-19749-11-git-send-email-thuth@redhat.com>
References: <1499781397-19749-1-git-send-email-thuth@redhat.com>
	<1499781397-19749-11-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 10/11] pc-bios/s390-ccw: Add virtio-net
 driver code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>

On Tue, 11 Jul 2017 15:56:36 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The driver provides the recv() and send() functions which will
> be required by SLOF's libnet code for receiving and sending
> packets.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/netboot.mak  |   2 +-
>  pc-bios/s390-ccw/virtio-net.c | 135 ++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/virtio.c     |   5 ++
>  pc-bios/s390-ccw/virtio.h     |  12 +++-
>  4 files changed, 151 insertions(+), 3 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/virtio-net.c

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
