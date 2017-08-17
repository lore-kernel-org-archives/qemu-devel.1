Received: from eggs.gnu.org ([2001:4830:134:3::10]:44650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGq2-0005Pm-Ab
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1diGpy-0001Gg-9l
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1diGpx-0001Fv-W6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:11:34 -0400
Date: Thu, 17 Aug 2017 11:11:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170817111116.79e918e9.cohuck@redhat.com>
In-Reply-To: <1502951113-4246-1-git-send-email-thuth@redhat.com>
References: <1502951113-4246-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/6] Enable more qtests for s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Fan Zhang <zhangfan@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Marc Mari <markmb@redhat.com>, Cleber Rosa <crosa@redhat.com>, Michael S Tsirkin <mst@redhat.com>

On Thu, 17 Aug 2017 08:25:07 +0200
Thomas Huth <thuth@redhat.com> wrote:

> We currently do not have many tests enabled for QEMU on s390x yet,
> so this series reworks some of the tests to be also usable on s390x
> to get some extended test coverage there.

More coverage on s390x is certainly desirable. I'm wondering how many
other tests are needlessly restricted to certain architectures as
well...

> 
> Along the way, this also cleans up some of the generic test code,
> e.g. by introducing generic functions to do hot-plugging with
> the device_add QMP command.

Cleanup also sounds good :)

> 
> Please review!
> 
>  Thanks,
>   Thomas
> 
> 
> Thomas Huth (6):
>   tests: Run filter-redirector and -mirror test only on POSIX systems
>   tests: Add network filter tests to the check-qtest-s390x list

I think these two are fine as-is.

>   tests: Enable the drive_del test also on s390x
>   tests: Introduce generic device hot-plug/hot-unplug functions
>   tests: Add qvirtio_(un)plug_device_test wrapper functions
>   tests: Enable the simple virtio tests on s390x, too

But these probably need some work (or at least, some thought.)

> 
>  tests/Makefile.include         | 20 +++++++++-----
>  tests/drive_del-test.c         | 13 ++++-----
>  tests/libqos/pci.c             | 19 ++-----------
>  tests/libqos/usb.c             | 30 +++++----------------
>  tests/libqos/virtio.c          | 29 ++++++++++++++++++++
>  tests/libqos/virtio.h          |  5 ++++
>  tests/libqtest.c               | 60 ++++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.h               | 19 +++++++++++++
>  tests/test-filter-mirror.c     | 14 +++++-----
>  tests/test-filter-redirector.c | 32 +++++++++++-----------
>  tests/test-netfilter.c         | 11 +++++++-
>  tests/usb-hcd-uhci-test.c      | 26 ++----------------
>  tests/usb-hcd-xhci-test.c      | 51 +++--------------------------------
>  tests/virtio-balloon-test.c    |  6 ++---
>  tests/virtio-console-test.c    | 12 ++++-----
>  tests/virtio-net-test.c        |  8 ++----
>  tests/virtio-rng-test.c        | 17 +++++-------
>  tests/virtio-scsi-test.c       | 24 ++---------------
>  tests/virtio-serial-test.c     | 33 +++++------------------
>  19 files changed, 208 insertions(+), 221 deletions(-)
> 

The big question remains again: Who merges this? I can merge this
through the s390x tree if there are no other takers.
