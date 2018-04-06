Received: from eggs.gnu.org ([2001:4830:134:3::10]:33940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f4Nk8-00005x-TT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f4Nk5-0003cL-0q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:33:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f4Nk4-0003cF-TT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:33:08 -0400
Date: Fri, 6 Apr 2018 11:33:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
References: <20180316074650.5415-1-kraxel@redhat.com>
	<7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

  Hi,

> The pages backing a DMA-buf are not allowed to move (at least not without a
> patch set I'm currently working on), but for certain MM operations to work
> correctly you must be able to modify the page tables entries and move the
> pages backing them around.
> 
> For example try to use fork() with some copy on write pages with this
> approach. You will find that you have only two options to correctly handle
> this.

The fork() issue should go away with shared memory pages (no cow).
I guess this is the reason why vgem is internally backed by shmem.

Hmm.  So I could try to limit the udmabuf driver to shmem too (i.e.
have the ioctl take a shmem filehandle and offset instead of a virtual
address).

But maybe it is better then to just extend vgem, i.e. add support to
create gem objects from existing shmem.

Comments?

cheers,
  Gerd
