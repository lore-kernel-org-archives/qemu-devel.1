Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BBDC33CAA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803D821734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 06:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SX0Abfje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803D821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itmlX-0005sz-Lb
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 01:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1itmku-0005SO-Cm
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1itmkp-0000Ig-Ol
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:11:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1itmkp-0000I2-Lf
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 01:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579587070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=DAjNUlNjeh/pl2ye5N2zX/+RcFrkk0pUjjQqMIGsR1k=;
 b=SX0AbfjetPiPqtDvoFv5CkCZz/fhv8buottTLAQiV2aoN19E8qZ+9CD0niRbqncGUt3yTS
 bvuY5gz7de9/6DiJMvqfeznjF6mcZBJu3pSadnZTbTfznHYIK8qS5UCn1qbETga1uampxU
 hRbBRdMieJ2o/zFoNtkDH4HnQOURQik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-5z_YgquXO8KmohbFXzLDFA-1; Tue, 21 Jan 2020 01:11:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A05800D54;
 Tue, 21 Jan 2020 06:11:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55CE15C21B;
 Tue, 21 Jan 2020 06:11:05 +0000 (UTC)
Subject: Re: [PATCH v4 15/18] tests/boot-serial-test: Test some Arduino boards
 (AVR based)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120220107.17825-1-f4bug@amsat.org>
 <20200120220107.17825-16-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ceb1dc3c-b45c-eb10-923b-407070b780dc@redhat.com>
Date: Tue, 21 Jan 2020 07:11:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200120220107.17825-16-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 5z_YgquXO8KmohbFXzLDFA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/01/2020 23.01, Philippe Mathieu-Daud=C3=A9 wrote:
> The Arduino Duemilanove is based on a AVR5 CPU, while the
> Arduino MEGA2560 on a AVR6 CPU.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/qtest/boot-serial-test.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
> index e556f09db8..582a497963 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -113,6 +113,8 @@ typedef struct testdef {
>  static testdef_t tests[] =3D {
>      { "alpha", "clipper", "", "PCI:" },
>      { "avr", "sample", "", "T", sizeof(bios_avr), NULL, bios_avr },
> +    { "avr", "arduino-duemilanove", "", "T", sizeof(bios_avr), NULL, bio=
s_avr },
> +    { "avr", "arduino-mega-2560-v3", "", "T", sizeof(bios_avr), NULL, bi=
os_avr},
>      { "ppc", "ppce500", "", "U-Boot" },
>      { "ppc", "40p", "-vga none -boot d", "Trying cd:," },
>      { "ppc", "g3beige", "", "PowerPC,750" },
>=20

Acked-by: Thomas Huth <thuth@redhat.com>


