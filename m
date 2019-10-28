Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F1CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC168214B2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 18:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmSlFiEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC168214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP9sP-0004Q6-5c
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 14:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iP8K8-00009j-KV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iP8K7-00057f-4G
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41479
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iP8K6-00057C-UQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572281814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+miw5Ha0sPs+u9Vssa8V1jZce/5D3Zi7uHB0dbugfhQ=;
 b=ZmSlFiEIU6vG+LbCnNHvz6W3h54OpbETWnv6nbGeWvIJ9cex2DFAxsLFCslSYOJHyQnRCp
 lHt3QkhBx8ijPQF+T24YWKDmgH4sTukGk6P/MPswdMSBXGJy+rPdy3tZ2eRlKhFmqe7Pss
 pIhRg56L+ztlYkn9OAJkmLQ4spC3yFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-R814HT63N5e-uCbHmExNQg-1; Mon, 28 Oct 2019 12:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8E45E4;
 Mon, 28 Oct 2019 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-183.rdu2.redhat.com
 [10.10.123.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38E3C3CCA;
 Mon, 28 Oct 2019 16:56:41 +0000 (UTC)
Date: Mon, 28 Oct 2019 12:56:39 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/26] tests/acceptance: Add test that runs NetBSD 4.0
 installer on PRep/40p
Message-ID: <20191028165639.GH3978@localhost.localdomain>
References: <20191028073441.6448-1-philmd@redhat.com>
 <20191028073441.6448-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191028073441.6448-14-philmd@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: R814HT63N5e-uCbHmExNQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 28, 2019 at 08:34:28AM +0100, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> As of this commit, NetBSD 4.0 is very old. However it is enough to
> test the PRep/40p machine.
>=20
> User case from:
> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>=20
> Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Installers after 4.0 doesn't work anymore, not sure if this is a
> problem from the QEMU model or from NetBSD.
>=20
> v3:
> - use avocado_qemu.wait_for_console_pattern (Cleber)
> - check getenv(AVOCADO_ALLOW_UNTRUSTED_CODE) (pm215)
> ---
>  MAINTAINERS                      |  1 +
>  tests/acceptance/ppc_prep_40p.py | 50 ++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17ff741c63..91746b87f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1068,6 +1068,7 @@ F: hw/rtc/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
>  F: include/hw/rtc/m48t59.h
>  F: pc-bios/ppc_rom.bin
> +F: tests/acceptance/machine_ppc_prep_40p.py

File name in patch is ppc_prep_40p.py.

> =20
>  sPAPR
>  M: David Gibson <david@gibson.dropbear.id.au>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep=
_40p.py
> new file mode 100644
> index 0000000000..7dd90bb2bb
> --- /dev/null
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -0,0 +1,50 @@
> +# Functional test that boots a PReP/40p machine and checks its serial co=
nsole.
> +#
> +# Copyright (c) Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import logging
> +

logging module is not used here.

> +from avocado import skipIf
> +from avocado import skipUnless
> +from avocado_qemu import MachineTest
> +from avocado_qemu import wait_for_console_pattern
> +
> +
> +class IbmPrep40pMachine(MachineTest):
> +
> +    timeout =3D 60
> +
> +    # 12H0455 PPS Firmware Licensed Materials
> +    # Property of IBM (C) Copyright IBM Corp. 1994.
> +    # All rights reserved.
> +    # U.S. Government Users Restricted Rights - Use, duplication or disc=
losure
> +    # restricted by GSA ADP Schedule Contract with IBM Corp.
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI')
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_factory_firmware_and_netbsd(self):
> +        """
> +        :avocado: tags=3Darch:ppc
> +        :avocado: tags=3Dmachine:40p
> +        :avocado: tags=3Dslowness:high
> +        """
> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +                    '7020-40p/P12H0456.IMG')
> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive=
/'
> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0.f=
s')
> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_ha=
sh)
> +
> +        self.vm.set_machine('40p')
> +        self.vm.set_console()
> +        self.vm.add_args('-bios', bios_path,
> +                         '-fda', drive_path)
> +        self.vm.launch()
> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST =
2007'
> +        wait_for_console_pattern(self, os_banner)
> +        wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
> --=20
> 2.21.0
>

With the import and name changes above:

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

Queuing on my python-next branch (and sending shortly in a PR).

Thanks,
- Cleber.


