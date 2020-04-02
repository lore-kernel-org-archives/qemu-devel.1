Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15EFC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8A2208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 08:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCX+YArr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8A2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvZW-0006VS-RY
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 04:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45789)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jJvYw-0005wO-B8
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jJvYv-0008LU-6m
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:50:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jJvYv-0008LI-3r
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 04:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585817456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o2ROWoA/Q4kopE0GRuJxFR1Mdzx26gimKSY4bj8fFeY=;
 b=JCX+YArr43XTVC3iGJfm+yjnCJOb9By03p+Vx2Fz6kXWO1A+Mu9NBGJMPF8T532021CK9X
 UtSilwn+iOXhwYp1QLTqCnnF5LF3XzIShKQzd5Yj4dXQy89ZNN8WEPqJQ7tICxO0UL8Szf
 p3K6n6jyJk5kIHPjMh8yhqXXfcVeHvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-unMlZHFhMauk_GWmxdC6XA-1; Thu, 02 Apr 2020 04:50:53 -0400
X-MC-Unique: unMlZHFhMauk_GWmxdC6XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69005800D6C;
 Thu,  2 Apr 2020 08:50:50 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9451C933;
 Thu,  2 Apr 2020 08:50:47 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 10/13] arm/arm64: ITS: INT functional
 tests
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-11-eric.auger@redhat.com>
 <f7f1d7c4-2321-9123-2394-528af737bfa7@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <fa4e14f6-20ee-982f-0eda-74b101cddf7a@redhat.com>
Date: Thu, 2 Apr 2020 10:50:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f7f1d7c4-2321-9123-2394-528af737bfa7@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/30/20 12:43 PM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/20 17:24, Eric Auger wrote:
>> Triggers LPIs through the INT command.
>>
>> the test checks the LPI hits the right CPU and triggers
>> the right LPI intid, ie. the translation is correct.
>>
>> Updates to the config table also are tested, along with inv
>> and invall commands.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> [...]
>=20
> So I've tested this series and found that the "INT" test will sometimes
> fail.
>=20
> "not ok 12 - gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8195 =
en
> PE #3 after migration
> not ok 13 - gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8196 =
on
> PE #2 after migration"
>=20
> From logs:
> "INFO: gicv3: its-migration: Migration complete
> INT dev_id=3D2 event_id=3D20
> INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D3,
> intid=3D8195) was expected
> FAIL: gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8195 en PE #=
3
> after migration
> INT dev_id=3D7 event_id=3D255
> INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D2,
> intid=3D8196) was expected
> FAIL: gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8196 on PE =
#2
> after migration"
>=20
>> +static void check_lpi_stats(const char *msg)
>> +{
>> +=C2=A0=C2=A0=C2=A0 bool pass =3D false;
>> +
>> +=C2=A0=C2=A0=C2=A0 mdelay(100);
>=20
> After changing this to 'mdelay(1000)', the above error doesn't show up
> anymore. But it sounds strange that 100ms is not enough to deliver a
> single LPI. I haven't dig it further but will get back here later.

Did you find some time to investigate this issue. Changing 100 to 1000
has a huge impact on the overall test duration and I don't think it is
sensible. Could you see what is your minimal value that pass the tests?

Thanks

Eric
>=20
>> +=C2=A0=C2=A0=C2=A0 smp_rmb(); /* pairs with wmb in lpi_handler */
>> +=C2=A0=C2=A0=C2=A0 if (lpi_stats.observed.cpu_id !=3D lpi_stats.expec=
ted.cpu_id ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.observed.lpi_id =
!=3D lpi_stats.expected.lpi_id) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (lpi_stats.observed.cpu=
_id =3D=3D -1 &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lp=
i_stats.observed.lpi_id =3D=3D -1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
port_info("No LPI received whereas (cpuid=3D%d, intid=3D%d) "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "was expected", lpi_stats.e=
xpected.cpu_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.expected.lpi_id);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
port_info("Unexpected LPI (cpuid=3D%d, intid=3D%d)",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.observed.cpu_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.observed.lpi_id);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass =3D true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 report(pass, "%s", msg);
>> +}
>=20
> This patch itself looks good to me,
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>=20
>=20
> Thanks
>=20


