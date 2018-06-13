Received: from eggs.gnu.org ([2001:4830:134:3::10]:54784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fT8kd-0007Ay-IT
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fT8kY-0005gx-Ln
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:36:03 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fT8kY-0005gN-GZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:35:58 -0400
Received: by mail-qt0-x241.google.com with SMTP id h5-v6so2939593qtm.13
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 09:35:58 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<20180313224719.4954-51-pbonzini@redhat.com>
	<20180601185139.GA25837@flamenco>
	<f3c45eff-634d-6187-8f65-624bce9d2e4e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <323c9978-2d21-cfec-a613-57f0c675531f@amsat.org>
Date: Wed, 13 Jun 2018 13:35:45 -0300
MIME-Version: 1.0
In-Reply-To: <f3c45eff-634d-6187-8f65-624bce9d2e4e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 50/69] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On 06/13/2018 01:21 PM, Paolo Bonzini wrote:
> On 01/06/2018 20:51, Emilio G. Cota wrote:
>> On Tue, Mar 13, 2018 at 23:47:00 +0100, Paolo Bonzini wrote:
>>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> Message-Id: <20180308223946.26784-25-f4bug@amsat.org>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  default-configs/alpha-softmmu.mak |  3 +++
>>>  hw/alpha/dp264.c                  | 10 ++++------
>>>  2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> This commit breaks alpha-softmmu bootup for me. I get no console
>> output whatsoever -- not even the green "Hello" when invoking
>> the alpha-softmmu binary with no arguments.
>>
>> Did anybody else notice this?
> 
> Philippe, are you going to take a look?  I tested 2.12 and I get the

Sure. Sorry I didn't notice earlier, my mail-filter demotes subject with
PULL :/

> same result as latest mainline: nothing on the VGA and
> 
> PCI: 00:00:0 class 0300 id 1013:00b8
> PCI:   region 0: 10000000
> PCI:   region 1: 12000000
> PCI: 00:01:0 class 0200 id 8086:100e
> PCI:   region 0: 12020000
> PCI:   region 1: 0000c000
> PCI: 00:02:0 class 0101 id 1095:0646
> PCI:   region 0: 0000c040
> PCI:   region 1: 0000c048
> PCI:   region 3: 0000c04c
> 
> on the serial console, respectively for VGA/network/IDE.
> 
> Paolo
> 
