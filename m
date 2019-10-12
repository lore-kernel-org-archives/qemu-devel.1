Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264BAC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA2120659
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA2120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAyl-0000wH-41
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAxs-0000VB-6I
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAxq-0007mG-2m
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:33:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33356)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAxp-0007lx-Jw
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:33:17 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 43EFD821C3
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:33:16 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k9so5005963wmb.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+AwujAzxwwII62SzHPivrju0d5DeXpV1bF5AZOVG9ws=;
 b=aFd2FzUYl8kKWex4cBO49trzTqu6dKeCytpdgqqyH4q9eHMdiItLRzTRv1kpXj/cTT
 Y0BX6usqbEKgtWafEmZnhdNOK9Ll1LWbeq9AdCWFe85I01jCq0qJzexFLNrRJp0b2fZR
 qG0Ymg10iw4Fh+CPX9UhIBAicLYIRF/Kc1ZKzHor+DL7yduZF0Jva3523yaQ1HM8vERH
 ExSQ0kbmR8v87NHi3mzelH8viv6IWsG4FM5afyCxgBjgLEqVlai4yveT1YD12zX/v/6P
 VxH8pNlgNAQDvQ4lHUnMYm6A6QZFEP1v299sPbpxk2WsarTFBKJfF42RmVv2kIepF7P7
 TP+A==
X-Gm-Message-State: APjAAAWIwxQmKMc/XfEvRhFoBWqQRxRWDj2AxBbT2PFTIxR32qD5/VPO
 8VO164saOND6jjVOeyz9uPzkp9i8l+wFRmxrDvHHd0ZW4uB72sAuLItpa2sfq1nycfPt7eVP18R
 S81B20cU1IFH4Guc=
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr17138541wrr.61.1570861994990; 
 Fri, 11 Oct 2019 23:33:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwCTajEaWuLzW4q24LRW2h2Op8OGcWhYbPhU0M9oVmN6uVbqDGAU2Jep56ZJKWENgjjKy3V1w==
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr17138524wrr.61.1570861994780; 
 Fri, 11 Oct 2019 23:33:14 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l9sm9823309wme.45.2019.10.11.23.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:33:14 -0700 (PDT)
Subject: Re: [RFC v5 121/126] hw/sd/ssi-sd.c: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-122-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fe720ff6-0949-fced-8d33-2e8dcb5d568a@redhat.com>
Date: Sat, 12 Oct 2019 08:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-122-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 6:05 PM, Vladimir Sementsov-Ogievskiy wrote:
> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp =3D=3D &fatal_err
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
>=20
> If we want to check error after errp-function call, we need to
> introduce local_err and than propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>     &error_fatel, this means that we don't break error_abort
>     (we'll abort on error_set, not on error_propagate)
>=20
> This commit (together with its neighbors) was generated by
>=20
> for f in $(git grep -l errp \*.[ch]); do \
>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff =
$f; \
> done;
>=20
> then fix a bit of compilation problems: coccinelle for some reason
> leaves several
> f() {
>      ...
>      goto out;
>      ...
>      out:
> }
> patterns, with "out:" at function end.
>=20
> then
> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
>=20
> (auto-msg was a file with this commit message)
>=20
> Still, for backporting it may be more comfortable to use only the first
> command and then do one huge commit.
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   hw/sd/ssi-sd.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 91db069212..f42204d649 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -241,10 +241,10 @@ static const VMStateDescription vmstate_ssi_sd =3D=
 {
>  =20
>   static void ssi_sd_realize(SSISlave *d, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       ssi_sd_state *s =3D FROM_SSI_SLAVE(ssi_sd_state, d);
>       DeviceState *carddev;
>       DriveInfo *dinfo;
> -    Error *err =3D NULL;
>  =20
>       qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
>                           DEVICE(d), "sd-bus");
> @@ -254,12 +254,14 @@ static void ssi_sd_realize(SSISlave *d, Error **e=
rrp)
>       dinfo =3D drive_get_next(IF_SD);
>       carddev =3D qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
>       if (dinfo) {
> -        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinf=
o), &err);
> +        qdev_prop_set_drive(carddev, "drive", blk_by_legacy_dinfo(dinf=
o),
> +                            errp);

This fits 72 chars, can you keep it in the same line?

>       }
> -    object_property_set_bool(OBJECT(carddev), true, "spi", &err);
> -    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
> -    if (err) {
> -        error_setg(errp, "failed to init SD card: %s", error_get_prett=
y(err));
> +    object_property_set_bool(OBJECT(carddev), true, "spi", errp);
> +    object_property_set_bool(OBJECT(carddev), true, "realized", errp);
> +    if (*errp) {
> +        error_setg(errp, "failed to init SD card: %s",
> +                   error_get_pretty(*errp));

Ditto...

>           return;
>       }
>   }
>=20

If possible please squash with "47/126 SD (Secure Card)"

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

