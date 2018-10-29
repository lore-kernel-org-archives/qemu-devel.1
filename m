Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH1Eh-0008A0-St
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1gH1Ed-00054V-UQ
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:41:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1gH1Ed-00053k-MC
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 02:41:11 -0400
References: <20181017093053.8811-1-tao3.xu@intel.com>
	<20181017093053.8811-2-tao3.xu@intel.com>
	<6b494abe-93ae-71fc-01f3-e149df5e24b5@redhat.com>
	<20181025132831.GG4096@habkost.net>
	<128b40da-f34e-9a45-e798-25e33855a51f@intel.com>
	<20181026082213.GJ4096@habkost.net>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <bde7f9f0-9500-82e5-d427-477e360e8563@intel.com>
Date: Mon, 29 Oct 2018 14:40:02 +0800
MIME-Version: 1.0
In-Reply-To: <20181026082213.GJ4096@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] i386: Add PKU/OSPKE on Skylake-Server
 CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, jingqi.liu@intel.com, robert.hu@intel.com, qemu-devel@nongnu.org


On 10/26/18 4:22 PM, Eduardo Habkost wrote:
> On Fri, Oct 26, 2018 at 01:53:10PM +0800, Tao Xu wrote:
>> On 10/25/18 9:28 PM, Eduardo Habkost wrote:
>>
>>> Sorry for taking so long to reply.  This can be safely done only
>>> if every host that is able to run Skylake-Server today is
>>> guaranteed to support PKU.  Is that the case?

Yes, as the release document ref below link (page 13):
https://software.intel.com/sites/default/files/managed/c5/15/\
architecture-instruction-set-extensions-programming-reference.pdf

PKU is supported in Skylake Server (Only Server) and later.
So, every host that is able to run Skylake-Server today is to
to support PKU.

>>>
>>> You'll also need Skylake-Server-*-cpu.pku=off entries on
>>> PC_COMPAT_3_0 to keep PKU disabled on pc-*-3.0 and older.
>>>
>> Thank you Eduardo,
>>
>>
>> But I can't find PC_COMPAT_3_0 in  include/hw/i386/pc.h. Will it exist on
>>
>> QEMU 3.1 and will I add "pku=off" after QEMU 3.1  release?
> PC_COMPAT_3_0 was added to qemu.git master a few weeks ago, by
> commit 9b4cf107b09d18ac30f46fd1c4de8585ccba030c.
>
Thank you. I'll add this on the next version of this patch.
