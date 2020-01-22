Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6575C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988632465B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dL3bs1zT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988632465B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuO08-0005mY-8S
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 16:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuNzN-00057C-Fd
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:56:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuNzL-0007N2-Py
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:56:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28963
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuNzL-0007L5-ML
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 16:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579730198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UIMsL7RQuXazB+NBZtSif4F+CvJHgqVfvSk9MlPEhk=;
 b=dL3bs1zTVH503Fm+2UBiLX2fOoggrUpSVXWWGl7O7J68hsl7E2ZB1nXkVOCu/2QXMPnemy
 vULwqtfFJjNgtfUIsRse3iwQILHnE9TIsgpY4PxX4gx3Uyz7MYVspfAw7JGO1g7wokEJSR
 MRqeUg8L92XvNBDp5v778xKGTHRQEAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-hup48hQONKqoWZSycfS4Ag-1; Wed, 22 Jan 2020 16:56:31 -0500
Received: by mail-wm1-f72.google.com with SMTP id b9so141098wmj.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 13:56:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dxwDltlM8cLM8KfoOaZhqIqUY1xKJAHyicLitykzf+g=;
 b=ViBaob1ChIxoq2sfX3fnBt1JbKVbNxijylEUcfsOlZnujzJ5Mw8OK0G+4LjUUmM+bT
 yi7LxKyU7lURku0MCfExZ/6KjbTqPwuTlbWbCK4qy71o2lyTL/YuoLsYQAFAx2NYQcz2
 T/lS7KVCFVDpFm73dotSNIPrwY8CNznepEvu2FE+B/cytDxI639TchMx5dDBVaAJL+fr
 5FvoosNhgYGdGKZp1FQ5B7D9/oHpojfDag7Md7+4E9RqY8e9/E4J2PfvFkC9FBalXDjc
 Vme0jqtw23uSApDFj2Cb0pSztetssI8N7Cn4rUmzgBMDngfs5AzVCRr6DWnZUMzuXvg7
 wrwQ==
X-Gm-Message-State: APjAAAWS+wdBUdsh3vCjxhl1t7RiVMoRcbzviFZ0MTOsCHpgGjNYOA11
 HNVr8TeiQTdquRbH0pYQV3+TwshAgd1kYjdudYpEK0S1uuZBUjfE60GwD8K/nJYQTWJ89gi2bgG
 Nx56r+9JKTatU2oM=
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr294845wmc.168.1579730190574; 
 Wed, 22 Jan 2020 13:56:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyinPjHo7YBusadh9t+lOvG9BKZ15VLyjUHKiNN4rm2Im2phxzvncZaTkKeNTTxnI5RJgwGYg==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr294822wmc.168.1579730190379; 
 Wed, 22 Jan 2020 13:56:30 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n10sm235773wrt.14.2020.01.22.13.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 13:56:29 -0800 (PST)
Subject: Re: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
To: Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200120220107.17825-1-f4bug@amsat.org>
 <CAK4993jBdx4WniPqLs2YLUnv5rXhGL2SC9bjbjeVmO5bvkRgoQ@mail.gmail.com>
 <CAAdtpL5FdzYga1sA+nsN4+JP2QMO5NMRDtdcJ0v1prHgjxZ+QQ@mail.gmail.com>
 <dfffa872-86fb-9cac-5738-93e88d5accc8@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <55776734-bd8c-fe88-5a8c-e5d223154235@redhat.com>
Date: Wed, 22 Jan 2020 22:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <dfffa872-86fb-9cac-5738-93e88d5accc8@twiddle.net>
Content-Language: en-US
X-MC-Unique: hup48hQONKqoWZSycfS4Ag-1
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/22/20 9:46 PM, Richard Henderson wrote:
> On 1/21/20 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> 4. There is difference between -bios and -kernel (arduino boars crash w=
hen -bios is used, but this seems because I run avr6 on avr5 CPU). I would =
be happy if you explained what is the difference between these two argument=
s.
>>
>> qemu man page is not very helpful...
>>
>>         -bios file
>>             Set the filename for the BIOS.
>>
>>         -kernel bzImage
>>             Use bzImage as kernel image. The kernel can be either a
>> Linux kernel or in multiboot format.
>>
>> Paolo, Peter, do you have a simple explanation?
>=20
> It depends on your target board.  They *can* do very different things.
>=20
> E.g. for "pc" (x86) machine, -bios sets the seabios image to use, and -ke=
rnel
> loads a kernel image that seabios will invoke.
>=20
> E.g. for "dp264" (alpha) machine, -bios sets the palcode image to use and
> -kernel loads a kernel image.  Note that in this case, the alpha kernel r=
elies
> on palcode services, so both must be present for the system to work.
>=20
> E.g. for "virt" (arm) machine, -bios loads a raw image at which the reset
> vector will be pointed, whereas -kernel loads a linux kernel image and fo=
llows
> the arm-linux kernel boot protocol.  In other words the images are treate=
d very
> differently.
>=20
> I don't know what, if anything, an avr kernel would require from boot ser=
vices.
>   I suspect the two options *could* be treated identically.

I think -bios used to be dumb, and originally it would only load a=20
binary blob at a fixed memory address (like mapping a ROM or a parallel=20
flash).
And -kernel was a bit smarter, understanding ELF format. It can set=20
(Linux) arch-specific registers, in particular when used with -append=20
(cmdline) and -dtb (device tree).

At some point -bios got to understand ELF too, so QEMU could load ROMs=20
mapped at different base address (and not force a default one).


