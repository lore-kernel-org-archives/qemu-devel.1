Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E7C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032D0206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 05:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032D0206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFXcM-0008Kb-31
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 01:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iFXbR-0007iC-Gr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iFXbQ-0002DO-FI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:55:09 -0400
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:35296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iFXbQ-0002AW-9X
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 01:55:08 -0400
Received: from player695.ha.ovh.net (unknown [10.108.54.34])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 4BF0A135419
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 07:55:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 204CFA5B380B;
 Wed,  2 Oct 2019 05:55:03 +0000 (UTC)
Subject: Re: [PATCH v3 01/34] xics: Minor fixes for XICSFabric interface
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20191002025208.3487-1-david@gibson.dropbear.id.au>
 <20191002025208.3487-2-david@gibson.dropbear.id.au>
 <2297d0ee-ff47-c000-5e6d-eb6aba83c456@kaod.org>
Message-ID: <37a7cf4e-fee0-53e2-d008-d56bd4225766@kaod.org>
Date: Wed, 2 Oct 2019 07:55:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <2297d0ee-ff47-c000-5e6d-eb6aba83c456@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 4303470919269452608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeehgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.60.248
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/2019 07:51, C=C3=A9dric Le Goater wrote:
> On 02/10/2019 04:51, David Gibson wrote:
>> Interface instances should never be directly dereferenced.  So, the co=
mmon
>> practice is to make them incomplete types to make sure no-one does tha=
t.
>> XICSFrabric, however, had a dummy type which is less safe.
>>
>> We were also using OBJECT_CHECK() where we should have been using
>> INTERFACE_CHECK().
>>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

pfff ...

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

>=20
>> ---
>>  include/hw/ppc/xics.h | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 64a2c8862a..faa33ae943 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -147,13 +147,9 @@ struct ICSIRQState {
>>      uint8_t flags;
>>  };
>> =20
>> -struct XICSFabric {
>> -    Object parent;
>> -};
>> -
>>  #define TYPE_XICS_FABRIC "xics-fabric"
>>  #define XICS_FABRIC(obj)                                     \
>> -    OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
>> +    INTERFACE_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
>>  #define XICS_FABRIC_CLASS(klass)                                     =
\
>>      OBJECT_CLASS_CHECK(XICSFabricClass, (klass), TYPE_XICS_FABRIC)
>>  #define XICS_FABRIC_GET_CLASS(obj)                                   =
\
>>
>=20
>=20


