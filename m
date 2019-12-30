Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5187DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A802071E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 10:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJYC2y7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A802071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilrqk-000295-55
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 05:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ilrq0-0001VS-FJ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:59:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ilrpy-0006PD-Sk
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:59:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42670
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ilrpy-0006ON-Oo
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 04:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577699986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqFk+x0X9D60pam+u0Foq5BjemwZC+N+k+hZLjLiTVE=;
 b=LJYC2y7wItLSGB24HW8x8iAxOOeOLQNf3C2lmL8/Ke/VyvMyV3vxqD9ly/jTzRPHlC+0na
 clcafZUXw9woZ+tQdVBKH5Ys+9Zbu/gMjk3UKTZCiRP130n3wwde3WJAvlptT6DbWjkc81
 ejVi2VgecVvHWaJghOg9+X8ZK/edPAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-DqbMEHdkNLaDRiAmax4bhg-1; Mon, 30 Dec 2019 04:59:44 -0500
Received: by mail-wm1-f72.google.com with SMTP id m133so1457037wmf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2019 01:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nHtO6Vsw0hLQyKeVXTvkdGim74QMEL7005MktoQeb/g=;
 b=tSEPmPui8vc1CZo+3hSkDiVWbzzXc8/i03qFoaeXZa0OMDalvvm5CaNIkDdX53rrI7
 IIWUvlQ26A5/qZ7r/5eph9RIPcHyFPHfAmPKj91TKF6mxdS/aOoRuOYuVNUJnVJjsRwd
 82jffxeNSr2t9XVG55/BuQB9hW74CL4zKTEVciUeZ5Xb90GzHSGAOuNLeUdWhNwa3CgY
 Z1Y50T5DsRs+Nmoapk727da3ZLcNPxp6dx7D2czp22gai2VQvP2TxM/FAeUVDCoxl1ko
 xXdayHO5UjewDrLb5ndWJ+61p9fDEcqWWhCrnj4ogKE4fnM/CiQS0l3tjoKJyxsKOYp6
 mdCw==
X-Gm-Message-State: APjAAAWxHjBQJ3zIzp484b64q326rk+SWahck1EIo8hGchfuH+CRU9JQ
 54g5hhl2QeNZhqY338/tQG/JgploJFQ7mvho4JOBxnjgiekBEkefzwhTB/vKohSo9a6sexQD3ZJ
 S6Nz7kqQiFtPRKiE=
X-Received: by 2002:a1c:4454:: with SMTP id r81mr33061268wma.117.1577699983544; 
 Mon, 30 Dec 2019 01:59:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzQJMPuSs+59lxAJOKH6KCCABboI19InCFscJ7xeEBu6XQWYAjfD10FKvWAF/jvDgOikM0V3Q==
X-Received: by 2002:a1c:4454:: with SMTP id r81mr33061234wma.117.1577699983295; 
 Mon, 30 Dec 2019 01:59:43 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id i16sm20447753wmb.36.2019.12.30.01.59.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2019 01:59:42 -0800 (PST)
Subject: Re: [PATCH 1/2] tcg: Search includes from the project root source
 directory
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191230090900.446-1-philmd@redhat.com>
 <20191230090900.446-2-philmd@redhat.com>
 <273bf2e5-1223-3d01-f930-394195c037e4@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <64c2434d-3b2b-1a3e-5358-e4b5acfbe8e8@redhat.com>
Date: Mon, 30 Dec 2019 10:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <273bf2e5-1223-3d01-f930-394195c037e4@weilnetz.de>
Content-Language: en-US
X-MC-Unique: DqbMEHdkNLaDRiAmax4bhg-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>,
 qemu-riscv@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Claudio Fontana <claudio.fontana@huawei.com>,
 Laurent Vivier <laurent@vivier.eu>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 12/30/19 10:53 AM, Stefan Weil wrote:
> Am 30.12.19 um 10:08 schrieb Philippe Mathieu-Daud=C3=A9:
>=20
> [...]
>=20
>>   tcg/tcg-op.h                  | 2 +-
>>   tcg/tcg.h                     | 4 ++--
>>   tcg/tcg-common.c              | 2 +-
>>   tcg/tcg-op-gvec.c             | 8 ++++----
>>   tcg/tcg-op-vec.c              | 6 +++---
>>   tcg/tcg-op.c                  | 6 +++---
>>   tcg/tcg.c                     | 2 +-
>>   tcg/tci.c                     | 2 +-
>=20
>=20
> Source files in the tcg directory should not need any change because
> they find include files in the same directory without searching.
>=20
> If we add a tcg/ include file prefix for them as well, that has the
> advantage that it might look prettier and more uniform, but it has the
> disadvantage of requiring a search by the preprocessor.

Yeah, I was not sure about these specific files. My first attempt was=20
without modifying them, but then I thought it would be better to keep=20
the codebase uniform, as you said.

>=20
> I'd prefer not changing those files.

OK, I'll wait to see what Richard/Markus prefer.

> Regards and best wished for 2020

Thanks ;)


