Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06133C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98D622B47
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCZwXCPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98D622B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDFJ-0007yD-11
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBDEM-0007XR-PA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:25:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58953
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1kBDEL-0004fa-9H
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598516756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ebWfJswIZKotNnZgY8inNGIuWi9/+2r8ZSZoxlfzwCE=;
 b=gCZwXCPPqQmZbmpEv7+7Zo7igqcKSN6uJEiwdemQMGewLZ3+8wcuoV9CXkqHTtxSZb4s9w
 FAPTM9WngBOE+2z8vM+NLSvwma/fTgYsH/og9muj9TNDLWWUdA2Q/j3Pv5a5vE1adcORj/
 VImuyw0ozNa3mySdgvkYvdBl1F7mUW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-PLR7xmtjOsW_PzH03pZyow-1; Thu, 27 Aug 2020 04:25:51 -0400
X-MC-Unique: PLR7xmtjOsW_PzH03pZyow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC045185FD97;
 Thu, 27 Aug 2020 08:25:49 +0000 (UTC)
Received: from localhost (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D142F7A40C;
 Thu, 27 Aug 2020 08:25:42 +0000 (UTC)
Date: Thu, 27 Aug 2020 10:25:38 +0200
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v6 01/20] microvm: name qboot binary qboot.rom
Message-ID: <20200827082538.tabz2zazyknnllrk@mhamilton>
References: <20200826105254.28496-1-kraxel@redhat.com>
 <20200826105254.28496-2-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826105254.28496-2-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=slp@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7dgw27ilqxnjy6fp"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:42:41
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

--7dgw27ilqxnjy6fp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:52:35PM +0200, Gerd Hoffmann wrote:
> qboot isn't a bios and shouldnt be named that way.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/microvm.c                       |   4 ++--
>  pc-bios/{bios-microvm.bin =3D> qboot.rom} | Bin
>  roms/Makefile                           |   6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename pc-bios/{bios-microvm.bin =3D> qboot.rom} (100%)

Reviewed-by: Sergio Lopez <slp@redhat.com>

> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 81d0888930d1..b1dc7e49c159 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -47,7 +47,7 @@
>  #include "kvm_i386.h"
>  #include "hw/xen/start_info.h"
> =20
> -#define MICROVM_BIOS_FILENAME "bios-microvm.bin"
> +#define MICROVM_QBOOT_FILENAME "qboot.rom"
> =20
>  static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
>  {
> @@ -158,7 +158,7 @@ static void microvm_devices_init(MicrovmMachineState =
*mms)
>      }
> =20
>      if (bios_name =3D=3D NULL) {
> -        bios_name =3D MICROVM_BIOS_FILENAME;
> +        bios_name =3D MICROVM_QBOOT_FILENAME;
>      }
>      x86_bios_rom_init(get_system_memory(), true);
>  }
> diff --git a/pc-bios/bios-microvm.bin b/pc-bios/qboot.rom
> similarity index 100%
> rename from pc-bios/bios-microvm.bin
> rename to pc-bios/qboot.rom
> diff --git a/roms/Makefile b/roms/Makefile
> index 5d9f15b6777f..2673a39f9dc2 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -66,7 +66,7 @@ default help:
>  =09@echo "  efi                -- update UEFI (edk2) platform firmware"
>  =09@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic mach=
ine"
>  =09@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic mach=
ine"
> -=09@echo "  bios-microvm       -- update bios-microvm.bin (qboot)"
> +=09@echo "  qboot              -- update qboot"
>  =09@echo "  clean              -- delete the files generated by the prev=
ious" \
>  =09                              "build targets"
> =20
> @@ -182,9 +182,9 @@ opensbi64-generic:
>  =09cp opensbi/build/platform/generic/firmware/fw_dynamic.bin ../pc-bios/=
opensbi-riscv64-generic-fw_dynamic.bin
>  =09cp opensbi/build/platform/generic/firmware/fw_dynamic.elf ../pc-bios/=
opensbi-riscv64-generic-fw_dynamic.elf
> =20
> -bios-microvm:
> +qboot:
>  =09$(MAKE) -C qboot
> -=09cp qboot/bios.bin ../pc-bios/bios-microvm.bin
> +=09cp qboot/bios.bin ../pc-bios/qboot.rom
> =20
>  clean:
>  =09rm -rf seabios/.config seabios/out seabios/builds
> --=20
> 2.27.0
>=20

--7dgw27ilqxnjy6fp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl9HbgEACgkQ9GknjS8M
AjUIHhAAmc77boSSZdJuk5WQXX+bhDDpCZ6QlrDu2cp06OD0CYr5MbbvDxxMXn8e
xbDv++NzpCHZczBMrPnWVq0zbTD72ygZp6NeurktT3udqK1eTfngdyvRd7GuG03k
45rVohlL1BHT+oJWg4FzBQfYjLE/U2SUR/egP530KWs3UgQAvCI+TrbkZ4alG1xW
CHVH8MiqFHsl9bzRklpJcNAbJ4WBt6tNaHmJvU7QqclSzG00bHEIRUUDf+zLYpLf
zID29JDmmkg2Ax0XOYPt4xzi9vJFEzWHsAOBkF+pfG0Hed5w7d/CSZ+ftnJdzF0n
hcnOdTdKgsuDFLGLfiTjLPgDaWcwE9hpkVDS+uQMHWBiUFrOp8AJqknnwrISgghV
ccJU/2lVbPbHQhs3Zu300TV2KiplsZLdc62hVcFU/e89TmvSdpWxz26Tqie3Uu+K
OYSLpnuTAx5oH2wCeRwTL5ZrlpnMWA7aO4Tues4JTRayKL/uBZuNw/wEDCNGB8IY
qxBMu86yc0Y4Ikgzu03D8LxS3muVv/rvXcuqTkWWroLwYDKolXUvEPmfeBnIzF7X
X3kZ2EFr225tl79TYr8pjl4MK/GimU41cw3+EtMTOj1pBJjf++1fyYSp6rBRT86S
JG79/CV13VSSDYz3bCWMsA/GctewGA+szcpjaoVLoz/5mwU2pvk=
=Rdrh
-----END PGP SIGNATURE-----

--7dgw27ilqxnjy6fp--


