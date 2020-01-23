Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89CC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FFD524673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlQUmEPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFD524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUgR-00058s-Pj
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUfo-0004ig-3o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUfn-0001Th-5L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:04:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43511
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUfn-0001TX-26
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579755894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=InqBzLpI6gQs33NZmqp1Tqn0h4vDv/9bepTrPNsBAdM=;
 b=GlQUmEPio9vorx+R8cvo/K6D0TaL8atp28+ObMHB10t4NV/CJegCuNrEhKT8nuX5v2p7J5
 /OdzrhsWwa/2xhk4O4mixZdwt3NTpFrUI0CtSVHnHmJGRa/69LKNod/r2084U+/QgKd0Iy
 GS7Lq5GxWcoIFoZ9gv1HvK1FM43LCnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-VnzCnXnXNeKAE5zJzeyJMg-1; Thu, 23 Jan 2020 00:04:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B5F818543BA;
 Thu, 23 Jan 2020 05:04:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF18681C0A;
 Thu, 23 Jan 2020 05:04:46 +0000 (UTC)
Subject: Re: [PATCH rc1 18/24] hw/avr: Introduce ATMEL_ATMEGA_MCU config
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-19-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <18202992-bb80-d873-89e0-d1c31ff3fd22@redhat.com>
Date: Thu, 23 Jan 2020 06:04:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123000307.11541-19-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: VnzCnXnXNeKAE5zJzeyJMg-1
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
Cc: S.E.Harris@kent.ac.uk, me@xcancerberox.com.ar,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, dovgaluk@ispras.ru,
 imammedo@redhat.com, mrolnik@gmail.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.03, Richard Henderson wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200120220107.17825-13-f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/avr/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 hw/avr/Kconfig
>=20
> diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
> new file mode 100644
> index 0000000000..da3b10afec
> --- /dev/null
> +++ b/hw/avr/Kconfig
> @@ -0,0 +1,5 @@
> +config ATMEL_ATMEGA_MCU
> +    bool
> +    select ATMEL_TIMER16
> +    select ATMEL_USART
> +    select ATMEL_POWER

Just my 0.02 =E2=82=AC, but I'd rather squash it into the next patch.

 Thomas


