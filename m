Received: from eggs.gnu.org ([209.51.188.92]:37428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBBIH-0006Nn-K1
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hBBIF-0006PC-V7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:14821)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hBBIB-0005xs-EC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 00:45:03 -0400
References: <20190131071658.29120-1-tao3.xu@intel.com>
	<20190131071658.29120-5-tao3.xu@intel.com>
	<20190206111124.73c99f4e@Igors-MacBook-Pro.local>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <ea1cf631-2c4c-9b66-c5d3-147d67181fab@intel.com>
Date: Tue, 2 Apr 2019 12:42:37 +0800
MIME-Version: 1.0
In-Reply-To: <20190206111124.73c99f4e@Igors-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: eblake@redhat.com, mst@redhat.com, xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com, danmei.wei@intel.com, karl.heubaum@oracle.com, rth@twiddle.net, Markus Armbruster <armbru@redhat.com>

On 2/6/19 6:11 PM, Igor Mammedov wrote:
> On Thu, 31 Jan 2019 15:16:54 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
> Maybe instead of adding/using more globals since the rest of numa.c was
> written so, it's time to introduce NumaMachine type which inherits
> form base Machine and extends it with numa extensions.
> 
> You don't have to refactor all old numa code for that (just the parts
> you use in HMAT) and later we could gradually refactor the rest of
> numa handling.
> 
Hi Igor,

I am sorry for replying after so long, because I am preparing the next 
version of patch and confusing about the implementation of NumaMachine.
If NumaMachine inherits from Machine, and then the PCmachine and other 
platform machine inherits from NumaMachine (Implementation a)? Or 
PCmachine and other platform machine inherits from Machine 
(Implementation b)?

Implementation a:		Implementation b:
Machine                         Machine
│                               │
└── NumaMachine                 ├── NumaMachine
     │                           │
     ├── PCMachine               ├── PCMachine
     │                           │
     └── none-PCMachine          └── none-PCMachine

And how about add numa.c's globals into MachineState? This may not 
change a lot.
Looking forward to your reply.

Tao
