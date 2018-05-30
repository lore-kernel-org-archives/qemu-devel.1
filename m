Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrPb-0001AM-7c
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNrPW-00074K-AP
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:04:31 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<fac124fe-d816-1bb2-c8b3-d1a0213f968b@amsat.org>
	<15666557-66b1-78e0-1062-b3a28ecaf580@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b83a5cd3-5918-e063-86ef-c65f1d44641e@amsat.org>
Date: Wed, 30 May 2018 00:04:21 -0300
MIME-Version: 1.0
In-Reply-To: <15666557-66b1-78e0-1062-b3a28ecaf580@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] ftgmac100 and NC-SI
 enhancements for the Aspeed SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 01:57 PM, Cédric Le Goater wrote:
> On 05/29/2018 02:34 PM, Philippe Mathieu-Daudé wrote:
>> Hi Cédric,
>>
>> On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
>>> Hello,
>>>
>>> Here is a couple of enhancements and fixes for the ftgmac100 NIC used
>>> on the Aspeed SoC. It includes VLAN and multicast support.
>>>
>>> Following is an assorted set of changes for the NC-SI backend also
>>> used on the Aspeed SoC when soldered on OpenPOWER boards. These fix a
>>> few problems found when running OpenBMC on aspeed QEMU machines.
>>>
>>> Thanks,
>>>
>>> Cédric.
>>>
>>> Cédric Le Goater (6):
>>>   ftgmac100: compute maximum frame size depending on the protocol
>>>   ftgmac100: add IEEE 802.1Q VLAN support
>>>   net/ftgmac100: fix multicast hash routine
>>>   slirp/ncsi: fix "Get Version ID" payload length
>>>   slirp/ncsi: add a "Get Parameter" response
>>>   slirp/ncsi: add checksum support
>>
>> Doesn't it make more sens to have slirp patches applied previous to the
>> ftgmac100 model?
> 
> why ? They are not necessarily dependent. 

OK, no worries.
