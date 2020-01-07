Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79C3C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:23:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B422072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kp0n9iEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B422072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotVg-00041B-9D
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iotUm-0002uU-Jn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iotUl-0007k9-Hn
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:22:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iotUl-0007jm-EG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578421343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32V1xU9oNA67ESdJMvKDbiuD7OxX5nvMnbKC5djXeS8=;
 b=Kp0n9iExTdq3INmK/xs/h7e/pH+18BZxNQh3d8+wTtuENblPHtSSrMWJdGJYIU94Fjaoh1
 3Q4NW6ThyKwMGA7JtrgZ8ozHLKYolPLlCeLpmG8YIBwako/bVz7gOG1j8UlQ2xF2+bTKoV
 EL0aJ7STljg7CehchPVHc1+ePBJx+yU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-BY_EAJhVM7yhdzLPWeZ-Bg-1; Tue, 07 Jan 2020 13:22:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id h130so135125wme.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hOIajqGrNdLv6qt+7m/aKytBtG1nd2AeRO9BgTvs5XU=;
 b=GkbFzcFss00yAD7GGyOJcsfk2wIhSa4lfQ3b9yIwZonQKplJKBpoRE1lzuGnT+z5PA
 meOKwY+I+VK7pM205J0sR7cjudLMC7ph+88Cz9EYJJoGnONd3kaCDTVOcaoNf/dLI5bz
 T7/A7SSNzYoT2NRFr2ihTG7c/0zIqV2XgTQ3hZPe505IsQIBcOpzyjjkW1lTwRgZk5Uw
 3ULhUgzMXaIBidRI1u/esArqRodCnkykx4gPnaZ464gktE70qjfqNfzsuyPZi8WW+HQQ
 dC2aauoZRUvuICDmsyLjouPK1XlgiI6z52lnCMTcmtIMbnZ6vSCQ7/hl4TWIZCVSIwvr
 SimQ==
X-Gm-Message-State: APjAAAU5UkCgm+ZCca2RbqTLj2+7zmZueRVecLtn8I9vegpQ2sYhsUXh
 KWeZufaFG3seQnXIeKoMGc21YoxTvu4CltFUjgsv5cpf/A3l+67B6Ttn37V29yJXPvdyNBG/h2t
 OyFbw+Z+sSW6B184=
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr340750wrt.339.1578421340463;
 Tue, 07 Jan 2020 10:22:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZjTzVSt/y34nxf490g8FHzLWefrDbVeGYutI28razXM9c5ALgTp0UUF5hp59qoY/O2nlCkA==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr340732wrt.339.1578421340267;
 Tue, 07 Jan 2020 10:22:20 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id x14sm467976wmj.42.2020.01.07.10.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 10:22:19 -0800 (PST)
Subject: Re: [PATCH 1/2] ppc/pnv: check return value of blk_pwrite()
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200107171809.15556-1-clg@kaod.org>
 <20200107171809.15556-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49613a4e-aec8-8ae3-4443-ede9ed1fd39f@redhat.com>
Date: Tue, 7 Jan 2020 19:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107171809.15556-2-clg@kaod.org>
Content-Language: en-US
X-MC-Unique: BY_EAJhVM7yhdzLPWeZ-Bg-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 6:18 PM, C=C3=A9dric Le Goater wrote:
> When updating the PNOR file contents, we should check for a possible
> failure of blk_pwrite().
>=20
> Fixes Coverity issue CID 1412228.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/pnv_pnor.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
> index bfb1e92b0392..0e86ae2feae6 100644
> --- a/hw/ppc/pnv_pnor.c
> +++ b/hw/ppc/pnv_pnor.c
> @@ -33,6 +33,7 @@ static uint64_t pnv_pnor_read(void *opaque, hwaddr addr=
, unsigned size)
>   static void pnv_pnor_update(PnvPnor *s, int offset, int size)
>   {
>       int offset_end;
> +    int ret;
>  =20
>       if (s->blk) {
>           return;
> @@ -42,8 +43,11 @@ static void pnv_pnor_update(PnvPnor *s, int offset, in=
t size)
>       offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
>       offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
>  =20
> -    blk_pwrite(s->blk, offset, s->storage + offset,
> -               offset_end - offset, 0);
> +    ret =3D blk_pwrite(s->blk, offset, s->storage + offset,
> +                     offset_end - offset, 0);
> +    if (ret < 0) {
> +        error_report("Could not update PNOR: %s", strerror(-ret));

Can you report the failed offset too please?

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +    }
>   }
>  =20
>   static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
>=20


