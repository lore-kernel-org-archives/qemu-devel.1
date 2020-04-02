Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261C5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38C1206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Glhx83sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38C1206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJxMA-0006nQ-3V
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 06:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJxLV-0006Fr-Ry
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJxLT-0002d2-Ur
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:45:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJxLT-0002b4-PI
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 06:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585824311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OZ0bh6AYp5yOWnAZDW7zwCfK5a87XH7Z5RimsLH1J4=;
 b=Glhx83sO5FScad8YsGNiM5uYFBJu/EA9ts9b/6OA+89vDcqTqURuJjb8hcdHXsH2QXEa9H
 RAgAFAzN8zhxzBhdSnGdTHDYAROsQj4TNabSr430LHFoCCawSommnutx1CECO4FBP9jz6y
 NpoS7Ee2MJcHkB56usQSO/W8KG7m4wM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-RNcGXVEVNMaA8v5R_nrjCw-1; Thu, 02 Apr 2020 06:45:05 -0400
X-MC-Unique: RNcGXVEVNMaA8v5R_nrjCw-1
Received: by mail-ed1-f70.google.com with SMTP id a14so2350562edx.22
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 03:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NY8fL6vUa+l+u0uasQEYddpB+PUHMihaWDn7qfBwnys=;
 b=ghEt2dgquBxVUIPK8E180/0832GfqFrNrG2Yk5iGCz+fFWVpurIlrTQ+chFZtSs0lE
 CoOSpHwZrdOJQWovq4qdUsvT3urPQcEemBxyB/XhPzMJY2da1VnKR+IX2X+MYZLvtOMp
 byGeNY49nqi6WTMxJPQ3/Bky8j/yH/NX3nuFmrAxEWNLTAVj7LPc4lUrMol/YsNQJyCl
 JeCScDwz+f264glqCBHDFUM9r/giO2+R8yaY51HB+QuFvJ8CWzuQWJHWeT1kDpet9zea
 UwgXKiw+NfPaf/yFwl56fismvBG3/jtCkeMAN7GLxxnStIgko/1Lj8MC33pPr4pg/iL6
 wk4w==
X-Gm-Message-State: AGi0PuYX5F6HRyKh1QAz1aCM7C9Anp2Ji7aKnBVCozzEt/xrJdiLLGdU
 AFDtyKpaofLastqFU3fFX71djSgZlilAWoFuQysgHzysh/YN/yAqJkVI7soVu2jYT21kKJHT4K/
 JSwXDQ3lgpWSwvOM=
X-Received: by 2002:a50:baef:: with SMTP id x102mr2212540ede.238.1585824304703; 
 Thu, 02 Apr 2020 03:45:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2J3Rwnq2CehJKNzuolMbZtTjd6e98ksY+ywBo/obB/T9BLfM/zg6tLgbKbz0C3+l9j92ziQ==
X-Received: by 2002:a50:baef:: with SMTP id x102mr2212515ede.238.1585824304445; 
 Thu, 02 Apr 2020 03:45:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h11sm872866edk.10.2020.04.02.03.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 03:45:03 -0700 (PDT)
Subject: Re: [PATCH for-5.0] vpc: Don't round up already aligned BAT sizes
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200402093603.2369-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0e08e8cc-056a-b5b3-7a16-174b3daeb714@redhat.com>
Date: Thu, 2 Apr 2020 12:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200402093603.2369-1-kwolf@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 11:36 AM, Kevin Wolf wrote:
> As reported on Launchpad, Azure apparently doesn't accept images for
> upload that are not both aligned to 1 MB blocks and have a BAT size that
> matches the image size exactly.
>=20
> As far as I can tell, there is no real reason why we create a BAT that
> is one entry longer than necessary for aligned image sizes, so change
> that.
>=20
> (Even though the condition is only mentioned as "should" in the spec and
> previous products accepted larger BATs - but we'll try to maintain
> compatibility with as many of Microsoft's ever-changing interpretations
> of the VHD spec as possible.)
>=20
> Fixes: https://bugs.launchpad.net/bugs/1870098
> Reported-by: Tobias Witek
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/vpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/vpc.c b/block/vpc.c
> index 6df75e22dc..d8141b52da 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -835,7 +835,7 @@ static int create_dynamic_disk(BlockBackend *blk, uin=
t8_t *buf,
>  =20
>       /* Write the footer (twice: at the beginning and at the end) */
>       block_size =3D 0x200000;
> -    num_bat_entries =3D (total_sectors + block_size / 512) / (block_size=
 / 512);
> +    num_bat_entries =3D DIV_ROUND_UP(total_sectors, block_size / 512);
>  =20
>       ret =3D blk_pwrite(blk, offset, buf, HEADER_SIZE, 0);
>       if (ret < 0) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


