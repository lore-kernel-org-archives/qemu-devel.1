Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9C4C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1799B20A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmuF5LRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1799B20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQSCq-0004JA-9S
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSBy-0003oX-Vj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:54:15 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQSBx-0003zw-F7
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:54:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQSBx-0003yT-2G
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587372852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbj5WFpAVwGdzXUY7nvATTK3SHOTjJ00A1mBD2MKseo=;
 b=YmuF5LRGoVLjvFycn+EBBrErLEQsiQv5VCS0NgCaPhfSg6lnqhJ33fKftLLpC/C8n41V5t
 bmQr5k+6SAoxHLAE6dRXUmzhjgmSDcZwGIXzgRKRCA+HmRM79UDj5fAXn8SUWNTEtBUjnH
 vqHDfjBxQ1Gcsd//6P3HHfsO6aAHHPo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-unFDexT0Ogir3rlUgtV03A-1; Mon, 20 Apr 2020 04:54:10 -0400
X-MC-Unique: unFDexT0Ogir3rlUgtV03A-1
Received: by mail-ed1-f71.google.com with SMTP id w4so130707edv.13
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 01:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AgHPQQpC1CJ+GoNQ4TRpMcRUBQOTDbbp8horvxqyeNs=;
 b=NAsPYukBJQsAa4wMoMQUNHTBeiTLfPtpMwsDbR2Vs3QHLx2pE4CkdcDmtk0ZaIYXFM
 PFBnzsYMO757SxPdTOmnJ7uNxzFGYjCHOx25Si70lFjPZ2PZtBQ5tUmlIbmwxEjfC4Un
 67JDvAWp0iWRsf3tWaQR4pU0i8u9B34V3ScEq2RHWmhZcc3sxOb0fciFuC/lsOm8/Yc+
 KRpUK6onBaY+2bHCUunp4eZAc0X4Cr5St2Y7IvwY1X/jhJB9AbYqdmhajrBpeHum+STK
 yhpHsKib9cqRvVQ2IVxmkDhpyLFmEd4QYtNsug88IbWf54yJrjqSOv0x9t5nHTBwNtZb
 GVkw==
X-Gm-Message-State: AGi0PuY2VJ9024p2mqaCcHctT5ABfDKqgAi6AVQZ8M2PfaEk6Gp8TpAt
 bAJBY7SWRcNEE1Tw+u1MpvmGUIKbn2Gnp6S4bl7+MEUtVU2ZW8wJ6CDpn8w83f014+hX42O0Hg1
 WofLUt4vo6ogsMHU=
X-Received: by 2002:aa7:d892:: with SMTP id u18mr12129409edq.156.1587372849120; 
 Mon, 20 Apr 2020 01:54:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypIf42kSSOo6Z3Y5OraQpKlkLxzeo5vo2GBhzwlWz8HbDlJSFp1HpquKdu16fMcicCFyDetoNQ==
X-Received: by 2002:aa7:d892:: with SMTP id u18mr12129396edq.156.1587372848899; 
 Mon, 20 Apr 2020 01:54:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id jx1sm76552ejb.87.2020.04.20.01.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 01:54:08 -0700 (PDT)
Subject: Re: [PATCH 06/11] fdc: Fix fallback=auto error handling
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b3dd8091-6134-ea3e-3e90-a6c2777792b2@redhat.com>
Date: Mon, 20 Apr 2020 10:54:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200420083236.19309-7-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
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
Cc: John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/20/20 10:32 AM, Markus Armbruster wrote:
> fdctrl_realize_common() rejects fallback=3Dauto.  Used by devices
> "isa-fdc", "sysbus-fdc", "SUNW,fdtwo".  The error handling is broken:
>=20
>      $ qemu-system-x86_64 -nodefaults -device isa-fdc,fallback=3Dauto,dri=
veA=3Dfd0 -drive if=3Dnone,id=3Dfd0
>      **
>      ERROR:/work/armbru/qemu/hw/block/fdc.c:434:pick_drive_type: assertio=
n failed: (drv->drive !=3D FLOPPY_DRIVE_TYPE_AUTO)
>      Aborted (core dumped)
>=20
> Cause: fdctrl_realize_common() neglects to bail out after setting the
> error.  Fix that.
>=20
> Fixes: a73275dd6fc3bfda33165bebc28e0c33c20cb0a0
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/block/fdc.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 33bc9e2f92..9628cc171e 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2615,6 +2615,7 @@ static void fdctrl_realize_common(DeviceState *dev,=
 FDCtrl *fdctrl,
>  =20
>       if (fdctrl->fallback =3D=3D FLOPPY_DRIVE_TYPE_AUTO) {
>           error_setg(errp, "Cannot choose a fallback FDrive type of 'auto=
'");
> +        return;
>       }
>  =20
>       /* Fill 'command_to_handler' lookup table */
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


