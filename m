Received: from eggs.gnu.org ([2001:4830:134:3::10]:51353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq9h-0002zO-9P
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq9b-0003zc-H6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:44:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwq9b-0003zK-B3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:44:03 -0400
Date: Tue, 26 Sep 2017 15:43:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926154356.638a0fcb.cohuck@redhat.com>
In-Reply-To: <cb323145-86e9-04b9-cb61-90bfabcf2c3a@de.ibm.com>
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-4-borntraeger@de.ibm.com>
	<a19a2b4f-af68-12d1-ee34-fbd174785c6f@redhat.com>
	<fc891aa4-d6f1-7348-3de7-cfa06ffa20c8@de.ibm.com>
	<49e66ee4-2df2-c310-93a7-e4ec91217c32@redhat.com>
	<cb323145-86e9-04b9-cb61-90bfabcf2c3a@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC 3/3] s390x/ais: disable ais for compat
 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 26 Sep 2017 15:32:41 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> I checked all the migration stuff now with -cpu z13 and it seems that
> migration is now broken for qemu 2.10->qemu 2.11 when using the s390-ccw-virtio-2.9
> machine due to the PCI fencing from Conny.
> 
> qemu-system-s390x: Unknown savevm section or instance 'PCIBUS' 0
> qemu-system-s390x: load of migration failed: Invalid argument

That's unfortunate... let me look into that.
