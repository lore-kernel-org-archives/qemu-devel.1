Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BAFC76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B30206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GMihwtYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B30206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp7gS-0006IS-IE
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 04:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1hp7gJ-0005ty-6y
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1hp7gI-0000Z4-4k
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:58:59 -0400
Received: from mout.web.de ([212.227.15.14]:38731)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1hp7gH-0000XS-Of
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563699525;
 bh=aw1lOiw61UHtobl+8Rk0xGNx32Kuzvb2QI7RJoSIesQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=GMihwtYqhuLmqtlPTKwPbQwCMblVkDWFuVZypxFsm7eYi5tkjrqfR4EBHaryYDqe9
 E4SRzvS7AOJk0lJBIQEyCkKV9VgyIpzYfP1a2ugX0apPMC7tSad0YMLumlbqJxw23X
 c19D22k2zCeC0HbC4cF5oSMIAxH4HX5/8079j8tg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSnyP-1hx8Pw2brB-00RmvJ; Sun, 21
 Jul 2019 10:58:45 +0200
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
 <20190602174041-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <2d735fe7-d451-207d-eca9-2796cad7e778@web.de>
Date: Sun, 21 Jul 2019 10:58:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <20190602174041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wRgJNtCgZGCa5bgzDZ/6HsICHfFgB+sZS3qa9oLAfxO71MTAEN+
 7z19UzuxBE2VfmiAcNSVlNgkraAlPFEXmKfqLU4jDewKy0PLzOc1/x1LGjeSOoPcelen4Bq
 Y1KxHDd1II0sO0PpQpeB6DVCwuZFp0ei4TDuNEW85IG1Gl0eKwMGKiJqMvUhov2zHP6Wq6K
 PH3zNUp9cX1aKk1kfGTZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9KQT8DCdvlQ=:qFtfZFVT0rsw/90rqoQFjd
 1mdJV2OgHylN5C/678fldGkx5eQITZqnjgM791tP4Pk1nnpSiv5ph/ApD16Ik5dm64WkOJVDn
 eJvtfga9+YZ30v7I40n78a8XMs8+3rW8/aYhVM/JXGNJZDxjcWWV7jTDYoWNcB6gg3uDhnuCk
 iJ/ucmnSkyxXR11Ii1SnLDt2kheDY+DHm6oPq4+5A8UpLTA/RlEEt0orU7Q/spFNCupEhrvrM
 cUUn0mre1CQqjlvAA07DAXyrsAxXI2ZvxNLAnTE9gdPd9N/HQbrss3m6Z6m7udyKVxQCBtewl
 0+ZZZBOltXb6lO8EESr1cubcPan+PG6X7c24PhV2pBWtI+r4yVqv+fptUwA1Hn1kgxrcJXwiF
 UQdg5LIDdzMIr53TArE0dSmn2ViAyHogJSP591tyez05NlyjIWKeJwE1U8TkYZikx7p1ywAyS
 8k8aERHCIOBKeU1ioUyMBuB6JLSqpOU6JSA0eNSKdZqIs25CWFW7pv+wn94GcFOPb3LWX/RTN
 Ct1kC8MhuEsIhrhRODY8SJN1hJnsDywETahdF4x4fqCZ2Te4RE9EI+iEcGV9CLbllrG98iePo
 nhOA/IlWIidpICQGRDAdHFdbHguqDy18SFuYKYGowVVoC/w49L9CZ6IzI/9sdq4HKlm1S/N81
 PA5980tGvclX7K7h8AyFwy9Q1ztGs+UC8zPLP+3t0NhAAnM90kuQDgu0FACI6p56wQjJ8l1/+
 9IKvg9d/XHQbEQzIssXzvaUuFWbFBVZ442h1j1+fY8/Ff5RQNt6pQ9hVvFtsAUnirzsv6c35X
 1Bai/yPx8yYKSXc5EbQ/94JKromC18VJWs45yT4gItHod9uqwjta9llTQXNm5GpNZq8hC6D0e
 heWD9CBOdKJNgiMLaHELG7yXkSiHhPTderpHCQUHFDE+gQtyq2gPSrwRuewWgy7dS1ly0ZQtC
 KeLI+HV+2JOUBRDszmfjC/wuohpBG6JHtTVRnds++L6m8Bn7Vvy7eoKm0sIEpFUG/m8IiJ/C4
 Jm9BGEEwK/l+g95oTing9jGAZh2Gt9FDYxBwpnmTu0GCluYofISn233UMPEOdd/Dje3F5o9UC
 Qz5KuifHFkKoR7Ip5IyI/2oJNJod5YVMxXy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.14
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.06.19 02:36, Michael S. Tsirkin wrote:
> On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Masked entries will not generate interrupt messages, thus do no need to
>> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
>> the kind
>>
>> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=3D0,=
 high=3D0xff00, low=3D0x100)
>>
>> if the masked entry happens to reference a non-present IRTE.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>> ---
>>  hw/intc/ioapic.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
>> index 7074489fdf..2fb288a22d 100644
>> --- a/hw/intc/ioapic.c
>> +++ b/hw/intc/ioapic.c
>> @@ -197,9 +197,11 @@ static void ioapic_update_kvm_routes(IOAPICCommonS=
tate *s)
>>              MSIMessage msg;
>>              struct ioapic_entry_info info;
>>              ioapic_entry_parse(s->ioredtbl[i], &info);
>> -            msg.address =3D info.addr;
>> -            msg.data =3D info.data;
>> -            kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
>> +            if (!info.masked) {
>> +                msg.address =3D info.addr;
>> +                msg.data =3D info.data;
>> +                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
>> +            }
>>          }
>>          kvm_irqchip_commit_routes(kvm_state);
>>      }
>> --
>> 2.16.4
>
>

Ping. Or is this queued for 4.2?

Jan

