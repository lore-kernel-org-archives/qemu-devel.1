Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DD9C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D98206BB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn1XZqqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D98206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTE8-0005uo-Sm
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUTDL-0005KP-Ov
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:16:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUTDK-0001Ry-Ac
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:15:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUTDK-0001RM-5N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573553757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3H9obxteALIfsHiPe6kVzPSjO4DSAzJ6dkCAwllVaAA=;
 b=Zn1XZqqXMJ+XP6i7AWUg87Kylq/tx6US2tXvJxg7EiTegIBzmYYqlaQJ7fqQ1ojQN07POI
 /190OZxZ/E7uH9RWVrFKtganz1c4BhFWsC9Sb+whsZClNkYi2FxHgoTJo0bnmSLPrm/T6U
 5fxEKUBgQFRNP7Yrg000FKqKEvGwkW8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-v2uzz6rmOumUrj7kukWwiQ-1; Tue, 12 Nov 2019 05:15:56 -0500
Received: by mail-wm1-f70.google.com with SMTP id 2so1234758wmd.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 02:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4sHjLgmPAxMotMWHo1H01H1P97SFawCT/pexWk36LL8=;
 b=L1MxFYbejd1yJrIWJa7SBxCit///5L21SO+lCJJ0EzG23pNiDNlbB/XudAViA3dv+U
 OQK2XXPMl2Ab1lWFrBh9xLDxLoFo6l3GQmJo6kD7EqsmQ2l4heAFCFWsLayAa/P2LE9n
 c53XfLk3Ey3QFn6dpBd2Er8pksqq3QJcuuXRpX43KvYVOn7hIfMQZgvH/eIc8glQ5bkP
 oo24VdcRffsAr0hZYk5lrzpmnWK3//6LFQiBSB8OdwQehgn38tUY3BA5SDjHy/nO3yJ9
 V79+mD9f46xCZnYaauUmvnoLzfMGvHo/D+LrKp51ovJNTyHGTPlbhbbbdg1jwWNiaBZb
 4cUA==
X-Gm-Message-State: APjAAAUzXE3LQyJPlU9FwPFoeujo2Gj2NvsjlNqAeLu10xI2AJK/cSkM
 9nZZQGjQXGfUlnNm+VlvHrmT/T7kxfxO5hjfc/Np7IueGZ77RgtKouhR/XHYMyz2KKc721WnARP
 UHvyXuLhilb0QaAI=
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr23759275wrw.290.1573553754785; 
 Tue, 12 Nov 2019 02:15:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQtOpoMVA77ocM8jWdwhy89TrYx67eYl21XjgHC56NdX5vj4ve9czbGrAG9SrtvLcQlkzxfg==
X-Received: by 2002:a05:6000:1083:: with SMTP id
 y3mr23759254wrw.290.1573553754478; 
 Tue, 12 Nov 2019 02:15:54 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h15sm17004913wrb.44.2019.11.12.02.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 02:15:53 -0800 (PST)
Subject: Re: [PATCH] i386: define the 'flush_l1d' CPUID feature bit
 (CVE-2018-3646)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kyle Copperfield <kmcopper@danwin1210.me>
References: <20191112035043.54600-1-kmcopper@danwin1210.me>
 <20191112095108.GL2366658@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2df81781-77c2-44a3-a565-f72818d41eb9@redhat.com>
Date: Tue, 12 Nov 2019 11:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112095108.GL2366658@redhat.com>
Content-Language: en-US
X-MC-Unique: v2uzz6rmOumUrj7kukWwiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 10:51, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Nov 12, 2019 at 03:50:43AM +0000, Kyle Copperfield via wrote:
>> New microcode introduces the "Flush L1D Cache" CPUID feature bit.
>> This needs to be exposed to guest OS to allow them to protect against
>> CVE-2018-3646.
>=20
> My understanding was that this is only required in the L0 hypervisor,
> not the guests or nested hypervisors, which is why QEMU hadn't already
> exposed this feature when L1TF first went public.
>=20
> Copying Paolo for a definitive answer on that though....

Correct; in fact in addition to this patch you would have to patch KVM
to allow guest writes to MSR_IA32_FLUSH_CMD.

Paolo

>=20
>>
>> Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
>> ---
>>  docs/qemu-cpu-models.texi | 7 +++++++
>>  target/i386/cpu.c         | 2 +-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
>> index f88a1def0d..1b5349d86a 100644
>> --- a/docs/qemu-cpu-models.texi
>> +++ b/docs/qemu-cpu-models.texi
>> @@ -180,6 +180,13 @@ Must be explicitly turned on for all Intel CPU mode=
ls.
>>  Requires the host CPU microcode to support this feature before it
>>  can be used for guest CPUs.
>> =20
>> +@item @code{flush_l1d}
>> +
>> +Required to enable strong Foreshadow-NG (VMM) (CVE-2018-3646) fixes in
>> +guests.
>> +
>> +Requires the host CPU microcode to support this feature before it
>> +can be used for guest CPUs.
>> =20
>>  @item @code{ssbd}
>> =20
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index a624163ac2..1fb6d677e2 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1083,7 +1083,7 @@ static FeatureWordInfo feature_word_info[FEATURE_W=
ORDS] =3D {
>>              NULL, NULL, NULL /* pconfig */, NULL,
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, "spec-ctrl", "stibp",
>> -            NULL, "arch-capabilities", "core-capability", "ssbd",
>> +            "flush_l1d", "arch-capabilities", "core-capability", "ssbd"=
,
>>          },
>>          .cpuid =3D {
>>              .eax =3D 7,
>> --=20
>> 2.24.0
>>
>>
>=20
> Regards,
> Daniel
>=20


