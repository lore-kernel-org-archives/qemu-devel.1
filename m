Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824F3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A7C20678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tk8-0003tX-OR
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i9tYY-00027b-Ud
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i9tYV-0002B4-QR
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:08:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56444)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1i9tYV-0001yn-FI; Mon, 16 Sep 2019 12:08:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EF354307D965;
 Mon, 16 Sep 2019 16:08:44 +0000 (UTC)
Received: from dhcp-17-173.bos.redhat.com (dhcp-17-173.bos.redhat.com
 [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0B8A5C1D6;
 Mon, 16 Sep 2019 16:08:40 +0000 (UTC)
Date: Mon, 16 Sep 2019 12:08:39 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190916160839.GA2724@dhcp-17-173.bos.redhat.com>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190915211940.30427-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190915211940.30427-2-f4bug@amsat.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 16 Sep 2019 16:08:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/6] tests/acceptance: Add test that
 runs NetBSD 4.0 installer on PRep/40p
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
 Thomas Huth <huth@tuxfamily.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 15, 2019 at 11:19:35PM +0200, Philippe Mathieu-Daud=E9 wrote:
> As of this commit, NetBSD 4.0 is very old. However it is enough to
> test the PRep/40p machine.
>=20
> User case from:
> http://mail-index.netbsd.org/port-prep/2017/04/11/msg000112.html
>=20
> Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
> Installers after 4.0 doesn't work anymore, not sure if this is a
> problem from the QEMU model or from NetBSD.
> ---
>  MAINTAINERS                      |  1 +
>  tests/acceptance/ppc_prep_40p.py | 63 ++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50eaf005f4..ce809c7dee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1068,6 +1068,7 @@ F: hw/timer/m48t59-isa.c
>  F: include/hw/isa/pc87312.h
>  F: include/hw/timer/m48t59.h
>  F: pc-bios/ppc_rom.bin
> +F: tests/acceptance/machine_ppc_prep_40p.py
> =20
>  sPAPR
>  M: David Gibson <david@gibson.dropbear.id.au>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_pr=
ep_40p.py
> new file mode 100644
> index 0000000000..53f2d2ecf0
> --- /dev/null
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -0,0 +1,63 @@
> +# Functional test that boots a PReP/40p machine and checks its serial =
console.
> +#
> +# Copyright (c) Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +import logging
> +
> +from avocado import skipIf
> +from avocado_qemu import Test
> +
> +
> +class IbmPrep40pMachine(Test):
> +
> +    timeout =3D 60
> +
> +    # TODO refactor to MachineTest

Your TODO is a clear sign of awareness of the duplicated code that
follows.  The mention of a MachineTest points into the direction that
I can see as the best final solution (that is, test classes that target
specific test scenarions).

But, it may be a more effective refactor strategy, to simply turn the
`wait_for_console_pattern` from a method into a utility function, and
then the discussion of the common test classes (say MachineTest,
GuestTest, MigrationTest) can follow later.

> +    def wait_for_console_pattern(self, success_message, failure_messag=
e=3DNone):

Following the previous suggestion, `self` would become something like `te=
st`.

> +        """
> +        Waits for messages to appear on the console, while logging the=
 content
> +

Documented as something like:

  :param test: an Avocado test containing a VM that will have its console
               read and probed for a success or failure message
  :type test: :class:`avocado_qemu.Test`

> +        :param success_message: if this message appears, test succeeds
> +        :param failure_message: if this message appears, test fails
> +        """
> +        console =3D self.vm.console_socket.makefile()
> +        console_logger =3D logging.getLogger('console')
> +        while True:
> +            msg =3D console.readline().strip()
> +            if not msg:
> +                continue
> +            console_logger.debug(msg)
> +            if success_message in msg:
> +                break
> +            if failure_message and failure_message in msg:
> +                fail =3D 'Failure message found in console: %s' % fail=
ure_message
> +                self.fail(fail)
> +
> +    @skipIf(os.getenv('CONTINUOUS_INTEGRATION'), 'Running on Travis-CI=
')
> +    def test_factory_firmware_and_netbsd(self):
> +        """
> +        :avocado: tags=3Darch:ppc
> +        :avocado: tags=3Dmachine:40p
> +        :avocado: tags=3Dslowness:high

This is certainly a discussion in itself, but I wonder what is your
criteria for definising the slowness level of a test.  FOY, this one
takes me ~17 seconds on my local machine.

> +        """
> +        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +                    '7020-40p/P12H0456.IMG')
> +        bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
> +        bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_has=
h)
> +        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archi=
ve/'
> +                     'NetBSD-4.0/prep/installation/floppy/generic_com0=
.fs')
> +        drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
> +        drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_=
hash)
> +
> +        self.vm.set_machine('40p')

FIY, Avocado 72.0 (due Tomorrow) will have relaxed strictness for tags
values.  That will allow us to represent all current machine type
names in ":avocado: tags=3Dmachine:$VALUE" (such as "s390-ccw-virtio").
Then we'll be able to reuse them here, avoiding a bit of boiler plate
code.

> +        self.vm.set_console()
> +        self.vm.add_args('-bios', bios_path,
> +                         '-fda', drive_path)
> +        self.vm.launch()
> +        os_banner =3D 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PS=
T 2007'
> +        self.wait_for_console_pattern(os_banner)
> +        self.wait_for_console_pattern('Model: IBM PPS Model 6015')
> --=20
> 2.20.1
>=20

Overall it looks good and works for me.  Let me know what you think of
the wait_for_console_pattern() refactor suggestions.

- Cleber.

