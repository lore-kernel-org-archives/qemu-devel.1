Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB24C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499C42177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIrJf54R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499C42177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJ0u-0000Sj-9s
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBIzx-0007vl-8l
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:35:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31167
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBIzu-0005CZ-NZ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598538925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=miV8XUjXTTJOn3p2npM8IlXQXuEYZD37KMjnDF+F1iA=;
 b=DIrJf54RCyzxMDeoanx9JC1/p2xYx1KOjr61UZotAU9kkubRX0sc+O5uN53Vd7R3v5kf9A
 NVVTeuNDCmNa01ExumEZsoLEu61HIeldYECfuFO9hcHplZpEValnbBBvcoF325T5ssB1Rg
 fX7/ll6kNheVGJwuZpvAy8jMijMhWNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-aOGCRYwQObqECh9IaQFU3Q-1; Thu, 27 Aug 2020 10:35:20 -0400
X-MC-Unique: aOGCRYwQObqECh9IaQFU3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6AC08797E1;
 Thu, 27 Aug 2020 14:35:18 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 038E37D4FD;
 Thu, 27 Aug 2020 14:35:11 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:35:11 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 02/20] seabios: add microvm config, update build rules
Message-ID: <20200827143511.vo3m6h4wla2xvtpz@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-3-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-3-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rg3d46m5axhcn2cp"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rg3d46m5axhcn2cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:36PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  roms/Makefile               |  5 ++++-
>  roms/config.seabios-microvm | 26 ++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 roms/config.seabios-microvm

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/roms/Makefile b/roms/Makefile
> index 2673a39f9dc2..f8890c7e39de 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -70,9 +70,12 @@ default help:
>  =09@echo "  clean              -- delete the files generated by the prev=
ious" \
>  =09                              "build targets"
> =20
> -bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256=
k
> +bios: build-seabios-config-seabios-128k \
> +=09=09build-seabios-config-seabios-256k \
> +=09=09build-seabios-config-seabios-microvm
>  =09cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
>  =09cp seabios/builds/seabios-256k/bios.bin ../pc-bios/bios-256k.bin
> +=09cp seabios/builds/seabios-microvm/bios.bin ../pc-bios/bios-microvm.bi=
n
> =20
>  vgabios seavgabios: $(patsubst %,seavgabios-%,$(vgabios_variants))
> =20
> diff --git a/roms/config.seabios-microvm b/roms/config.seabios-microvm
> new file mode 100644
> index 000000000000..a253e2edc6ec
> --- /dev/null
> +++ b/roms/config.seabios-microvm
> @@ -0,0 +1,26 @@
> +CONFIG_QEMU=3Dy
> +CONFIG_QEMU_HARDWARE=3Dy
> +CONFIG_PERMIT_UNALIGNED_PCIROM=3Dy
> +CONFIG_ROM_SIZE=3D128
> +CONFIG_XEN=3Dn
> +CONFIG_BOOTSPLASH=3Dn
> +CONFIG_ATA=3Dn
> +CONFIG_AHCI=3Dn
> +CONFIG_SDCARD=3Dn
> +CONFIG_PVSCSI=3Dn
> +CONFIG_ESP_SCSI=3Dn
> +CONFIG_LSI_SCSI=3Dn
> +CONFIG_MEGASAS=3Dn
> +CONFIG_MPT_SCSI=3Dn
> +CONFIG_FLOPPY=3Dn
> +CONFIG_FLASH_FLOPPY=3Dn
> +CONFIG_NVME=3Dn
> +CONFIG_PS2PORT=3Dn
> +CONFIG_USB=3Dn
> +CONFIG_LPT=3Dn
> +CONFIG_RTC_TIMER=3Dn
> +CONFIG_USE_SMM=3Dn
> +CONFIG_PMTIMER=3Dn
> +CONFIG_TCGBIOS=3Dn
> +CONFIG_HARDWARE_IRQ=3Dn
> +CONFIG_ACPI_PARSE=3Dy
> --=20
> 2.27.0
>=20

--rg3d46m5axhcn2cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HxJQACgkQ9GknjS8M
AjVUMw//R4YOoUkulw6epKw3azYlDYv1CKbHs5yQIAHMtSaEorAoFuDUWJQ3DeMu
0ZVr7rdYL7G9yFEzmChmXmzmrqj4X90tQqvDonUV5XYplgeykhoft9ZmcoXjrWxg
JTUtAEknT2P5s49N31R6sTbs9ZlP0NoL17LqKl+6fndVK6LP6hKbAlkNdCMQ2SN1
KyYfM4E1gLoY6NpH9MnqZ56M34mhPXvpt+wO1GakHK92dkovesPeLI2qttSG1Uym
ywq4c9DLYfQlV1pad1xYpCaEbvAQ2K4W4P+KFgi9hGHv6f2IC+JXjWApUjMkpSsQ
2oBwUJyuVfwbFqde+UbWOWwwvotzQuM264mjwhuSTlqp6i0czlrERbquWu+l8xeA
iexHVWSxatwdIb1dU98fXXYBO7s1d/XxtZkdWVTJbh6TCVWuXkX+waR9FXKk5180
suTET6HjTMsUseAn74l5/n41i8C2bFudb41Na7ly51oh2ApglDPP+t1VbxTnUPnR
CkkYBHWbl8KjbHspWCJaAJsfOhey8K0uBiWI4+SO4muyP4A8Xhxow3OkBToDBJFn
LfsO6Ba1MwzU/ozmrh5EDQwPOcADBbezkEb4bfhmjtza5/bpwmzwzG7aX2koZdjC
mnF9y3owJpFu3mpIwi5BWxAnMI+9R0DlBmTDi1GOxk5SRKLangI=
=TLfL
-----END PGP SIGNATURE-----

--rg3d46m5axhcn2cp--


