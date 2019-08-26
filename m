Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37094C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 05:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6322190F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 05:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6322190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i27k5-0002Hg-3s
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 01:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i27j7-0001p2-C7
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 01:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i27j4-0000nJ-Sf
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 01:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i27j4-0000mr-La
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 01:39:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A839418C426C;
 Mon, 26 Aug 2019 05:39:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-115.ams2.redhat.com [10.36.116.115])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF3E5D6A5;
 Mon, 26 Aug 2019 05:39:28 +0000 (UTC)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <a324bbce-814d-d363-7baa-db50f565618d@redhat.com>
Date: Mon, 26 Aug 2019 07:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824184635.34192-9-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 26 Aug 2019 05:39:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
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
Cc: philmd@redhat.com, imammedo@redhat.com, richard.henderson@linaro.org,
 dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/08/2019 20.46, Michael Rolnik wrote:
> 1. Avocado test
>     The test is based on
>     https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/De=
mo
>     demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX'=
 out.
>     it also demostrates that timer and IRQ are working
>=20
> 2. Boot serial test
>     Prinit out 'T' through serial port
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/Makefile.include           |  2 ++
>  tests/acceptance/machine_avr6.py | 36 ++++++++++++++++++++++++++++++++
>  tests/boot-serial-test.c         | 10 +++++++++
>  3 files changed, 48 insertions(+)
>  create mode 100644 tests/acceptance/machine_avr6.py
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 49684fd4f4..dbaeb87572 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -202,6 +202,8 @@ check-qtest-i386-y +=3D tests/test-x86-cpuid-compat=
$(EXESUF)
>  check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
> =20
> +check-qtest-avr-y +=3D tests/boot-serial-test$(EXESUF)
> +
>  check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
>  check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> =20
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machin=
e_avr6.py
> new file mode 100644
> index 0000000000..0601080b01
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,36 @@
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process
> +
> +class AVR6Machine(Test):
> +    timeout =3D 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=3Darch:avr
> +        :avocado: tags=3Dmachine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/free-rto=
s/Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNO=
PQRSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_url +=3D '/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/de=
mo.elf'
> +        rom_hash =3D '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
> +        rom_path =3D self.fetch_asset(rom_url, asset_hash=3Drom_hash)
> +
> +        self.vm.set_machine('sample')
> +        self.vm.add_args('-bios', rom_path)
> +        self.vm.add_args('-nographic')
> +        self.vm.launch()
> +
> +        time.sleep(2)
> +        self.vm.shutdown()
> +
> +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 24852d4c7d..22cbaccc1b 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -16,6 +16,15 @@
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> =20
> +static const uint8_t bios_avr[] =3D {
> +    0x88, 0xe0,             /* ldi r24, 0x08   */
> +    0x80, 0x93, 0xc1, 0x00, /* sts 0x00C1, r24 ; Enable tx */
> +    0x86, 0xe0,             /* ldi r24, 0x06   */
> +    0x80, 0x93, 0xc2, 0x00, /* sts 0x00C2, r24 ; Set the data bits to =
8 */
> +    0x84, 0xe5,             /* ldi r24, 0x54   */
> +    0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
> +};
> +
>  static const uint8_t kernel_mcf5208[] =3D {
>      0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>      0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
> @@ -92,6 +101,7 @@ typedef struct testdef {
> =20
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
> +    { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>=20

Acked-by: Thomas Huth <thuth@redhat.com>

