Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F07CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A6620863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A6620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPlZ-0001Uh-Lx
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOPks-0000Bf-1w
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOPkp-0007Os-Pa
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOPkp-0007OK-Hu
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:21:31 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 016CB81F0C
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 17:21:30 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q22so1936536wmc.1
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 10:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d+mlOi10GBgF+Ct9GmU4A8EQD/BLOfKG6hNadHPnjXk=;
 b=FQV/ZpExY4BfIoBVvNzq8Op/yaB4agTtsPduvD+2f5Q/anZW97EZ1KNRu583r/6ZxO
 D1hy8/7ZkbqtsUIVeNgGW93TGIlrHeRINs73J1iGmKw/skBFdzoxbxU2mRu990IjoUJy
 NwN1Sp1t4ig8woY8I5IB1B6SJwhuWWKF4tquzHiRa7ay6O/ryUbmc8qfVObAPfKmR6du
 FJfc/MDkjXshA7/kRkvwc11Qir8vfPDALENIkkoRvyAsD7aDczQpZR8pMPQVeqI5cSTB
 cvrZwaHP4jhhh08vCqDnHDTzTXJLMSqOjU2Qw51CZyHPK/UjspVG6oTnsFsVe2RFZ5KZ
 Mwwg==
X-Gm-Message-State: APjAAAU0r9a92wq+igVh144oVnTKF8WySVw4I69gYWtiwFtKl1xkK5Lc
 2drKbk/Jp/u6ubdHNGF+/+wZMeYCRhkxhDNvJMMm2K/5TvF984eics31UaEk/g7hW7YxBCxYouI
 axoYNezpR2t+X16M=
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr3971046wmb.138.1572110488729; 
 Sat, 26 Oct 2019 10:21:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwVoO2Yvao3aKFmEVMuSobQ5jpf1mPFf9tX8bu6Cjxq8e9Y7mp3rlXT/ufUfPmNQZ7DG1yjiw==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr3971028wmb.138.1572110488505; 
 Sat, 26 Oct 2019 10:21:28 -0700 (PDT)
Received: from [192.168.1.33] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id t10sm5826924wrw.23.2019.10.26.10.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 10:21:27 -0700 (PDT)
Subject: Re: [PATCH v15 02/11] esp: move get_cmd() post-DMA code to
 get_cmd_cb()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20191026164546.30020-1-laurent@vivier.eu>
 <20191026164546.30020-3-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <909926bc-fbf9-827e-638e-ad17ec8c3414@redhat.com>
Date: Sat, 26 Oct 2019 19:21:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191026164546.30020-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/19 6:45 PM, Laurent Vivier wrote:
> This will be needed to implement pseudo-DMA
>=20
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

:)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/scsi/esp.c | 46 +++++++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 09b28cba17..0230ede21d 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -84,6 +84,34 @@ void esp_request_cancelled(SCSIRequest *req)
>       }
>   }
>  =20
> +static int get_cmd_cb(ESPState *s)
> +{
> +    int target;
> +
> +    target =3D s->wregs[ESP_WBUSID] & BUSID_DID;
> +
> +    s->ti_size =3D 0;
> +    s->ti_rptr =3D 0;
> +    s->ti_wptr =3D 0;
> +
> +    if (s->current_req) {
> +        /* Started a new command before the old one finished.  Cancel =
it.  */
> +        scsi_req_cancel(s->current_req);
> +        s->async_len =3D 0;
> +    }
> +
> +    s->current_dev =3D scsi_device_find(&s->bus, 0, target, 0);
> +    if (!s->current_dev) {
> +        /* No such drive */
> +        s->rregs[ESP_RSTAT] =3D 0;
> +        s->rregs[ESP_RINTR] =3D INTR_DC;
> +        s->rregs[ESP_RSEQ] =3D SEQ_0;
> +        esp_raise_irq(s);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
>   static uint32_t get_cmd(ESPState *s, uint8_t *buf, uint8_t buflen)
>   {
>       uint32_t dmalen;
> @@ -108,23 +136,7 @@ static uint32_t get_cmd(ESPState *s, uint8_t *buf,=
 uint8_t buflen)
>       }
>       trace_esp_get_cmd(dmalen, target);
>  =20
> -    s->ti_size =3D 0;
> -    s->ti_rptr =3D 0;
> -    s->ti_wptr =3D 0;
> -
> -    if (s->current_req) {
> -        /* Started a new command before the old one finished.  Cancel =
it.  */
> -        scsi_req_cancel(s->current_req);
> -        s->async_len =3D 0;
> -    }
> -
> -    s->current_dev =3D scsi_device_find(&s->bus, 0, target, 0);
> -    if (!s->current_dev) {
> -        // No such drive
> -        s->rregs[ESP_RSTAT] =3D 0;
> -        s->rregs[ESP_RINTR] =3D INTR_DC;
> -        s->rregs[ESP_RSEQ] =3D SEQ_0;
> -        esp_raise_irq(s);
> +    if (get_cmd_cb(s) < 0) {
>           return 0;
>       }
>       return dmalen;
>=20

