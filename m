Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNLWx-00071Y-3Y
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eNLWu-00061u-15
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 11:29:43 -0500
References: <20171208160207.26494-1-david@redhat.com>
	<20171208160207.26494-15-david@redhat.com>
	<20171208172604.2bf84cee.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d6afc0f3-5c27-584b-125c-bb4f51cf523b@redhat.com>
Date: Fri, 8 Dec 2017 17:29:36 +0100
MIME-Version: 1.0
In-Reply-To: <20171208172604.2bf84cee.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12 14/14] s390x: change the QEMU
 cpu model to a stripped down z12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On 08.12.2017 17:26, Cornelia Huck wrote:
> On Fri,  8 Dec 2017 17:02:07 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> We are good enough to boot upstream Linux kernels / Fedora 26/27. That
>> should be sufficient for now.
>>
>> As the QEMU CPU model is migration safe, let's add compatibility code.
>> Generate the feature list to reduce the chance of messing things up in the
>> future.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio-ccw.c  |   8 ++++
>>  target/s390x/cpu.h          |   3 ++
>>  target/s390x/cpu_models.c   | 100 ++++++++++++++++++--------------------------
>>  target/s390x/cpu_models.h   |   1 +
>>  target/s390x/gen-features.c |  87 ++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 140 insertions(+), 59 deletions(-)
> 
> Unfortunately, this patch makes mingw unhappy (x86_64-w64-mingw32 on my
> F26 laptop):
> 
> In file included from /home/cohuck/git/qemu/target/s390x/cpu_models.h:17:0,
>                  from /home/cohuck/git/qemu/target/s390x/cpu.h:28,
>                  from /home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:16:
> /home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c: In function 'ccw_machine_2_12_instance_options':
> ./gen-features.h:96:35: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
>  #define S390_FEAT_LIST_QEMU_V2_12 0x3000e918fd6de14fULL,0x000ffffff0000000ULL,0x0000000000000000ULL,0x0000000000000000ULL
>                                    ^
> /home/cohuck/git/qemu/hw/s390x/s390-virtio-ccw.c:728:51: note: in expansion of macro 'S390_FEAT_LIST_QEMU_V2_12'
>      static const S390FeatBitmap qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V2_12 };
>                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~

Huh? we have ULL added to all constants, this should not get reported.

-- 

Thanks,

David / dhildenb
