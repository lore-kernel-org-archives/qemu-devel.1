Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fYPxa-0000JV-7e
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 01:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fYPxX-00085O-7C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 01:59:14 -0400
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:59364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1fYPxW-0007qB-Oe
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 01:59:11 -0400
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<4e370dcb-d4d6-680e-5f40-b0a1d7dd58e1@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d4216058-c627-f7f5-6502-851cca792dd1@reactos.org>
Date: Thu, 28 Jun 2018 07:58:58 +0200
MIME-Version: 1.0
In-Reply-To: <4e370dcb-d4d6-680e-5f40-b0a1d7dd58e1@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: remove legacy esp_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, pbonzini@redhat.com, famz@redhat.com

Le 27/06/2018 à 22:01, Mark Cave-Ayland a écrit :
> On 13/06/18 10:47, Mark Cave-Ayland wrote:
> 
>> Something else that came out of reviewing Laurent's q800 patchset: after my
>> SPARC cleanups last year, MIPS Jazz is the last remaining user of the legacy
>> esp_init() function.
>>
>> Patch 1 switches mips_jazz_init() over to create the ESP device directly
>> via qdev. Please note that I do not have any MIPS jazz images and so this
>> is compile-tested only (although passes "make check") and needs an ACK from
>> someone (Hervé?).
>>
>> Now that the last user of esp_init() is gone, patch 2 removes the legacy
>> function and its associated header.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>>
>> Mark Cave-Ayland (2):
>>    hw/mips/jazz: create ESP device directly via qdev
>>    esp: remove legacy esp_init() function
>>
>>   hw/mips/mips_jazz.c   | 19 ++++++++++++++++---
>>   hw/scsi/esp.c         | 30 ------------------------------
>>   include/hw/scsi/esp.h |  5 -----
>>   3 files changed, 16 insertions(+), 38 deletions(-)
> 
> Ping? Is anyone able to test the MIPS jazz board with these patches at all?

Tested-by: Hervé Poussineau <hpoussin@reactos.org>
