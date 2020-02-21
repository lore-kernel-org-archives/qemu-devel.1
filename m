Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782CC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:20:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032CB24656
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfP3caCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032CB24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56ME-0003wu-4X
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j56LG-0002vR-Qw
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j56LF-0007CC-NC
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:19:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51252
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j56LF-0007B3-JA
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582283969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4ebQwlt11Gl0jrM7qcleoPwEVIE6AQamzr2NAIpqU4=;
 b=CfP3caCCLmOZsfwg/EiZFlrhYBT8HkAVjtH6v3d3/VwGOH5skQB/hD2+rDA2jaDpe22tkR
 i5hQBSzhDKT1T6wH7OsTCbos3zXaJBXy/ViSp8V6/w7U1QR9zdUCk1xoKwF89/pF4gwu+F
 QWcswXd4y3wusei/cJoeXWZTKE5iux8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-tTppOu2LP5ipl8htr_m5ww-1; Fri, 21 Feb 2020 06:19:25 -0500
X-MC-Unique: tTppOu2LP5ipl8htr_m5ww-1
Received: by mail-qv1-f71.google.com with SMTP id e26so1131247qvb.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 03:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7txp7z1X8erN7BC9QYO3PQSZ4yDrqkuOWmxBfekEQjM=;
 b=kKLNyRoGKXkBMBeVYkxmkHSMlPnJwkRisPxvzyKlQo/iohtNWuPBUyN7qLBwlYH7+c
 J5LKNWLUyE/E9yR3SeJxL6a6eilfXEr1bwJQ8pX8eJeN63k+aRw9yuvsKlrsBa38HBWM
 7aRGatA27ZzgYsHwMAvPhUSEtjetrc8uERHT9+cOsDc2QlE275fJ52vx5lLE86NYUpTV
 FYAlwtARZEK0MGSeNXrN4nde/OFLh3uhCA4k7jVAt527UoiyFPvEHZWPPwJijWMFnNPX
 ToujA4Ij0NPX0neHgFlRneCYGYCkwBUkiRXWH49Jb42LGmy4z5Q5wlmZr3AGvPiF4QNA
 t3kw==
X-Gm-Message-State: APjAAAU4WKJOP0HBXmcKGXUoyDsrni20LxbHBJs7UvwGiJ0Rtw5Rf1qm
 xXDKerRcFYLp6o7RMy9XIC25ScEuolQGULMS0Vfh2DQqvx2Uy4yXXGoaUyQhnTOoUsezZ7JPUmP
 3Rw5Y8itMLN/pTR4=
X-Received: by 2002:ac8:425a:: with SMTP id r26mr31032977qtm.138.1582283965353; 
 Fri, 21 Feb 2020 03:19:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEYI/1JwoIqXH1oGA8/qEEp3fDLCv4oEsDMkSZ7ZFlFWeitxRZvT0VxRdkchJrjgSYW2BAcw==
X-Received: by 2002:ac8:425a:: with SMTP id r26mr31032950qtm.138.1582283965127; 
 Fri, 21 Feb 2020 03:19:25 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id q14sm1359692qkn.30.2020.02.21.03.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:19:24 -0800 (PST)
Date: Fri, 21 Feb 2020 06:19:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yubo Miao <miaoyubo@huawei.com>
Subject: Re: [RFC v3 3/3] ACPI/unit-test: Add a new test for pxb-pcie for arm
Message-ID: <20200221061811-mutt-send-email-mst@kernel.org>
References: <20200221063512.1104-1-miaoyubo@huawei.com>
 <20200221063512.1104-4-miaoyubo@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200221063512.1104-4-miaoyubo@huawei.com>
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 02:35:12PM +0800, Yubo Miao wrote:
> From: miaoyubo <miaoyubo@huawei.com>
>=20
> Currently, pxb-pcie could be defined by the cmdline like
>     --device pxb-pcie,id=3Dpci.9,bus_nr=3D128
> However pxb-pcie is not described in acpi tables for arm.
>=20
> The formal two patches support pxb-pcie for arm, escpcially the
> specification for pxb-pcie in DSDT table.
>=20
> Add a testcase to make sure the ACPI table is correct for guest.
>=20
> Signed-off-by: miaoyubo <miaoyubo@huawei.com>


Please look at the top of tests/qtest/bios-tables-test.c
for how to add or update tests.

> ---
>  tests/data/acpi/virt/DSDT.pxb  | Bin 0 -> 34209 bytes
>  tests/qtest/bios-tables-test.c |  54 +++++++++++++++++++++++++++++----
>  2 files changed, 48 insertions(+), 6 deletions(-)
>  create mode 100644 tests/data/acpi/virt/DSDT.pxb
>=20
> diff --git a/tests/data/acpi/virt/DSDT.pxb b/tests/data/acpi/virt/DSDT.px=
b
> new file mode 100644
> index 0000000000000000000000000000000000000000..4eea3192c75ff28f7054d626a=
9363ca025b6c0ad
> GIT binary patch

I can't read this.

> literal 34209
> zcmeI*cXU+szJ~D)1PGxe5PG+us9-{<Do8R35G4>YGz}UAMT!L#ks?x*Dx!d5hoIPd
> z?}}o>iWL;GW5HgrlKbvVM&HM??^)~qbMIProvd|8p2_U*%qO!m?AgcPkRQ(<wr)WX
> zR3DKyBsMVKK5tZUEMJ#Z3xXj0I{cizY-H-_vUpxu>HL<ltgNimvVn#9^>bszg^Hd*
> zYT59@{GfDxK}u{$QSzH5MFX?4va_qcnOYVriD$G-YqqdX5KgQUqzA#0T0ymH9aJ-P
> zt=3D#;Qdf_)p=3DV$jH6t9{xXmH68P3ev)8EFlwrs(=3DX$_(9dxJh>6UU8FZi5vcVla%Bp
> zz50)g^-pXvw4i9XAYFAU@nN}Xb+t___n%u<uhU$chBua*GNL5;Gf3Q8mfgX>w)`8L
> z7F4goX88!*;pB+$X8&bG_2BOj*;OO*!h6xx&B+mI)uU#l*o>||BPVi3ji?#5Y(|dH
> z=3DoUF6C2B^h&FJPcx<}5a88su#W_0%%JtAk+ikeZ+X7unGJtJq-j+)WHX7uzKy&`9%

...


