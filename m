Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC3C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFB1C2084B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB1C2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTWt-0006FC-PA
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frederic.konrad@adacore.com>) id 1hgTVn-0005ZE-Eu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1hgTVm-0008GA-DK
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:28:23 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:55315
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1hgTVj-0008At-W7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:28:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 5195B8139A;
 Thu, 27 Jun 2019 14:28:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bclz8uHiOq4B; Thu, 27 Jun 2019 14:28:15 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-447-75.w86-206.abo.wanadoo.fr
 [86.206.4.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 9B0A581397;
 Thu, 27 Jun 2019 14:28:14 +0200 (CEST)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190627115331.2373-1-f4bug@amsat.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <f27e2a5c-07dd-b118-7a85-c46587ffaf99@adacore.com>
Date: Thu, 27 Jun 2019 14:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627115331.2373-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH 0/3] tests/acceptance: Add tests for the
 Leon3 board
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

Thanks for that!

I'm not aware at all of the tests/acceptance/* stuff.. How can we launch =
those
tests?

Appart of that it looks good to me :).

Regards,
Fred

Le 6/27/19 =C3=A0 1:53 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> Quick tests worth to avoid regressions, idea from
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
> "Maintainers, please tell us how to boot your machines"
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (3):
>    tests/acceptance: Add test that boots the HelenOS microkernel on Leo=
n3
>    tests/acceptance: Add test that boots Linux up to BusyBox on Leon3
>    .travis.yml: Let the avocado job run the Leon3 test
>=20
>   .travis.yml                             |  2 +-
>   MAINTAINERS                             |  1 +
>   tests/acceptance/machine_sparc_leon3.py | 89 ++++++++++++++++++++++++=
+
>   3 files changed, 91 insertions(+), 1 deletion(-)
>   create mode 100644 tests/acceptance/machine_sparc_leon3.py
>=20

