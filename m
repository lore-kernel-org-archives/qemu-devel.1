Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68702C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3410824673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFMya8/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3410824673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUeA-00049N-Do
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:03:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUdT-0003hT-CX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUdR-0008LF-LP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:02:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUdR-0008Kw-GQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579755748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UpffHva8U/zKslINJ40GhF8THZXQlZFsm17RikAzSPs=;
 b=XFMya8/8DyHzy1B0weXDVnLI/IW0gWn77ZJwaQrCi9AlyW4rLxfN/udKZ8l3YAmoCSfbhL
 Y1hLrOB8+tvNXx/juRsbQ5OFyskshrzjJtesLR1kQZdnI/QR2OQoIU9ynQnWZo3IB1qOZX
 nHAHULzny7AUfTQiVCV+CpZY5wKSkDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-0kRU-VoPP9OHwvZPx68qFg-1; Thu, 23 Jan 2020 00:02:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E71477;
 Thu, 23 Jan 2020 05:02:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBDB781C0A;
 Thu, 23 Jan 2020 05:02:19 +0000 (UTC)
Subject: Re: [PATCH rc1 16/24] target/avr: Add machine none test
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-17-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eec49811-21a0-82b3-49c3-c47a77a487f0@redhat.com>
Date: Thu, 23 Jan 2020 06:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123000307.11541-17-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0kRU-VoPP9OHwvZPx68qFg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: S.E.Harris@kent.ac.uk, me@xcancerberox.com.ar, dovgaluk@ispras.ru,
 Aleksandar Markovic <amarkovic@wavecomp.com>, imammedo@redhat.com,
 mrolnik@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.02, Richard Henderson wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-Id: <20200118191416.19934-18-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/qtest/machine-none-test.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-t=
est.c
> index 5953d31755..3e5c74e73e 100644
> --- a/tests/qtest/machine-none-test.c
> +++ b/tests/qtest/machine-none-test.c
> @@ -27,6 +27,7 @@ static struct arch2cpu cpus_map[] =3D {
>      /* tested targets list */
>      { "arm", "cortex-a15" },
>      { "aarch64", "cortex-a57" },
> +    { "avr", "avr6-avr-cpu" },
>      { "x86_64", "qemu64,apic-id=3D0" },
>      { "i386", "qemu32,apic-id=3D0" },
>      { "alpha", "ev67" },
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


