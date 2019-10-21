Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7756ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477BF20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 12:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477BF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMX7u-0007Pd-88
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 08:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMX5a-0006U6-Kj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMX5Z-0004Yq-3e
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:47:10 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:55970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMX5Y-0004YD-Sg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 08:47:09 -0400
Received: from player773.ha.ovh.net (unknown [10.109.160.232])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id EBDFB1B06A1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 14:47:05 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player773.ha.ovh.net (Postfix) with ESMTPSA id ADA34B37396B;
 Mon, 21 Oct 2019 12:47:00 +0000 (UTC)
Subject: Re: qemu/powernv: coreboot support?
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
 <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
 <20191019160933.fizoc6tpu5jday4o@proprietary-killer>
 <20191020062842.GI1960@umbus.fritz.box>
 <0a7cbd9b-2c46-259d-4e0d-9084ee2875a3@kaod.org>
 <20191021053439.GA6439@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f196a1a6-fcbf-f409-e7e7-95b42135c0be@kaod.org>
Date: Mon, 21 Oct 2019 14:46:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191021053439.GA6439@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Ovh-Tracer-Id: 12162252268935678931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeehgdehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Marty E. Plummer" <hanetzer@startmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/2019 07:34, David Gibson wrote:
> On Sun, Oct 20, 2019 at 08:51:47AM +0200, C=E9dric Le Goater wrote:
>> On 20/10/2019 08:28, David Gibson wrote:
>>> On Sat, Oct 19, 2019 at 11:09:34AM -0500, Marty E. Plummer wrote:
>>>> On Sat, Oct 19, 2019 at 05:53:12PM +0200, C=E9dric Le Goater wrote:
>>>>> On 19/10/2019 17:31, Marty E. Plummer wrote:
>>>>>> On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=E9dric Le Goater wrote=
:
>>>>>>> On 18/10/2019 19:28, Marty E. Plummer wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> First off, thank you for the work you've done on the ppc64 suppo=
rt, it
>>>>>>>> has been very useful. I'm currently working on a coreboot port f=
or the
>>>>>>>> talos ii line of systems (which means more ppc64 support, suppor=
t
>>>>>>>> specifically for the power9 sforza chip, and specific mainboard =
support.
>>>>>>>> My plate is very full lol) and have been using qemu to debug the
>>>>>>>> bootblock.
>>>>>>>>
>>>>>>>> It has been very useful for that, but I'm now at the point where=
 I need
>>>>>>>> to jump to romstage, and that's where it gets tricky. qemu parse=
s the rom
>>>>>>>> image and looks for a ffs header, locates skiboot on it, and jum=
ps straight
>>>>>>>> to that. Not exactly ideal for debugging something not produced =
from op-build.
>>>>>>>
>>>>>>> yes. I suppose you are using my branch powernv-4.2 which adds PNO=
R support
>>>>>>> and a way to boot directly from PNOR. In that case, QEMU parses t=
he PNOR
>>>>>>> file to extract the PAYLOAD partition (skiboot). skiboot also det=
ects the
>>>>>>> flash and extract the kernel and initramfs from the PNOR.
>>>>>>>
>>>>>>> However, you can bypass all this internal boot process by simply =
passing
>>>>>>> a -bios option and not passing a MTD device.
>>>>>>>
>>>>>> Doing so gives me the following error:
>>>>>> qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.ro=
m'
>>>>>> (this is after I patched the 4mb size limit up)
>>>>>
>>>>> Could you make that rom available ?=20
>>>>>
>>>> Sure, I think. Not sure about how sending files works in my current =
mail
>>>> client but will see. Its more or less a 'stock' (as stock as can be =
for
>>>> a new coreboot target) coreboot.rom file, but I've added some logic =
into
>>>> the build to fake a pnor ffs header at the end in order to trick hos=
tboot
>>>> bootloader into loading it.
>>>
>>> Ok.  Note that the qemu emulated machine doesn't model the hardware
>>> right down to the level of hostboot.  That's wy we're just loading
>>> skiboot and jumping straight into it usually.  I guess clg's stuff to
>>> load pnor images gets us a little closer to the hardware behaviour,
>>> but I think it's still only a rough approximation.
>>
>> It's really tied to the OpenPOWER firmwares using the HIOMAP protocol
>> to discuss with the BMC and load the flash. We could loosen how QEMU=20
>> interprets the MTD device and use a property to inform QEMU that this
>> is an OpenPOWER  PNOR file and that skiboot and can be loaded from it.
>> Something to discuss.
>=20
> Right.  I'm guessing one significant issue here is that to fully model
> the BMC, with *its* firmware and comms channels with the main host
> would be quite a lot of work, hence cheating a bit to bypass that.

In fact, we are not cheating that much. We use the IPMI BT interface of=20
QEMU to handle the HIOMAP communication with the BMC and this model is=20
quite precise.=20

The mapping of the PNOR is simply mapped on the LPC FW address space.=20
The underlying access are simplified because we don't have a LPC model
but we could generate all the SPI transaction using the Aspeed models.=20
I had experiments in that sense for P8.=20

I will sense the patches I have on the topic.

C.=20


>> I have applied this small hack to load larger -bios files :
>> =20
>> --- qemu-powernv-4.2.git.orig/hw/ppc/pnv.c
>> +++ qemu-powernv-4.2.git/hw/ppc/pnv.c
>> @@ -58,7 +58,7 @@
>> =20
>>  #define FW_FILE_NAME            "skiboot.lid"
>>  #define FW_LOAD_ADDR            0x0
>> -#define FW_MAX_SIZE             (4 * MiB)
>> +#define FW_MAX_SIZE             (64 * MiB)
>> =20
>>  #define KERNEL_LOAD_ADDR        0x20000000
>>  #define KERNEL_MAX_SIZE         (256 * MiB)
>>
>> and coreboot.rom loads and boots and loops.
>>
>>
>> You can use -d exec,in_asm to check what's going on.
>>
>>
>> C.
>>
>=20


