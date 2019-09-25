Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5DC4320D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAAD0214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAD0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCvYR-0007lF-QL
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 20:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ren_guo@c-sky.com>) id 1iCv11-0004fw-RN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ren_guo@c-sky.com>) id 1iCv10-0001Xv-9g
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:18:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39223)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ren_guo@c-sky.com>)
 id 1iCv0z-0001Vr-Uj; Tue, 24 Sep 2019 20:18:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.004950699|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.639357-0.0099686-0.350674; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03306; MF=ren_guo@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.Faz1EVd_1569370398; 
Received: from it-c02z45m7lvcf.lan(mailfrom:ren_guo@c-sky.com
 fp:SMTPD_---.Faz1EVd_1569370398) by smtp.aliyun-inc.com(10.147.40.2);
 Wed, 25 Sep 2019 08:13:18 +0800
Content-Type: text/plain;
	charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH V2] target/riscv: Bugfix reserved bits in PTE for RV64
From: Guo Ren <ren_guo@c-sky.com>
In-Reply-To: <CAKmqyKMzpTKBT+urX_7qFASqcAd4kkfJmf6LUk-0V=0LOuHLxw@mail.gmail.com>
Date: Wed, 25 Sep 2019 08:13:17 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <8E7A78A5-5E6F-49A2-89BC-85D2506229C6@c-sky.com>
References: <1569311902-12173-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMzpTKBT+urX_7qFASqcAd4kkfJmf6LUk-0V=0LOuHLxw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
X-Mailman-Approved-At: Tue, 24 Sep 2019 20:52:28 -0400
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, guoren@kernel.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> =D4=DA 2019=C4=EA9=D4=C225=C8=D5=A3=AC=C9=CF=CE=E77:33=A3=ACAlistair =
Francis <alistair23@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, Sep 24, 2019 at 12:58 AM <guoren@kernel.org> wrote:
>>=20
>> From: Guo Ren <ren_guo@c-sky.com>
>>=20
>> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so =
we
>> need to ignore them. They can not be a part of ppn.
>>=20
>> 1: The RISC-V Instruction Set Manual, Volume II: Privileged =
Architecture
>>   4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>>   4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>=20
> Thanks for the patch!
>=20
> The spec says "must be zeroed by software for forward compatibility"
> so I don't think it's correct for QEMU to zero out the bits.
QEMU don=A1=AFt zero out the bits, QEMU just ignore the bits for ppn.

>=20
> Does this fix a bug you are seeing?
Yes, because we try to reuse these bits as attributes.

>=20
>>=20
>> Changelog V2:
>> - Bugfix pte destroyed cause boot fail
>> - Change to AND with a mask instead of shifting both directions
>=20
> The changelog shouldn't be in the commit, it should be kept under the
> line line below.
I just prefer to save them in commit.

>=20
>>=20
>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>=20
> The change log should go here.
OK, but git am we=A1=AFll lose them.

>=20
>> target/riscv/cpu_bits.h   | 3 +++
>> target/riscv/cpu_helper.c | 3 ++-
>> 2 files changed, 5 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>> index e998348..ae8aa0f 100644
>> --- a/target/riscv/cpu_bits.h
>> +++ b/target/riscv/cpu_bits.h
>> @@ -470,6 +470,9 @@
>> #define PTE_D               0x080 /* Dirty */
>> #define PTE_SOFT            0x300 /* Reserved for Software */
>>=20
>> +/* Reserved highest 10 bits in PTE */
>> +#define PTE_RESERVED        ((target_ulong)0x3ff << 54)
>=20
> I think it's just easier to define this as 0xFFC0000000000000ULL and
> remove the cast.
OK follow your rule, but I still prefer prior.

>=20
>> +
>> /* Page table PPN shift amount */
>> #define PTE_PPN_SHIFT       10
>>=20
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 87dd6a6..7a540cc 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -258,10 +258,11 @@ restart:
>>         }
>> #if defined(TARGET_RISCV32)
>>         target_ulong pte =3D ldl_phys(cs->as, pte_addr);
>> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
>> #elif defined(TARGET_RISCV64)
>>         target_ulong pte =3D ldq_phys(cs->as, pte_addr);
>> +        hwaddr ppn =3D (pte & ~PTE_RESERVED) >> PTE_PPN_SHIFT;
>> #endif
>> -        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
>=20
> You don't have to move this shift
En=A1=AD Do you want this: ?

#if defined(TARGET_RISCV32)
        target_ulong pte =3D ldl_phys(cs->as, pte_addr);
+      hwaddr ppn =3D pte;
#elif defined(TARGET_RISCV64)
         target_ulong pte =3D ldq_phys(cs->as, pte_addr);
+       hwaddr ppn =3D (pte & ~PTE_RESERVED);
#endif
+        ppn =3D ppn >> PTE_PPN_SHIFT;

The pte couldn=A1=AFt be destroyed, just ppn ignore the RESERVED bits.



