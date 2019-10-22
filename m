Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC2920684
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC2920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxfj-0004k3-S5
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMxTM-0005z3-AC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMxTI-0005Xb-NR
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMxTI-0005XD-Ff
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:57:24 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 885A5C058CBD
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 16:57:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s19so6171729wmj.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 09:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rpq7Nqp/E9RoUvfJrrerAkiFPkO8VSgI4ozv2JmTa/s=;
 b=Nm/zcB+LfsZxc8of/WlQemgVCyvIPB2Y4TVMvED8OFhDTfayRvSzctnQqrZiHekaCJ
 FNQhAuhFOWsB21jOs8/oKU0WbAcBVj1kPwTkBgqYfADr4PBEFvr2Jma5GxF9Dl2sjGPz
 WZhgJV6RC166aRRtJxx4h2Aaw9i5EWf8ZZahbSfvSa8I4w0ig+y2Q7pUZ2PffKJcUgM2
 EkJHDwEXqjhgGycAZLxgQQuNLxfCla0O2V3EzoSSDVbWyUegmRuiZcU51Y7Yw68Vzfub
 6gbc459gbGBxKCCN3xTScVPmSvM0J9lSx4yJ2i1SBkXMaz54/S8ehEEiQLSqX4gQ41FZ
 De/w==
X-Gm-Message-State: APjAAAWmVh57+spMMtj/QY0JIejjlxlEUkg5WWD0KvtyV4OJY8/24ojw
 iLYygG9SPafe21Pf0OQ/ugpDmj8ya6ra0D7h3fZ3fmvLbzFU4sqlRB6Knru0johicXL0nbfO8TN
 J+O7V3xK9ejZ134s=
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr3709528wme.71.1571763442128; 
 Tue, 22 Oct 2019 09:57:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqweH+eDZQBjQQFiq4Eoh3TGZHPYjB8PsGTJgSUXJSYXHQ8WRdVZ+CO1GRildLbB0do7svA/DA==
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr3709510wme.71.1571763441830; 
 Tue, 22 Oct 2019 09:57:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19?
 ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
 by smtp.gmail.com with ESMTPSA id r15sm7274680wro.20.2019.10.22.09.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 09:57:21 -0700 (PDT)
Subject: Re: [PATCH 0/4] mc146818rtc: Allow call
 object_initialize(MC146818_RTC) instead of rtc_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191018133547.10936-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <408f168a-f124-18d8-6cda-805c223411f0@redhat.com>
Date: Tue, 22 Oct 2019 18:57:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191018133547.10936-1-philmd@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/10/19 15:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Four RTC146818 patches extracted from a bigger series:
> "hw/i386/pc: Split PIIX3 southbridge from i440FX northbridge"
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg03685.html
>=20
> This step is required to be able to create a MC146818_RTC within
> a QOM object (which will be used in the "piix4: add a mc146818rtc
> controller" patch later).
>=20
> No changes since previous post:
> $ git backport-diff -u pc_split_i440fx_piix
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/4:[----] [--] 'mc146818rtc: move structure to header file'
> 002/4:[----] [--] 'mc146818rtc: Move RTC_ISA_IRQ definition'
> 003/4:[----] [--] 'mc146818rtc: Include "mc146818rtc_regs.h" directly i=
n mc146818rtc.c'
> 004/4:[----] [--] 'mc146818rtc: always register rtc to rtc list'
>=20
> Herv=C3=A9 Poussineau (2):
>   mc146818rtc: move structure to header file
>   mc146818rtc: always register rtc to rtc list
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   mc146818rtc: Move RTC_ISA_IRQ definition
>   mc146818rtc: Include mc146818rtc_regs.h directly in mc146818rtc.c
>=20
>  hw/timer/mc146818rtc.c              | 39 +++--------------------------
>  include/hw/timer/mc146818rtc.h      | 36 +++++++++++++++++++++++++-
>  include/hw/timer/mc146818rtc_regs.h |  2 --
>  tests/rtc-test.c                    |  1 +
>  4 files changed, 39 insertions(+), 39 deletions(-)
>=20

Queued, thanks.

Paolo

