Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA13CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9434722B4E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 14:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btuOfrm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9434722B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJIy-0003CB-QU
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJIJ-0002Fr-3D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:54:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBJIG-0008El-QS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 10:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hulzSRTtOv3ETP7tY5V3fQYPmAn/sJswJpFi9qH5rxQ=;
 b=btuOfrm+eUHqMYfwFTBEkVAOnCq3eq8Mb4cBwCZeAr1hUsH+83wlHVicYSVF11wt91O3RB
 YYgK6TBhtAmcqG/n3hHVD/ZepTfIOiGd+oMFvxsxI0HG5/KcAfJ7s9rva8vRcp0ZihaXeE
 6D3L4Tp16eP8m0bPOXKLL+jwxau0BdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-XbcKLPfBOAexr7oEbpJkxQ-1; Thu, 27 Aug 2020 10:54:19 -0400
X-MC-Unique: XbcKLPfBOAexr7oEbpJkxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46D8C18BA282;
 Thu, 27 Aug 2020 14:54:18 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F41785D9F1;
 Thu, 27 Aug 2020 14:54:12 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:54:11 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 11/20] microvm/acpi: use seabios with acpi=on
Message-ID: <20200827145411.uptnlveyo4v7lekj@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-12-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-12-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="53pjgifjc2w2eu3r"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--53pjgifjc2w2eu3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:45PM +0200, Gerd Hoffmann wrote:
> With acpi=3Doff continue to use qboot.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/microvm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>


> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index ca0c9983f137..54510a03f754 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -52,6 +52,7 @@
>  #include "hw/xen/start_info.h"
> =20
>  #define MICROVM_QBOOT_FILENAME "qboot.rom"
> +#define MICROVM_BIOS_FILENAME  "bios-microvm.bin"
> =20
>  static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
>  {
> @@ -174,7 +175,9 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
>      }
> =20
>      if (bios_name =3D=3D NULL) {
> -        bios_name =3D MICROVM_QBOOT_FILENAME;
> +        bios_name =3D x86_machine_is_acpi_enabled(x86ms)
> +            ? MICROVM_BIOS_FILENAME
> +            : MICROVM_QBOOT_FILENAME;
>      }
>      x86_bios_rom_init(get_system_memory(), true);
>  }
> --=20
> 2.27.0
>=20

--53pjgifjc2w2eu3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HyRIACgkQ9GknjS8M
AjX1KxAAnOEoeB0aqyCUoyzjz3ZigyRQ5fzH9cRBhqYIKyt9yEOwP5+BHp2pjYVh
X/CyJusfnnPD0pyRhAVu0QlEYl9EIEPf2aO2RAchaxDFpSGMSNcziP6ViG9k2ipr
l8D2CVyFW0spbcJL3fDXPSkEEo9W+vFlsmB68WM1FoTF/MMnaRmFEr+aQnFI16SI
tqAax8WwC/FIlotlvprL8iaViHH+ziWnDdzP0rSHsBHd5TbAvbUS6f5Y4yi0wEBy
aZYEE6xm037/k65F1s+agKq4RHpJ80ARuZA0z5wTXpL9/y8P1SM06bDwleSIWzoF
IUJw8reFujMW0mF4PiH8QlrV4Pp9sokG1AZFfO9Jhnp2o8xXphLRBAAcMqogZN+l
BUQzTdsZPXW8vpdgB8x8n5YRKc/5aAPj1qNZy6gha1Azq66SNodQjk0PaQ58OkKY
kUQ03SlUx7OoCOOr8Wy/0RZf+4TR1qEiyzHnYTSLqktnH3R4BysXV2cb9cLZpE7S
x8knBEpcDCCC5u6Ig1H/6Uw2HANbrV0kbJZ93N+IY/mmAnkhJo4fe+KAaO1Zaeci
Nt+7jHiFqPQoZOmA1G6ADf2rweWb8hY1BlMs0618X2Yp586Ji8GpianEjfuhdaAG
wXt/oXRAAJEhyWRyA30PpgOz/KACxw3RgugtZOuZ/qoYoNw5uP4=
=PI1W
-----END PGP SIGNATURE-----

--53pjgifjc2w2eu3r--


