Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B5C11D0C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC4A22467A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 18:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5cOmu9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC4A22467A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4r0P-0003c9-TD
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 13:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4qzn-0003Ah-Cg
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4qzm-0000kR-BW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:56:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4qzm-0000k6-7t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 13:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582224981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iT5jnh/RGs2ZGHgycpWLwzHDAEekyLVNBki5EoWb+fY=;
 b=c5cOmu9V2oXIPXMGKYp7K2YetJPucnqFZiXJakHNdHWk3fhRhHfydRIldT8RNWjsB6PtM1
 7Oyfbb0j1CNrs0+oWbCfw07S0jmFqCB0+jVkS4JvhzWkex/qtmmbyP8IOnNjM1KYHnejjK
 lHLUg0gfkk/q11Y47GnGntOPdNQKLr4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-5EwsKp3JObyLheroGPXlFA-1; Thu, 20 Feb 2020 13:55:11 -0500
Received: by mail-wm1-f70.google.com with SMTP id u11so1206581wmb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 10:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=38kovK2RFHGYw22ulqBrLKdnZnFJdmfF2rny7axMScg=;
 b=BUq/+d1lUb19mWWyOLHkmPiUvjOdjD5/xD/ig9LNDliIFdkHSGc40ZFxYaMZT9SvoW
 jlSNWpMLxLwqsLv4qbJiA8Dj3h7Szny8ydHOiiRCpjqOpTU4rJ4qEl8GYR09IaffcyzP
 UD3kBsNK3e/QMjJEF2ladgbhdc4XaKnN/MeRtbhRkgnwCK0NfgNx/hR+HZcCt/ELEAFK
 ngb+QSFJnsaSkMHbNdcfYTll9P7IvetpZp3hcmcQUzvhwbJj1KKhYcuj2lixlbzi2nsb
 DfmxHj5HpxcF0sUD8ZiO7ZUrWCyKPXLr/NY8M3qde8P3jc3uFSFCu5GYmvKRctxOt6vW
 D0DA==
X-Gm-Message-State: APjAAAVtuXSnoRTcXvvF21caAT3jQSXM/5AiLPk6r6HlFTrOGDvm2eVO
 smNJ65fhW/JnUM7lQumodN25ld4f4Seq0FOnwPNVWxSLsZwu5fhRD0vUyIQaopujNpknODPrFYd
 ZrddjkzZFmpFjSts=
X-Received: by 2002:a1c:a70b:: with SMTP id q11mr5773772wme.108.1582224910343; 
 Thu, 20 Feb 2020 10:55:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyO3Yb7vrZyhR4/mDMMfCIi6SuUZgrSTG5FgkQ1TOUr9ueeWM8u0EC291p/o2gYmYE2BXVtLQ==
X-Received: by 2002:a1c:a70b:: with SMTP id q11mr5773751wme.108.1582224910127; 
 Thu, 20 Feb 2020 10:55:10 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v131sm289240wme.23.2020.02.20.10.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 10:55:09 -0800 (PST)
Subject: Re: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
To: Laurent Vivier <laurent@vivier.eu>, Changbin Du <changbin.du@gmail.com>,
 alex.bennee@linaro.org
References: <20200220155834.21905-1-changbin.du@gmail.com>
 <269f16b4-e843-1058-4c3b-f11de45b04e1@redhat.com>
 <2f66143c-daa8-2f1d-0593-424791d81fd0@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d0aa7696-e5b4-3258-0441-05f07520fded@redhat.com>
Date: Thu, 20 Feb 2020 19:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2f66143c-daa8-2f1d-0593-424791d81fd0@vivier.eu>
Content-Language: en-US
X-MC-Unique: 5EwsKp3JObyLheroGPXlFA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 7:06 PM, Laurent Vivier wrote:
> Le 20/02/2020 =C3=A0 18:47, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>> On 2/20/20 4:58 PM, Changbin Du wrote:
>>> Recently when debugging an arm32 system on qemu, I found sometimes the
>>> single-step command (stepi) is not working. This can be reproduced by
>>> below steps:
>>>  =C2=A0 1) start qemu-system-arm -s -S .. and wait for gdb connection.
>>>  =C2=A0 2) start gdb and connect to qemu. In my case, gdb gets a wrong =
value
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 (0x60) for PC.
>>>  =C2=A0 3) After connected, type 'stepi' and expect it will stop at nex=
t ins.
>>>
>>> But, it has never stopped. This because:
>>>  =C2=A0 1) We doesn't report =E2=80=98vContSupported=E2=80=99 feature t=
o gdb explicitly and gdb
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 think we do not support it. In this case, gdb=
 use a software
>>> breakpoint
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 to emulate single-step.
>>>  =C2=A0 2) Since gdb gets a wrong initial value of PC, then gdb inserts=
 a
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 breakpoint to wrong place (PC+4).
>>>
>>> Since we do support =E2=80=98vContSupported=E2=80=99 query command, so =
let's tell gdb
>>> that
>>> we support it.
>>>
>>> Before this change, gdb send below 'Z0' packet to implement single-step=
:
>>> gdb_handle_packet: Z0,4,4
>>>
>>> After this change, gdb send "vCont;s.." which is expected:
>>> gdb_handle_packet: vCont?
>>> put_packet: vCont;c;C;s;S
>>> gdb_handle_packet: vCont;s:p1.1;c:p1.-1
>>
>> You actually fixed this for all architectures :)
>>
>> This has been annoying me on MIPS since more than a year...
>=20
> The problem started with an update of QEMU or of GDB?
>=20
> At one point it seemed to work, so what happened?

I'd say gdb. I can try different combinations of QEMU/gdb but I won't do=20
that soon.


