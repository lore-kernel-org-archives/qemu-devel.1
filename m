Received: from eggs.gnu.org ([2001:4830:134:3::10]:49150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djoSg-0003jP-3l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1djoSf-0001uI-6t
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:17:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1djoSf-0001tp-07
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 11:17:53 -0400
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-10-cohuck@redhat.com>
	<feebff17-e4b8-2e00-9775-126055172564@linux.vnet.ibm.com>
	<20170821141353.32a1242c.cohuck@redhat.com>
	<aa499e7a-2692-d3b8-d3f5-c8bc1d5783d2@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <91e5cbdf-9d91-fc7f-3fb5-3727d73b1419@redhat.com>
Date: Mon, 21 Aug 2017 17:17:45 +0200
MIME-Version: 1.0
In-Reply-To: <aa499e7a-2692-d3b8-d3f5-c8bc1d5783d2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: zyimin@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On 21.08.2017 17:10, Halil Pasic wrote:
[...]
> The situation is just complicated by the fact that there is code which
> relies on assert(true) asserting for correctness (e.g. virtio goes so far
> to make builds with normal asserts disabled fail). Thus for me it's hard
> to assume that the assertion is guaranteed to be disabled in production.

FYI: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03608.html

 Thomas
