Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A1DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B31F21852
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itxg0Dba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B31F21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1GC-0003dm-GA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iX1FB-0002zB-Pr
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:00:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iX1F9-0001gn-QL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:00:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iX1F9-0001gG-LB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574161222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfamZ8r1B6df84t+mJZMybMdyLIrQuz0VSRiPVu75wY=;
 b=itxg0DbaonCti4bu/NhHAvUwgAF2sIafXj+edsVynr9EaMAw0x3UbxsBggOoUpfX6vRGQT
 Hsg1rmwlDhJNwiTHGtrkIjye6iGaSpmVEQIvuGDAaMOSNlhQP3SzEhhM8NmiOIvRQX6s60
 HRb46x2573Qr1vIBEf/wQ4rINbb9TsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-jPUCXwpMOjO9NdmXFyJxng-1; Tue, 19 Nov 2019 06:00:19 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0D1918B6380;
 Tue, 19 Nov 2019 11:00:17 +0000 (UTC)
Received: from [10.36.117.126] (ovpn-117-126.ams2.redhat.com [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E63CE5DA7C;
 Tue, 19 Nov 2019 11:00:14 +0000 (UTC)
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
 <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
 <3aa1d025-20a3-e813-2fe6-35518efedf2f@redhat.com>
 <20191118184906.GB3812@habkost.net>
 <CAFEAcA_iTX2TKh20DB9ZMtDLuPm=OvoyP==KRhfVh99BqDnrzA@mail.gmail.com>
 <20191118220417.GF3812@habkost.net>
 <CAFEAcA8XoyeAfHuKe0AEvecCzo748Yk1VD1+VD=C3ACZdfzwsw@mail.gmail.com>
 <ca517ad9-46bb-c0ac-2227-a64ab8fe5e15@redhat.com>
 <CAFEAcA-egL5kbo81eBT+FVBz7vSaWqUVzFUF3MNOttnzY6vZMQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1fd9876d-5ad9-15e9-a2dc-6e5e747f9ca8@redhat.com>
Date: Tue, 19 Nov 2019 12:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-egL5kbo81eBT+FVBz7vSaWqUVzFUF3MNOttnzY6vZMQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: jPUCXwpMOjO9NdmXFyJxng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.11.19 11:36, Peter Maydell wrote:
> On Tue, 19 Nov 2019 at 09:59, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.11.19 10:22, Peter Maydell wrote:
>>> I don't hugely care about query-cpu-model-expansion. I
>>> just don't want it to have bad effects on the semantics
>>> of user-facing stuff like x- properties.
>>
>> IMHO, max should really include all features (yes, also the bad
>> x-features on arm :) ) and we should have a way to give users the
>> opportunity to specify "just give me the best model independent of the
>> accelerator" - something like a "best" model, but I don't care about the
>> name.
>=20
> How would "max includes all features" work if we have two
> x- features (or even two normal features!) which are incompatible
> with each other? How does it work for features which are

I assume the "max" model should at least be consistent, see below.

> valid for some other CPU type but not for 'max'? The design
> seems to assume a rather simplified system where every
> feature is independent and can always be applied to every
> CPU, which I don't think is guaranteed to be the case.

I do agree that the use case of "max" for detecting which features can=20
be enabled for any CPU model is quite simplified and would also not work=20
like this on s390x. It really means "give me the maximum/latest/greatest=20
you can". Some examples on s390x:

On s390x, we don't allow to enable new features for older CPU=20
generation. "vx" was introduced with a z13. If "max" is a z13, it can=20
include "vx", if available. However, if you select a z12 (zEC12), you=20
cannot enable "vx":

"Feature '%s' is not available for CPU model '%s', it was introduced=20
with later models."

Also, we have dependency checks=20
(target/s390x/cpu_models.c:check_consistency()), that at least warn on=20
inconsistencies between features (feature X requires feature Y).

We would need more fine-grained "max" models. E.g., z13-max vs. z13-best=20
vs. z13-base.

- z13-max: Maximum features that can be enabled on the current
            accel/host for a z13.
- z13-best: Best features that can be enabled on the current
            accel/host for a z13.
- z13-base: base feature set, independent of current
            accel/host for a z13. (we do have this already on s390x)

>=20
> thanks
> -- PMM
>=20


--=20

Thanks,

David / dhildenb


