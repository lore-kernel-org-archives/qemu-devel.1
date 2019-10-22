Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499D0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E05120700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E05120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMr6s-00050G-Aq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMr6D-0004LR-5S
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMr6B-0005VE-Af
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:09:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMr6B-0005U9-2R
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:09:07 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5A9485538
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 10:09:05 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j14so8586411wrm.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 03:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cDIcC71X2j9LYsUN5sPmNj6EXJxvGKxWzrnLFwfa96M=;
 b=I3CO6tsmnqu/7e5h2PAxiq7HXQg1HEzRoCseCEoQMvx9zjf+V0vIawM3713TrfiqO7
 i6gKjBQk7nvYDKGRdcoU9gL4Tg1D6m5RdUVwKSM4JfunjAjUG4w9HEQrJMJNn3P3Oj4Z
 GqjGGHsfoCjoLnoVNPzX0PtY6w3mTXg0c8A+kcfpAANlXwRkaR9gC3BbhfWn2dYB2nbs
 x29gKDbedX/3jCARfEyXlfwy/quENSD+MWzyKKg0AYodvJnv9UtEh/WUYusXtCz279Kg
 6XbFfQupK8uhmGSppv5GZ9otxMuVkWf/pF0+tfJMIOZabsp/a+wfLMUuclkYOzB2P1A1
 O22g==
X-Gm-Message-State: APjAAAVKPdyBW8KLFIOJM8C1NeHRVQ4fSFerJ/nretkZRIVo00R2Kq1A
 TyyvtFwm58SaecpG9LbFfzGR8+/YxYpfdq1VOmbFllyIannEDwRIuH+g3qSZRU+duzREtFL/pFO
 FOs+vpZPztb15lgA=
X-Received: by 2002:adf:b219:: with SMTP id u25mr2579502wra.327.1571738944624; 
 Tue, 22 Oct 2019 03:09:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwi5wHiKhxAtgMDwyR2/pEx6MJWzdYADcmQ7oliJoFdviyyJI7d3qbM+MbGjcSKc0iW3nsRYg==
X-Received: by 2002:adf:b219:: with SMTP id u25mr2579475wra.327.1571738944403; 
 Tue, 22 Oct 2019 03:09:04 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id f7sm10525268wre.68.2019.10.22.03.09.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 03:09:03 -0700 (PDT)
Subject: Re: [PATCH v2 03/20] piix4: Add a i8259 Interrupt Controller as
 specified in datasheet
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-4-philmd@redhat.com>
 <CAL1e-=hOQqRj2_QA8LqWdsD9JM6t6YzoyxC1cEaMBhs1vmN8oA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a6aee537-f433-a350-1679-fcb402cabccd@redhat.com>
Date: Tue, 22 Oct 2019 12:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hOQqRj2_QA8LqWdsD9JM6t6YzoyxC1cEaMBhs1vmN8oA@mail.gmail.com>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 11:53 AM, Aleksandar Markovic wrote:
>=20
>=20
> On Friday, October 18, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com=20
> <mailto:philmd@redhat.com>> wrote:
>=20
>     From: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>=20
>     Add ISA irqs as piix4 gpio in, and CPU interrupt request as piix4
>     gpio out.
>     Remove i8259 instanciated in malta board, to not have it twice.
>=20
>     We can also remove the now unused piix4_init() function.
>=20
>     Acked-by: Michael S. Tsirkin <mst@redhat.com <mailto:mst@redhat.com=
>>
>     Acked-by: Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>>
>     Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org
>     <mailto:hpoussin@reactos.org>>
>     Message-Id: <20171216090228.28505-8-hpoussin@reactos.org
>     <mailto:20171216090228.28505-8-hpoussin@reactos.org>>
>     Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com
>     <mailto:amarkovic@wavecomp.com>>
>     [PMD: rebased, updated includes, use ISA_NUM_IRQS in for loop]
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/isa/piix4.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 43 ++++++++++++++=
++++++++++++++++++-----------
>      =C2=A0hw/mips/mips_malta.c | 32 +++++++++++++-------------------
>      =C2=A0include/hw/i386/pc.h |=C2=A0 1 -
>      =C2=A03 files changed, 45 insertions(+), 31 deletions(-)
>=20
>=20
>=20
> A detail: In the title:
> Add a i8259=C2=A0 -> Add an i8259

OK.

