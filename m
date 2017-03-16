Received: from eggs.gnu.org ([2001:4830:134:3::10]:56167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coQLl-0004zB-3S
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1coQLk-0001cM-Ge
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 04:01:33 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170310044402.38880-2-haoqf@linux.vnet.ibm.com> (QingFeng Hao's
	message of "Fri, 10 Mar 2017 05:44:02 +0100")
References: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
	<20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
Reply-To: quintela@redhat.com
Date: Thu, 16 Mar 2017 09:01:22 +0100
Message-ID: <87efxxy7jh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v1 1/1] vmstate: fix failed iotests case 68
 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
> This problem affects s390x only if we are running without KVM.
> Basically, S390CPU.irqstate is unused if we do not use KVM,
> and thus no buffer is allocated.
> This causes size=0, first_elem=NULL and n_elems=1 in
> vmstate_load_state and vmstate_save_state. And the assert fails.
> With this fix we can go back to the old behavior and support
> VMS_VBUFFER with size 0 and nullptr.
>
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

queued
