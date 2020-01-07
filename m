Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47323C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFEA2146E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFEA2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iorhc-0005P6-8Q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iorh4-0004wb-Cz
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:26:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iorh3-0002w9-0Z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:26:58 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:44221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iorh2-0002uf-Qs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:26:56 -0500
Received: from player726.ha.ovh.net (unknown [10.108.35.197])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1D49B14CEC7
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 17:26:53 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 42709DDF1E3D;
 Tue,  7 Jan 2020 16:26:44 +0000 (UTC)
Subject: Re: [PULL 01/88] ppc/pnv: Add a PNOR model
To: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
 <20191217044322.351838-2-david@gibson.dropbear.id.au>
 <CAFEAcA_NpwX8i74UisTB8xT=cve5w4eBRHxmqSs36mHRA1bdCQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <057f97ac-3850-a3b0-bd5d-03b68f9d96f3@kaod.org>
Date: Tue, 7 Jan 2020 17:26:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_NpwX8i74UisTB8xT=cve5w4eBRHxmqSs36mHRA1bdCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12775867721831910145
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedggeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.175
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@fr.ibm.com>,
 qemu-ppc <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 3:43 PM, Peter Maydell wrote:
> On Tue, 17 Dec 2019 at 04:43, David Gibson <david@gibson.dropbear.id.au=
> wrote:
>>
>> From: C=C3=A9dric Le Goater <clg@fr.ibm.com>
>>
>> On a POWERPC PowerNV system, the host firmware is stored in a PNOR
>> flash chip which contents is mapped on the LPC bus. This model adds a
>> simple dummy device to map the contents of a block device in the host
>> address space.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Message-Id: <20191021131215.3693-2-clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/ppc/Makefile.objs      |   4 +-
>>  hw/ppc/pnv.c              |  14 ++++
>>  hw/ppc/pnv_pnor.c         | 135 +++++++++++++++++++++++++++++++++++++=
+
>>  include/hw/ppc/pnv.h      |   3 +
>>  include/hw/ppc/pnv_pnor.h |  25 +++++++
>>  5 files changed, 180 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/ppc/pnv_pnor.c
>>  create mode 100644 include/hw/ppc/pnv_pnor.h
>=20
> Hi; Coverity finds some issues in this patch:
>=20
>> +static void pnv_pnor_update(PnvPnor *s, int offset, int size)
>> +{
>> +    int offset_end;
>> +
>> +    if (s->blk) {
>> +        return;
>> +    }
>> +
>> +    offset_end =3D offset + size;
>> +    offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>> +    offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
>> +
>> +    blk_pwrite(s->blk, offset, s->storage + offset,
>> +               offset_end - offset, 0);
>=20
> Here we call blk_pwrite() but don't check whether it
> succeeded or failed. (CID 1412228)

Yes. I will send fixes for both issues.

Thanks,

C.=20

>> +static void pnv_pnor_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvPnor *s =3D PNV_PNOR(dev);
>> +    int ret;
>> +
>> +    if (s->blk) {
>> +        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
>> +                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRIT=
E);
>> +        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
>> +        if (ret < 0) {
>> +            return;
>> +        }
>> +
>> +        s->size =3D blk_getlength(s->blk);
>> +        if (s->size <=3D 0) {
>=20
> blk_getlength() returns an int64_t, but s->size is a uint32_t.
> This means that this attempt to check for <=3D 0 doesn't
> actually catch the negative values which are errors...
>=20
>> +            error_setg(errp, "failed to get flash size");
>> +            return;
>> +        }
>> +
>> +        s->storage =3D blk_blockalign(s->blk, s->size);
>=20
> ...so we'll pass a very large positive number to
> blk_blockalign() (since it takse a size_t argument), which
> Coverity correctly identifies as doing the wrong thing.
> (CID 1412226)
>=20
> Side note: the blk functions here seem a bit inconsistent:
> blk_getlength() returns int64_t
> blk_blockalign() takes size_t
> blk_pread() takes int
>=20
>> +
>> +        if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
>> +            error_setg(errp, "failed to read the initial flash conten=
t");
>> +            return;
>> +        }
>> +    } else {
>> +        s->storage =3D blk_blockalign(NULL, s->size);
>> +        memset(s->storage, 0xFF, s->size);
>> +    }
>> +
>> +    memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
>> +                          TYPE_PNV_PNOR, s->size);
>> +}
>=20
> thanks
> -- PMM
>=20


