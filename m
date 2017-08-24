Received: from eggs.gnu.org ([2001:4830:134:3::10]:42346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkqJv-000099-44
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dkqJq-0006UM-6g
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dkqJp-0006U3-W9
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 07:29:02 -0400
Date: Thu, 24 Aug 2017 13:28:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824132855.4f395982.cohuck@redhat.com>
In-Reply-To: <1503569328-22197-1-git-send-email-thuth@redhat.com>
References: <1503569328-22197-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/s390x/s390-skeys: Mark the
 storage key devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Thu, 24 Aug 2017 12:08:48 +0200
Thomas Huth <thuth@redhat.com> wrote:

> QEMU currently aborts if the user tries to create a skey device:
> 
> $ s390x-softmmu/qemu-system-s390x -nographic -device s390-skeys-qemu
> qemu-system-s390x: hw/s390x/s390-skeys.c:30: s390_get_skeys_device:
>  Assertion `ss' failed.
> Aborted (core dumped)
> 
> The storage key devices are only meant to be instantiated one time,
> internally. They can not be used by the user, so mark them with
> user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-skeys-kvm.c | 4 ++++
>  hw/s390x/s390-skeys.c     | 4 ++++
>  2 files changed, 8 insertions(+)

Thanks, applied.
