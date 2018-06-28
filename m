Received: from eggs.gnu.org ([2001:4830:134:3::10]:46890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYQyR-00019O-Ht
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYQyO-0006rN-Bt
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:04:11 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYQyO-0006qs-5r
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:04:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id w137-v6so8320557wmw.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 00:04:08 -0700 (PDT)
References: <20180613094727.11326-1-mark.cave-ayland@ilande.co.uk>
	<4e370dcb-d4d6-680e-5f40-b0a1d7dd58e1@ilande.co.uk>
	<d4216058-c627-f7f5-6502-851cca792dd1@reactos.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9b923c7-4c7b-7ec5-327f-02053e79b800@redhat.com>
Date: Thu, 28 Jun 2018 09:04:04 +0200
MIME-Version: 1.0
In-Reply-To: <d4216058-c627-f7f5-6502-851cca792dd1@reactos.org>
Content-Type: text/plain; charset=utf-8
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
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, famz@redhat.com

On 28/06/2018 07:58, Hervé Poussineau wrote:
> Le 27/06/2018 à 22:01, Mark Cave-Ayland a écrit :
>> On 13/06/18 10:47, Mark Cave-Ayland wrote:
>>
>>> Something else that came out of reviewing Laurent's q800 patchset:
>>> after my
>>> SPARC cleanups last year, MIPS Jazz is the last remaining user of the
>>> legacy
>>> esp_init() function.
>>>
>>> Patch 1 switches mips_jazz_init() over to create the ESP device directly
>>> via qdev. Please note that I do not have any MIPS jazz images and so
>>> this
>>> is compile-tested only (although passes "make check") and needs an
>>> ACK from
>>> someone (Hervé?).
>>>
>>> Now that the last user of esp_init() is gone, patch 2 removes the legacy
>>> function and its associated header.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>>
>>> Mark Cave-Ayland (2):
>>>    hw/mips/jazz: create ESP device directly via qdev
>>>    esp: remove legacy esp_init() function
>>>
>>>   hw/mips/mips_jazz.c   | 19 ++++++++++++++++---
>>>   hw/scsi/esp.c         | 30 ------------------------------
>>>   include/hw/scsi/esp.h |  5 -----
>>>   3 files changed, 16 insertions(+), 38 deletions(-)
>>
>> Ping? Is anyone able to test the MIPS jazz board with these patches at
>> all?
> 
> Tested-by: Hervé Poussineau <hpoussin@reactos.org>
> 
> 

Queued, thanks.

Paolo
