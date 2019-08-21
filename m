Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2BEC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DA8216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DA8216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tb3-0000Rw-7z
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0TZh-0006qZ-Cc
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0TTz-0002Qv-Lm
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0TTz-0002QU-ET
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:29:11 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D08433026D
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 16:29:10 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id s18so1452039wrt.21
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 09:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rd8ogXOTn3+XqTwYTyF0LJn+wdjlrM6jMibpOnG9qJg=;
 b=tyOlG+zoU03ZSd2ka80wvNsYMdS/MjsCpQ7y73XC2nUer6+d7PUcAzq7YKbysMne52
 xxwM/shojzVbSZn15nDwQAMksxlAjoSd8GGeP57LkMiXW7Yb9w4NMoR/cZrGRd4QvbSE
 az9hhnAuvtqPm9tePBJhYkaJU59xc9ZJ61kzBl2+bfbk1Z+SdcYadGzlsaYeQgdGTI8q
 coxinkLMqtWhSJcwL5J6jEmEBafivfgq7ye1NlUsEliYwpnKrD18l09HXvPWC4M9nbrb
 7g5alaOA0CxeTCZk6nMJIsd3qjA7yf0MmsV0HwneROHc6CQeXho4MOSdA8uxIWelgQJt
 /SNw==
X-Gm-Message-State: APjAAAV/lCU4FXDjxTmIu0NZlkgkz9oowx0JZQ/SiA+6Lr5UClxLW675
 9cnJn353tWZsuPpb4QPFkj8V8B4JOr/qMTPJBPYvUcTaNQIrS6U30BuJg6wUewcbtKoc0SV9SYi
 vEX2eB4qeVDa/sSM=
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr12399526wrw.66.1566404949262; 
 Wed, 21 Aug 2019 09:29:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy7cCDK432jRZLnHxeb7TOhMLfHJptPDKPuMMLMdJ7NY1YTNtcIgoNec7U4HpxrPx4r1Bnt0g==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr12399493wrw.66.1566404949103; 
 Wed, 21 Aug 2019 09:29:09 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id r16sm47052049wrc.81.2019.08.21.09.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 09:29:08 -0700 (PDT)
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <BN6PR2201MB1251511E7694854909AFEEB4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CAFEAcA9UJGXOdNUD49bxmrdoZ5FEv4VLqAvyzDw66MOGsGB=wg@mail.gmail.com>
 <BN6PR2201MB1251C78A16D557867586FFD4C6AB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <1fc18db5-abd4-80be-11ee-209dfd4a55f4@linaro.org>
 <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9c6110d6-1319-418d-ba4c-9fa8be460cf9@redhat.com>
Date: Wed, 21 Aug 2019 18:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LMD.2.03.1908201811150.2980@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [EXTERNAL]Re: Proposal for amending TCG interface
 naming scheme
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 6:21 PM, BALATON Zoltan wrote:
>On 8/20/19 5:37 PM, Richard Henderson wrote:
>> What if we use the AArch64 mnemonics: zxt (zero-extend) and sxt
>> (sign-extend)?
>> This would give us
>>
>> =C2=A0=C2=A0 tcg_gen_zxt8_i32
>> =C2=A0=C2=A0 tcg_gen_sxt8_i32
>> =C2=A0=C2=A0 (etc)
>> =C2=A0=C2=A0 tcg_gen_zxt_i32_i64
>> =C2=A0=C2=A0 tcg_gen_sxt_i32_i64
>=20
> Again this might look familiar to those knowing AArch64 but not to
> someone who does not know that. Maybe zext sext is a bit more decyphera=
ble.

Both namings seems acceptable.

Not sure if the lexicographic distance is reduced, neither if reducing
it would make a difference :)

