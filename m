Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6FC5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562BD20781
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 10:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTK7vaBr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562BD20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRCbe-0000eD-IG
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCad-0008PM-1B
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRCac-0001dq-4v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:26:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRCab-0001Wk-Ny
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 06:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587551204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vu4GZGPqpWaVXTxSTo+lfJSeFZFnJF3Y9FIwDSRzpwk=;
 b=QTK7vaBrukEmnimHMNcU6rKGgIeqM5X76uR6bK1zL8TvBnOtMa225ikTLNmTWc9N2uYU+m
 2fvDGif+FYPzr6ZpRJU4W7qNMwZb/+HaeqlpENpDlEDkHVmQt76cIiBgnM9t4Prh2nGL66
 GTAX6TIJe902SYfsXGN2pKB/nEZ5vn8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65--mEeEXWvPNeU97DNtTIdbg-1; Wed, 22 Apr 2020 06:26:42 -0400
X-MC-Unique: -mEeEXWvPNeU97DNtTIdbg-1
Received: by mail-wr1-f72.google.com with SMTP id q10so822594wrv.10
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 03:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wp+lKFgC006ZVm8r4AYLF2fJZc45QuAbKLEBEcG3USI=;
 b=T8no9lGDUaiwHnm/YP5WaIiAJNA52tQ0UKIZfTGTEuYxnwyUEVSqyH1soNK3/F2W+z
 VCuwQTXL0MStvD3UHWZrcHyTFs4I/u4pNkTXNSnnekKNCR685eSY3SbXAtb4CpLkDM1N
 PqSfHslHOW3S6YzZfpnw01xXcGisqyWNALZYJwqR+Gs0AJl3XuQJy4QttfXIQHVAL1PD
 zxg941rBUXey9iL43vU/HIBz6E7wzLERxIfXslILQRb7FG2FSjuBx0aQgVX1lVA4bjq9
 b5buigvGW2nxtmiBVVKfWtJHQpyX79zzoV81OBz/VVkTpsaj//QkLA1R+3CrZfeEZs6k
 2vWA==
X-Gm-Message-State: AGi0Pubvqn9fHRQAQG4VjH/DnlZR4qWhxSLfxXI+Zvdab3wqtmqqZV0i
 aWTwvunFjMtBTlQOzUmAlh+ImDuYUozq5RgtSBI2RKMARtJCVN2fueoCrW56G8xva7KoXqv98VM
 r32zmWS3Lq9cad+w=
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr9801501wme.139.1587551201598; 
 Wed, 22 Apr 2020 03:26:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypICUGiSzIP8nb6GBh2ks4XA7flGckzQaJZ9GJikW/vrXW0aFMfKfPAb7sH7UXDKRfUBHj0wOQ==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr9801471wme.139.1587551201209; 
 Wed, 22 Apr 2020 03:26:41 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 5sm6793423wmg.34.2020.04.22.03.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 03:26:40 -0700 (PDT)
Subject: Re: [PATCH 5/5] ramfb: drop leftover debug message
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-6-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9cd1b1be-7caf-c41c-c143-c1cc0855a062@redhat.com>
Date: Wed, 22 Apr 2020 12:26:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422100211.30614-6-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/22/20 12:02 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/display/ramfb.c | 2 --
>   1 file changed, 2 deletions(-)
>=20
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index d1b1cb9bb294..be884c9ea837 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -88,8 +88,6 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset,=
 size_t len)
>       addr   =3D be64_to_cpu(s->cfg.addr);
>       format =3D qemu_drm_format_to_pixman(fourcc);
>  =20
> -    fprintf(stderr, "%s: %dx%d @ 0x%" PRIx64 "\n", __func__,
> -            s->width, s->height, addr);
>       surface =3D ramfb_create_display_surface(width, height,
>                                              format, stride, addr);
>       if (!surface)
>=20

I'd move this before patch #3/5 "ramfb: don't update RAMFBState on=20
errors". Anyway,

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


