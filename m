Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8719C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C9E24125
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 07:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaSLxyhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C9E24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuAKC-0004To-NN
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 02:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuAIz-0003o1-NZ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuAIw-0005Uk-3K
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:20:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30422
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuAIv-0005SM-Tp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 02:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579677596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=X2m5PAzWaOjdS19doYbHQuc45gp4yYQVNyIb4aBDjCQ=;
 b=LaSLxyhC7gkfrU2VdPygVHwdWew4zcwwz+B3s6ko+/ukkXPyaxorkbcbFGcZUOF3WtYERd
 oDDaQYknVSPprvmFJlVlJujOzDfvz4p84YdKfbx+pqhaYAWd/vVXMLVRquMqvqziuPHCk0
 d0rJeiualdS7VluC3tJok3VdZVNjy54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-mfcGcc3XMxKQ0_AcKYk0mg-1; Wed, 22 Jan 2020 02:19:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B641005502;
 Wed, 22 Jan 2020 07:19:51 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B07B89D02;
 Wed, 22 Jan 2020 07:19:50 +0000 (UTC)
Subject: Re: [PATCH] hw/misc/stm32f4xx_syscfg: Fix copy/paste error
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
References: <20200121213853.9601-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <05208ecf-9d8f-7dfc-ea95-974e93aa49b5@redhat.com>
Date: Wed, 22 Jan 2020 08:19:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200121213853.9601-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: mfcGcc3XMxKQ0_AcKYk0mg-1
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/01/2020 22.38, Philippe Mathieu-Daud=C3=A9 wrote:
> Missed in 870c034da0b, hopefully reported by Coverity.
>=20
> Fixes: Coverity CID 1412793 (Incorrect expression)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/misc/stm32f4xx_syscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
> index dbcdca59f8..f960e4ea1e 100644
> --- a/hw/misc/stm32f4xx_syscfg.c
> +++ b/hw/misc/stm32f4xx_syscfg.c
> @@ -47,7 +47,7 @@ static void stm32f4xx_syscfg_set_irq(void *opaque, int =
irq, int level)
>      STM32F4xxSyscfgState *s =3D opaque;
>      int icrreg =3D irq / 4;
>      int startbit =3D (irq & 3) * 4;
> -    uint8_t config =3D config =3D irq / 16;
> +    uint8_t config =3D irq / 16;
> =20
>      trace_stm32f4xx_syscfg_set_irq(irq / 16, irq % 16, level);
> =20
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


