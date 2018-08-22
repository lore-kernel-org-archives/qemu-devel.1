Received: from eggs.gnu.org ([2001:4830:134:3::10]:44530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fsIWl-000132-Lb
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 22:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fsILP-0003e0-93
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:54:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:20953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fsILO-0003ag-Jk
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 21:53:59 -0400
References: <1534821487-14189-1-git-send-email-jing2.liu@linux.intel.com>
	<1534821487-14189-3-git-send-email-jing2.liu@linux.intel.com>
	<e88aac49-d0be-6ba9-9674-1785caa5af5b@gmail.com>
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <b3d4db42-0ff0-9fd6-7c4e-ee74d15093e5@linux.intel.com>
Date: Wed, 22 Aug 2018 09:53:51 +0800
MIME-Version: 1.0
In-Reply-To: <e88aac49-d0be-6ba9-9674-1785caa5af5b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/pci: add PCI resource reserve
 capability to legacy PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, lersek@redhat.com, pbonzini@redhat.com

Hi Marcel,

On 8/21/2018 5:59 PM, Marcel Apfelbaum wrote:
> 
> 
> On 08/21/2018 06:18 AM, Jing Liu wrote:
>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>> BUS/IO/MEM/PREF resource for legacy pci-pci bridge. Add the
>> resource reserve capability deleting in pci_bridge_dev_exitfn.
>>
>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>> ---
>>   hw/pci-bridge/pci_bridge_dev.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
[...]
> 
> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
> 
Thanks for the quick reviewing and feedback.
So could I ask what I should do now, update a new version
with your rb or just waiting for pushing, or else?

Thanks,
Jing

> Thanks,
> Marcel
> 
