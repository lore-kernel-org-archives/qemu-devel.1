Received: from eggs.gnu.org ([209.51.188.92]:59271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1hPS-0007Jx-7a
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h1hPO-0005En-E6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:01:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:51441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h1hPM-00059V-4I
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 20:01:12 -0500
Date: Thu, 7 Mar 2019 02:00:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <201903070131.56436.randrianasulu@gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1903070153210.71841@zero.eik.bme.hu>
References: <201903070131.56436.randrianasulu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] PMON2000 compilation and kernel question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Randrianasulu <randrianasulu@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, 7 Mar 2019, Andrew Randrianasulu wrote:
>> To find out if the compiled firmware does something different with the 
>> GPU chip you can enable ati-vga traces with -trace enable="ati*" that 
>> should print register accesses (there's also a define for even more 
>> debug messages in ati_int.h). You could compare those to see if the 
>> binary does something else with the GPU.
>
>
> hm, did this, used 'diff -y' for comparing output. It seems my version does a lot more

Checked off-list, just for the record: looks like your compiled binary 
tries to set up a flat-panel display besides the CRT but flat-panel part 
of GPU is not modelled and with both screens pmon tries to put CRT screen 
at an 80MB offset which can't work as chip has only 16MB VRAM. This 
results in distorted screen. I'm not sure why it does that but it 
shouldn't try to use flat-panel display at the first place because 
fulong2e mini-pc QEMU tries to emulate is not a laptop and has no flat 
panel. The pmon_2e.bin binary does not do this and only creates a CRT 
screen at offset 0 so I think the config used to compile pmon is not right 
yet.

Regards,
BALATON Zoltan
