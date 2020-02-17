Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A74C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE9D620725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9D620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ezQ-0003IA-Tp
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1j3evh-0006Ln-Nm
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1j3evd-0006p4-P5
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:51:13 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:56379
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1j3evd-0006lT-Hr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:51:09 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 7B8F58138C;
 Mon, 17 Feb 2020 12:51:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x2GP1_zed2AE; Mon, 17 Feb 2020 12:51:05 +0100 (CET)
Received: from [10.10.126.96] (wifi-guest-96.act-europe.fr [10.10.126.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 6131881387;
 Mon, 17 Feb 2020 12:51:05 +0100 (CET)
Subject: Re: [PATCH v2] tests/acceptance/machine_sparc_leon3: Do not run
 HelenOS test by default
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200212203627.16592-1-philmd@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <a5b75aae-34cb-2e38-57d1-5fb1613d4aa0@adacore.com>
Date: Mon, 17 Feb 2020 12:51:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200212203627.16592-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 2/12/20 =C3=A0 9:36 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> The www.helenos.org server is slow and downloading the Leon3 binary
> takes too long [*]. Do not include this test in the default suite.
>=20
> Similarly to commit 471c97a69b:
>=20
>    Currently the Avocado framework does not distinct the time spent
>    downloading assets vs. the time spent running a test. With big
>    assets (like a full VM image) the tests likely fail.
>=20
>    This is a limitation known by the Avocado team.
>    Until this issue get fixed, do not run this tests automatically.
>=20
>    Tests can still be run setting the AVOCADO_TIMEOUT_EXPECTED
>    environment variable.
>=20
> [*] https://travis-ci.org/stsquad/qemu/jobs/649599880#L4198
>=20
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add missing staged hunk...
> ---
>   tests/acceptance/machine_sparc_leon3.py | 4 ++++
>   1 file changed, 4 insertions(+)
>=20
> diff --git a/tests/acceptance/machine_sparc_leon3.py b/tests/acceptance=
/machine_sparc_leon3.py
> index f77e210ccb..27e4717a51 100644
> --- a/tests/acceptance/machine_sparc_leon3.py
> +++ b/tests/acceptance/machine_sparc_leon3.py
> @@ -5,6 +5,9 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later. See the COPYING file in the top-level directory.
>  =20
> +import os
> +
> +from avocado import skipUnless
>   from avocado_qemu import Test
>   from avocado_qemu import wait_for_console_pattern
>  =20
> @@ -13,6 +16,7 @@ class Leon3Machine(Test):
>  =20
>       timeout =3D 60
>  =20
> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might tim=
eout')
>       def test_leon3_helenos_uimage(self):
>           """
>           :avocado: tags=3Darch:sparc
>=20

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks Philippe!

