Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CBC7222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBC7222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQFd-0000yY-8M
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDQDu-00082n-W1
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDQDt-0006AA-TE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDQDt-00069N-L6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:38:05 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9AA8988302
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:38:04 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id l6so703547wrn.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KeoCKoKkU9vwg3QJ+8OxDoD/snf2B/GcBZIQCDBN8nE=;
 b=r5j0K8SzZK8h4so9grRrDnpAakSZf4+52B5GldzZ4p5X/Oa4p4AXvNd2c8CBNbJrs5
 4z1jBOG22to/FhVuMmB26YP6D/by5Da6hXAHq6BNQ8IgPSRhfvBdyG7cLt3e9CVZszSm
 XVlXg9WNRiqGyspOvksydrN9dTNvJacPWYLJ3gkQe8jBCBC4zTPeE06nwSTP6hkQ5C8H
 zXvmpnBw8fS7lEHOldlKLqQc3025D/rNCT5ywzOB2DH7tL9cTOA4suyUxzKJ8q2wgS/g
 nHtmDwwRr6m7GiZRDcYhy4CODjze01jczVYfNINeXpS7I/Mdryb+cRWyqhIdrum4hBSS
 2jJQ==
X-Gm-Message-State: APjAAAUSu95ElIDkgsW2Wfdhb9IxBJIu1wczQDvGlm65Q7oTZwquL1S6
 pXxv/vjKtx/yuh76RxhJRdBP/4JbiOVuasB9arGDIcqr3SEXwspNck8nAhb80bv4njlGeDbLzBG
 wcGD9qo/TLFnxw64=
X-Received: by 2002:adf:f44d:: with SMTP id f13mr1388490wrp.197.1569490683338; 
 Thu, 26 Sep 2019 02:38:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8lKS+gq4ZH4eOHj0FoiUYGa2RI+wHsX1YkZKfRhb4mG1RV4plXXug7gRhCqaceJfXtGXXJg==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr1388477wrp.197.1569490683154; 
 Thu, 26 Sep 2019 02:38:03 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id d28sm2780009wrb.95.2019.09.26.02.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:38:02 -0700 (PDT)
Subject: Re: [SeaBIOS] [PATCH v7 1/8] block: Refactor macros - fix tabbing
To: Sam Eiderman <sameid@google.com>, qemu-devel@nongnu.org
References: <20190925110639.100699-1-sameid@google.com>
 <20190925110639.100699-2-sameid@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <aa0a2c79-60d1-1cfb-4679-4157a3c3f697@redhat.com>
Date: Thu, 26 Sep 2019 11:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925110639.100699-2-sameid@google.com>
Content-Type: text/plain; charset=utf-8
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
 seabios@seabios.org, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 1:06 PM, Sam Eiderman wrote:
> From: Sam Eiderman <shmuel.eiderman@oracle.com>
>=20
> Fixing tabbing in block related macros.
>=20
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/ide/qdev.c            |  2 +-
>  include/hw/block/block.h | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
> index 6fba6b62b8..6dd219944f 100644
> --- a/hw/ide/qdev.c
> +++ b/hw/ide/qdev.c
> @@ -290,7 +290,7 @@ static void ide_drive_realize(IDEDevice *dev, Error=
 **errp)
>      DEFINE_BLOCK_PROPERTIES(IDEDrive, dev.conf),        \
>      DEFINE_BLOCK_ERROR_PROPERTIES(IDEDrive, dev.conf),  \
>      DEFINE_PROP_STRING("ver",  IDEDrive, dev.version),  \
> -    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),    \
> +    DEFINE_PROP_UINT64("wwn",  IDEDrive, dev.wwn, 0),   \
>      DEFINE_PROP_STRING("serial",  IDEDrive, dev.serial),\
>      DEFINE_PROP_STRING("model", IDEDrive, dev.model)
> =20
> diff --git a/include/hw/block/block.h b/include/hw/block/block.h
> index 607539057a..fd55a30bca 100644
> --- a/include/hw/block/block.h
> +++ b/include/hw/block/block.h
> @@ -50,21 +50,21 @@ static inline unsigned int get_physical_block_exp(B=
lockConf *conf)
>                            _conf.logical_block_size),                  =
  \
>      DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,              =
  \
>                            _conf.physical_block_size),                 =
  \
> -    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  =
\
> +    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),  =
  \
>      DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),  =
  \
> -    DEFINE_PROP_UINT32("discard_granularity", _state, \
> -                       _conf.discard_granularity, -1), \
> -    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce, \
> -                            ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_UINT32("discard_granularity", _state,                 =
  \
> +                       _conf.discard_granularity, -1),                =
  \
> +    DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,         =
  \
> +                            ON_OFF_AUTO_AUTO),                        =
  \
>      DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
> =20
>  #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                        =
  \
>      DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                    =
  \
>      DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
> =20
> -#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
> -    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
> -    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
> +#define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)                    =
  \
> +    DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),                =
  \
> +    DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0),              =
  \
>      DEFINE_PROP_UINT32("secs", _state, _conf.secs, 0)
> =20
>  #define DEFINE_BLOCK_ERROR_PROPERTIES(_state, _conf)                  =
  \
>=20

