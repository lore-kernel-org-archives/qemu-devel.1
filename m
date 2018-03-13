Received: from eggs.gnu.org ([2001:4830:134:3::10]:48896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evig1-00021s-2n
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1evifv-0001Pe-GP
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:05:09 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1evifv-0001PH-9s
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:05:03 -0400
Received: by mail-wr0-f195.google.com with SMTP id m4so9108180wrb.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:05:03 -0700 (PDT)
References: <1520937591-27088-1-git-send-email-pbonzini@redhat.com>
	<2c23a5aa-ea1f-b561-1b63-bdeca3bb0c25@de.ibm.com>
	<CAFEAcA9TJ0okEipdBrr+TmJOa2VN3TT2QhRs=Kx-6Gp8LO4xaw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9abfa500-0ed5-104f-eb15-27759be94a51@redhat.com>
Date: Tue, 13 Mar 2018 13:05:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9TJ0okEipdBrr+TmJOa2VN3TT2QhRs=Kx-6Gp8LO4xaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] update Linux headers to 4.15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13/03/2018 12:57, Peter Maydell wrote:
> On 13 March 2018 at 11:45, Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>
>> On 03/13/2018 11:39 AM, Paolo Bonzini wrote:
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  include/standard-headers/linux/input-event-codes.h |   1 +
>>>  include/standard-headers/linux/pci_regs.h          |  30 +-
>>>  include/standard-headers/linux/virtio_gpu.h        |   1 -
>>>  include/standard-headers/linux/virtio_net.h        |  13 +
>>>  include/standard-headers/linux/virtio_ring.h       |   2 +-
>>>  include/standard-headers/rdma/vmw_pvrdma-abi.h     |  13 +-
>>>  linux-headers/asm-powerpc/kvm.h                    |   2 +
>>>  linux-headers/asm-powerpc/unistd.h                 |   3 +
>>>  linux-headers/asm-s390/unistd.h                    | 401 +--------------------
>>>  linux-headers/asm-s390/unistd_32.h                 | 364 +++++++++++++++++++
>>>  linux-headers/asm-s390/unistd_64.h                 | 331 +++++++++++++++++
>>>  linux-headers/asm-x86/kvm_para.h                   |   5 +
>>>  linux-headers/linux/kvm.h                          |  92 +++++
>>>  linux-headers/linux/psci.h                         |   3 +
>>>  linux-headers/linux/vfio.h                         |  72 ++++
>>>  scripts/update-linux-headers.sh                    |   2 +
>>>  16 files changed, 918 insertions(+), 417 deletions(-)
>>>  create mode 100644 linux-headers/asm-s390/unistd_32.h
>>>  create mode 100644 linux-headers/asm-s390/unistd_64.h
>>
>> s390 part look sane.
> 
> ...patchew thinks it failed the build test on s390 though.

Yeah, I didn't catch it because virglrenderer is missing in the Docker
configs.  One recent virtio-gpu patch modified linux-headers/ with
something that's not yet in Linux's tree.

Paolo
