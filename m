Received: from eggs.gnu.org ([2001:4830:134:3::10]:48105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT81P-0005Hs-Kr
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dT81O-0001dp-SU
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:44:47 -0400
References: <149934999661.27.13789728207994914021@f0098f8687cc>
	<1ff791c6-a914-2a26-e5d2-683cacc82b86@redhat.com>
	<20170706143623.GA28118@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6e3845c-a172-a6b9-529f-4d8cba624dd5@redhat.com>
Date: Thu, 6 Jul 2017 16:44:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170706143623.GA28118@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/6] block: Add VFIO based driver for
 NVMe device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, keith.busch@intel.com, stefanha@redhat.com, krister@redhat.com



On 06/07/2017 16:36, Fam Zheng wrote:
> On Thu, 07/06 16:22, Paolo Bonzini wrote:
>>
>>
>> On 06/07/2017 16:06, no-reply@patchew.org wrote:
>>> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
>>> #843: FILE: block/nvme.c:40:
>>> +    volatile uint32_t *doorbell;
>>>
>>> ERROR: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
>>> #869: FILE: block/nvme.c:66:
>>> +typedef volatile struct {
>>
>> Indeed volatile should not be necessary, since we use memory barriers
>> appropriately.  But these are hardware registers (like, host hardware)
>> so I guess it's okay for this special case.
> 
> I think I used it because we don't have ACCESS_ONCE (maybe we should?).

We have atomic_read and atomic_set (and Linux in fact tries not to use
ACCESS_ONCE anymore, it's been replaced by READ_ONCE and WRITE_ONCE so
it's really 1:1 with QEMU).

Paolo
