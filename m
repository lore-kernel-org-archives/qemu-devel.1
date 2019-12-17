Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94131C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFCD24655
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDEWngXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFCD24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihE1c-0001XJ-6U
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihE0j-0000br-9v
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihE0i-000895-9U
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihE0i-00086y-5E
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576593579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILM05Zo3j4GRJaKUGTMiJGTmysoLd2r/1R3EpUzY4ys=;
 b=TDEWngXPVpw7z1q+T4NqNo2TX2abJ8e+DAYBge03MpuARRCl1lmLGjpYAyC7jLdq3t2xxY
 4g+H85l3e/wHUlOkuDNtSbztLS2IoKQPl9xaWSGlwhzXpfo/v2t+z8/GRUXfOiV1+fAtOJ
 AAJpcV2Lmbyo6nhJvyd21xgD8ebn0iE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-6m_cNkHIPtmzk9jjpmXKYQ-1; Tue, 17 Dec 2019 09:39:38 -0500
Received: by mail-wm1-f71.google.com with SMTP id f25so995277wmb.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8pJJj8/GL8hcw9u2PNFe9qeV59bikXTvl//4v/VHgvo=;
 b=IOLgwbQTVYmZ9O2svZvBwolbnH2Vu0t0/eVxeuR6zp+RgRXESmrT/isa5kC53yUTSV
 eNyiKasCmIZrejxAwIGG9gPGhQm83FKwsehR2NrXD54ULYnC98WwftGNjeiYn4gAmK3b
 8to7t6nSn2z9JNkOa7JOnHBwtZ1+ZIXlrYIPN7Pe/qW7suuNeL/UzV6UXwRxEM2aG38C
 YC4LncdXmidfllsBeTttN+6GVLFH1gyCYx8qas5nt6+jcQtakLeAOboshivBMA1oBxGk
 VEF6Ojb5CCTDvDcVZtfltpPWFWU2VERgyAInPuM9roQ8R1INxBCmfMGW+OhXr17sZnD7
 4Oyw==
X-Gm-Message-State: APjAAAWxRa7feja6lnPNA5Kp1xgfy6QE0kRaNmgCf9MtWUcuShpwLkcl
 HAnkRNdfUv5XV9IRHLYLNhbWeTDcVnRE3Y7gjVR9j0WF/7puVh/PHqfxcOhSJ30gKRv7nNfmFM8
 bxHFV5B5eHptTX8E=
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr5760567wme.177.1576593576879; 
 Tue, 17 Dec 2019 06:39:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzgUasN9e8x/ZS+9ZpuXNuHmFsLEnEkAlSvN3B9N3+AAPzReDsZxiBbMt9FDuR96yGV6WENA==
X-Received: by 2002:a1c:9e4c:: with SMTP id h73mr5760549wme.177.1576593576598; 
 Tue, 17 Dec 2019 06:39:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:503f:4ffc:fc4a:f29a?
 ([2001:b07:6468:f312:503f:4ffc:fc4a:f29a])
 by smtp.gmail.com with ESMTPSA id a14sm26878928wrx.81.2019.12.17.06.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 06:39:35 -0800 (PST)
Subject: Re: [RFC PATCH] semihosting: suspend recieving CPU when blocked
 (HACK, WIP)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
 <20191217121443.14757-1-alex.bennee@linaro.org>
 <1ca001f0-43a5-d8fc-fee0-3a318cc698e5@redhat.com> <87bls7vzjc.fsf@linaro.org>
 <976227bb-916a-2c50-1f8d-e146a199de15@redhat.com> <875zifvxw0.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5c6068cb-f8bf-fe4b-391b-7ced97f14221@redhat.com>
Date: Tue, 17 Dec 2019 15:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <875zifvxw0.fsf@linaro.org>
Content-Language: en-US
X-MC-Unique: 6m_cNkHIPtmzk9jjpmXKYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: keithp@keithp.com, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/12/19 15:18, Alex Benn=C3=A9e wrote:
>=20
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 17/12/19 14:42, Alex Benn=C3=A9e wrote:
>>>> Why do you need to set exception_index to something other than -1 (usi=
ng
>>>> cpu_loop_exit_noexc for example)?
>>> If there is no exception to process we won't exit the main loop which w=
e
>>> need to do if we want to wait until there is data to read.
>>
>> Okay.
>>
>>>> Using ->stop here is a bit weird, since ->stop is usually related to
>>>> pause_all_vcpus.
>>>
>>> Arguably we could come up with a better API to cpu.c but this allows us
>>> to use cpu_resume(c->sleeping_cpu) when waking up rather than hand
>>> rolling our own wake-up mechanism.
>>
>> But we already have the right wake-up mechanism, which is
>> cpu->halted/cpu_has_work.
>=20
> cpu_has_work is a guest function though and semihosting_console is a
> common hw module. It can't peek into the guests internal state.

semihosting_console only needs to something like
cpu_interrupt(cpu->stopped_cpu, CPU_INTERRUPT_SEMIHOST).  (By the way,
the stopped_cpu should probably be a list to mimic the condition
variable---for example a GSList).

> This all
> comes back to cpu_thread_is_idle anyway in making our decision about if
> we do or do not sleep on the halt_cond.
>=20
>> That also makes it possible to just use
>> EXCP_HALTED instead of adding a new EXCP_BLOCKED.
>=20
> We can certainly use EXCP_HALTED but maybe come up with a common way of
> entering the state? There seems to be a combination of messing around
> with special interrupts and direct poking of cs->halted =3D 1 while
> setting the exception. Maybe this could finally clear up the #if
> defined(TARGET_I386) hacking in cpus.c?

If you're talking accel/tcg/cpu-exec.c, that's different; the issue
there is that x86 has a kind of warm reset pin that is not equivalent to
cpu_reset.  Removing that would only entail adding a new member function
to CPUClass.

Paolo


