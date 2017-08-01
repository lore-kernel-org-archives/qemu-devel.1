Received: from eggs.gnu.org ([2001:4830:134:3::10]:50084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcZMM-0005nM-SE
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dcZMJ-0007Wm-PK
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dcZMJ-0007VY-JW
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:45:23 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-3-git-send-email-zuban32s@gmail.com>
	<e64320d2-6fa3-03cb-a96e-7c5ce508afdb@redhat.com>
	<CAKSfGUCo9bqxwtMgmW1PO4h-ratpLodJwJa3twL8OKkbuNJs=w@mail.gmail.com>
	<20170801183208-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <789fdbb3-73b8-9308-5d94-b3944fd70d03@redhat.com>
Date: Tue, 1 Aug 2017 18:45:13 +0300
MIME-Version: 1.0
In-Reply-To: <20170801183208-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin OConnor <kevin@koconnor.net>, lersek@redhat.com, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 01/08/2017 18:32, Michael S. Tsirkin wrote:
> On Mon, Jul 31, 2017 at 09:40:41PM +0300, Alexander Bezzubikov wrote:
>>>> +typedef struct PCIEPCIBridge {
>>>> +    /*< private >*/
>>>> +    PCIBridge parent_obj;
>>>> +
>>>> +    bool msi_enable;
>>>
>>>
>>> Please rename the msi_enable property to "msi" in order
>>> to be aligned with the existent PCIBridgeDev and
>>> consider making it OnOffAuto for the same reason.
>>> (I am not sure about the last part though, we have
>>>   no meaning for "auto" here)
>>>
>>
>> Agreed about "msi", but OnOffAuto looks weird to me
>> as we always want MSI to be enabled.
> 

Hi Michael,

> Why even have a property then? Can't you enable it unconditionally?
> 

Because of a current bug in Linux kernel:
    https://www.spinics.net/lists/linux-pci/msg63052.html
msi will not work until the patch is merged. Even when
it will be merged, not all linux kernels will contain the patch.

Disabling msi is a workaround for the above case.

Thanks,
Marcel
