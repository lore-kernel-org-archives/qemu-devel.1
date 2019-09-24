Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F97C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC7820665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQpSYbtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC7820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmZ9-0003Ol-Hp
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iClRa-0000bx-HO
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iClRY-0003qQ-0Z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:05:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iClRX-0003pr-RT
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569333927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=qsZFkBCjAg4NRJpBDgNBqwAYIrBs9cL8UQCX2si23RE=;
 b=YQpSYbtLALT2reRAOTfU3RduiEu/GdPLP44YxspEX9pX1Zdy36m4aSt5gCclEJJSQb0cB9
 da9FuPFDxFvPp3D9/UFHTDmhTzzTzGn0VEKW2ZNIvxDqB5Fj5Tx6GvX6EoqxbfQFTND9La
 zzqklAuEUkY8BoBadEaDL5Y1/pdKjCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-vlRp2KULNrWb0BhM9Vmxjg-1; Tue, 24 Sep 2019 10:05:25 -0400
Received: by mail-wr1-f69.google.com with SMTP id j3so620365wrn.7
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SPLJnRLkroiJLQOvFWvOrYF8z/53F+MgKQSL9d4wxPk=;
 b=WgQTQ+rHLuxZTffJJjGXJKDgrKUvSKjNZwsmiNlUIAu3hRUzg+Ek4q5w0JgI90syI7
 RVtZSe/wb90Sp0WmcYYUS/c7gDx7YEptBEw4tr3J9cirTCLw6Vv66cI6BRD7HrzYpw7i
 Tcqg20jurAWA4k8aNHqf0zNb7UsMPblC87NE91qySvK4FSFaY95UX60C3ZSjCZJUVvrs
 V4iHX+8AOiFc5rHKpGMaWBiyPIKxsUimGWzih0+qPu+IAYU6gyc6xJf5tEg3bXo7GeDe
 1FtRH/SMs6XGxatir6HuGJYAFn4ZHiNz42MW9tMSEi2WvexY/OJyWINl+nzRRiUcsmmh
 pnKA==
X-Gm-Message-State: APjAAAXuz8y2jOEdDPWdLGETjy8ZYdNlHIY9kWk/TnU0rrTXfdpk8wHT
 LuSXpBbtsYIlxGWiLqlzXF1sP7gVIqF6BgZ0JXheUm33t2H4puoZOlTZUNU40VNz1EH/MRSQ5Cm
 n07YSEnHB3vmuZMs=
X-Received: by 2002:a5d:694e:: with SMTP id r14mr2458772wrw.34.1569333924759; 
 Tue, 24 Sep 2019 07:05:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzBwOmY8pOjEwJTG0GQU8tmcP9XUiJI3dCpuqjsVJH32z5rx2evgf7PoHPI0D1O73fzBbepjg==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr2458751wrw.34.1569333924579; 
 Tue, 24 Sep 2019 07:05:24 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f186sm126612wmg.21.2019.09.24.07.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Sep 2019 07:05:23 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] RTC support for QEMU RISC-V virt machine
To: Anup Patel <Anup.Patel@wdc.com>, Peter Maydell
 <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20190924131131.118155-1-anup.patel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <735d696e-f0dc-cad3-acc3-056cf152cc22@redhat.com>
Date: Tue, 24 Sep 2019 16:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190924131131.118155-1-anup.patel@wdc.com>
Content-Language: en-US
X-MC-Unique: vlRp2KULNrWb0BhM9Vmxjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Atish Patra <Atish.Patra@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Anup,

On 9/24/19 3:11 PM, Anup Patel wrote:
> This series adds RTC device to QEMU RISC-V virt machine. We have
> selected Goldfish RTC device model for this. It's a pretty simple
> synthetic device with few MMIO registers and no dependency external
> clock. The driver for Goldfish RTC is already available in Linux so
> we just need to enable it in Kconfig for RISCV and also update Linux
> defconfigs.
>=20
> We have tested this series with Linux-5.3 plus defconfig changes
> available in 'goldfish_rtc_v1' branch of:
> https://github.com/avpatel/linux.git
>=20
> Changes since v1:
>  - Removed redundant object properties from Goldfish RTC emulation
>  - Added vmstate for Goldfish RTC
>=20
> Anup Patel (2):
>   hw: timer: Add Goldfish RTC device
>   riscv: virt: Use Goldfish RTC device
>=20
>  hw/riscv/Kconfig                |   1 +
>  hw/riscv/virt.c                 |  15 ++
>  hw/timer/Kconfig                |   3 +
>  hw/timer/Makefile.objs          |   1 +
>  hw/timer/goldfish_rtc.c         | 278 ++++++++++++++++++++++++++++++++
>  include/hw/riscv/virt.h         |   2 +
>  include/hw/timer/goldfish_rtc.h |  46 ++++++

Minor comment, if my ongoing series "Split RTC devices from hw/timer/ to
hw/rtc/" is accepted, you'd have to rebase this in hw/rtc/goldfish_rtc:
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03334.html
(no logical change involved).

Regards,

Phil.


