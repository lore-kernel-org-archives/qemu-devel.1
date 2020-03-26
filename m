Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E84C2D0EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83CF7207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIlPV9pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CF7207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSdh-0007Rd-MJ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jHSa1-0003uZ-CG
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jHSa0-0004zu-5h
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:29:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jHSZz-0004zm-UT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585229390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtoyUJ6PE/9qGLkv2lMCLxBOo8GwNFuIYUexs1JlRFc=;
 b=JIlPV9pf/1+7Sn5DMTOZd2S53tegzu15qyWwUqK9OAAxk9U8GbtcClotxQoLjNBLSValwE
 cFFn+mhGrtVzLxolUH16IlwWTFWTzmcECh5dQRTn/CZ9zlnL1swaFhZsM38CdvloGnsaIV
 XRmG+0MNmxvIK9nZj5SI68yaMFhEJsI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-0Ss_1u3yM6eQmUjjamKfTA-1; Thu, 26 Mar 2020 09:29:49 -0400
X-MC-Unique: 0Ss_1u3yM6eQmUjjamKfTA-1
Received: by mail-wr1-f69.google.com with SMTP id y1so3038525wrn.10
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 06:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fxB69WNDtiZmWljnc/QZ62pSZjNih/V9hdMT7pwfsB4=;
 b=JPW1rXDwt+iExZlSs8xp9liKvuPg7dJJwf3LIg++aT1cWfrPUjUGAQEWPmNt3LG07A
 9G27E7k48tnVh8TzkkFfcYSx5Xi/FZnbO9muobQ2m+hSOW/d/FuIxSdvwba+z9GRNSze
 6ZCjpwhQPsGrdDB6I1A7eNep3Vrqa9f0rz6/gKqafjvSlYCAM0xHDeExMd1pL7EqeLg1
 XLZyi8lnAXyAXiRKA33xQOUqqY6lyv5sQmoMeKE50RZTmiUwUuBB2ajix1eNAa1OGqev
 1ijL9gzp0hl0j2R+4hxhD+LwXZBVc4SdzpJwuGAin+/hUxq8jQe4jBF+EYudvL5QHCTf
 8dDw==
X-Gm-Message-State: ANhLgQ05IiRvbCP/VlK3LbDDIhegLGmPf1CR3QIhVp0WMhgR8a61b/b0
 zf5L23RFUo4r+uhYBe5vJvZqHzhYZnHUzmXzxpIz+Fp4e34rchReRv+S6ZxTDaGEVbblEPmU958
 67tqsL8gSbyvEuo0=
X-Received: by 2002:a1c:6745:: with SMTP id b66mr12883wmc.30.1585229384881;
 Thu, 26 Mar 2020 06:29:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtG8JjK5Bk7XDnOLvBSaCY5Rlex3hofBr/jUawogKbTImcmIrtveDgJPXcDCR+WdLUOERac6g==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr12868wmc.30.1585229384608;
 Thu, 26 Mar 2020 06:29:44 -0700 (PDT)
Received: from redhat.com (bzq-109-67-62-195.red.bezeqint.net. [109.67.62.195])
 by smtp.gmail.com with ESMTPSA id s22sm3235617wmc.16.2020.03.26.06.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 06:29:44 -0700 (PDT)
Date: Thu, 26 Mar 2020 09:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: acpi_pcihp_eject_slot() bug if passed 'slots == 0'
Message-ID: <20200326092845-mutt-send-email-mst@kernel.org>
References: <CAFEAcA-oWBjOXWmnLvPww9wrty_QbSc+Xv3BY3sQAnEXFkfQbA@mail.gmail.com>
 <20200326132901.7aecb9e5@redhat.com>
 <20200326135041.297de118@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200326135041.297de118@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 01:50:41PM +0100, Igor Mammedov wrote:
> On Thu, 26 Mar 2020 13:29:01 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Thu, 26 Mar 2020 11:52:36 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >=20
> > > Hi; Coverity spots that if hw/acpi/pcihp.c:acpi_pcihp_eject_slot()
> > > is passed a zero 'slots' argument then ctz32(slots) will return 32,
> > > and then the code that does '1U << slot' is C undefined behaviour
> > > because it's an oversized shift. (This is CID 1421896.)
> > >=20
> > > Since the pci_write() function in this file can call
> > > acpi_pcihp_eject_slot() with an arbitrary value from the guest,
> > > I think we need to handle 'slots =3D=3D 0' safely. But what should
> > > the behaviour be? =20
> >=20
> > 0 is not valid value, we should ignore and return early in this case
> > like we do with bsel. I'll post a path shortly.
> well, looking more that is only true for main bus, for bridges it can be
> slot number can be zero,

It can but we don't allow slot zero hotplug with SHPC
so it's easier if we don't allow this with ACPI either.

> then AML left shifts it and writes into B0EJ
> which traps into pci_write(, data) and that is supposed to eject
> slot 0 according to guest(AML).
>=20
> Michael,
> what's your take on it?
>=20
> >=20
> > >=20
> > > thanks
> > > -- PMM
> > >  =20
> >=20
> >=20


