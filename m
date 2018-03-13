Received: from eggs.gnu.org ([2001:4830:134:3::10]:46274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eviZ4-00066k-1j
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eviZ3-00062U-86
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:57:58 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37033)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eviZ3-00062A-31
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:57:57 -0400
Received: by mail-ot0-x243.google.com with SMTP id t2so18642618otj.4
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:57:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2c23a5aa-ea1f-b561-1b63-bdeca3bb0c25@de.ibm.com>
References: <1520937591-27088-1-git-send-email-pbonzini@redhat.com>
	<2c23a5aa-ea1f-b561-1b63-bdeca3bb0c25@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 11:57:35 +0000
Message-ID: <CAFEAcA9TJ0okEipdBrr+TmJOa2VN3TT2QhRs=Kx-6Gp8LO4xaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] update Linux headers to 4.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>

On 13 March 2018 at 11:45, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>
> On 03/13/2018 11:39 AM, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  include/standard-headers/linux/input-event-codes.h |   1 +
>>  include/standard-headers/linux/pci_regs.h          |  30 +-
>>  include/standard-headers/linux/virtio_gpu.h        |   1 -
>>  include/standard-headers/linux/virtio_net.h        |  13 +
>>  include/standard-headers/linux/virtio_ring.h       |   2 +-
>>  include/standard-headers/rdma/vmw_pvrdma-abi.h     |  13 +-
>>  linux-headers/asm-powerpc/kvm.h                    |   2 +
>>  linux-headers/asm-powerpc/unistd.h                 |   3 +
>>  linux-headers/asm-s390/unistd.h                    | 401 +--------------------
>>  linux-headers/asm-s390/unistd_32.h                 | 364 +++++++++++++++++++
>>  linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
>>  linux-headers/asm-x86/kvm_para.h                   |   5 +
>>  linux-headers/linux/kvm.h                          |  92 +++++
>>  linux-headers/linux/psci.h                         |   3 +
>>  linux-headers/linux/vfio.h                         |  72 ++++
>>  scripts/update-linux-headers.sh                    |   2 +
>>  16 files changed, 918 insertions(+), 417 deletions(-)
>>  create mode 100644 linux-headers/asm-s390/unistd_32.h
>>  create mode 100644 linux-headers/asm-s390/unistd_64.h
>
> s390 part look sane.

...patchew thinks it failed the build test on s390 though.

thanks
-- PMM
