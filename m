Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D5BC43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39C42070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf69QxNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39C42070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6sa-0004U1-4B
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6rp-0003cA-Up
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6ro-0007aK-PG
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21121
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6ro-0007Zt-LR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574421167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FG5sBghzYFrSCoZlOoXNEsywCD7gdBl2SdP4sinCkNc=;
 b=Nf69QxNbcGrQs2Z0X+u/MRk6kco/fsbT6Zav1IwvSox/uTsmAEzVFx8TRTLijSvc0K7gto
 FYl1xI015o7upDDTOdinoC7d+gW9islPwjKU4GpWFGgnOO4QkjPuPanztT+XOLPog9lEnc
 /nV31VrFNYZWpWMa4r3lzh/k5Va95w0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-cf7KXgzQMMOfVXTptrtxEA-1; Fri, 22 Nov 2019 06:12:44 -0500
Received: by mail-wr1-f69.google.com with SMTP id y1so3769950wrl.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g3TTn4evOyzAWWzKaQC+wx5+hzdgPfTVk8iX5k5KZQs=;
 b=XCWwGehaTx6p5GATUL6IllYeZDRWmLnSTe+/NDvY3AHVrK4kB1Vs/KXA8F5TtBJZh6
 MCCjVyL+z7PeuO+HvBCBcKx0hi22cUW3d9qs9x4znauNSpoVp7VPmVH0F75bMq2viKWv
 J3Y63rZRAXzMOMxiv6keOWVROzVp2IeSOeMsr2viptBiEWPGW+80omSM2rYlH96lN0Zr
 lIeOlADg0lHD35cSgu6ytJ/auvp9RgpupLe2WAlI4HwGYQQeb2Yl6EsTUsVogYmVbofp
 Y6NCTsxpm/Ivc1y4rMWA5iNQv2dL/xI0G21UeANIj/T8WsneE2XF0EDQUZsnQsKzNS+m
 xv3w==
X-Gm-Message-State: APjAAAVES+0pSy6CR5AqFe2XlKpC7DA7LoJfm5f9m3KqNg+fbgkmod1K
 CbunSUN6vYobgNqKyEEH1xumv034tVZzb/O29luRYHSO0seLOy80C4UAj6EvG2aqlcUN9pfHTjD
 bSY7okPdjgv2PI+U=
X-Received: by 2002:a1c:558a:: with SMTP id j132mr15609809wmb.21.1574421163623; 
 Fri, 22 Nov 2019 03:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjNeI8M4nluuEnODEj1WmEP7COVG7O8wwMMkUsz9ZKU0W6+ePvihkjujmMa/UxbNR6RurM4w==
X-Received: by 2002:a1c:558a:: with SMTP id j132mr15609792wmb.21.1574421163420; 
 Fri, 22 Nov 2019 03:12:43 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id q25sm7376876wra.3.2019.11.22.03.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:12:42 -0800 (PST)
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
 <CAK4993iFuC3LTzkwjAx7uKA18jh-zOo5aYx2+1ugc9fw8UPtYg@mail.gmail.com>
 <e1fedeff-3eab-f215-a376-334417f5bf53@linaro.org>
 <CAL1e-=hKepMcesqsOwxp_HSRO9mvF6V6k4TAoVn5kcmb=20FQg@mail.gmail.com>
 <88d92b88-d72e-8e7a-01ec-522ab07d10f0@redhat.com>
 <CAK4993gbHSmUxSKfXta3zfghXU7zwNcRMGisHY_13G_OydZ-Qw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7dc5d266-c615-a73d-974f-21d474cd4193@redhat.com>
Date: Fri, 22 Nov 2019 12:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK4993gbHSmUxSKfXta3zfghXU7zwNcRMGisHY_13G_OydZ-Qw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: cf7KXgzQMMOfVXTptrtxEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 11:54 AM, Michael Rolnik wrote:
> Hi all.
>=20
> Once implemented, how to invoke this function?

I'm testing your series with:

qemu-system-avr -kernel ~/Downloads/ATmegaBOOT.elf -d in_asm,unimp

The '-d in_asm' enable dumping the assembler instructions translated.

> Sent from my cell phone, please ignore typos
>=20
> On Fri, Nov 22, 2019, 12:46 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     Hi Michael,
>=20
>     On 11/22/19 9:43 AM, Aleksandar Markovic wrote:
>      > On Friday, November 22, 2019, Richard Henderson
>      > <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>
>     <mailto:richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>> wrote:
>      >
>      >=C2=A0 =C2=A0 =C2=A0On 11/21/19 8:53 PM, Michael Rolnik wrote:
>      >=C2=A0 =C2=A0 =C2=A0 > It seems to be a huge investment. this funct=
ion should
>     parse the
>      >=C2=A0 =C2=A0 =C2=A0 > binary data as `decode_insn` does, so I sugg=
est to modify
>     decodetree
>      >=C2=A0 =C2=A0 =C2=A0 > tool to make decoding information available =
to the
>     instruction print
>      >=C2=A0 =C2=A0 =C2=A0 > function.
>      >=C2=A0 =C2=A0 =C2=A0 > what do you think?
>      >
>      >=C2=A0 =C2=A0 =C2=A0See target/openrisc/disas.c, which makes use of=
 decodetree.
>      >=C2=A0 =C2=A0 =C2=A0It shouldn't be difficult to do something slimi=
ar for avr.
>      >
>      >
>      > I support Richard's suggested direction. Since you already
>     implemenred
>      > core AVR decoder using decodetree, and you have this openrisc QEMU
>      > disassembler example, could you perhaps give a try to what
>     Richard said,
>      > Michael?
>=20
>     As Aleksandar commented elsewhere in this thread, the port is useful =
as
>     it, and having the disas output is a feature request.
>=20
>     If you have time to look at it before 5.0 development window opens,
>     I'll
>     be pleased to review and test it. Anyway I won't object we merge your
>     work because this is missing.
>=20
>     Regards,
>=20
>     Phil.
>=20


