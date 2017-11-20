Received: from eggs.gnu.org ([2001:4830:134:3::10]:32974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGupO-0006Rt-QQ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eGupL-0002c4-Kf
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:46:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:44699
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eGupL-0002ZJ-Dc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:46:07 -0500
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1510926167-23326-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<bce58dcf-ff3d-0d7f-7929-81c3b0e042c4@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b2aeb3f1-2689-1e21-4a88-db7a46e2bc6e@ilande.co.uk>
Date: Mon, 20 Nov 2017 22:45:58 +0000
MIME-Version: 1.0
In-Reply-To: <bce58dcf-ff3d-0d7f-7929-81c3b0e042c4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/15] sun4u: move initialisation of all
 ISABus devices into ebus_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 20/11/17 00:47, Philippe Mathieu-Daudé wrote:

> On 11/17/2017 10:42 AM, Mark Cave-Ayland wrote:
>> This belongs in the PCI-ISA bridge rather than at the machine level.
> 
> nice, this helps me in another series (clean out i386/pc, refactor
> superio devices).

Awesome!

>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  hw/sparc64/sun4u.c |   78 +++++++++++++++++++++++++++++++---------------------
>>  1 file changed, 46 insertions(+), 32 deletions(-)
>>
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index f3203ea..b441f1e 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -85,6 +85,7 @@ typedef struct EbusState {
>>      PCIDevice parent_obj;
>>  
>>      ISABus *isa_bus;
>> +    uint64_t console_serial_base;
> 
> I'd rather use hwaddr here, anyway:
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Yeah it could potentially be either, however to me it feels nicer to
have the value as uint64_t so it "matches" qdev_prop_set_uint64().


ATB,

Mark.
