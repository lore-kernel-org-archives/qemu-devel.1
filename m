Received: from eggs.gnu.org ([2001:4830:134:3::10]:42113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQVNZ-00028v-C0
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQVNV-0004Xz-AF
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:09:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQVNV-0004Xq-5C
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:09:17 -0400
References: <20180601162620.32362-1-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fcbe5483-fde8-9232-a0c1-255ae54fb983@redhat.com>
Date: Wed, 6 Jun 2018 12:09:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180601162620.32362-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/31] acpi, vhost, misc: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 01.06.2018 18:26, Michael S. Tsirkin wrote:
> The following changes since commit 63b88968f139b6a77f2f81e6f1eedf70c0170a85:
> 
>   intel-iommu: rework the page walk logic (2018-05-23 17:34:05 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 25b1d45a1975fd8624c37b5bf42e8502ccf53460:
> 
>   vhost-blk: turn on pre-defined RO feature bit (2018-06-01 19:20:38 +0300)
> 
> ----------------------------------------------------------------
> acpi, vhost, misc: fixes, features
> 
> vDPA support, fix to vhost blk RO bit handling, some include path
> cleanups, NFIT ACPI table.

I'm getting a warning during "make check" now:

acpi-test: Warning! SSDT mismatch. Actual [asl:/tmp/asl-SPL1JZ.dsl,
aml:/tmp/aml-L3C3JZ], Expected [asl:/tmp/asl-ME01JZ.dsl,
aml:tests/acpi-test-data/q35/SSDT.dimmpxm].

Do the test tables maybe need an update?

 Thomas
