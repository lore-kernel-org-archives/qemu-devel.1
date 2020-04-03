Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3707FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FC820737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGwiBgif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FC820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQGm-0001y4-1Q
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQCG-0004HO-W8
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:33:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQCD-0002Yi-Ad
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:33:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55636
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQCA-0002VS-0b
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585935206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1BdZ+1FD20J+7FJXUiX3iZNrn1rFYrz/A/MkCPjcJI=;
 b=YGwiBgifUEb1+yxULzG5VFhxnl1D1DXWvxOtROApWlGVboSQ/D+xfJTVPJlwSK/ccsEynV
 VI7bLpvmhtbYlpVAVRH85g4oOdknmZEZN6ZcXU2f2Lin4iUuaqRDsvt967K9fKgpzReUAp
 7yU7SBI/F72eK2rpnpun1+MBNpKvt8A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-GPFX5giuP1GGqDrVloVZKA-1; Fri, 03 Apr 2020 13:33:23 -0400
X-MC-Unique: GPFX5giuP1GGqDrVloVZKA-1
Received: by mail-ed1-f72.google.com with SMTP id i10so6057940edk.13
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1PUwBr0dmRetM81rG+fW0RnAnduc84fHIF0VEUeAiLc=;
 b=cyLWOkGltfAd1izaCqsRZpw8IvekRrPKxFC8wTE3uRf9PrAdyvPWoapz8JF8VDQBnm
 PnMEpnh0uJea3llfzYp2A8OiLTYAJL3S3h1Lk7akiInPvtD07AuS8l+ij9hTHukQVi+V
 yNxKMOUVKi+rlm2Sq2grVYDPmSQV5Tsvx43eWYE9RD8qnE7k0FNDdrbltGXnUrho+MKg
 s4jq7ijOy9IUZXxtrn+lvBA0HWW2THIAsVsSBuuHNnirBg8+RNJ30kkfcB/2z2VS3xK8
 RDIuVg7yU+rfbw7++uSM4sAl27YVsax8rEszjx7eJ3wNBoTCxM6RSnCYr9588gVyN+Ku
 vTqw==
X-Gm-Message-State: AGi0PuZ3SggmV+LK5NTV+KaXnJaqEX+3uQMZX2N1x33qt4cV+Rj4clei
 uKzajA39cbS0bZqPx6mmB3Y0wxIcGy3Q/HKeGh/Th0Nw4xfB/re2Si+wWwx1xk6yLaNNOTHhmDu
 yO9KBZXMgOMrqnqE=
X-Received: by 2002:aa7:d4d1:: with SMTP id t17mr8911066edr.362.1585935202317; 
 Fri, 03 Apr 2020 10:33:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJMqlUf+czpz15Ry7P87bqfGkBsDVxTxENmq1M4lMUXNoZX42xikLI8cI2raxtXAXe2QPVXWA==
X-Received: by 2002:aa7:d4d1:: with SMTP id t17mr8911052edr.362.1585935202169; 
 Fri, 03 Apr 2020 10:33:22 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id c19sm975163ejd.48.2020.04.03.10.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 10:33:21 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] configure: Do not leave sphinx in-tree artifacts
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200403165422.21714-1-philmd@redhat.com>
 <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0438b8f1-91fd-5664-4375-2320a942ebea@redhat.com>
Date: Fri, 3 Apr 2020 19:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BAvi3HEuvpMyyir9CqAbkg3nF3920zBVF-sPyFz++Rg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 6:57 PM, Peter Maydell wrote:
> On Fri, 3 Apr 2020 at 17:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> When ./configure checks the sphinx version is new enough, it leaves
>> the docs/sphinx/__pycache__/ directory. Avoid this by using the '-B'
>> option (don't write .py[co] files on import) via the
>> PYTHONDONTWRITEBYTECODE environment variable.
>>
>> Reported-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> This only happens for an in-tree build, right?

Correct.

> I think in
> that case you're kind of OK with having random stuff
> left in the source tree... It seems easy enough to suppress
> them though, so I guess we might as well.

Here is the post where Eric commented it:
https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00631.html

>=20
> thanks
> -- PMM
>=20


