Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5ECECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AED20872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AED20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8QL-0003Hp-QL
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7S2-00084L-0j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7S0-0002ca-9k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7S0-0002bu-1s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:12:28 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C995121D
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:12:27 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id f63so1196196wma.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6URh6sfF5SY+GjIiIeygv7Pue70RSRcvYor9Y98FLzs=;
 b=fYlcCazbxaPqQ8OLvuPjI+UTCaDSPn2sFjIm5rVNCq/3HxViQgJgejFgwyVl+Ku+Rs
 JXoOfiDWIHHMYszZZw5553c5tWA1iqRcpvgbO+njNGjSgZhix005uNUxLMoha3uNmyWt
 yh1TMlKgb1/e2dwCHAZU5LSLt6zKz4VBH43kMp5PsC36wk+RtSl7+ctznLukH8L72b80
 MYb5RUjBE4R4uHgSRh1HRqxdWbKQAzLZaKLHOM4ne95vSGEgMyENzYrYsflUzU4g0A/y
 pAHsUaeWyw0L5WN2kj0yy7mS2ZC3xCc1zGqXDgV1wgoHJYVckwnxcAf20fAh0djbUNfg
 6e5Q==
X-Gm-Message-State: APjAAAVB9x5b3gQk1sTwdC2QcZcHaMucP3CAMzHPU1vK9A3f+2O8o+NO
 riwaG841+QP9RGqNeaUoTyMCrBSLiwihr8V/zXdx3PXOJPHbfcSKYLcZOWZNRwPbHFjieyQiPd1
 XphwODMaNg0cLGkk=
X-Received: by 2002:a5d:6506:: with SMTP id x6mr3498657wru.366.1571325145508; 
 Thu, 17 Oct 2019 08:12:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySU6DS/RqeRVbBcOi9QO31rcYMYaBXaBuv0ezlv/Z4bgIg5NWR+I6f0LoIGcDuKW0FQqw/eg==
X-Received: by 2002:a5d:6506:: with SMTP id x6mr3498623wru.366.1571325145314; 
 Thu, 17 Oct 2019 08:12:25 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id a3sm2711161wmj.35.2019.10.17.08.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:12:24 -0700 (PDT)
Subject: Re: [PATCH 04/32] mc146818rtc: Move RTC_ISA_IRQ definition
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-5-philmd@redhat.com>
 <CAL1e-=jOiMe2--=ht0Wgwh0a_At=sDhUzX7EkNU86nPt230a-g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff0603bb-ffef-ca67-6d0f-9e7a36abaa7f@redhat.com>
Date: Thu, 17 Oct 2019 17:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jOiMe2--=ht0Wgwh0a_At=sDhUzX7EkNU86nPt230a-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 5:02 PM, Aleksandar Markovic wrote:
>=20
>=20
> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org <mailto:f4bug@am=
sat.org>>
>=20
>     The ISA default number for the RTC devices is not related to its
>     registers neither. Move this definition to "hw/timer/mc146818rtc.h"=
.
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0include/hw/timer/mc146818rtc.h=C2=A0 =C2=A0 =C2=A0 | 2 ++
>      =C2=A0include/hw/timer/mc146818rtc_regs.h | 2 --
>      =C2=A0tests/rtc-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +
>      =C2=A03 files changed, 3 insertions(+), 2 deletions(-)
>=20
>=20
> Philippe, do this and related patches clash with your recent=20
> reorganization of timers/rtcs?

Indeed, but since big boring series take time to get merged, I prefer to=20
have it reviewed already, then I'll rebase and fix conflicts on the one=20
that isn't merged.

Thanks for reviewing the other patches!

> A.
>=20
>     diff --git a/include/hw/timer/mc146818rtc.h
>     b/include/hw/timer/mc146818rtc.h
>     index 0f1c886e5b..17761cf6d9 100644
>     --- a/include/hw/timer/mc146818rtc.h
>     +++ b/include/hw/timer/mc146818rtc.h
>     @@ -39,6 +39,8 @@ typedef struct RTCState {
>      =C2=A0 =C2=A0 =C2=A0QLIST_ENTRY(RTCState) link;
>      =C2=A0} RTCState;
>=20
>     +#define RTC_ISA_IRQ 8
>     +
>      =C2=A0ISADevice *mc146818_rtc_init(ISABus *bus, int base_year,
>      =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq intercept_irq);
>      =C2=A0void rtc_set_memory(ISADevice *dev, int addr, int val);
>     diff --git a/include/hw/timer/mc146818rtc_regs.h
>     b/include/hw/timer/mc146818rtc_regs.h
>     index bfbb57e570..631f71cfd9 100644
>     --- a/include/hw/timer/mc146818rtc_regs.h
>     +++ b/include/hw/timer/mc146818rtc_regs.h
>     @@ -27,8 +27,6 @@
>=20
>      =C2=A0#include "qemu/timer.h"
>=20
>     -#define RTC_ISA_IRQ 8
>     -
>      =C2=A0#define RTC_SECONDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A00
>      =C2=A0#define RTC_SECONDS_ALARM=C2=A0 =C2=A0 =C2=A0 =C2=A01
>      =C2=A0#define RTC_MINUTES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A02
>     diff --git a/tests/rtc-test.c b/tests/rtc-test.c
>     index 6309b0ef6c..18f895690f 100644
>     --- a/tests/rtc-test.c
>     +++ b/tests/rtc-test.c
>     @@ -15,6 +15,7 @@
>=20
>      =C2=A0#include "libqtest-single.h"
>      =C2=A0#include "qemu/timer.h"
>     +#include "hw/timer/mc146818rtc.h"
>      =C2=A0#include "hw/timer/mc146818rtc_regs.h"
>=20
>      =C2=A0#define UIP_HOLD_LENGTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(8 * NANOSECONDS_PER_SECOND / 32768)
>     --=20
>     2.21.0
>=20
>=20

