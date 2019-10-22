Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DE3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C6921783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C6921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrIp-00031I-ME
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMrHh-0001zt-40
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMrHf-0001rs-2O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:21:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMrHe-0001rS-Pw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:20:59 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 766F8AB975
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:20:57 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id i23so761984wmb.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LzIyntbnOMvvjZPx4q4aMMTRdnXACy5Wsp+Zpx4YaH8=;
 b=Ybw2XxMdj51vU6jkOsvz6J10aU5zWlOS6ZfhfWq9o144zHArsVv+ru9eHsOw66GbuQ
 VMUqtfIyBaq+yNCbeXn35ej+wLH6a/2cKi9/Lx+ESeNoi5qbbUMiNJpkWJhkAs4LPrxw
 fUa38CMdx+tAqz6ij5HgaWrMMzhMqSF3dHmFYnEzIwRjjP5dxOANHAPHzI1jyIw5RHzM
 H1kIIfHD+5c0WJGuOpJdJyCQDRRT/yRPxNfMhG0uyqY6W/J5hQFjTe98MCU/g/P4NXXx
 YNIV1JNlgxF1mY6qH3YQz3ZenW45nN79ijmdB+yXjNqJ/vEUqEJesVQBWPuLSisuzU50
 XIeg==
X-Gm-Message-State: APjAAAWDunD4y36pZm+HF9T3H4hBYl/GTwbYoJm9IOiTdWc+NNk89PmN
 D0qiWULfanUfv+rk4KXzVP4TSZ2WV6FnJVcPOzAnNYpaZVNlcDjycU5NYXVFC+kIN8qJyFyQ9mz
 ZoN0Y5DBpmQvgjjo=
X-Received: by 2002:a5d:5383:: with SMTP id d3mr2582903wrv.55.1571739656211;
 Tue, 22 Oct 2019 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxKKX8XwMt41kjSGPq2XXbgbGYM4d7FPjwKNCB0uWa2V0GDNi89Ox39YIQieVprqGS6r329Tw==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr2582865wrv.55.1571739655888;
 Tue, 22 Oct 2019 03:20:55 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id n205sm5603122wmf.22.2019.10.22.03.20.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:20:55 -0700 (PDT)
Subject: Re: [PATCH v8 2/8] block: Support providing LCHS from user
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20191016164145.115898-1-sameid@google.com>
 <20191016164145.115898-4-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a2e93337-f4a7-db62-e87c-8c2ea2dd62bf@redhat.com>
Date: Tue, 22 Oct 2019 12:20:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016164145.115898-4-sameid@google.com>
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 jsnow@redhat.com, seabios@seabios.org, kevin@koconnor.net,
 liran.alon@oracle.com, kraxel@redhat.com,
 Sam Eiderman <shmuel.eiderman@oracle.com>, lersek@redhat.com,
 karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 6:41 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Add logical geometry variables to BlockConf.
>=20
> A user can now supply "lcyls", "lheads" & "lsecs" for any HD device
> that supports CHS ("cyls", "heads", "secs").
>=20
> These devices include:
>      * ide-hd
>      * scsi-hd
>      * virtio-blk-pci
>=20
> In future commits we will use the provided LCHS and pass it to the BIOS
> through fw_cfg to be supplied using INT13 routines.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> Signed-off-by: Sam Eiderman <sameid@google.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   include/hw/block/block.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index fd55a30bca..d7246f3862 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -26,6 +26,7 @@ typedef struct BlockConf {
>       uint32_t discard_granularity;
>       /* geometry, not all devices use this */
>       uint32_t cyls, heads, secs;
> +    uint32_t lcyls, lheads, lsecs;
>       OnOffAuto wce;
>       bool share_rw;
>       BlockdevOnError rerror;
> @@ -65,7 +66,10 @@ static inline unsigned int get_physical_block_exp(Bl=
ockConf *conf)
>   #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                   =
   \
>       DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),               =
   \
>       DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),             =
   \
> -    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
> +    DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0),                =
  \
> +    DEFINE_PROP_UINT32("lcyls", _state, _conf.lcyls, 0),              =
  \
> +    DEFINE_PROP_UINT32("lheads", _state, _conf.lheads, 0),            =
  \
> +    DEFINE_PROP_UINT32("lsecs", _state, _conf.lsecs, 0)
>  =20
>   #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                 =
   \
>       DEFINE_PROP_BLOCKDEV_ON_ERROR("rerror", _state, _conf.rerror,    =
   \
>=20

