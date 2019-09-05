Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF0BC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C952173B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C952173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5pPu-00058w-Bx
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5pP9-0004b8-0d
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:54:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5pP7-0007wl-Sy
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:54:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5pP7-0007wU-Lw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:54:17 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B85117BDA9
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 10:54:16 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id g2so332714wmk.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9OBKhYZVAKZ9enmCZl2DGXC9sidzhQsl+qMJfNoHVh0=;
 b=uT2B+WZh9Ie7TRj5V9OzAE0zMA6IGKnyRJ2uMY/xJEsA0lRLn1G3btwu/WDWUzB+aB
 tziMTC7TwmqEH9aWXXVRIGZJHNF+VT58cEkvEMIUBM7taR924JoP6gbA9AJms+AMOP3i
 0iWyyB9NPZAVt6YACKlJpXG8APNRJLKqZAEvbJSSiioNgETancLAaBEA1c8LvEGrCPTf
 nUD2Nt1HnuH5vQLxOoYuhC1zzKIHKAPWuS+TDmAmok+oQtaLLgrvHtNP9oT2/wPNEXw9
 VE5MgmSyaYgs6GeIHmIvMNc9EeMEOQhqzutDXXkWLG4Ddo9AwFNduC1bF5gbbpomE0Xy
 jAFQ==
X-Gm-Message-State: APjAAAWP286noycFamhPc81dmeMhVrTUCuRbVliVyOXcQOP9A7yyD2z4
 3ta3RAJjXUoLJuRxlz+CdPUd93UNUDyADb6Q0o98pRqJ+JbSpCTlAdajqPG5JwJZTyL221dhod3
 1kes6puhe2GKs91I=
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr2533331wmj.58.1567680855085;
 Thu, 05 Sep 2019 03:54:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEQmMrzVTU7FTSe5rrgaPvKKkELqRO8qOnhzpaFXMtES6064lWpEsJDWpupTujQ0h7u/KpxA==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr2533318wmj.58.1567680854901;
 Thu, 05 Sep 2019 03:54:14 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e15sm1372067wru.93.2019.09.05.03.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:54:14 -0700 (PDT)
To: Josh Kunz <jkz@google.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190816233422.16715-1-jkz@google.com>
 <5b4df64c-40e4-70cd-753e-f52e2b547c18@vivier.eu>
 <CADgy-2tzD0FVXbKtadSL1JuMWW_TEzFP2ZD0hzA4PUnxh1Xz0g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <fe428dbd-a9f4-42c0-bb12-8c14fb3e2489@redhat.com>
Date: Thu, 5 Sep 2019 12:54:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CADgy-2tzD0FVXbKtadSL1JuMWW_TEzFP2ZD0hzA4PUnxh1Xz0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support gdb 'qOffsets' query
 for ELF
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
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Alex.

On 9/3/19 9:19 PM, Josh Kunz via Qemu-devel wrote:
> The `Data` and `Code` flags in `qOffsets` are actually section offsets
> rather than segment offsets. GDB relocates the symbols in those section=
s
> relative to their location in the binary. So we have to use `load_bias`=
.
>=20
> See here for a more detailed description:
> https://sourceware.org/gdb/onlinedocs/gdb/General-Query-Packets.html#Ge=
neral-Query-Packets

Maybe we can amend a reference to
http://sourceware.org/gdb/onlinedocs/gdb/General-Query-Packets.html#index=
-qOffsets-packet
in the commit.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> On Mon, Aug 26, 2019 at 1:29 AM Laurent Vivier <laurent@vivier.eu> wrot=
e:
>=20
>> Le 17/08/2019 =C3=A0 01:34, Josh Kunz via Qemu-devel a =C3=A9crit :
>>> This is needed to support debugging PIE ELF binaries running under QE=
MU
>>> user mode. Currently, `code_offset` and `data_offset` remain unset fo=
r
>>> all ELF binaries, so GDB is unable to correctly locate the position o=
f
>>> the binary's text and data.
>>>
>>> The fields `code_offset`, and `data_offset` were originally added way
>>> back in 2006 to support debugging of bFMT executables (978efd6aac6),
>>> and support was just never added for ELF. Since non-PIE binaries are
>>> loaded at exactly the address specified in the binary, GDB does not n=
eed
>>> to relocate any symbols, so the buggy behavior is not normally observ=
ed.
>>>
>>> Buglink: https://bugs.launchpad.net/qemu/+bug/1528239
>>> Signed-off-by: Josh Kunz <jkz@google.com>
>>> ---
>>>  linux-user/elfload.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> As it seems they are text and data segment offsets, why it's not based
>> on info->start_code and info->start_data?
>>
>> Thanks,
>> Laurent
>>

