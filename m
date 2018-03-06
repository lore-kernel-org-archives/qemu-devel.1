Received: from eggs.gnu.org ([2001:4830:134:3::10]:42392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etM2L-0004j9-K6
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1etM2K-00005j-Qt
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 18:30:25 -0500
Date: Wed, 7 Mar 2018 00:30:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <47673305-ea4c-20bf-a3c1-47d4e4cfd950@redhat.com>
Message-ID: <alpine.BSF.2.21.1803070028590.57076@zero.eik.bme.hu>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
	<20180111045937.2119-7-david@gibson.dropbear.id.au>
	<47673305-ea4c-20bf-a3c1-47d4e4cfd950@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 06/11] hw/ide: Emulate SiI3112
 SATA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On Tue, 6 Mar 2018, Thomas Huth wrote:
> On 11.01.2018 05:59, David Gibson wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> This is a common generic PCI SATA controller that is also used in PCs
>> but more importantly guests running on the Sam460ex board prefer this
>> card and have a driver for it (unlike for other SATA controllers
>> already emulated).
>
> Hi,
>
> looks like this new device can now be used to crash QEMU in certain
> circumstances:
>
> $ ppc64-softmmu/qemu-system-ppc64 -monitor stdio
> QEMU 2.11.50 monitor - type 'help' for more information
> (qemu) device_add sii3112,id=x
> (qemu) device_del x
> qemu-system-ppc64: /home/thuth/devel/qemu/memory.c:2346:
> memory_region_del_subregion: Assertion `subregion->container == mr' failed.
> Aborted (core dumped)
>
> Any ideas how to fix this?

Looks like the exit function that causes this crash was left there by 
mistake and is not needed. I've sent a patch to remove it.

Thank you,
BALATON Zoltan
