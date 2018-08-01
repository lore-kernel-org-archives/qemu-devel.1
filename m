Received: from eggs.gnu.org ([2001:4830:134:3::10]:47765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkuH6-00086R-Hw
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fkuH3-0001Il-8C
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 12:47:00 -0400
References: <20180801132733.15628-1-pbonzini@redhat.com>
	<8dd02a8d-093f-5592-d4ee-50cc4fba6de9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2782cf7d-214f-a408-e080-046c2b5a63d9@redhat.com>
Date: Wed, 1 Aug 2018 18:46:53 +0200
MIME-Version: 1.0
In-Reply-To: <8dd02a8d-093f-5592-d4ee-50cc4fba6de9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] tests: virtio: separate ccw
 tests from libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, e.emanuelegiuseppe@gmail.com

On 01/08/2018 18:39, Thomas Huth wrote:
> I think you could omit the virtio_net_nop test here, since we already
> check that device in tests/pxe-test.c (and maybe also virtio_blk and
> virtio_scsi since they are tested in tests/cdrom-test.c).
> 
> Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks Conny and Thomas for the quick review.

Emanuele, please add this patch to your qgraph branch!  You can use "git
am -s" and cut-and-paste the original message source from thunderbird or
gmail into the Terminal.

Paolo
