Received: from eggs.gnu.org ([2001:4830:134:3::10]:42622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3p4-0006oE-WC
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds3p4-0001Pp-6O
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:19:06 -0400
References: <20170913091038.2900-1-cohuck@redhat.com>
	<20170913091038.2900-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7d703910-cd25-98fd-5382-2b8b62b10840@redhat.com>
Date: Wed, 13 Sep 2017 11:18:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170913091038.2900-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, haoqf@linux.vnet.ibm.com

On 13.09.2017 11:10, Cornelia Huck wrote:
> The default cpu model on s390x does not provide zPCI, which is
> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> on s390x, so use the -ccw instead of the -pci versions of virtio
> devices on s390x.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  tests/qemu-iotests/051        | 12 +++++++++++-
>  tests/qemu-iotests/051.out    |  2 +-
>  tests/qemu-iotests/051.pc.out |  2 +-
>  3 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
