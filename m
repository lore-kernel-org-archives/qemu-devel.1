Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwVUI-0005OH-GS
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwVUF-00060k-Er
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwVUF-00060R-8N
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:39:59 -0400
Date: Mon, 25 Sep 2017 17:39:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170925173954.11fba063.cohuck@redhat.com>
In-Reply-To: <2ec0f5a8-b12e-1b4a-8d6f-ecddedeecc78@linux.vnet.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<20170915190118.03dc1b57.cohuck@redhat.com>
	<1301a0dc-755f-1670-1062-b70ea86802e0@linux.vnet.ibm.com>
	<2ec0f5a8-b12e-1b4a-8d6f-ecddedeecc78@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, 25 Sep 2017 17:06:01 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> @Connie
> I would also like to have an account. 

Done (for both of you).

> I would also like to do a
> v2 of this somewhere in the not too distant future. I intend
> to address the issues pointed out by you here (chpid_type,
> cu_type). Another question is whether this should go under
> hw/misc/ like the pci-testdev? ccw-testdev would also probably
> be a better file name (that ccw-tester) regardless of in which
> folder does this belong. 

Probably not a bad idea to follow pci here.

> One more thing I am considering for
> v2 is this make it extensible argument. I had something like
> mode on my mind from the very beginning (fib would be one mode).
> The idea was to provide a control ccw for setting/getting the mode
> (something like virtio) as well as a device property for setting
> the initial mode (so that guest does not have to know about it).

Yes, a control ccw sounds nice, we should just make sure that it
doesn't collide with future tests (e.g. if we want to do some channel
program fuzzing). Alternatively, this could be controled by a diagnose,
which would be out of band (we can use a high function code for diag
500 that is unlikely to collide with future extensions).
