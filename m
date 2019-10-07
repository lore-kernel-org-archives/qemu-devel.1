Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C81ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A202A20679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C55o6pqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A202A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVIM-0003w0-GT
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUyL-0004CG-MG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUyK-00067N-Fd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:30:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUyK-00067C-6g
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:30:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so13138085wma.5
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=abUfW5EDQ+UuQFU0PkAHsV3pN+X+vdSvJNQGfLUI/Uo=;
 b=C55o6pqbOaGWCCQlh+GcJI4zN5Hw5n4HSjK1LeYfShNXbYXjYcEBD1z14u5G+MWkxw
 ObqLQf8cfVmmzb/7TEeNiv3QCkTXLD1gJNqPmhm2iogVpHWVbPU9Xk9PigDJZaEQIFQ2
 D9BoEX6rV08GSJo+8ly0CGeHXyy45GW2EVC4UkjYBGUxzL0PIvPIaOw4dlckQBvBgP/H
 CiudOvXyyrD/xi2TB2gMoEOa/E+akYK2znNJZ7jY1nVigI5uFIC9P7Jmcqfkf+v/KiNs
 +fsThG5mcOawh09S2UjsFHH1KDmhet3pT1AUC0PdMJOMP/VhINfXSmacDVzQ/3fB1B9O
 MDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=abUfW5EDQ+UuQFU0PkAHsV3pN+X+vdSvJNQGfLUI/Uo=;
 b=TILPh1kDz8gDx9eL7iwAXBllSjXoGWGGYNANtjiFNIveKTlcbSOrAFhpneVQyWf4aM
 4ZXviHh0vgI+uIcmX7sPyKq1rQjpb6qU/BOaqkIJTBRwv1EG+by0S3kOZ1MTPMAXwcKH
 7RmjQnmENi9It0ChXBxUqodrRVI02XM8lvMQQZuyKGfHzeFkSpOY9s/RolQjaOe4njCc
 S+YN54+IPI9BKv5VTegI7h8xa1pe8y+JMZxr3TZ9MuykrfSWXb3IfYRN1aZdmOkdqhgw
 umMXpSMg11OkZdUvmKUfRUBdQo51B7e1xYFceeQUWZkuHb1kTD+4OtVxg7xLXPzYSkD7
 YjQg==
X-Gm-Message-State: APjAAAVsH91nREuwW9H14X7DowHR58UYsdhLin5vjWT7kPKTpzwhJy3C
 Dc0JA1bB8+XStG6l5KQJ88D07Q==
X-Google-Smtp-Source: APXvYqw0r1djKOI5SCwZQCKkVZsCSPHC9pwx3RczsRVFDeWB5md3mVuygjUyWcUVUD6Od//kdXQ2dw==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr21936948wma.68.1570462250967; 
 Mon, 07 Oct 2019 08:30:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y3sm412033wmg.2.2019.10.07.08.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:30:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ACD641FF87;
 Mon,  7 Oct 2019 16:30:49 +0100 (BST)
References: <20191001160426.26644-1-alex.bennee@linaro.org>
 <5582c91e-ac0e-9f74-a3de-82f7fe25fadd@redhat.com>
 <874l0sl5z6.fsf@linaro.org>
 <d25121c7-e499-95e4-840e-4de53a4469f2@redhat.com>
 <a475e640-1739-24df-f873-d54abb891c35@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] cpus: kick all vCPUs when running thread=single
In-reply-to: <a475e640-1739-24df-f873-d54abb891c35@linaro.org>
Date: Mon, 07 Oct 2019 16:30:49 +0100
Message-ID: <87blusk1xy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Doug Gale <doug16k@gmail.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/6/19 9:05 AM, Paolo Bonzini wrote:
>> On 01/10/19 19:40, Alex Benn=C3=A9e wrote:
>>>
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 01/10/19 18:04, Alex Benn=C3=A9e wrote:
>>>>> qemu_cpu_kick is used for a number of reasons including to indicate
>>>>> there is work to be done. However when thread=3Dsingle the old
>>>>> qemu_cpu_kick_rr_cpu only advanced the vCPU to the next executing one
>>>>> which can lead to a hang in the case that:
>>>>>
>>>>>   a) the kick is from outside the vCPUs (e.g. iothread)
>>>>>   b) the timers are paused (i.e. iothread calling run_on_cpu)
>>>>>
>>>>> To avoid this lets split qemu_cpu_kick_rr into two functions. One for
>>>>> the timer which continues to advance to the next timeslice and another
>>>>> for all other kicks.
>>>>>
>>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> Cc: Doug Gale <doug16k@gmail.com>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Peter Maydell <peter.maydell@linaro.org>
>>>>> ---
>>>>>  cpus.c | 24 ++++++++++++++++++------
>>>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> Looks good to me.  Single-threaded TCG is not going to have high vCPU
>>>> counts anyway.
>>>
>>> Are you going to take this via your queue?
>>
>> I wasn't, since we have had a proper TCG maintainer for a while. :)
>
> Hah.  Point taken, and queued.  Would you care to go on the record with
> something more than a LGTM?

Heh, I was confused because cpus.c is shown twice in MAINTAINERS as
Paolo is the main loop guy ;-)

>
>
> r~


--
Alex Benn=C3=A9e

