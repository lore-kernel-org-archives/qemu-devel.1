Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA7C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 525712075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfjuZVpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525712075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is5AS-000868-Bx
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 08:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is59F-0006UE-AH
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is59E-000479-22
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32463
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is59D-00046v-VG
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 08:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579181119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Omd1dymP/aA8I6I3SnZ+1r2udZhBpsCMI9jYmRDtIBA=;
 b=CfjuZVpH3siw4qbgU537HdRid9EPmWqftot/32nXjrPMyc3/D4TD3vqUq183nSqCcyYA8c
 Q3yin6Xle9zDCw70a3dG+0ghqFExUcjQogXYhHkQa+0k8SGt8YbZ8/z4EfwCuXGsdQtFFq
 18WqAqapUm0Y6EKBnmAngEM1jHaQWZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-nCSoRUIWOliI5kw8TDdvew-1; Thu, 16 Jan 2020 08:25:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FFA21902EA4;
 Thu, 16 Jan 2020 13:25:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36AD988894;
 Thu, 16 Jan 2020 13:25:09 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:25:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Guoheyi <guoheyi@huawei.com>
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified
 by _HID
Message-ID: <20200116142508.1d82af31@redhat.com>
In-Reply-To: <a4992b63-e8e7-7f54-341e-f7dd3d7e8880@huawei.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <20200105074308-mutt-send-email-mst@kernel.org>
 <a4992b63-e8e7-7f54-341e-f7dd3d7e8880@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nCSoRUIWOliI5kw8TDdvew-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 19:56:19 +0800
Guoheyi <guoheyi@huawei.com> wrote:

> =E5=9C=A8 2020/1/5 20:53, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > On Sun, Jan 05, 2020 at 07:34:01AM -0500, Michael S. Tsirkin wrote: =20
> >> On Thu, Dec 19, 2019 at 02:47:59PM +0800, Heyi Guo wrote: =20
> >>> According to ACPI spec, _ADR should be used for device which is on a
> >>> bus that has a standard enumeration algorithm. It does not make sense
> >>> to have a _ADR object for devices which already have _HID and will be
> >>> enumerated by OSPM.
> >>>
> >>> Signed-off-by: Heyi Guo <guoheyi@huawei.com> =20
> >> Are you sure? I would think this depends on the ID and the device
> >> really. E.g. PCI devices all are expected to have _ADR and some of the=
m
> >> have a _HID. =20
> >
> > To clarify I am not commenting on patches.
> > The spec says this:
> > =096.1.5 _HID (Hardware ID)
> >
> > =09This object is used to supply OSPM with the device=E2=80=99s PNP ID =
or ACPI ID. 1
> >
> > =09When describing a platform, use of any _HID objects is optional. How=
ever, a _HID object must be
> >
> > =09used to describe any device that will be enumerated by OSPM. OSPM on=
ly enumerates a device
> >
> > =09when no bus enumerator can detect the device ID. For example, device=
s on an ISA bus are
> >
> > =09enumerated by OSPM. Use the _ADR object to describe devices enumerat=
ed by bus enumerators
> >
> > =09other than OSPM.
> >
> >
> > Note: "detect the device ID" not "enumerate the device" which I think
> > means there's a driver matching this vendor/device ID.
> >
> > So it seems fine to have _ADR so device is enumerated, and still have
> > _HID e.g. so ACPI driver can be loaded as fallback if there's
> > no bus driver.
> >
> >
> > Note I am not saying the patch itself is not correct.
> > Maybe these devices are not on any standard bus and that
> > is why they should not have _ADR? I have not looked.
> >
> > I am just saying that spec does not seem to imply _HID and _ADR
> > can't coexist. =20
>=20
> More reading on the spec, I found a statement as below=20
> (https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf,=20
> section 6.1, on top of page 343):

I'd replace 'It does not make sense ...' sentence with pointer to spec
and quote below in commit message.

> A device object must contain either an _HID object or an _ADR object,=20
> but should not contain both

[...]


