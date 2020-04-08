Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82861C2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A1CB206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3kD5yzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1CB206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMANA-0007Sm-CO
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jMAIw-000214-Ty
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:59:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jMAIw-0005SX-09
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:59:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jMAIv-0005Ry-Si
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586350781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNwPELplmwfD1kCGcXRDxJa4F+4njivrwX3kZHTE16A=;
 b=R3kD5yzGEX1RxpXXqTQwIkvJZ2AA8DMbT4CA6pKKeIUVamdYJNEjnhJt+qbQKinr5P4uKk
 syXoG2x8Kqx/hMDBpRnGlhsHIASzJu6+H0Q/AmgYRMImHaeKkzmMTUwKw0fU2aYj69pKI0
 LBe5FdniztGXAo2FnqLCaNvhu3Klwbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-_BrUqFhXO9GJJdNH-dtZUQ-1; Wed, 08 Apr 2020 08:59:38 -0400
X-MC-Unique: _BrUqFhXO9GJJdNH-dtZUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7CB08017F5;
 Wed,  8 Apr 2020 12:59:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD60560C63;
 Wed,  8 Apr 2020 12:59:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A28A01750A; Wed,  8 Apr 2020 14:59:28 +0200 (CEST)
Date: Wed, 8 Apr 2020 14:59:28 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 07/12] acpi: move aml builder code for rtc device
Message-ID: <20200408125928.scuf2eh34553q3ao@sirius.home.kraxel.org>
References: <20200403080502.8154-1-kraxel@redhat.com>
 <20200403080502.8154-8-kraxel@redhat.com>
 <20200403120921.258db9a5@redhat.com>
 <20200406082517.uyz7zv4jiqqjbcli@sirius.home.kraxel.org>
 <20200406141705.77d90b68@redhat.com>
 <20200407102658.x5tb4txcpvmtxfj7@sirius.home.kraxel.org>
 <20200408132727.374c470d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200408132727.374c470d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > > > > > +    crs =3D aml_resource_template();
> > > > > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10,=
 0x02));
> maybe replace magic 0x0070 with macro
>   RTC_BASE_ADDR

Yes, that sounds better.

> > > > > > +    aml_append(crs, aml_irq_no_flags(8));
> > > > > > +    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02,=
 0x06));
>=20
> one more comment, is this last io record correct?
> (looking at realize it maps only 2 bytes at 0x70)

No idea, I've just moved around the code.

Good question though.  Also why this splitted in two ranges the first
place.  Looking at physical hardware (my workstation) I see this:

        Device (RTC)
        {
            Name (_HID, EisaId ("PNP0B00") /* AT Real-Time Clock */)  // _H=
ID: Hardware ID
            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Sett=
ings
            {
                IO (Decode16,
                    0x0070,             // Range Minimum
                    0x0070,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                IRQNoFlags ()
                    {8}
            })
        }

Clues anyone?

thanks,
  Gerd


