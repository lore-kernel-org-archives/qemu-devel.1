Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d3Hye-0008Es-4j
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d3Hya-0003UV-Um
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:07:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1d3Hya-0003T3-PB
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:07:04 -0400
References: <20170425045201.71457-1-bjsdjshi@linux.vnet.ibm.com>
	<20170425045642.GG31848@bjsdjshi@linux.vnet.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3a453449-f451-08d1-3a14-e26dd40b667f@redhat.com>
Date: Wed, 26 Apr 2017 10:06:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170425045642.GG31848@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vfio/pci: Fix incorrect error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, alex.williamson@redhat.com

Hi Dong,

On 25/04/2017 06:56, Dong Jia Shi wrote:
> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-04-25 06:52:01 +0200]:
> 
> Hey Alex,
> 
> Please ignore the "RFC" tag in the subject. Sorry for the mistake.
> 
>> When the "No host device provided" error occurs, the hint message
>> that starts with "Use -vfio-pci," makes no sense, since "-vfio-pci"
>> is not a valid command line parameter.
>>
>> Correct this by replacing "-vfio-pci" with "-device vfio-pci".
>>
>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>> ---
>>  hw/vfio/pci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 03a3d01..32aca77 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2625,8 +2625,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>          if (!(~vdev->host.domain || ~vdev->host.bus ||
>>                ~vdev->host.slot || ~vdev->host.function)) {
>>              error_setg(errp, "No provided host device");
>> -            error_append_hint(errp, "Use -vfio-pci,host=DDDD:BB:DD.F "
>> -                              "or -vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>> +            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
>> +                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>>              return;
>>          }
>>          vdev->vbasedev.sysfsdev =
>> -- 
>> 2.10.2
>>
> 
