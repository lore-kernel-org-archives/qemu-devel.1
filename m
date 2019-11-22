Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDACC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB3820715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUkDW6Is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB3820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6Tg-00082Q-63
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:47:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6Si-0007bD-Sx
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:46:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6Sf-000621-BF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:46:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24597
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6Sc-0005vi-DK
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574419604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PBGOqxRMMKFtpMt2IQdGSHuRbpmhEI9IR0q8vkgkVGU=;
 b=VUkDW6Is0NLpSGnJj92OEvEGqWlrLJXko7TuFk2AhW3FloEiuHytQ3DSdyDvqsER/GeiWu
 teQmCWCc6n01VP2Aj9JoDI0VhA8SlR9PiHjOgVVwedFAlkT3SCMmuHNepSFGwzZ8jbv282
 Qb/B3hD+WsWlGNXjTRQAjyVqbZwvAcY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-xs51MUKiO_uVpLiboe0xbQ-1; Fri, 22 Nov 2019 05:46:41 -0500
Received: by mail-wm1-f70.google.com with SMTP id 199so3262581wmb.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rL+zCNHExavyfeoiAmJnJhyGrgCkSmuLhMk+e3/aZdI=;
 b=IeWp/0WHB/tlmnE78XLOcxpg9NS5mvBqrxzG83hYn2LbfB9n+UKfeMA4gELRHD9QFT
 FMO0SSYDfr/tJnlrVpLZCsalTv4aVPYEImqTfxxdIJlhkM7q5PgX4wH8R77ADy2xKF5L
 Z+TinAmGfocOwfqzSinseDaeg+IMXUIEB78TlB3XBhDI5GPfQbQ2yO1cpJDrINDloi84
 i+cJkPWlP/Wu/SStK58Lx5PCInIe1w9zy1JW+VcImOSWxQwXod+qGmqiUsyz/JAFzpSh
 2bHyAwGClOrXeqHmmvfy61WGGZAtqscEGNS32OYEht08Jfelp5zCFgccfSxqDFLMhazj
 MEKQ==
X-Gm-Message-State: APjAAAWDVF0FCaAFy3/SLm4WOcOf42yWaW70iBMOKkln7ZT1U/h4qe1i
 O3S1Nx8gSdXZAmme/BDpuX4EvENg3JIYXgqJz9E0Aed44x0Lo9VMxuB+X4AJx4WctxhaCRiGoMa
 r3e1BwCY1xgWqDlA=
X-Received: by 2002:a1c:e08a:: with SMTP id
 x132mr15924311wmg.146.1574419599991; 
 Fri, 22 Nov 2019 02:46:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAvzwRU++GH7DVPOpVu1VlWsgF/kvXNdp4d/QDWSC234UXyU8DHy3T40RY8JcNlAmCmtMv1A==
X-Received: by 2002:a1c:e08a:: with SMTP id
 x132mr15924285wmg.146.1574419599760; 
 Fri, 22 Nov 2019 02:46:39 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id r2sm6007921wrm.71.2019.11.22.02.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:46:39 -0800 (PST)
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAK4993gtPkqESswLBoo1cMuvJFzwSVgUP=Oh-hpG2JSTKezjmw@mail.gmail.com>
 <CAK4993iFuC3LTzkwjAx7uKA18jh-zOo5aYx2+1ugc9fw8UPtYg@mail.gmail.com>
 <e1fedeff-3eab-f215-a376-334417f5bf53@linaro.org>
 <CAL1e-=hKepMcesqsOwxp_HSRO9mvF6V6k4TAoVn5kcmb=20FQg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <88d92b88-d72e-8e7a-01ec-522ab07d10f0@redhat.com>
Date: Fri, 22 Nov 2019 11:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hKepMcesqsOwxp_HSRO9mvF6V6k4TAoVn5kcmb=20FQg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: xs51MUKiO_uVpLiboe0xbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>, Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael,

On 11/22/19 9:43 AM, Aleksandar Markovic wrote:
> On Friday, November 22, 2019, Richard Henderson=20
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> wrot=
e:
>=20
>     On 11/21/19 8:53 PM, Michael Rolnik wrote:
>      > It seems to be a huge investment. this function should parse the
>      > binary data as `decode_insn` does, so I suggest to modify decodetr=
ee
>      > tool to make decoding information available to the instruction pri=
nt
>      > function.
>      > what do you think?
>=20
>     See target/openrisc/disas.c, which makes use of decodetree.
>     It shouldn't be difficult to do something slimiar for avr.
>=20
>=20
> I support Richard's suggested direction. Since you already implemenred=20
> core AVR decoder using decodetree, and you have this openrisc QEMU=20
> disassembler example, could you perhaps give a try to what Richard said,=
=20
> Michael?

As Aleksandar commented elsewhere in this thread, the port is useful as=20
it, and having the disas output is a feature request.

If you have time to look at it before 5.0 development window opens, I'll=20
be pleased to review and test it. Anyway I won't object we merge your=20
work because this is missing.

Regards,

Phil.


