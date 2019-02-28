Received: from eggs.gnu.org ([209.51.188.92]:57118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gzP1c-0005kL-HV
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gzP1b-0007rE-JK
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:59:12 -0500
References: <201902270125.36158.randrianasulu@gmail.com>
	<b3f9b42e-5895-51ca-9313-506b857e65d8@ilande.co.uk>
	<201902281139.14787.randrianasulu@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <a984d6e6-4b9c-fecf-d0c6-3ff9b80cc07c@ilande.co.uk>
Date: Thu, 28 Feb 2019 16:59:02 +0000
MIME-Version: 1.0
In-Reply-To: <201902281139.14787.randrianasulu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] regression: target/ppc: convert VSX logical
 operations to vector operations broke X for ppc64le guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 28/02/2019 08:39, Andrew Randrianasulu wrote:

>>> configure line:
>>> setarch i686 ./configure --target-list=ppc64-softmmu
>>>
>>> launch line:
>>> ppc64-softmmu/qemu-system-ppc64 -display
>>> sdl,gl=on -hda /mnt/sdb1/PPC-img/alpine_disk.img
>>>
>>> where alpine_disk.img is HDD installed Alpine 3.7 for ppc64le with xfce4
>>> desktop.
>>
>> AFAICT the vector instructions converted here are independent of endian, so
>> I can't see why this patch on its own would have any effect.
>>
>> Maybe it could be because the "setarch i686" part forces use of some
>> lesser-used 32-bit paths in the vector code - is this required? And do you
>> see the same issue on a x86_64 build?
> 
> I use 32-bit Slackware userland with x86_64 kerenl - so setarch prevent most of 
> configures from detecting my arch wrongly.
> 
> Yes, bug was and is present with qemu compiled for x86_64 (inside chroot).
> I initially discovered it there, and after dropping -O3 and even march=native, 
> and even disabling avx2 via configure switch - moved to bisect.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06414.html

Can you upload your alpine_disk.img somewhere and then email me the link off-list?
I'll see if I can take a look when I get a spare moment.


ATB,

Mark.
