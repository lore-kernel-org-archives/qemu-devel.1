Received: from eggs.gnu.org ([2001:4830:134:3::10]:51063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flXap-0005zj-5f
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flXao-0005Jc-7l
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:45:59 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flXan-0005JN-Vg
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 06:45:58 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so9022207oie.5
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 03:45:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180803083830.775669-1-mst@redhat.com>
References: <20180803083830.775669-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Aug 2018 11:45:36 +0100
Message-ID: <CAFEAcA9r4K9qgFFqvRKqTFMUowyAAEV=QZEnhk3eheQRodbnvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] pc, virtio: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 August 2018 at 10:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> Please consider for 3.0 if there is another rc.
>
> The following changes since commit f7502360397d291be04bc040e9f96c92ff2d8030:
>
>   Update version for v3.0.0-rc3 release (2018-07-31 19:30:17 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1c707d6990eaf3db0c9dc4557bba5458977e9f8d:
>
>   tests/acpi: update tables after memory hotplug changes (2018-08-03 11:35:21 +0300)
>
> ----------------------------------------------------------------
> pc, virtio: fixes
>
> A couple of last minute fixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Dou Liyang (2):
>       hw/acpi-build: Add a check for memory-less NUMA nodes
>       tests/acpi-test: update ACPI tables test blobs
>
> Igor Mammedov (1):
>       pc: acpi: fix memory hotplug regression by reducing stub SRAT entry size
>
> Michael S. Tsirkin (1):
>       tests/acpi: update tables after memory hotplug changes
>
> Tiwei Bie (1):
>       vhost: check region type before casting

Can you clarify which of these are regressions from 2.12, please?
At this point in the release cycle I only want to apply fixes
for regressions. (Test only updates might also be OK, but I
need more information than just the commit message subject line.)

thanks
-- PMM
