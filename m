Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA73C2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3801E20409
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 17:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do0dUqbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3801E20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilyzU-0008Ek-DM
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 12:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ilyyt-0007p6-Ka
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ilyyq-0001Sz-Fl
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:37:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36967
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ilyyq-0001SZ-5S
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 12:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577727443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81Oe6wO0BAHSphMFxlNAP4mShlz60cbI1WwgCdRmBdQ=;
 b=Do0dUqbiHZkSuH7ge2GqZBJUEJvfju7dUzhPgd6+Yi5nRpGeJmryPNMaALL2yupY7VhlAA
 NFcXoBn+z2ul+9t49RzfVYKh8YTjkHGktNvj5+Ei1hCA7yj4HENvjEm3vjPchj+Amjzm9v
 hUtgm5H1OAYvFFfYqPUkwjUloDykKSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-PovBKKErOqyFdoH6IcQbRQ-1; Mon, 30 Dec 2019 12:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C5E800D41;
 Mon, 30 Dec 2019 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 747F460BE1;
 Mon, 30 Dec 2019 17:37:10 +0000 (UTC)
Subject: Re: [PATCH v40 20/21] target/avr: Add Avocado test
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191229215158.5788-1-mrolnik@gmail.com>
 <20191229215158.5788-21-mrolnik@gmail.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ce09e537-9d44-7d99-9ce2-23145f8270a7@redhat.com>
Date: Mon, 30 Dec 2019 15:37:08 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191229215158.5788-21-mrolnik@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PovBKKErOqyFdoH6IcQbRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: thuth@redhat.com, me@xcancerberox.com.ar, richard.henderson@linaro.org,
 dovgaluk@ispras.ru, imammedo@redhat.com, philmd@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 12/29/19 7:51 PM, Michael Rolnik wrote:
> The test is based on
> https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos/Demo
> demo which. If working correctly, prints 'ABCDEFGHIJKLMNOPQRSTUVWX' out.
> it also demostrates that timer and IRQ are working
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/acceptance/machine_avr6.py | 58 ++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
>   create mode 100644 tests/acceptance/machine_avr6.py
>
> diff --git a/tests/acceptance/machine_avr6.py b/tests/acceptance/machine_=
avr6.py
> new file mode 100644
> index 0000000000..7a7d8afc29
> --- /dev/null
> +++ b/tests/acceptance/machine_avr6.py
> @@ -0,0 +1,58 @@
> +#
> +# QEMU AVR
> +#
> +# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
> +#
> +# This program is free software: you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation, either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import logging
> +import time
> +import distutils.spawn
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado.utils import process

Please remove unused imports: logging, distutils.spawn, skipUnless and=20
process.

> +
> +class AVR6Machine(Test):

It helps others reading this if you document the test purpose here.=20
Besides it makes the pylinter happier. ;)

> +    timeout =3D 5
> +
> +    def test_freertos(self):
> +        """
> +        :avocado: tags=3Darch:avr
> +        :avocado: tags=3Dmachine:sample
> +        """
> +        """
> +        https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/=
Demo/AVR_ATMega2560_GCC/demo.elf
> +        constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQ=
RSTUVWX'
> +        """
> +        rom_url =3D 'https://github.com/seharris/qemu-avr-tests'
> +        rom_sha1=3D '36c3e67b8755dcf37e06af6730ef5d477b8ed16d'
> +        rom_url +=3D '/raw/'
> +        rom_url +=3D rom_sha1
> +        rom_url +=3D '/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf'
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

Do you really need to shutdown the VM here? Because it will be shut down=20
later on avocado_qemu.Test.tearDown() anyway.

> +
> +        match =3D 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
> +
> +        self.assertIn(match, self.vm.get_log())

It is a matter of taste, but I would simply do:

self.assertIn('ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX',

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.get_log())

Thanks for writing this acceptance test!

- Wainer


