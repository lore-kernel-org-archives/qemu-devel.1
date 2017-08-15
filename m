Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdlK-00087r-TL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:28:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhdlF-00057q-Vy
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhdlF-00057Z-Os
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 11:28:05 -0400
Date: Tue, 15 Aug 2017 17:27:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815172755.39d3559b.cohuck@redhat.com>
In-Reply-To: <1502431076-22849-1-git-send-email-thuth@redhat.com>
References: <1502431076-22849-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 0/2] Improvements for the pxe
 tester
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <victork@redhat.com>

On Fri, 11 Aug 2017 07:57:54 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The first patch improves the buffer handling in the pxe tester a
> little bit by allocating a separate buffer on the heap for each
> architecture. This also gets rid of the huge pre-initialized
> array in the tester, shrinking the size of the executable by
> half of a megabyte!
> The second patch adds s390x support to the pxe tester. Starting
> with QEMU 2.10, the guest firmware on s390x can now net-boot via
> TFTP, too, so we can automatically test this code in the pxe tester.
> 
> v2: Adressed Cornelia's review feedback from the first version, e.g.:
>  - Use g_malloc0() instead of g_malloc()
>  - Use sizeof with parentheses
> 
> Thomas Huth (2):
>   tests/boot-sector: Do not overwrite the x86 buffer on other
>     architectures
>   tests/pxe: Check virtio-net-ccw on s390x
> 
>  tests/Makefile.include |  1 +
>  tests/boot-sector.c    | 61 +++++++++++++++++++++++++++++++++++++-------------
>  tests/pxe-test.c       |  7 ++++++
>  3 files changed, 54 insertions(+), 15 deletions(-)
> 

It's that question again: Who picks this up? :)

I can take it through the s390 tree if nobody else wants it.
