Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fygAF-000544-CQ
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 12:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fyg4q-0002Tp-89
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 12:27:16 -0400
References: <20180908161421.18089-1-hpoussin@reactos.org>
	<4be43e71-1fdc-bc8a-8554-24b1a487b97b@weilnetz.de>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <9c583862-6945-951f-9da0-174ff8ced5a7@reactos.org>
Date: Sat, 8 Sep 2018 18:27:06 +0200
MIME-Version: 1.0
In-Reply-To: <4be43e71-1fdc-bc8a-8554-24b1a487b97b@weilnetz.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] hw/ppc: on 40p machine,
 change default firmware to OpenBIOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Le 08/09/2018 à 18:20, Stefan Weil a écrit :
> Am 08.09.2018 um 18:14 schrieb Hervé Poussineau:
> [...]
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index f123b15e3e..f865822e32 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -75,12 +75,12 @@ typedef struct testdef {
>>   static testdef_t tests[] = {
>>       { "alpha", "clipper", "", "PCI:" },
>>       { "ppc", "ppce500", "", "U-Boot" },
>> -    { "ppc", "40p", "-boot d", "Booting from device d" },
>> +    { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>>       { "ppc", "g3beige", "", "PowerPC,750" },
>>       { "ppc", "mac99", "", "PowerPC,G4" },
>>       { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
>>       { "ppc64", "ppce500", "", "U-Boot" },
>> -    { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
>> +    { "ppc64", "40p", "-m 192", "Memory: 192M" },
> 
> I suggest using "Memory: 192 MiB" (like in the code for sam460ex above).

No, because OpenBIOS doesn't print the "iB" letters...

Hervé
