Received: from eggs.gnu.org ([2001:4830:134:3::10]:51349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8WO-00005f-UG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fT8WL-0003Mc-PC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:21:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fT8WL-0003LD-IB
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:21:17 -0400
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<20180313224719.4954-51-pbonzini@redhat.com>
	<20180601185139.GA25837@flamenco>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3c45eff-634d-6187-8f65-624bce9d2e4e@redhat.com>
Date: Wed, 13 Jun 2018 18:21:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180601185139.GA25837@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>

On 01/06/2018 20:51, Emilio G. Cota wrote:
> On Tue, Mar 13, 2018 at 23:47:00 +0100, Paolo Bonzini wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20180308223946.26784-25-f4bug@amsat.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  default-configs/alpha-softmmu.mak |  3 +++
>>  hw/alpha/dp264.c                  | 10 ++++------
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>=20
> This commit breaks alpha-softmmu bootup for me. I get no console
> output whatsoever -- not even the green "Hello" when invoking
> the alpha-softmmu binary with no arguments.
>=20
> Did anybody else notice this?

Philippe, are you going to take a look?  I tested 2.12 and I get the
same result as latest mainline: nothing on the VGA and

PCI: 00:00:0 class 0300 id 1013:00b8
PCI:   region 0: 10000000
PCI:   region 1: 12000000
PCI: 00:01:0 class 0200 id 8086:100e
PCI:   region 0: 12020000
PCI:   region 1: 0000c000
PCI: 00:02:0 class 0101 id 1095:0646
PCI:   region 0: 0000c040
PCI:   region 1: 0000c048
PCI:   region 3: 0000c04c

on the serial console, respectively for VGA/network/IDE.

Paolo
