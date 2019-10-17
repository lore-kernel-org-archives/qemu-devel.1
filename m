Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0375C2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0375C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8ap-0008Rs-Lx
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7pt-0004D9-0u
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7pr-0004tT-OQ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7pr-0004tL-Gh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:37:07 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52E23C0546D5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 15:37:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i10so1135901wrb.20
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZoDnuvieE1vwdFJevEjTqU698vVlleevRIzQBYr+fco=;
 b=dbb2lEv3QDWPvLJWq8bpg6zkwzoo9NX7WhkUFWW66bavQqeQxPcyytqTrd48bX4bRO
 IqgbLYwK4vt+grP/dPq3/9dwK1u3VghDWuAs+Yqtq1S80BWkQFJ/Tua+y/4rfAIvNmfY
 Fgs/5Z+pOnE7snpRC6aXBYa7wziIpF0ReGEt+uxciWPY59b/oa379yJ68u4sJoklc6VH
 PeYukRaN1LXeokkN825QPtY9aNqZXDyXZExMKlHENRPA0cTXVX1X6dVOtumZLTcK6ZGV
 hcOwV1794k+4Gp5k0xbvW6rRbQ24mwWQq/E9xYWFWbC9ahUY6VpQptCS3AhfOuJCvHwj
 o0Jg==
X-Gm-Message-State: APjAAAVPc2k+60MtkjjSOVDia9LfBKkf0kMlziJ6yZxZawCyzk+/ibnL
 49SVEaQzoSXKy8c2jpZ4Z87exryrH21zzKaurRWNVlYHNcEBjBvPqXpHb1kg8CDkVE6VAmhDmxO
 CudSHM4kUZZKzSno=
X-Received: by 2002:a05:600c:2214:: with SMTP id
 z20mr3546238wml.10.1571326625066; 
 Thu, 17 Oct 2019 08:37:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFByCpFsOPI/D90wmVQpllY3A59GiUvIq918ytgRa2P+GX+b1/cFy2xEF+A9MVn2e0t84JKg==
X-Received: by 2002:a05:600c:2214:: with SMTP id
 z20mr3546210wml.10.1571326624845; 
 Thu, 17 Oct 2019 08:37:04 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id c6sm2444560wrm.71.2019.10.17.08.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 08:37:04 -0700 (PDT)
Subject: Re: [PATCH 21/32] hw/i386/pc: Reduce gsi_handler scope
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-22-philmd@redhat.com>
 <CAL1e-=hLUDDqFiV8W1f2PFGYJMomvmZUXmjA55X7WEEYMykjHQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8bcf9189-efbe-1575-7e57-fd7bdd202547@redhat.com>
Date: Thu, 17 Oct 2019 17:37:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hLUDDqFiV8W1f2PFGYJMomvmZUXmjA55X7WEEYMykjHQ@mail.gmail.com>
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

On 10/17/19 5:16 PM, Aleksandar Markovic wrote:
> On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     pc_gsi_create() is the single function that uses gsi_handler.
>     Make it a static variable.
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-
>      =C2=A0include/hw/i386/pc.h | 2 --
>      =C2=A02 files changed, 1 insertion(+), 3 deletions(-)
>=20
>     diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>     index a7597c6c44..59de0c8a1f 100644
>     --- a/hw/i386/pc.c
>     +++ b/hw/i386/pc.c
>     @@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {
>      =C2=A0};
>      =C2=A0const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_=
4);
>=20
>     -void gsi_handler(void *opaque, int n, int level)
>     +static void gsi_handler(void *opaque, int n, int level)
>      =C2=A0{
>      =C2=A0 =C2=A0 =C2=A0GSIState *s =3D opaque;
>=20
>     diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>     index d0c6b9d469..75b44e156c 100644
>     --- a/include/hw/i386/pc.h
>     +++ b/include/hw/i386/pc.h
>     @@ -172,8 +172,6 @@ typedef struct GSIState {
>      =C2=A0 =C2=A0 =C2=A0qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
>      =C2=A0} GSIState;
>=20
>     -void gsi_handler(void *opaque, int n, int level);
>     -
>      =C2=A0GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>=20
>=20
> Philippe, this 2-line deletion seems not to belong to this patch. If=20
> true, please place it in another or a separate patch.

It does, this is the point of the change, make it static and remove its=20
declaration :)

