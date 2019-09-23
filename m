Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBA5C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD58207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsCK3Ec0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD58207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCPVk-0005NE-O2
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iCPTx-0003hu-8C
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iCPTt-0004tw-KD
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60947
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iCPTq-0004s3-LU
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569249501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=tJzlvEapAHdOw1LQNxEKhPz2DZGJnHM7r9dOy1HLRcs=;
 b=ZsCK3Ec03hzMZxWU4EN8E1jBGHJ5xu6t3TXlv9K9R3xfg/VD+Cj3bA2m3xLpX259uPvaQv
 C4adTqMZ+wX7nQToD8sMkE3iG+FIQQUapwtNIcHWQ1i0V0gp04Ol2p8+69JgkoZPRvnEIe
 0K5Q2FOWY/f8P8t0w7AM3ftT4PEuaaA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-iy1ST_k9NESIMKWfrh1eCQ-1; Mon, 23 Sep 2019 10:38:20 -0400
Received: by mail-wm1-f72.google.com with SMTP id k184so6815947wmk.1
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BXih5y6YqThKi1akRs7yXlXWhX/uFbiPfVomIjBcT/4=;
 b=HqqPGrbJldFVkas7tmnuiMqXK2owy5NjC6389oTTt2q6IfnYMPDZOzqlLhCXz/ECCb
 n2DTiMXgetyQsTzNkZsxU17OCwJO8lZpaQuwy7nT+SBrypKkKqMLIBmHQG5b3DcXxZ7b
 EZZcJXOn6YRui6GYppgpNSTCe9qqDhn4uqDxDuXAwQgS/rMYVOAbOmC3wFKsbSgl47uN
 ozT83XFKyPGT+fOQuYt5tK3PmMItcQ7vmCRpLSdVRg7Jucj8nhjoOP1YdbEkoyNeHB4/
 RhyYWVZCyeXCebH8XmwDV8j1mLthLH6zGYho4dKgMJCnXRgsD3+4eozkR3r6jUyXr7kV
 WE3A==
X-Gm-Message-State: APjAAAWwIdMQlWBBKeRZ2vrrI9/vPqBwKTYEBVCbp+Avf67s64ead9cQ
 As+SVw+dOYvGsKEWv60E6+6CMsk4rYk68Gc4s18vLoA0ut7pYWkeZbDfIRKnc8oWVz0nwPrcQeQ
 AsQ3q3EcZN/fP+zE=
X-Received: by 2002:a5d:6242:: with SMTP id m2mr20880227wrv.261.1569249499167; 
 Mon, 23 Sep 2019 07:38:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz9rqoSoW7AcbCHZjKAi1mItpNXN85Xdv7lyuNA1IczOg/m/tFvdoNDCFmQszW8wyHI8yVjcw==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr20880206wrv.261.1569249498948; 
 Mon, 23 Sep 2019 07:38:18 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id u10sm17360638wrg.55.2019.09.23.07.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2019 07:38:18 -0700 (PDT)
Subject: Re: illegal hardware instruction during MIPS-I ELF linux user
 emulation
To: Libo Zhou <zhlb29@foxmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
Date: Mon, 23 Sep 2019 16:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
Content-Language: en-US
X-MC-Unique: iy1ST_k9NESIMKWfrh1eCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Libo,

On 9/23/19 10:15 AM, Libo Zhou wrote:
> Hi all,
>=20
> I have an binary file generated by a cross compiler. The 'file' command s=
ays
>=20
> $ file test
> test: ELF 32-bit LSB LSB executable, MIPS, MIPS-I version 1 (SYSV), stati=
cally linked, with debug_info, not stripped.

If you look at the mips_defs[] array in
target/mips/translate_init.inc.c, the older ISA implemented is MIPS-II:

$ git grep .insn_flags target/mips/translate_init.inc.c
translate_init.inc.c:75:        .insn_flags =3D CPU_MIPS32,
translate_init.inc.c:97:        .insn_flags =3D CPU_MIPS32 | ASE_MIPS16,
translate_init.inc.c:117:        .insn_flags =3D CPU_MIPS32,
translate_init.inc.c:137:        .insn_flags =3D CPU_MIPS32 | ASE_MIPS16,
translate_init.inc.c:158:        .insn_flags =3D CPU_MIPS32R2,
translate_init.inc.c:179:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16,
translate_init.inc.c:201:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16,
translate_init.inc.c:223:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16
| ASE_DSP,
translate_init.inc.c:249:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16,
translate_init.inc.c:297:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16
| ASE_DSP | ASE_MT,
translate_init.inc.c:323:        .insn_flags =3D CPU_MIPS32R2 | ASE_MIPS16
| ASE_DSP | ASE_DSP_R2,
translate_init.inc.c:343:        .insn_flags =3D CPU_MIPS32R2 | ASE_MICROMI=
PS,
translate_init.inc.c:364:        .insn_flags =3D CPU_MIPS32R2 | ASE_MICROMI=
PS,
translate_init.inc.c:410:        .insn_flags =3D CPU_MIPS32R5 | ASE_MSA,
translate_init.inc.c:449:        .insn_flags =3D CPU_MIPS32R6 | ASE_MICROMI=
PS,
translate_init.inc.c:488:        .insn_flags =3D CPU_NANOMIPS32 | ASE_DSP
| ASE_DSP_R2 | ASE_DSP_R3 |
translate_init.inc.c:511:        .insn_flags =3D CPU_MIPS3,
translate_init.inc.c:531:        .insn_flags =3D CPU_VR54XX,
translate_init.inc.c:552:        .insn_flags =3D CPU_MIPS64,
translate_init.inc.c:578:        .insn_flags =3D CPU_MIPS64,
translate_init.inc.c:607:        .insn_flags =3D CPU_MIPS64 | ASE_MIPS3D,
translate_init.inc.c:636:        .insn_flags =3D CPU_MIPS64R2 | ASE_MIPS3D,
translate_init.inc.c:657:        .insn_flags =3D CPU_MIPS64R2,
translate_init.inc.c:681:        .insn_flags =3D CPU_MIPS64R2,
translate_init.inc.c:721:        .insn_flags =3D CPU_MIPS64R6 | ASE_MSA,
translate_init.inc.c:761:        .insn_flags =3D CPU_MIPS64R6 | ASE_MSA,
translate_init.inc.c:781:        .insn_flags =3D CPU_LOONGSON2E,
translate_init.inc.c:801:        .insn_flags =3D CPU_LOONGSON2F,
translate_init.inc.c:830:        .insn_flags =3D CPU_MIPS64R2 | ASE_DSP |
ASE_DSP_R2,

So currently there is no MIPS-I only CPU.
Note that the code got written with MIPS32 in mind, and implementing
MIPS-I requires a considerable amount of change in the codebase.

> When I executed it with
>=20
> $./qemu-mipsel test
> qemu: uncaught target signal 4 (Illegal instruction) - core dumped
> [1] 11088 illegal hardware instruction (core dumped) ./qemu-mipsel test

You can try ./qemu-mipsel -d in_asm,int test to display debugging
information, you might see which instruction trapped.

IMO it is likely the RFE (Return from Exception) instruction.

Regards,

Phil.

> However, when I use another cross compiler that generates MIPS32 rel2 bin=
aries, it worked fine.
>=20
> Can anyone tell me what's going wrong?
>=20
> Cheers,
> Libo Zhou
>=20


