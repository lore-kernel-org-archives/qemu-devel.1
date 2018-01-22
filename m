Received: from eggs.gnu.org ([2001:4830:134:3::10]:50965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edXlD-0003Ba-GG
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 03:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1edXl8-0005iw-KR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 03:47:23 -0500
Date: Mon, 22 Jan 2018 09:47:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180122094710.61870cb6.cohuck@redhat.com>
In-Reply-To: <5450c5b0-8079-e562-3ecd-86e293bcf0b3@de.ibm.com>
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-2-borntraeger@de.ibm.com>
	<8c31b940-cc9e-d410-0e0d-46e6dc4c84f0@redhat.com>
	<5450c5b0-8079-e562-3ecd-86e293bcf0b3@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/3] header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Mon, 22 Jan 2018 09:31:43 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> kernel patch has now landed as 
> 
> commit 35b3fde6203b932b2b1a5b53b3d8808abc9c4f60
>     KVM: s390: wire up bpb feature
> 
> in Linus tree.
> 
> 
> The new number is
> #define KVM_CAP_S390_BPB 152
> (instead of 151)

I'll replace this with a proper header sync and push out later today.
