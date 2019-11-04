Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA1CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7202080F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eplqeZsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7202080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRhQv-0000Kv-4P
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iRhPY-0007sB-Sk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iRhPX-0007xj-T0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:49:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iRhPX-0007xV-On
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572893346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpInmTKfqSghN/xi91gRYBHPQ1L9fpJhKYfhAFTqAzY=;
 b=eplqeZsGCnN9vfmZs66pQGns8ipKoPS5hOqjzK/QRXLPpUXUbi+XXwnCuZ0ZdKsLtbGqOL
 mbM2f02aElp8wAWEFJzg8aiFbFWOEFR7PXscytDF0BLzOk53sVUxqiNp9EdCB8AabqlxBG
 7JmP0/RmbSk7Q4CiX9bNhqygwYjAWL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-AcMbwCgfPdG076ys-9BGDw-1; Mon, 04 Nov 2019 13:49:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3ED101005500;
 Mon,  4 Nov 2019 18:49:01 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F00E5D9CD;
 Mon,  4 Nov 2019 18:48:58 +0000 (UTC)
Date: Mon, 4 Nov 2019 11:48:57 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Li Qiang <liq3ea@163.com>
Subject: Re: Questions about the VFIO BAR region
Message-ID: <20191104114857.74fe9222@x1.home>
In-Reply-To: <5DC05485.008EAA.00665@m12-12.163.com>
References: <5DC05485.008EAA.00665@m12-12.163.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: AcMbwCgfPdG076ys-9BGDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "liq3ea@gmail.com" <liq3ea@gmail.com>,
 Alex Williamson <alex.l.williamson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 00:40:39 +0800
Li Qiang <liq3ea@163.com> wrote:

> Hello Alex, Auger and all,
>=20
> I have a question about the VFIO virtual device BAR.
>=20
> In vfio_region_setup, it initialize a =E2=80=98region->mem=E2=80=99 MR an=
d set its ops to =E2=80=98vfio_regions_ops=E2=80=99.=20
> In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical device=E2=80=
=99s MMIO to QEMU=E2=80=99s virtual address space=20
> as a raw MR =E2=80=98region->mmaps[i].mem=E2=80=99.=20
> And also it set the latter MR as a subregion of the first one.
>=20
> So when the guest accesses the BAR, it will direct go to the physical dev=
ice=E2=80=99s BAR.
> My question is here:
> When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to read/wri=
te the BAR?
> Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99 we need=
 to call =E2=80=98vbasedev->ops->vfio_eoi(vbasedev);=E2=80=99?

We support:

 a) sparse mmaps where the entire BAR is not covered by an mmap
 b) quirks, which layer on top of the mmaps to provide virtualized
    access
 c) INTx emulation which disables mmaps MRs in order to detect device
    access as a generic mechanism for inferring interrupt
    acknowledgment.

The latter being the reason we call vfio_eoi.  Thanks,

Alex


