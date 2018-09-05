Received: from eggs.gnu.org ([2001:4830:134:3::10]:48012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fxanY-0000g5-Iw
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fxanU-0004RU-2n
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:36:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fxanT-0004Of-R5
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 12:36:51 -0400
Received: by mail-wm0-x242.google.com with SMTP id 207-v6so8359104wme.5
	for <qemu-devel@nongnu.org>; Wed, 05 Sep 2018 09:36:51 -0700 (PDT)
References: <1534821487-14189-1-git-send-email-jing2.liu@linux.intel.com>
	<1534821487-14189-3-git-send-email-jing2.liu@linux.intel.com>
	<e88aac49-d0be-6ba9-9674-1785caa5af5b@gmail.com>
	<b3d4db42-0ff0-9fd6-7c4e-ee74d15093e5@linux.intel.com>
	<36d3de24-3d5e-e57a-b722-bbaaf1fd0035@gmail.com>
	<913f0f69-eadc-eb2b-05f7-4a1398cdbf46@linux.intel.com>
	<0abfc176-a6a6-e12d-1662-1b124a559882@gmail.com>
	<5f440e08-33f0-6cc2-266b-d646771f385f@linux.intel.com>
	<74eecedd-1203-0bb1-30ed-be4bbc038d95@linux.intel.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <920bf34c-7328-9fc4-446d-20a04d00c75f@gmail.com>
Date: Wed, 5 Sep 2018 19:36:47 +0300
MIME-Version: 1.0
In-Reply-To: <74eecedd-1203-0bb1-30ed-be4bbc038d95@linux.intel.com>
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
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, mst@redhat.com
Cc: anthony.xu@intel.com, lersek@redhat.com, qemu-devel@nongnu.org



On 09/05/2018 05:08 AM, Liu, Jing2 wrote:
> Hi Marcel and Michael,
>
> Got no response so I would like to ask if I need do something more for
> this serial? :)
>

Hi Jing,

Maybe Michael is PTO, let's wait a few more days.

Michael, I can send a pull request for this series if you are busy.
Thanks,
Marcel

> Thanks,
> Jing
>
> On 8/30/2018 10:58 AM, Liu, Jing2 wrote:
>> Ping Michael :)
>>
>> Thanks,
>> Jing
>>
>> On 8/25/2018 12:51 AM, Marcel Apfelbaum wrote:
>>>>>>> On 08/21/2018 06:18 AM, Jing Liu wrote:
>>>>>>>> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
>>>>>>>> BUS/IO/MEM/PREF resource for legacy pci-pci bridge. Add the
>>>>>>>> resource reserve capability deleting in pci_bridge_dev_exitfn.
>>>>>>>>
>>>>>>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>>>>>>>> ---
>>>>>>>>   hw/pci-bridge/pci_bridge_dev.c | 24 ++++++++++++++++++++++++
>>>>>>>>   1 file changed, 24 insertions(+)
>> [...]
>>>>>>> Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
>>>>>>>
>>>>>> Thanks for the quick reviewing and feedback.
>>>>>> So could I ask what I should do now, update a new version
>>>>>> with your rb or just waiting for pushing, or else?
>>>>>>
>>>>>
>>>>> You just need to wait until Michael adds the series
>>>>> to his next pull request. Nothing more to do.
>>>>>
>>>> OK, got it! Thanks!
>>>
>>> Please ping Michael if your code is not merged in a week or so.
>>>
>>>> BTW, do you have some suggestion on the seabios counterpart patches?
>>>> https://patchew.org/Seabios/1534386737-8131-1-git-send-email-jing2.liu@linux.intel.com/ 
>>>>
>>>
>>> I plan to have  a look this weekend.
>>>
>>> Thanks,
>>> Marcel
>>
