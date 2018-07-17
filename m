Received: from eggs.gnu.org ([2001:4830:134:3::10]:49814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOUd-0003tE-2w
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffOUZ-00044P-3g
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffOUY-000448-T0
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 07:50:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62DBE402312B
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:50:06 +0000 (UTC)
References: <20180717113402.5510-1-quintela@redhat.com>
	<20180717113402.5510-12-quintela@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ecb1b9b-dbe2-1e1d-609f-30374d86b698@redhat.com>
Date: Tue, 17 Jul 2018 13:50:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180717113402.5510-12-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/25] check: Only test hda when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 17.07.2018 13:33, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index af395b5f22..691f853ab6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -241,8 +241,8 @@ gcov-files-pci-y += hw/display/vga-pci.c
>  gcov-files-pci-y += hw/display/virtio-gpu.c
>  gcov-files-pci-y += hw/display/virtio-gpu-pci.c
>  gcov-files-pci-$(CONFIG_VIRTIO_VGA) += hw/display/virtio-vga.c
> -check-qtest-pci-y += tests/intel-hda-test$(EXESUF)
> -gcov-files-pci-y += hw/audio/intel-hda.c hw/audio/hda-codec.c
> +check-qtest-pci-$(CONFIG_HDA) += tests/intel-hda-test$(EXESUF)
> +gcov-files-pci-$(CONFIG_HDA) += hw/audio/intel-hda.c hw/audio/hda-codec.c
>  check-qtest-pci-$(CONFIG_IVSHMEM) += tests/ivshmem-test$(EXESUF)
>  gcov-files-pci-y += hw/misc/ivshmem.c
>  check-qtest-pci-y += tests/megasas-test$(EXESUF)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
