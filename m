Received: from eggs.gnu.org ([2001:4830:134:3::10]:55882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djll7-0006xK-5Z
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djll4-0004PY-Bi
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1djll4-0004PE-5D
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:24:42 -0400
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-5-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2d8e10ff-915a-bc8f-a1d5-c42815ce3637@redhat.com>
Date: Mon, 21 Aug 2017 14:24:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/10] s390x: chsc nt2 events are
 pci-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 21.08.2017 11:16, Cornelia Huck wrote:
> The nt2 event class is pci-only - don't look for events if pci is
> not in the active cpu model.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/s390-pci-bus.c  |  4 ++--
>  hw/s390x/s390-pci-bus.h  |  4 ++--
>  hw/s390x/s390-pci-stub.c |  4 ++--
>  target/s390x/ioinst.c    | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
