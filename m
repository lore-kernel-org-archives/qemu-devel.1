Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB37C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E202468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 09:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOsNvZ0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E202468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isk4Y-0005ab-2a
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 04:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isk3q-00053u-QD
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:06:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isk3o-0002be-Sv
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:06:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isk3o-0002aw-Of
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 04:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579338387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9grBksCdiZbl/XMAPOh0nj+GwsDnMnJJzNB9IiKqeM=;
 b=AOsNvZ0ykDkeP5mYtE25bqoBliV10EEpFNbKkLhQG9dUMJnA017ODl8yEfzmvqt7+zmvYT
 0k3vdv1NdstR8QhaU+lXF2EaCImkSGRE+W9+0dXKdBwqlBOtMsqtHVO8qssNl5aiE2iz4i
 9ExM4q6Js2Bu4FyuumUQSmHCgBbl5+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Pf4N26kxOMigEBkZeNFCpQ-1; Sat, 18 Jan 2020 04:06:26 -0500
Received: by mail-wr1-f70.google.com with SMTP id b13so11508737wrx.22
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 01:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GcT0DegigFwiZ69V42qbjHs3PQy1tdSqLiTo7CzqPGk=;
 b=jCAGhJtsdddeOm8R3hVuGXcHDBTASINYvgzBe7aBqxPsQk2DviXyelpaeP55winqSq
 8snz4TwWNq4OvHmOWqrJkMXkncNVLLBnx4q9srp0oLrSsaHa2yUcZqoH6m1ymHMYHM6S
 mSNuxbKWYRf6zT1rVh+YhBu+nUvhvQHfIl+qve/Eh3EA2PSVsaHJWLM2viy74q2rxzp8
 WQIRCQdWcpzuYX6/INEgyY7d4gDuZdZSzWJu8LfxxX327p3aqsVU6JwEKjtdne2eLXic
 HtpFYT2zgHzJtzyXz9frf6a7N7WC2iu2VTdfYNhrheg7whjNMdWFfh3I/WSm1yd005am
 qILw==
X-Gm-Message-State: APjAAAUqm1aeNL+ITpz/evS9d+7OLj9pW4NYSgVMN7nr1+3KHwDddN/9
 lvt6DjhlEjrNptcnKFAISD71JipWea5cyHdyEvTQEX51kBvLvxgvpRjLs+lkmVX3kySn9SWa2fF
 yKTV5QSix9A1BoeU=
X-Received: by 2002:adf:f604:: with SMTP id t4mr7020024wrp.33.1579338385129;
 Sat, 18 Jan 2020 01:06:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaAK0YebZaRH9QHue1b3LJ4MqwI5IZt3CMXaPkhctKJQ5mdvCnzNQb71FwsUjtwJZop+f4kQ==
X-Received: by 2002:adf:f604:: with SMTP id t4mr7019991wrp.33.1579338384773;
 Sat, 18 Jan 2020 01:06:24 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id h2sm38466419wrv.66.2020.01.18.01.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 01:06:23 -0800 (PST)
Subject: Re: [PATCH v3 06/17] hw/arm/allwinner: add CPU Configuration module
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-7-nieklinnenbank@gmail.com>
 <8bbf88b2-867a-c95d-a3ae-e819f7dd08ac@redhat.com>
 <CAPan3Wo3Li4XZJqHhhk5fnY_PnzGZ8YwUwCud8Ge4Z_+BOwW1w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5760dae5-f7cc-5736-7275-e6461f985dbd@redhat.com>
Date: Sat, 18 Jan 2020 10:06:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Wo3Li4XZJqHhhk5fnY_PnzGZ8YwUwCud8Ge4Z_+BOwW1w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Pf4N26kxOMigEBkZeNFCpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/15/20 12:04 AM, Niek Linnenbank wrote:
> On Tue, Jan 14, 2020 at 12:14 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 1/8/20 9:00 PM, Niek Linnenbank wrote:
>      > Various Allwinner System on Chip designs contain multiple processo=
rs
>      > that can be configured and reset using the generic CPU Configurati=
on
>      > module interface. This commit adds support for the Allwinner CPU
>      > configuration interface which emulates the following features:
>      >
>      >=C2=A0 =C2=A0* CPU reset
>      >=C2=A0 =C2=A0* CPU status
>      >=C2=A0 =C2=A0* Shared 64-bit timer
>      >
[...]
>      > +=C2=A0 =C2=A0 case REG_CPU0_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* CPU#0 Control */
>      > +=C2=A0 =C2=A0 case REG_CPU1_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* CPU#1 Control */
>      > +=C2=A0 =C2=A0 case REG_CPU2_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* CPU#2 Control */
>      > +=C2=A0 =C2=A0 case REG_CPU3_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* CPU#3 Control */
>      > +=C2=A0 =C2=A0 case REG_CPU0_STATUS:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
CPU#0 Status */
>      > +=C2=A0 =C2=A0 case REG_CPU1_STATUS:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
CPU#1 Status */
>      > +=C2=A0 =C2=A0 case REG_CPU2_STATUS:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
CPU#2 Status */
>      > +=C2=A0 =C2=A0 case REG_CPU3_STATUS:=C2=A0 =C2=A0 =C2=A0 =C2=A0/* =
CPU#3 Status */
>      > +=C2=A0 =C2=A0 case REG_CLK_GATING:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
CPU Clock Gating */
>      > +=C2=A0 =C2=A0 case REG_GEN_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* General Control */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->gen_ctrl =3D val;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_SUPER_STANDBY:=C2=A0 =C2=A0 =C2=A0/* Super=
 Standby Flag */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->super_standby =3D val;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_ENTRY_ADDR:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
Reset Entry Address */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->entry_addr =3D val;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_DBG_EXTERN:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
Debug External */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_CNT64_CTRL:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
64-bit Counter Control */
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s->counter_ctrl =3D val;
>      > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>      > +=C2=A0 =C2=A0 case REG_CNT64_LOW:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/* 64-bit Counter Low */
>      > +=C2=A0 =C2=A0 case REG_CNT64_HIGH:=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
64-bit Counter High */
>=20
>     You forgot to set these. Maybe you can add a int64_t cnt64_diff, set =
it
>     here to the difference with qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), an=
d
>     in the read() function return cnt64_diff +
>     qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL).
>=20
> OK I'll need to look into that. Currently this timer is not used by=20
> Linux, NetBSD or U-Boot as far
> as I know. But since it is there, it should be correct indeed.

You might reduce this patch by simply using LOG_UNIMP for these=20
registers. Than add the patch when you find some use.

We are more confident when reviewing code when we have a way to test it :)


