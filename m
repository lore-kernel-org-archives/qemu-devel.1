Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duZJW-0005uI-Ix
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duZJT-0004fz-4K
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:20:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duZJS-0004dU-Tr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:20:51 -0400
Date: Wed, 20 Sep 2017 09:20:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920092037.7acd932b.cohuck@redhat.com>
In-Reply-To: <0f9f4972-c7eb-1af5-af78-141cbbd41876@de.ibm.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
	<0f9f4972-c7eb-1af5-af78-141cbbd41876@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/38] various s390x patches (+some fixes)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, david@redhat.com

On Tue, 19 Sep 2017 19:03:13 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/19/2017 06:42 PM, Cornelia Huck wrote:
> > The following changes since commit 7ec6a364916c0d1eba01128481e503a550a2b466:
> > 
> >   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-19 15:44:07 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://github.com/cohuck/qemu tags/s390x-20170919-v2
> > 
> > for you to fetch changes up to 9d1c4449218d8a2e98a6a11688b09b9137f25c1c:
> > 
> >   MAINTAINERS/s390x: add terminal3270.c (2017-09-19 18:31:32 +0200)
> > 
> > ----------------------------------------------------------------
> > Assorted s390x patches:
> > - introduce virtio-gpu-ccw, with virtio-gpu endian fixes
> > - lots of cleanup in the s390x code
> > - make device_add work for s390x cpus
> > - enable seccomp on s390x
> > - an ivshmem endian fix
> > - set the reserved DHCP client architecture id for netboot
> > - fixes in the css and pci support
> > 
> > ----------------------------------------------------------------  
> 
> What happened to the indirect data access patches from Halil? Last time I checked
> you said "applied thanks"?
> 

I had dequeued them, as there was still way too much discussion on the
patches. I expect Halil to send a v3 with the feedback addressed.

[Ah, I see that you were not on cc: on the discussion...]
