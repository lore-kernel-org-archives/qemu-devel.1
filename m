Received: from eggs.gnu.org ([208.118.235.92]:35851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf291-0006Tj-U5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gf28y-000131-PT
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:30:39 -0500
Received: from chuckie.co.uk ([82.165.15.123]:35875
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gf28y-0000nG-JC
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:30:36 -0500
References: <1546443980-26779-1-git-send-email-thuth@redhat.com>
	<c2648f00-c44f-7f8e-8673-501b88f1e125@redhat.com>
	<17ed4887-1784-960e-d82e-ec90d98efc82@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e6074237-548f-9330-df19-00064e68d300@ilande.co.uk>
Date: Thu, 3 Jan 2019 12:30:13 +0000
MIME-Version: 1.0
In-Reply-To: <17ed4887-1784-960e-d82e-ec90d98efc82@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing
 SPARC-related files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org

On 03/01/2019 07:19, Thomas Huth wrote:
> On 2019-01-02 20:34, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 1/2/19 4:46 PM, Thomas Huth wrote:
>>> These files / devices are only used by SPARC machines, so we can sort
>>> them into the corresponding categories in the MAINTAINERS file.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  MAINTAINERS | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b6c2645..e897963 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1069,9 +1069,11 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>  S: Maintained
>>>  F: hw/sparc/sun4m.c
>>>  F: hw/sparc/sun4m_iommu.c
>>> +F: hw/display/cg3.c
>>> +F: hw/display/tcx.c
>>>  F: hw/dma/sparc32_dma.c
>>>  F: hw/misc/eccmemctl.c
>>> -F: hw/misc/slavio_misc.c
>>> +F: hw/*/slavio_*.c
>>>  F: include/hw/sparc/sparc32_dma.h
>>>  F: pc-bios/openbios-sparc32
>>>  F: include/hw/sparc/sun4m_iommu.h
>>> @@ -1083,6 +1085,8 @@ F: hw/sparc64/sun4u.c
>>>  F: pc-bios/openbios-sparc64
>>>  F: hw/pci-host/sabre.c
>>>  F: include/hw/pci-host/sabre.h
>>> +F: include/hw/sparc/sun4u_iommu.h
>>
>> I sent a patch to trivial@ with other sun4u changes, reviewed by Mark:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04467.html
> 
> Oh, right, sorry!
> 
>> Neither mine nor your are complete :)
>> Can I include your patch when respining the series? (Not sure I need to
>> respin although).
> 
> Sure!

Certainly these extra files look correct to me - Philippe, I think I already gave R-B
tags for these, so feel free to keep them when you re-post the series with Thomas's
changes.


ATB,

Mark.
