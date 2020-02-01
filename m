Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02DDC33C9E
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 07:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9982220679
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 07:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGSmC74J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9982220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixmsK-0002FT-P9
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 02:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixmrX-0001en-ES
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixmrV-00066t-HB
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:06:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixmrV-00061T-6i
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 02:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580540796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UmDwR1M7st9PUiUhos3zTLy2AE+KwzAALevD8KFIGVM=;
 b=GGSmC74JeZYPP6ojTd72JXnTaVIqx7g5afcTXR7f9lNfzVOvLj7Mrobyq1DHVLzkTJgIdj
 eri81wI9OQmTpLkv9K3EEOquCBg1vMfgqZDY116soVEt+O4w91c5XbUG24K9I8cAJ8a83T
 TZfFL5cmvI+s11+lC3OTBui2KuIySe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-nvb3iEQMO-Kvt8WfbMybrw-1; Sat, 01 Feb 2020 02:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7132F8017DF;
 Sat,  1 Feb 2020 07:06:27 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-33.ams2.redhat.com [10.36.116.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09D0A89E7E;
 Sat,  1 Feb 2020 07:06:17 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests/acceptance: Extract boot_integratorcp() from
 test_integratorcp()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200131211102.29612-1-f4bug@amsat.org>
 <20200131211102.29612-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c13e2bf5-2373-f33e-1aea-824c46b9f3cf@redhat.com>
Date: Sat, 1 Feb 2020 08:06:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200131211102.29612-2-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: nvb3iEQMO-Kvt8WfbMybrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/2020 22.11, Philippe Mathieu-Daud=C3=A9 wrote:
> As we want to re-use this code, extract it as a new function.
> Since we are using the PL011 serial console, add a Avocado tag
> to ease filtering of tests.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/machine_arm_integratorcp.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/accepta=
nce/machine_arm_integratorcp.py
> index 4f9ab40f2f..748819916d 100644
> --- a/tests/acceptance/machine_arm_integratorcp.py
> +++ b/tests/acceptance/machine_arm_integratorcp.py
> @@ -19,12 +19,7 @@ class IntegratorMachine(Test):
> =20
>      timeout =3D 90
> =20
> -    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> -    def test_integratorcp(self):
> -        """
> -        :avocado: tags=3Darch:arm
> -        :avocado: tags=3Dmachine:integratorcp
> -        """
> +    def boot_integratorcp(self):
>          kernel_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
>                        'arm-test/kernel/zImage.integrator')
>          kernel_hash =3D '0d7adba893c503267c946a3cbdc63b4b54f25468'
> @@ -40,4 +35,13 @@ class IntegratorMachine(Test):
>                           '-initrd', initrd_path,
>                           '-append', 'printk.time=3D0 console=3DttyAMA0')

I wonder whether you might want to move the "console=3DttyAMA0" to the
test_integratorcp(), too, to get the text in the framebuffer in the
second test instead?

>          self.vm.launch()
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted co=
de')
> +    def test_integratorcp(self):
> +        """
> +        :avocado: tags=3Darch:arm
> +        :avocado: tags=3Dmachine:integratorcp
> +        :avocado: tags=3Ddevice:pl011
> +        """
> +        self.boot_integratorcp()
>          wait_for_console_pattern(self, 'Log in as root')
>=20

Anyway, patch looks fine,

Reviewed-by: Thomas Huth <thuth@redhat.com>


