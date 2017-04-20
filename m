Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19Iq-0003Db-BP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19Im-0006g2-8x
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:27:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d19Im-0006fp-2N
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 06:27:04 -0400
Received: by mail-qk0-x243.google.com with SMTP id d80so2136358qke.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 03:27:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <5a275226-bce0-4c8f-a708-063245cfe8f2@Spark>
	<583d86e4-dc32-ca67-6157-2b4c1654a758@ilande.co.uk>
	<1492680594151.52017@epfl.ch>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb97bd0b-432b-838e-ab78-d13a365bb649@amsat.org>
Date: Thu, 20 Apr 2017 07:26:59 -0300
MIME-Version: 1.0
In-Reply-To: <1492680594151.52017@epfl.ch>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi Ajallooiean,

On 04/20/2017 06:29 AM, Ajallooiean Hossein wrote:
> Thanks for getting back to me so quickly.
>
> I can boot Sparc64  -- ONLY when using the qemu from package manager. supposedly version 2.5
>
> but when building it myself (as i have some additions) - im getting this kernel error:
>
> https://pastebin.com/9XjdrUat
>
>
> I am compiling qemu by myself and am using the following cmd to run it:

Can you share your configure options and the final output (displaying 
CFLAGS, QEMU_CFLAGS and which features enabled)

Can you try recompiling with --disable-tcg-interpreter then retesting 
your kernel?

Thanks,

Phil.

>
>
> /Downloads/qemu-2.9.0-rc4/sparc64-softmmu$ ./qemu-system-sparc64 -M sun4u -m 196 -kernel /home/nihosa/Downloads/kernel4.10.11.sparc64 -hda /home/nihosa/Downloads/debian-9.0-sparc64-NETINST-1.qcow2 -nographic -L pc-bios
>
>
> If you have it running, could you please send me your kernel/image for testing?
>
> Thanks a lot
> Hoss
> ________________________________________
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Sent: Thursday, April 20, 2017 9:26 AM
> To: Ajallooiean Hossein; qemu-devel@nongnu.org
> Subject: Re: [Qemu-devel] Help needed: Sparc 64, kernel panic
>
> On 20/04/17 06:25, Ajallooiean Hossein wrote:
>
>> Hi All
>>
>> Has anyone experienced any kernel panics with the Sparc64 in 2.9-rc4? I dont seem to be able to run it right out of the box.
>>
>> Ill appreciate any kind of help
>>
>> Regards
>> -H
>
> I have a range of test images that I boot on a regular basis for
> qemu-system-sparc64 with success. Can you provide the full command line,
> QEMU version, and the output of the panic?
>
>
> ATB,
>
> Mark.
>
>
