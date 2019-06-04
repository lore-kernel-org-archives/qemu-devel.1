Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B10CC28CC3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4892924ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 13:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4892924ABA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52713 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY9VT-0005dS-Ib
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 09:29:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY9UF-00050r-H0
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hY9UD-0000Ho-Jn
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 09:28:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hY9UC-0000Eu-Bc; Tue, 04 Jun 2019 09:28:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0C8730BDE49;
	Tue,  4 Jun 2019 13:28:18 +0000 (UTC)
Received: from [10.36.117.157] (ovpn-117-157.ams2.redhat.com [10.36.117.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D16D767260;
	Tue,  4 Jun 2019 13:28:14 +0000 (UTC)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190604093656.23565-1-david@redhat.com>
	<a813de86-33eb-b22e-8d06-054e85e4f074@vivier.eu>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d61ac5a3-4480-956c-c4b4-603c06f088f8@redhat.com>
Date: Tue, 4 Jun 2019 15:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a813de86-33eb-b22e-8d06-054e85e4f074@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 04 Jun 2019 13:28:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1] linux-user: elf: ELF_HWCAP for s390x
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04.06.19 14:54, Laurent Vivier wrote:
> Le 04/06/2019 =C3=A0 11:36, David Hildenbrand a =C3=A9crit=C2=A0:
>> Let's add all HWCAPs that we can support under TCG right now, when the
>> respective CPU facilities are enabled.
>>
>> Cc: Riku Voipio <riku.voipio@iki.fi>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> This patch is based on "[PATCH v2 00/22] s390x/tcg: Vector Instruction
>> Support Part 4". I guess it is best if I just include it in my next
>> pull request.
> Based-on: <20190603090635.10631-1-david@redhat.com>
>           [PATCH v2 00/22] s390x/tcg: Vector Instruction Support Part 4
>=20
>>
>> ---
>>  include/elf.h        |  1 +
>>  linux-user/elfload.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/include/elf.h b/include/elf.h
>> index ea7708a4ea..3501e0c8d0 100644
>> --- a/include/elf.h
>> +++ b/include/elf.h
>> @@ -598,6 +598,7 @@ typedef struct {
>>  #define HWCAP_S390_ETF3EH       256
>>  #define HWCAP_S390_HIGH_GPRS    512
>>  #define HWCAP_S390_TE           1024
>> +#define HWCAP_S390_VXRS         2048
>> =20
>>  /* M68K specific definitions. */
>>  /* We use the top 24 bits to encode information about the
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index a57b7049dd..59b813066c 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -1308,6 +1308,45 @@ static inline void init_thread(struct target_pt=
_regs *regs,
>>  #define ELF_DATA	ELFDATA2MSB
>>  #define ELF_ARCH	EM_S390
>> =20
>> +#include "elf.h"
>> +
>> +#define ELF_HWCAP get_elf_hwcap()
>> +
>> +static uint32_t get_elf_hwcap(void)
>> +{
>> +    uint32_t hwcap =3D 0;
>> +
>> +    if (s390_has_feat(S390_FEAT_ESAN3)) {
>> +        hwcap |=3D HWCAP_S390_ESAN3;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_ZARCH)) {
>> +        hwcap |=3D HWCAP_S390_ZARCH;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_STFLE)) {
>> +        hwcap |=3D HWCAP_S390_STFLE;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_MSA)) {
>> +        hwcap |=3D HWCAP_S390_MSA;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_LONG_DISPLACEMENT)) {
>> +        hwcap |=3D HWCAP_S390_LDISP;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_EXTENDED_IMMEDIATE)) {
>> +        hwcap |=3D HWCAP_S390_EIMM;
>> +    }
>> +    if (s390_has_feat(S390_FEAT_EXTENDED_TRANSLATION_3) &&
>> +        s390_has_feat(S390_FEAT_ETF3_ENH)) {
>> +        hwcap |=3D HWCAP_S390_ETF3EH;
>> +    }
>> +    /* 31-bit processes can use 64-bit registers */
>> +    hwcap |=3D HWCAP_S390_HIGH_GPRS;
>> +    if (s390_has_feat(S390_FEAT_VECTOR)) {
>> +        hwcap |=3D HWCAP_S390_VXRS;
>> +    }
>> +
>> +    return hwcap;
>> +}
>> +
>>  static inline void init_thread(struct target_pt_regs *regs, struct im=
age_info *infop)
>>  {
>>      regs->psw.addr =3D infop->entry;
>>
>=20
> Acked-by: Laurent Vivier <laurent@vivier.eu>
>=20
> You can also do like the other architectures that use shortcuts like th=
is:
>=20
> #define GET_FEATURE(feat, hwcap) \
>     do { if (s390_has_feat(feat)) { hwcaps |=3D hwcap; } } while (0)
> ...
> GET_FEATURE(S390_FEAT_VECTOR, HWCAP_S390_VXRS);
> ...

Thanks, I'll use this.

Cheers!

--=20

Thanks,

David / dhildenb

