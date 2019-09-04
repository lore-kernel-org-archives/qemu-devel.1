Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10658C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C4722CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C4722CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VVZ-0005bK-BJ
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5V6F-00058L-RP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5V6E-0007XY-4o
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:13:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5V6D-0007Wz-To
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:13:26 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C72D641C2
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 13:13:24 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id g2so757826wmk.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 06:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=34lGvCBEes50QxProvXYAUO/YjszUbBzHY34WbUGDnk=;
 b=ewm0y7udmWj56k65+5b02/hPHfgbMckpVDXMB/MZMLL4MHE9/aEdx6Iu9Dl2cWWzl7
 +F/di6I9W9CrUOisxSnbrkcFV8e+i0eHG5QQxc01426JRg56gu+3re3HxSAtG37Skk82
 c4bdl+iF+2Jo6RgVlFKEkn06+HBwJ+C5d/b3oXbXo1z7tI4kRYqKfc28WyYnpgZLB1Nt
 pFsrr+UUYU8leWzd8RJTY1oad+oczMIiM6gU4Yp3D+yW3H3NgoVZpK6Bw8rbKzvlSPI/
 nyz1XnObceuswKH5ZsS2nXu7aH4ennLzr19K5UScXzWVp1rJsIiuXuAF3enjC66g0hJC
 PmGA==
X-Gm-Message-State: APjAAAVdDE6tnJDZWxka4QSuajh+zkXGmu554Hz7K/eRfAK+lWHAfk+q
 VIdkpoKKT81gZiKdqeIMk2D5pXYoSMrV9htUkh0l8NYlGnK+/dKtZPveJBhRwvx+TeGY4KGnebH
 QS6CmJeOkDj2BmT0=
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr5690530wrx.309.1567602802804; 
 Wed, 04 Sep 2019 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbM/6Fj1XFOJ/hGtyuMZMSZ+OvXwv4mW1sIDB01ZjQ4dhT5ovxra4WeuoLHjCOaVH1HZmKAQ==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr5690515wrx.309.1567602802637; 
 Wed, 04 Sep 2019 06:13:22 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id q26sm3148719wmf.45.2019.09.04.06.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2019 06:13:22 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190903153633.6651-1-peter.maydell@linaro.org>
 <20190903153633.6651-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <eebc49ff-47a8-368d-f10f-8f5c1fef1060@redhat.com>
Date: Wed, 4 Sep 2019 15:13:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190903153633.6651-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 12/21] hw/arm: Use sysbus_init_child_obj for
 correct reference counting
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

On 9/3/19 5:36 PM, Peter Maydell wrote:
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Both object_initialize() and qdev_set_parent_bus() increase the
> reference counter of the new object, so one of the references has
> to be dropped afterwards to get the reference counting right.
> In machine model code this refcount leak is not particularly
> problematic because (unlike devices) machines will never be
> created on demand via QMP, and they are never destroyed.
> But in any case let's use the new sysbus_init_child_obj() instead
> to get the reference counting here right.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20190823143249.8096-4-philmd@redhat.com
> [PMM: rewrote commit message]

Thank you very much Peter!

> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/exynos4_boards.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index f69358a5ba8..2781d8bd419 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -131,8 +131,8 @@ exynos4_boards_init_common(MachineState *machine,
>      exynos4_boards_init_ram(s, get_system_memory(),
>                              exynos4_board_ram_size[board_type]);
> =20
> -    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
> -    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
> +    sysbus_init_child_obj(OBJECT(machine), "soc",
> +                          &s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC=
);
>      object_property_set_bool(OBJECT(&s->soc), true, "realized",
>                               &error_fatal);

