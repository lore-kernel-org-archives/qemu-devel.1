Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759BCC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 442F220650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442F220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAey-0000hw-Dm
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAeK-0000JD-UY
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAeJ-0008Nr-Ka
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAeJ-0008Mu-Cn
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:07 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 570932A09D8
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:13:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k2so5433756wrn.7
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oM14AIdxLkocNjiv0QQgb5o74BNet0VJHZyDHmi0mds=;
 b=OkzBPYly4zdJ9W/WItb+58zh9SQJf8o3JUc92Fy6yT23UoKD7pA9IRmsBtWpF38cDT
 5mnEKWg4nKoro7+oXenrh1Usdwp2H/oj/Hkv73zQQ4dHaN46+meb/V5fpRkMl2JK5oFa
 PXgzsUhOppUisUZyiPPWegPfascl7OB08pQzFa5oNYDsvrK9lTXoc3HgTYEBoPq5r1Fg
 2k4H+Xt0V4bWFTBcOQrWxWCa+LGU8VH27aIAxOi6PuOqL+orPgo8VNp9Zc8WUmk21uRa
 Z3h8JH2mPdrrtEFs/lxt0P37Dhr8YlwM/V+fXp5esVxJwUoQN2TwNAv+VrxAgyaPvbB1
 DTAQ==
X-Gm-Message-State: APjAAAVPMqIXE7ueIfQSwFqfRjlOHphGAidp1bH/3SBSvl4lx1U6C7x7
 fN4R5LmTt0Z7I1dslKwB0Z5rqERz4F6llt46eQmOi2PCSzwgzzvKLQUBfHDdv9BPwEJx3HvBM0I
 Xi2EJjYzTdY9PpwE=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr3098473wro.11.1570860785078;
 Fri, 11 Oct 2019 23:13:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx8+esya1R3YqQ/ceAGQ4jtkEoyBHZXiuplZPaRc9uwJEA8GU12eGNzozJg5aBJi0GIULt+UQ==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr3098459wro.11.1570860784804;
 Fri, 11 Oct 2019 23:13:04 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id i1sm12783319wmb.19.2019.10.11.23.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:13:04 -0700 (PDT)
Subject: Re: [RFC v5 047/126] SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-48-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3150c977-1510-20c8-6f24-4bf4e60722a2@redhat.com>
Date: Sat, 12 Oct 2019 08:13:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-48-vsementsov@virtuozzo.com>
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

On 10/11/19 6:04 PM, Vladimir Sementsov-Ogievskiy wrote:
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
>   hw/sd/sdhci-pci.c |  7 +++----
>   hw/sd/sdhci.c     | 21 +++++++++------------
>   2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
> index 2c8d8f59b5..b1448cf22e 100644
> --- a/hw/sd/sdhci-pci.c
> +++ b/hw/sd/sdhci-pci.c
> @@ -29,13 +29,12 @@ static Property sdhci_pci_properties[] =3D {
>  =20
>   static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       SDHCIState *s =3D PCI_SDHCI(dev);
> -    Error *local_err =3D NULL;
>  =20
>       sdhci_initfn(s);
> -    sdhci_common_realize(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_common_realize(s, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e56031b5e4..db9e9add82 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1293,7 +1293,7 @@ static const MemoryRegionOps sdhci_mmio_ops =3D {
>  =20
>   static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp=
)
>   {
> -    Error *local_err =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>  =20
>       switch (s->sd_spec_version) {
>       case 2 ... 3:
> @@ -1304,9 +1304,8 @@ static void sdhci_init_readonly_registers(SDHCISt=
ate *s, Error **errp)
>       }
>       s->version =3D (SDHC_HCVER_VENDOR << 8) | (s->sd_spec_version - 1=
);
>  =20
> -    sdhci_check_capareg(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_check_capareg(s, errp);
> +    if (*errp) {
>           return;
>       }
>   }
> @@ -1337,11 +1336,10 @@ void sdhci_uninitfn(SDHCIState *s)
>  =20
>   void sdhci_common_realize(SDHCIState *s, Error **errp)
>   {
> -    Error *local_err =3D NULL;
> +    ERRP_AUTO_PROPAGATE();
>  =20
> -    sdhci_init_readonly_registers(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_init_readonly_registers(s, errp);
> +    if (*errp) {
>           return;
>       }
>       s->buf_maxsz =3D sdhci_get_fifolen(s);
> @@ -1461,13 +1459,12 @@ static void sdhci_sysbus_finalize(Object *obj)
>  =20
>   static void sdhci_sysbus_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       SDHCIState *s =3D SYSBUS_SDHCI(dev);
>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> -    Error *local_err =3D NULL;
>  =20
> -    sdhci_common_realize(s, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    sdhci_common_realize(s, errp);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

