Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0DAC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:49:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C742320720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGBxr+S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C742320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwku7-0007mG-Qa
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwktU-0007Hs-3m
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwktQ-0005VV-85
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:48:24 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwktQ-0005Uz-4b
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580294899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=yRRdmyt9PRZUEIJ4je+I2F9DPokhr/04ewkeRanlvCs=;
 b=PGBxr+S/hWbJL5y5lXFtH4i1VF0PsGQrsermcZW2vL3WY1vfUFreWJn0lJXP7w1hQTZsbH
 Kx+qvNitpJVfKczbur85n3E6623Lvn48DEpNosiEBEfjt5i+JOWnrPMUUvn2nSbUa0u63A
 5Id6vz3bSyzgJqrSas1eD7jiD5LZTss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-5AsRGxvJMGaqXegCNbFygw-1; Wed, 29 Jan 2020 05:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC02C1800D41;
 Wed, 29 Jan 2020 10:48:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B03F260C18;
 Wed, 29 Jan 2020 10:48:14 +0000 (UTC)
Subject: Re: Assertion triggers with power8e_v2.1-powernv-cpu-core
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
References: <5937c35c-e290-5b7a-18f4-05a5149b58c5@redhat.com>
 <db907c1e-9a67-0eeb-ef18-c710e68cd311@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2a37c985-2ada-e64d-5f4e-fb158e372af5@redhat.com>
Date: Wed, 29 Jan 2020 11:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <db907c1e-9a67-0eeb-ef18-c710e68cd311@kaod.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5AsRGxvJMGaqXegCNbFygw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 11.39, C=C3=A9dric Le Goater wrote:
> On 1/29/20 11:31 AM, Thomas Huth wrote:
>> FYI, scripts/device-crash-test reported an assertion, triggerable like t=
his:
>>
>> $ qemu-system-ppc64 -machine ppce500 -device power8e_v2.1-powernv-cpu-co=
re
>> qemu-system-ppc64: hw/ppc/pnv_core.c:221: pnv_core_realize: Assertion
>> `pc->chip' failed.
>> Aborted (core dumped)
>>
>> Of course using that CPU is not possible on ppce500, but there should be
>> a proper error message instead of that assertion.
>>
>> Does anybody have an idea what's the best place to fix this issue?
>=20
> The cores should be instantiated by a PowerNV chip. So may be we
> should fix this issue with :
>=20
> @@ -325,6 +325,7 @@ static void pnv_core_class_init(ObjectCl
>      dc->realize =3D pnv_core_realize;
>      dc->unrealize =3D pnv_core_unrealize;
>      device_class_set_props(dc, pnv_core_properties);
> +    dc->user_creatable =3D false;
>  }
> =20
>  #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
>=20
>=20
> I think that most of the PowerNV devices are not user creatable.

Right, there are also aborts with: pnv-lpc, pnv-homer, pnv-occ, ...

Do you have some spare time for a patch?

 Thomas


