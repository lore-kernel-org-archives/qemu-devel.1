Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760BAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1F3206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e91ZPsHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1F3206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw6uQ-0003I6-EI
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 11:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw6tp-0002fi-HM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:06:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw6to-0001ua-Dx
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:06:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29686
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw6to-0001uQ-Ab
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 11:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580141164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=zIY6K1MaE0r4zDufInqIXB8XjuRww+MPQ9sST5zR4ss=;
 b=e91ZPsHMXYMKgqg3YwSKvq1R1a+gv/F9upJRMTtpgXaavFEv1r8gXLb1262JeBVjcYjrN1
 b+b87rscvwgqHrhUE4Q+F6t/FQamo48Z5Bxqoedur9rCwCyQVW2jNlsicfkZqKTsvmqOyb
 EXh623SLwrJ1/5AKo4ALC3lcHR0TmeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-zf7F07bBMEKzehgEODRaVw-1; Mon, 27 Jan 2020 11:05:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA7C78024F5;
 Mon, 27 Jan 2020 16:05:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED9E55D9CA;
 Mon, 27 Jan 2020 16:05:40 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] tests/boot_linux_console: Tag Emcraft Smartfusion2
 as running 'u-boot'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-8-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <addb50ef-b6cd-fec1-2266-f062cae65090@redhat.com>
Date: Mon, 27 Jan 2020 17:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-8-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zf7F07bBMEKzehgEODRaVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 00.51, Philippe Mathieu-Daud=C3=A9 wrote:
> Avocado tags are handy to automatically select tests matching
> the tags. Since this test also runs U-Boot, tag it.
>=20
> We can run all the tests using U-Boot as once with:
>=20
>   $ avocado --show=3Dapp run -t u-boot tests/acceptance/
>   JOB LOG    : avocado/job-results/job-2020-01-21T00.16-ee9344e/job.log
>    (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_emcraft_sf2: PASS (16.59 s)
>    (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm=
_raspi2_uboot: PASS (0.47 s)
>    (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aar=
ch64_raspi3_uboot: PASS (2.43 s)
>   RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>   JOB TIME   : 19.78 s
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 22b360118d..4a4cf9d0ea 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -305,6 +305,7 @@ class BootLinuxConsole(Test):
>          :avocado: tags=3Darch:arm
>          :avocado: tags=3Dmachine:emcraft-sf2
>          :avocado: tags=3Dendian:little
> +        :avocado: tags=3Du-boot
>          """
>          uboot_url =3D ('https://raw.githubusercontent.com/'
>                       'Subbaraya-Sundeep/qemu-test-binaries/'
>=20

We should maybe move that test to another file, too, since it is not
using Linux. Or should we maybe rename boot_linux_console.py to simply
boot_console.py ?

 Thomas


