Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D3DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D2524673
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/TvrfQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D2524673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uSh-0005li-JC
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8uS0-00053K-H0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8uRz-0000uJ-Gj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:26:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8uRz-0000tw-DA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583191575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LBq3ctE2emrc2Sarh5ssYvL+A2SwU+l45frWrTXGuLI=;
 b=R/TvrfQKnpOw1I1g0PkItO1fbmL8oh0LXdbf07yIQ7Tp1f4gp8VsfI6BEHKuf5DjVOc4ty
 DXeHfKUQeKnGN3MNYCO3Nd5w7FwcVpvu1NmGsMInpOcjK9OmK04K9mq6eqeYW6M0VMEBOU
 MsE1ElAR6lYbBjy//LN/WZpBUvBCwns=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-rqSDEz2eMPGR9K1cd_aSZQ-1; Mon, 02 Mar 2020 18:26:13 -0500
X-MC-Unique: rqSDEz2eMPGR9K1cd_aSZQ-1
Received: by mail-wr1-f71.google.com with SMTP id w11so371653wrp.20
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HYGCpIEaBPODM6i3plpteorL7m1/E518vMfDgreoWU4=;
 b=qNiXpdzh1IOMlDM1L0NCSXBEwnQVszWcOxVTtJ/MyrfnGyy65fJiJTB+5acIomnhPP
 nE3BuB3Y/NBGUud07eGaxcXOp+a2Q+xpJzy6UcwTseDAB1bH5eMINJh2uwFN/STBLozt
 sxGnlmlBWZR1+XC7AG75Ttte75GZg6YTJs0ADwDVSWkAOo9H5l3feDt8vNKbOhiU7ZGZ
 xdOmrQIoaoBuxzXg9EMKH/1Xud8fYlK4taSZeWVySGdiIv58M1PC1OjdbwuKUhyHw5Sa
 v/TTJALpfR+5dGqsewpfnawFuofJ8+Vvn96fvYRlFycVRcnwYDOU+LcitjfBRjY9m6sQ
 CwZQ==
X-Gm-Message-State: ANhLgQ3MaRdUSd6SH60fjpzCgdMBcMTWUzkRrpN1LChAN+t1F/D+3whM
 kxZJL99UxVa5ZoMhPXc+LuXmYMzP6Pmjge5dj91bcSwG866ZIT6xQOo8wzYxN65jJTPL0vmgpiI
 rUXlbnqsewvwWtF4=
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr1894783wrr.394.1583191572334; 
 Mon, 02 Mar 2020 15:26:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuCMzTVJYlnDivxJXkgvrNV7LSsTiMyp37TSLR2qIXORvrETCZcvguZheb/NK1zGmRBuxOxZA==
X-Received: by 2002:a5d:42c6:: with SMTP id t6mr1894773wrr.394.1583191572166; 
 Mon, 02 Mar 2020 15:26:12 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id a6sm803700wmh.32.2020.03.02.15.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:26:11 -0800 (PST)
Subject: Re: [PATCH] hw/artist: Reduce default artist screen size to 800x600
 pixel
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>
References: <20200302191409.GA4512@ls3530.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e7a15230-6406-14f3-9fa3-f31809a05df5@redhat.com>
Date: Tue, 3 Mar 2020 00:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302191409.GA4512@ls3530.fritz.box>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 8:14 PM, Helge Deller wrote:
> Reduce the default emulated screen size to 800x600 pixel instead of
> 1280x1024 pixel. With the bigger screen size the emulated graphic card
> isn't fully visible on my laptop display, and if people want bigger
> sizes it's possible to define it on the command line.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 65be9e3554..74cff24d7b 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -1418,8 +1412,8 @@ static const VMStateDescription vmstate_artist =3D =
{
>   };
>=20
>   static Property artist_properties[] =3D {
> -    DEFINE_PROP_UINT16("width",        ARTISTState, width, 1280),
> -    DEFINE_PROP_UINT16("height",       ARTISTState, height, 1024),
> +    DEFINE_PROP_UINT16("width",        ARTISTState, width, 800),
> +    DEFINE_PROP_UINT16("height",       ARTISTState, height, 600),
>       DEFINE_PROP_UINT16("depth",        ARTISTState, depth, 8),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>=20

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


