Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33040C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C50206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjW2B2Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C50206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs4zA-0005lt-BC
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 08:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35327)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hs4yU-0005Mc-8B
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hs4yT-0008Oc-Am
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:41:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hs4yT-0008NU-44
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:41:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id s3so53693091wms.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 05:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WoAoMpRl5H8KX4C/5ahEO27vsDItrGFUWNGDgAtSFJM=;
 b=KjW2B2Hz+unvfEosiqxrQ+UNBQSKAzPXRVsHGCxQuoWvY9N/o/xSqvimN75LkxSenu
 kPTEE2Duv4SOaLIfsSopiddVnX5c16ixMkmvdNKHes9VkVZqdKx+B4+QmbvCLTW492fA
 tVucQSdtCziGI6vw47h83U/AlkbSm6bFTONWR/Qd8Hk+BDfjCWhtbc2/uZPU+ZiFA5Ic
 HZ4e+L9Qp8dMSOYEVh3I/hdifjGihS2AplN7bwggL2ZWPnH/oO0rF4ISvya0xPvQaRl8
 hQ88dSmeYIqyeQXcDNqNPaZ7DBoi0nhwt3+ffMLi5A1RiWR6baeZGNnsZSd3gXDfyB4Q
 X5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WoAoMpRl5H8KX4C/5ahEO27vsDItrGFUWNGDgAtSFJM=;
 b=TUQANPXMwnN0++Fjoy5BAOHYNRxjRirBUQ4/lu2hL7mByRrrJvJpuIdIBt8GmauXxu
 nSABaNyjR75zZqD85hBflJLJie7IQKxmOslsslXaRntszdp0N0thU6xDjG9iR9yILARF
 8CG+O9bkX9/gr1ssMsLyxbByjHgQVs75eetMEwKkwTIbrwHVZtkPQKs3Jl6tfKJigqN8
 vM34VDsxs9G41UXtzGbbQWlg5GRMcD0npBYDXInAE1EVGv75P8zscnyglgduHemnDI9O
 CDQ+ReV+K6NFi8/MQb2QJ9xqIKN/+ROWQhh/NShXL+dL1qFO2kuAHQDIvn7NEtrFQz8L
 /63Q==
X-Gm-Message-State: APjAAAUQQnkh6/CSrvNHjT/2ATksgDj9j505x8qA5giIues2cuqAqEem
 ueLHkAVjdt1F4tuR5d6SvYG+6g==
X-Google-Smtp-Source: APXvYqytarX6rI71Ai8pXDziW/H+xhEfNcuwWMHiOQu/WYJk5TavkRTmQNPADJuvFUaLEGkeTLSUWg==
X-Received: by 2002:a7b:c206:: with SMTP id x6mr99771832wmi.156.1564404115228; 
 Mon, 29 Jul 2019 05:41:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q18sm74129573wrw.36.2019.07.29.05.41.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 05:41:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 210521FF87;
 Mon, 29 Jul 2019 13:41:54 +0100 (BST)
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <20190729082115.GB32718@redhat.com>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190729082115.GB32718@redhat.com>
Date: Mon, 29 Jul 2019 13:41:54 +0100
Message-ID: <87lfwhhv1p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Jul 27, 2019 at 07:20:15PM +0100, Peter Maydell wrote:
>> On Sat, 27 Jul 2019 at 13:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >
>> > On 27/07/19 09:16, Markus Armbruster wrote:
>> > > We started with a single trace-events.  That wasn't good, so we spli=
t it
>> > > up into one per directory.  That isn't good, so what about splitting=
 it
>> > > up into one per source file?  Pass -DTRACE_HEADER=3D'"trace-DIR-FOO.=
h"
>> > > instead of -DTRACE_HEADER=3D'"trace-DIR.h"' when compiling DIR/FOO.c.
>> >
>> > For Make this would all work great, however not for Meson because it
>> > doesn't allow per-file compile flags.
>>
>> Apologies for randomly parachuting into this email thread, but if
>> Meson doesn't support per-file compile flags then what's the plan
>> for handling the cases where we currently need per-file compile flags ?
>
> I'd suggest we don't actually /need/ per-file compiler flags in most
> cases. eg when we add  $foo.o-libs +=3D $(FOO_LIBS) that's not really
> a per-file setting when it gets expanded onto the final linker line.
> Its just a "-lfoo" that gets used for the library as a while.

We do for tests, often to select a specific processor type or feature we
need to build that particular instance of the test.

--
Alex Benn=C3=A9e

