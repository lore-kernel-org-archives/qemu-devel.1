Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A8AC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C24F920866
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpYlYY6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24F920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEne-00039d-QU
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:18:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEXA-0001TG-4z
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEX8-0004dQ-Qv
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:01:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEX8-0004bo-Lg
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=joKcrZqse/2rI2WBzidhVM6HneRljCD0MWlkHrQCOPM=;
 b=JpYlYY6GRr4O0aBKfZh5xMh4bbcZqDw4STW6G34dRxb9pxZk+AL18Fs6ADiuyMhTvTGksy
 K/Vsyq+z6LG8DVY85o5/g4tYqvuFbK5mj0W3uF+riFG4gYL8JC5SjddIn9prLEzMBP/WV1
 qWPSghjMVN8rpWnX3zzKVMY8VZNjpCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-4COBcRMUPGGefyLNNGFApw-1; Sat, 14 Dec 2019 08:59:54 -0500
Received: by mail-wr1-f72.google.com with SMTP id f10so1017207wro.14
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 05:59:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8ablovXuvhNSxsWx83+/G5FRg33eclyz++hORIZtpqw=;
 b=ZRTmp2qKeQKwjworT9cR1nkp8rjyk85RIJwvIN3wdsitv5HPfzMyGGKmXSTMgtxABu
 m2fsY0ashKCx4L79+G2PkZMa/If7btSrYdIfus5QCv1DbTM8PIuLMcdBoZ09kKby1KvX
 Wt9R9aQcNXapV4kRNlm3iUA5675fujNThKs7aqQsnlYZt3KsuYbwgEpTSAdEsYOvmLMb
 0CC9nFwfcFyFEkLfTkRV4BI23PEEF+zwcMDnom+nj51cAnbHLRpLe0CVSQOqKiyQdf0v
 UarnO0DgrYpxL2EXae5J5ndwW0AwOdpyLdape2CMfqgF174Z11g63xBzqbx63Bogea0F
 81Ag==
X-Gm-Message-State: APjAAAVAE1vpxzM88pG11KbJVJGsE3AvyTv8VoQE8m+jtmbONmPIF8c0
 Pq0uFPgp01HCKX5YlnFL7GiUX6QcwcaZK8RgfaZJCWncPINRXFr1ATRMkF/bhEQ6KwLv1NnMhM1
 pB8Ro0dWWSHm5lE4=
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr19359950wmc.63.1576331993073; 
 Sat, 14 Dec 2019 05:59:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrx5HZOidI8oSBXFDAPClc+5D4C097hsRHKYDeM6nDsPjp5XZzhTAKSDZLvYNqNkzmNjJtHw==
X-Received: by 2002:a05:600c:54b:: with SMTP id
 k11mr19359939wmc.63.1576331992865; 
 Sat, 14 Dec 2019 05:59:52 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u10sm13781029wmd.1.2019.12.14.05.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 05:59:52 -0800 (PST)
Subject: Re: [PATCH 09/10] arm: allwinner-h3: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-10-nieklinnenbank@gmail.com>
 <CAPan3WrRKnu5vFz=JvrnD8tewUk7SdwFVYx4xVL353AnfPDgHQ@mail.gmail.com>
 <6bee15d7-7d80-0709-ac90-ef2052b39329@redhat.com>
 <CAPan3Woq_EJAE6s-N5dAApAgzexGr4M-OtFkiHuMN_Xp=8_bTQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <457e0620-c11e-8e5a-df1c-93f95f52eda8@redhat.com>
Date: Sat, 14 Dec 2019 14:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPan3Woq_EJAE6s-N5dAApAgzexGr4M-OtFkiHuMN_Xp=8_bTQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 4COBcRMUPGGefyLNNGFApw-1
X-Mimecast-Spam-Score: 0
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/13/19 10:00 PM, Niek Linnenbank wrote:
> On Fri, Dec 13, 2019 at 12:56 AM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Niek,
>=20
>     On 12/11/19 11:34 PM, Niek Linnenbank wrote:
>      > Ping!
>      >
>      > Anyone would like to comment on this driver?
>      >
>      > I finished the rework on all previous comments in this series.
>      >
>      > Currently debugging the hflags error reported by Philippe.
>      > After that, I'm ready to send out v2 of these patches.
>      >
>      > Regards,
>      > Niek
>      >
>      > On Mon, Dec 2, 2019 at 10:10 PM Niek Linnenbank
>      > <nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>
>     <mailto:nieklinnenbank@gmail.com <mailto:nieklinnenbank@gmail.com>>>
>     wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0The Allwinner H3 System on Chip contains an int=
egrated storage
>      >=C2=A0 =C2=A0 =C2=A0controller for Secure Digital (SD) and Multi Me=
dia Card (MMC)
>      >=C2=A0 =C2=A0 =C2=A0interfaces. This commit adds support for the Al=
lwinner H3
>      >=C2=A0 =C2=A0 =C2=A0SD/MMC storage controller with the following em=
ulated features:
>      >
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0* DMA transfers
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0* Direct FIFO I/O
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0* Short/Long format command responses
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0* Auto-Stop command (CMD12)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0* Insert & remove card detection
>      >
>      >=C2=A0 =C2=A0 =C2=A0Signed-off-by: Niek Linnenbank <nieklinnenbank@=
gmail.com
>     <mailto:nieklinnenbank@gmail.com>
>      >=C2=A0 =C2=A0 =C2=A0<mailto:nieklinnenbank@gmail.com
>     <mailto:nieklinnenbank@gmail.com>>>
>      >=C2=A0 =C2=A0 =C2=A0---
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/allwinner-h3-sdhost.c=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 791
>     ++++++++++++++++++++++++++++
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A07 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0include/hw/sd/allwinner-h3-sdhost.h |=C2=
=A0 73 +++
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A07 files changed, 911 insertions(+)
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 hw/sd/allwinner-h3-sd=
host.c
>      >=C2=A0 =C2=A0 =C2=A0 =C2=A0create mode 100644 include/hw/sd/allwinn=
er-h3-sdhost.h
[...]
> Thanks again for all of your helpful comments Philippe!
> I've started to rework the patch.
>=20
> One question about adding tags in the commit message: should I
> already add 'Reviewed-by: ' when I re-send v2 of this patch? Or should
> that be added after you have seen the v2 changes?

You shouldn't add the Reviewed-by tag until explicitly given by the=20
reviewer. If the changes are trivial, it is easy to conditionally give=20
the tag such "If ... is done: R-b", "With ... fixed: R-b".

Since this is your first contribution, I have been more careful. Also=20
since your patch is already of very good quality, I'v been a bit picky=20
regarding few details.

Since there are too many comments, so I prefer to fully review the v2 of=20
this patch again.

Regards,

Phil.


