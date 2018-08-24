Received: from eggs.gnu.org ([2001:4830:134:3::10]:45750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftFOi-00079W-7D
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1ftFJ1-0000S3-Fd
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:51:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:51708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1ftFJ1-0000Qz-50
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:51:27 -0400
Received: by mail-wm0-x241.google.com with SMTP id y2-v6so2181304wma.1
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 09:51:27 -0700 (PDT)
References: <1534821487-14189-1-git-send-email-jing2.liu@linux.intel.com>
	<1534821487-14189-3-git-send-email-jing2.liu@linux.intel.com>
	<e88aac49-d0be-6ba9-9674-1785caa5af5b@gmail.com>
	<b3d4db42-0ff0-9fd6-7c4e-ee74d15093e5@linux.intel.com>
	<36d3de24-3d5e-e57a-b722-bbaaf1fd0035@gmail.com>
	<913f0f69-eadc-eb2b-05f7-4a1398cdbf46@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0abfc176-a6a6-e12d-1662-1b124a559882@gmail.com>
Date: Fri, 24 Aug 2018 19:51:23 +0300
MIME-Version: 1.0
In-Reply-To: <913f0f69-eadc-eb2b-05f7-4a1398cdbf46@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, anthony.xu@intel.com, lersek@redhat.com, mst@redhat.com

Hi Jing,

On 08/24/2018 05:27 AM, Liu, Jing2 wrote:
> Hi Marcel,
>
> On 8/22/2018 2:58 PM, Marcel Apfelbaum wrote:
>> Hi Jing,
>>
>> On 08/22/2018 04:53 AM, Liu, Jing2 wrote:
>>> Hi Marcel,
>>>
>>> On 8/21/2018 5:59 PM, Marcel Apfelbaum wrote:
>>>>
>>>>
>>>> On 08/21/2018 06:18 AM, Jing Liu wrote:
>>>>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>>>>> BUS/IO/MEM/PREF resource for legacy pci-pci bridge. Add the
>>>>> resource reserve capability deleting in pci_bridge_dev_exitfn.
>>>>>
>>>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>>>>> ---
>>>>>   hw/pci-bridge/pci_bridge_dev.c | 24 ++++++++++++++++++++++++
>>>>>   1 file changed, 24 insertions(+)
>>>>>
>>> [...]
>>>>
>>>> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
>>>>
>>> Thanks for the quick reviewing and feedback.
>>> So could I ask what I should do now, update a new version
>>> with your rb or just waiting for pushing, or else?
>>>
>>
>> You just need to wait until Michael adds the series
>> to his next pull request. Nothing more to do.
>>
> OK, got it! Thanks!

Please ping Michael if your code is not merged in a week or so.

> BTW, do you have some suggestion on the seabios counterpart patches?
> https://patchew.org/Seabios/1534386737-8131-1-git-send-email-jing2.liu@linux.intel.com/ 
>

I plan to have  a look this weekend.

Thanks,
Marcel

> Jing
>> Thanks,
>> Marcel
>>
>>> Thanks,
>>> Jing
>>>
>>>> Thanks,
>>>> Marcel
>>>>
>>
>>
