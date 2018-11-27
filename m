Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gRiT9-0001vu-Ro
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gRiIW-0003OQ-Qn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gRiIW-0003Nk-Jf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 13:41:24 -0500
References: <20181115192446.17187-1-minyard@acm.org>
	<20181115192446.17187-7-minyard@acm.org>
	<20181126172308.GJ2547@work-vm>
	<7055e173-6f4f-7954-69c7-47e0f26dfaf6@acm.org>
	<20181127160144.GB2616@work-vm>
	<d01dc051-f078-c703-bd19-e1874afdfc33@acm.org>
	<20181127181448.GC2616@work-vm>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0b51df6b-d0e1-37a6-be32-a3f052ea9e4b@redhat.com>
Date: Tue, 27 Nov 2018 19:41:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181127181448.GC2616@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/12] boards.h: Ignore migration for
 SMBus devices on older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Corey Minyard <minyard@acm.org>, dgibson@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 27/11/2018 19:14, Dr. David Alan Gilbert wrote:
> * Corey Minyard (minyard@acm.org) wrote:
>> On 11/27/18 10:01 AM, Dr. David Alan Gilbert wrote:
>>> * Corey Minyard (minyard@acm.org) wrote:
>>>> On 11/26/18 11:23 AM, Dr. David Alan Gilbert wrote:
>>>>> * minyard@acm.org (minyard@acm.org) wrote:
>>>>>> From: Corey Minyard <cminyard@mvista.com>
...
>>>> The pm_smbus device is also used by mips fulong.=C2=A0 From what I c=
an tell, that
>>>> machine doesn't have any concept of backwards compatibility, so it s=
eemed
>>>> save to no worry about it there.=C2=A0 If it weren't for that, this =
bool could go
>>>> into the
>>> Yeh that's fine.
>>>
>>> What about the eeprom's are they used more widely?
>>
>> The only other I2C EEPROM I see is hw/nvram/eeprom_at24c.c.=C2=A0 That=
 device is
>> only
>> configured for PPC.=C2=A0 It has a block device backend, too.=C2=A0 Th=
is is a little
>> annoying
>> because smbus_eeprom.c emulates an at24c02.=C2=A0 It would be nice to =
only have
>> one of these.
>=20
> Added in David and Laurent for odd-ppc stuff;  if I'm reading it right
> it's not used by one of the versioned machines.

Yes, it seems unused.

It has been introduced for the mvme31100 machine emulation, by:

commit 5d8424dbd3e8335ea3d57f64eaa603c8fc80706f
Author: Michael Davidsaver <mdavidsaver@gmail.com>
Date:   Sun Nov 19 21:24:17 2017 -0600

    nvram: add AT24Cx i2c eeprom

    Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

from the series:

[00/12] Add MVME3100 PPC SBC
https://patchwork.ozlabs.org/cover/839400/

[12/12] tests: add mvme3100-test=09
[11/12] ppc: add mvme3100 machine
[10/12] timer: add ds1375 RTC=09
[09/12] nvram: add AT24Cx i2c eeprom=09
[08/12] e500: add mpc8540 i2c controller to ccsr
[07/12] qtest: add e500_i2c_create()
[06/12] i2c: add mpc8540 i2c controller
[05/12] e500: name openpic and pci host bridge
[04/12] e500: additional CCSR registers
[03/12] e500: note possible bug with host bridge=09
[02/12] e500: consolidate mpc8540 guts with e500-ccsr
[01/12] e500: add board config options
https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D14303

But the patch adding the machine type has never been commited:

[11/12] ppc: add mvme3100 machine
https://patchwork.ozlabs.org/patch/839407/

Thanks,
Laurent
