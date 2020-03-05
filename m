Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A8E2073D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7fd3Fhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A8E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9lZT-0007JL-Gd
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j9lYg-0006jX-3n
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j9lYf-0002Vm-8m
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:08:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37831
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j9lYf-0002VO-57
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583395720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF+HbE50GELJHZ+XJOAWl/vf3PX3vFsfj2R/1n8ejR0=;
 b=O7fd3FhjqDV5VwOrpzISW2AAMBWQ7JbTtF/eaKTcj2/JpyfPnyg2IbZ/RXc7UOyM6UhbNb
 UnMM7XsVz29os8ZGiG1OAZxvqU8S8/4Q0qYf1Jfu1RMywe9MMv9+AlHDpnfT/tqZuUk7LI
 D70m7sFEHdhlSJDDEKlXmSPE8Lep9U0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-P30gFA44PFG1p-ZRVVqAyw-1; Thu, 05 Mar 2020 03:08:38 -0500
X-MC-Unique: P30gFA44PFG1p-ZRVVqAyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B088800D5C
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 08:08:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA5BD91D79;
 Thu,  5 Mar 2020 08:08:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 105B817449; Thu,  5 Mar 2020 09:08:36 +0100 (CET)
Date: Thu, 5 Mar 2020 09:08:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
Message-ID: <20200305080836.cggs6z3s5g5thuzw@sirius.home.kraxel.org>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Yan Vugenfirer <yvugenfi@redhat.com>,
 Yuri Benditovich <ybendito@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > +    case 5: /* qxl-5 */
> > +        pci_device_rev =3D QXL_REVISION_STABLE_V12 + 1;
> > +        io_size =3D pow2ceil(QXL_IO_RANGE_SIZE);
> > +        break;

> this patch -- commit ed71c09ffd6f -- disables ACPI S3 in the Windows 10
> guest for me, using OVMF and QXL.
>=20
> The "Sleep" menu entry disappears from the power button icon/menu at the
> login screen, and "psshutdown -d -t 3" (from the pstools package) also
> stops working (it reports that the computer does not support S3).

Any chance the qxl windows guest driver checks "revision =3D=3D 4"
instead of "revision >=3D 4"?

cheers,
  Gerd


