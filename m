Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D902C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A8320650
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 06:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A8320650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJAfm-0001aB-FT
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 02:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iJAex-0000r5-2g
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iJAev-0000GK-RJ
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iJAev-0000FZ-JS
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 02:13:45 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 992296C25
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 06:13:44 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id q9so4973593wmj.9
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 23:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NWD0rcFvfPENBhQzCbUaWQqHMOt09I+Qlo10qSTLBgg=;
 b=qaeKeN5YwbtItKxg2HocukkJZH1CByWP0aiokwFMVZm8SvatumrZG1j55UQLwFan4s
 HtkSM3m7gjvT3gGVTi8O/aFKIzqJh+x/QuMbFPqgikdOqMSBqzmoJEFzc035b7+lGf4A
 M6SnFkrsFcVHA6WFZZPgXb4a731cqb28SIa0nC4/bbo1Vqao1iR2mpyW2DdMhKUvucBe
 doBunBgYk9GiIo/tO9L5fd8ZRscX7P9BzvsPnna/VHo1apYipLfLd44SjnlfFIm5NgVw
 RShLmCSuN8lkglLTMfLd2YtNgcFdYBsK1GDQTgW5kge5qHrdHmlfxSiXxYhVfX1E5Yi9
 VsJg==
X-Gm-Message-State: APjAAAVS4DNmo0djFEPJ5kWxP/2i6OKr70o5QSG2y87dA6Nnd8qjHxYH
 G02rRt6lkVU5Pmn1bv2gedAY/PuLLE5pkqxrFlRTh0oVFzaG3P+ta1hco6SBB6siWN2SIWl1T9j
 /hQd194/wzyq0DY8=
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr6417880wma.81.1570860823330; 
 Fri, 11 Oct 2019 23:13:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymWp3saPmIKOu4D9Tp2A7IEGk2F2oF+oMTeezPLTn9VjoatbQpVbSl3rKzEZEwW5dfvUWBRw==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr6417865wma.81.1570860823117; 
 Fri, 11 Oct 2019 23:13:43 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id l6sm8060061wmg.2.2019.10.11.23.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2019 23:13:42 -0700 (PDT)
Subject: Re: [RFC v5 064/126] fw_cfg: introduce ERRP_AUTO_PROPAGATE
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-65-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6a82b26-68e2-c45c-07e7-70d5b669fc15@redhat.com>
Date: Sat, 12 Oct 2019 08:13:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011160552.22907-65-vsementsov@virtuozzo.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, armbru@redhat.com,
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
>   hw/nvram/fw_cfg.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7dc3ac378e..e10687c876 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -1104,12 +1104,11 @@ static Property fw_cfg_io_properties[] =3D {
>  =20
>   static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       FWCfgIoState *s =3D FW_CFG_IO(dev);
> -    Error *local_err =3D NULL;
>  =20
> -    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
> +    if (*errp) {
>           return;
>       }
>  =20
> @@ -1155,14 +1154,13 @@ static Property fw_cfg_mem_properties[] =3D {
>  =20
>   static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
>   {
> +    ERRP_AUTO_PROPAGATE();
>       FWCfgMemState *s =3D FW_CFG_MEM(dev);
>       SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>       const MemoryRegionOps *data_ops =3D &fw_cfg_data_mem_ops;
> -    Error *local_err =3D NULL;
>  =20
> -    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
> +    if (*errp) {
>           return;
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

