Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B4BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7CA20867
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7CA20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOMJC-0001ga-Oy
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 09:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iOMIE-0000Aq-O4
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iOMIC-0005PQ-KP
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:39:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iOMIC-0005OT-F8
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:39:44 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5EF0C859FE
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 13:39:42 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id s17so2956740wrp.17
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 06:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gZvI1N59alkjdVA9tc+4bwd+JOaBLlBdzAC8Z+8yWHI=;
 b=RqkIOXZ1pDbvpFI9WcY80UUi/J9yqIKIJf+wHzPjLVZLYGmGKJbz6M1yXD1Y23TrVu
 Yl9kGsVSH/EJQKHzXkNRlB0xkyrifA3CsO95jL9hNfv4sC1od1T4gEaykGc/sHiekVip
 6mQMDqkkx6fB7oCG0MH00L+zfuiharc5H1pT8IRfIZPxWgdVbbNwmKMAgTJ52k02PacR
 cs0Yv4F4Cz6HAQtohlPGvgkPa8GwGCmbOdo6HZMbrOUGDUCsmp2x4vRTO8e4kfNxi9z1
 gIBmyQqpHF9N0S22BdU0KQbF/rmvL0u4hp8uThriqGu0g8Me3B/3WwtmpMS4dfWG6/bV
 dsCQ==
X-Gm-Message-State: APjAAAVm+SSH9c3IU2Gij6AR6NjiuqEl6raYcgCgWYwOD9FASe6uAAyq
 c8d3BBH7rvacgyUvnPoCzULYi6deKvxwkbyo7ReUuwNmZGJHpCmvMtBszWE/F5GDL9ND+GHCuqX
 Y9iashkEDNw2/djU=
X-Received: by 2002:a1c:27c7:: with SMTP id n190mr2582069wmn.106.1572097180837; 
 Sat, 26 Oct 2019 06:39:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOx++TcFeh3YWO4fbfhnhUQKXTikubzMc4yW4qgFwe79nzfhVJBFaBu3UUQxHLccqLv6xm+A==
X-Received: by 2002:a1c:27c7:: with SMTP id n190mr2582059wmn.106.1572097180544; 
 Sat, 26 Oct 2019 06:39:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5ea:12e3:40be:7add?
 ([2001:b07:6468:f312:5ea:12e3:40be:7add])
 by smtp.gmail.com with ESMTPSA id 26sm4745325wmf.20.2019.10.26.06.39.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Oct 2019 06:39:39 -0700 (PDT)
Subject: Re: [PULL 00/39] Misc (mostly x86) patches for 2019-10-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-1gWa8qRK85i+MP-UixiPq7NPHw+8kn6KPq6VQMtRt4g@mail.gmail.com>
 <d599e5c5-0963-bf02-df88-0e01ee739c93@redhat.com>
 <d7fbed89-29f9-7b4f-b894-9fd78dc9ce73@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a933de1a-b46a-db3b-377f-93b2296e8c2f@redhat.com>
Date: Sat, 26 Oct 2019 15:39:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d7fbed89-29f9-7b4f-b894-9fd78dc9ce73@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/10/19 15:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/25/19 1:17 PM, Paolo Bonzini wrote:
>> On 25/10/19 12:46, Peter Maydell wrote:
>>>
>>> x86_register_ferr_irq() is defined in target/i386/fpu_helper.c,
>>> which is only built if CONFIG_TCG, but the callers don't
>>> seem to be similarly guarded and there's no stub fallback.
>>
>> Indeed, thanks.=C2=A0 I'll add an "if (tcg_enabled())" since this feat=
ure is
>> not supported by accelerators other than TCG.
>=20
> Paolo, since the "Split timer <-> rtc" series got merged via
> the trivial tree, you need to squash this fix to patch #33
> ("mc146818rtc: Include mc146818rtc_regs.h directly in
> =C2=A0mc146818rtc.c") to avoid build failure:

There are a couple other semantic conflicts, so I pushed again the tag.

Paolo

