Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF75C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA65820716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFB2kr37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA65820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIqTE-0005gg-3J
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jIqSZ-00059X-1e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jIqSX-0002yy-SG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:11:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:37488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jIqSX-0002yK-Og
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585559512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2DCNzbDRPMtY5AnjTRXp7pP6euGDlLTuk3BX6MYjYU=;
 b=ZFB2kr37PjwRPb3fFYZb7oIiXDnJiwxiCiB5lCZLCuggV4mTyQGoCdCzvuvB0pTayGLRu1
 Oe+zHxhv8JDnS/rNZ+bvkfhUfgKdzIuBLxkSIYD83je+kkdR3Lyzfkww5nmkQyVfOM4lVL
 FI+v+dY9NDTIspBfMAQb8JzIj31H/ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-YUwdMTuWP9aQAZleaNZsXw-1; Mon, 30 Mar 2020 05:11:50 -0400
X-MC-Unique: YUwdMTuWP9aQAZleaNZsXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23FFFDB83;
 Mon, 30 Mar 2020 09:11:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 340D419925;
 Mon, 30 Mar 2020 09:11:42 +0000 (UTC)
Date: Mon, 30 Mar 2020 11:11:39 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
Message-ID: <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, Zenghui Yu <yuzenghui@huawei.com>,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 10:46:57AM +0200, Auger Eric wrote:
> Hi Zenghui,
>=20
> On 3/30/20 10:30 AM, Zenghui Yu wrote:
> > Hi Eric,
> >=20
> > On 2020/3/20 17:24, Eric Auger wrote:
> >> +static void its_cmd_queue_init(void)
> >> +{
> >> +=A0=A0=A0 unsigned long order =3D get_order(SZ_64K >> PAGE_SHIFT);
> >> +=A0=A0=A0 u64 cbaser;
> >> +
> >> +=A0=A0=A0 its_data.cmd_base =3D (void *)virt_to_phys(alloc_pages(or=
der));
> >=20
> > Shouldn't the cmd_base (and the cmd_write) be set as a GVA?
> yes it should

If it's supposed to be a virtual address, when why do the virt_to_phys?

> >=20
> > Otherwise I think we will end-up with memory corruption when writing
> > the command queue.=A0 But it seems that everything just works fine ..=
.
> > So I'm really confused here :-/
> I was told by Paolo that the VA/PA memory map is flat in kvmunit test.

What does flat mean? kvm-unit-tests, at least arm/arm64, does prepare
an identity map of all physical memory, which explains why the above
is working. It's doing virt_to_phys(some-virt-addr), which gets a
phys addr, but when the ITS uses it as a virt addr it works because
we *also* have a virt addr =3D=3D phys addr mapping in the default page
table, which is named "idmap" for good reason.

I think it would be better to test with the non-identity mapped addresses
though.

Thanks,
drew

>=20
> >=20
> >> +
> >> +=A0=A0=A0 cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / SZ_4K - 1)=
=A0=A0=A0 |
> >> GITS_CBASER_VALID);
> >> +
> >> +=A0=A0=A0 writeq(cbaser, its_data.base + GITS_CBASER);
> >> +
> >> +=A0=A0=A0 its_data.cmd_write =3D its_data.cmd_base;
> >> +=A0=A0=A0 writeq(0, its_data.base + GITS_CWRITER);
> >> +}
> >=20
> > Otherwise this looks good,
> > Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> Thanks!
>=20
> Eric
> >=20
> >=20
> > Thanks
> >=20
>=20
>=20


