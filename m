Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE30C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9BB20848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7YPP2Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9BB20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9U3H-0004fp-Fd
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9U2L-0004Ef-7I
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9U2I-0000XZ-Nd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53627
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9U2I-0000Te-Hf
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583328365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F2QiWloHhAFkCmA6zmIexGhCnKFGx20dUCZNlZveLU=;
 b=Y7YPP2Gf0m+NUUlOtcCmcjSYKfPd/UeJ6lmeIo96VD8D6c15AAQ9B1HKR/Ca87G1ZOlnU6
 VqdJOzeo9XAAHbjfOoSAvAPAZ2bXBXjROdzh12JSCD00bCSldsnXEMYBB3IV4k3bPXn0Tf
 Ig1QhfexvVQW3J8lHsC33P0IDJQnj5M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-KCm75fPwOi20RGLbl55H1Q-1; Wed, 04 Mar 2020 08:26:03 -0500
X-MC-Unique: KCm75fPwOi20RGLbl55H1Q-1
Received: by mail-ed1-f72.google.com with SMTP id u12so1575592edb.20
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 05:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OdSzQ8mTXhVpM/SpNBxv5GPGPX4nKw3S6fpG0cimgxM=;
 b=Q9n5fCViGSyldgB48McJe5S7HeKsd7sEucAIdmxHg6HNeKh/PFZfI2yfLV2c+Cvjld
 K1U2WDXMtZRfDlP9cclrGPERoS/2uju2V7XrTAiH9+P48OhkpTrwNJrP10Gdj3yOFfrF
 YkyiW+EnsncQwVIxjciAPfhmDpmm3dU+0hDFq0LIAWHIRihhpuDAg2ySUMliatKzqwdd
 xlZBjzWjwLZbpm6r2islOp0gclg69z6p5WdlelhPDzbYIU/jld/P78dnh+kqzAruXYgi
 ELuRbBHBASKNS6gMpsW26EMOzPFEss3muklhKx2SB+7OitEiGjZLtLV+PimQdKf5vjAF
 s0rA==
X-Gm-Message-State: ANhLgQ3gJatc504RjavgQpHS3gdi+DpTRltW6VGWxnXAW+q/mlKikjrs
 JypA+bgtqb1HhafCI5N+Jy+Hss4qqA89LUZczSVadQ/kpY0QwfdN7hKJ9PZ7Wh13qUYmJcA3OD0
 6q9tG2eUny9IKpV4=
X-Received: by 2002:a17:906:ff01:: with SMTP id
 zn1mr2312529ejb.323.1583328362303; 
 Wed, 04 Mar 2020 05:26:02 -0800 (PST)
X-Google-Smtp-Source: ADFU+vumzUMnNJzzRXTFwa2Zbg2sMS0E6IrFNn09DoMwJq03qV7TTapOzG/Y2hXw5TIjGUwn7edYAA==
X-Received: by 2002:a17:906:ff01:: with SMTP id
 zn1mr2312514ejb.323.1583328362069; 
 Wed, 04 Mar 2020 05:26:02 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q26sm1188886ejb.50.2020.03.04.05.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 05:26:01 -0800 (PST)
Subject: Re: [PATCH] dp8393x: Mask EOL bit from descriptor addresses, take 2
To: Finn Thain <fthain@telegraphics.com.au>, Jason Wang <jasowang@redhat.com>
References: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ab614cdb-0bbc-23cc-890a-0a15e9016ba6@redhat.com>
Date: Wed, 4 Mar 2020 14:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2003041421280.12@nippy.intranet>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 4:23 AM, Finn Thain wrote:
> A portion of a recent patch got lost due to a merge snafu. That patch is
> now commit 88f632fbb1 ("dp8393x: Mask EOL bit from descriptor addresses")=
.
> This patch restores the portion that got lost.
>=20
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> ---
>   hw/net/dp8393x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 8a3504d962..81fc13ee9f 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -525,8 +525,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>                                    * (4 + 3 * s->regs[SONIC_TFC]),
>                                  MEMTXATTRS_UNSPECIFIED, s->data,
>                                  size);
> -            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0) & ~0x1;
> -            if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
> +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, 0);
> +            if (s->regs[SONIC_CTDA] & SONIC_DESC_EOL) {
>                   /* EOL detected */
>                   break;
>               }
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


