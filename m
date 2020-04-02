Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F36EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03562073B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atPJIU3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03562073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK12w-000755-6U
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 10:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jK12B-0006YU-LE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jK12A-0008UV-0T
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:41:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jK129-0008TL-SU
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 10:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585838489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQlIPwSA6eO8FaNGqaPVKwSvrWhWEma0a4EepOgZn9Y=;
 b=atPJIU3pA8KzMLInKyK4TWyS5oY3Cfo0p9CrCD7uGZWBNc7eaHGeV7G/Wc1C26P4Ntq2k5
 vk1l0sUaNiwcd0OjtqkytcUzUmBOU/3NWfe79esUHZAHEezVweM5wqXq6fIKrc8b3GilRs
 CEzcPVfcGW4Ot3un34WyHD6tsUFfjjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-jcwdGm7hNY6oM0oaAdC1ag-1; Thu, 02 Apr 2020 10:41:25 -0400
X-MC-Unique: jcwdGm7hNY6oM0oaAdC1ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94C7419067E7;
 Thu,  2 Apr 2020 14:41:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78A36D768E;
 Thu,  2 Apr 2020 14:41:15 +0000 (UTC)
Date: Thu, 2 Apr 2020 16:41:12 +0200
From: Andrew Jones <drjones@redhat.com>
To: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [kvm-unit-tests PATCH v7 10/13] arm/arm64: ITS: INT functional
 tests
Message-ID: <20200402144112.u6nwzkqe7mt3rr6c@kamzik.brq.redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-11-eric.auger@redhat.com>
 <f7f1d7c4-2321-9123-2394-528af737bfa7@huawei.com>
 <fa4e14f6-20ee-982f-0eda-74b101cddf7a@redhat.com>
 <114f8bba-a1e0-0367-a1b4-e875718d8dba@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <114f8bba-a1e0-0367-a1b4-e875718d8dba@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, Auger Eric <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, andre.przywara@arm.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 02, 2020 at 08:40:42PM +0800, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/4/2 16:50, Auger Eric wrote:
> > Hi Zenghui,
> >=20
> > On 3/30/20 12:43 PM, Zenghui Yu wrote:
> > > Hi Eric,
> > >=20
> > > On 2020/3/20 17:24, Eric Auger wrote:
> > > > Triggers LPIs through the INT command.
> > > >=20
> > > > the test checks the LPI hits the right CPU and triggers
> > > > the right LPI intid, ie. the translation is correct.
> > > >=20
> > > > Updates to the config table also are tested, along with inv
> > > > and invall commands.
> > > >=20
> > > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > >=20
> > > [...]
> > >=20
> > > So I've tested this series and found that the "INT" test will somet=
imes
> > > fail.
> > >=20
> > > "not ok 12 - gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8=
195 en
> > > PE #3 after migration
> > > not ok 13 - gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8=
196 on
> > > PE #2 after migration"
> > >=20
> > >  From logs:
> > > "INFO: gicv3: its-migration: Migration complete
> > > INT dev_id=3D2 event_id=3D20
> > > INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D3,
> > > intid=3D8195) was expected
> > > FAIL: gicv3: its-migration: dev2/eventid=3D20 triggers LPI 8195 en =
PE #3
> > > after migration
> > > INT dev_id=3D7 event_id=3D255
> > > INFO: gicv3: its-migration: No LPI received whereas (cpuid=3D2,
> > > intid=3D8196) was expected
> > > FAIL: gicv3: its-migration: dev7/eventid=3D255 triggers LPI 8196 on=
 PE #2
> > > after migration"
> > >=20
> > > > +static void check_lpi_stats(const char *msg)
> > > > +{
> > > > +=A0=A0=A0 bool pass =3D false;
> > > > +
> > > > +=A0=A0=A0 mdelay(100);
> > >=20
> > > After changing this to 'mdelay(1000)', the above error doesn't show=
 up
> > > anymore. But it sounds strange that 100ms is not enough to deliver =
a
> > > single LPI. I haven't dig it further but will get back here later.
> >=20
> > Did you find some time to investigate this issue. Changing 100 to 100=
0
> > has a huge impact on the overall test duration and I don't think it i=
s
> > sensible. Could you see what is your minimal value that pass the test=
s?
>=20
> I can reproduce this issue with a very *low* probability so I failed
> to investigate it :-(.  (It might because the LPI was delivered to a
> busy vcpu...)
>=20
> You can leave it as it is until someone else complain about it again.
> Or take the similar approach as check_acked() - wait up to 5s for the
> interrupt to be delivered, and bail out as soon as we see it.

I think the check_acked approach would be the best approach.

Thanks,
drew

>=20
>=20
> Thanks,
> Zenghui
>=20
>=20


