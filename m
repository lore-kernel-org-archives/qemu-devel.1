Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76DC3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C3520659
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C3520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3l9U-0005Lc-PV
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 13:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3l4t-0002gD-10
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3l4n-0004Z9-SY
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:52:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3l4n-0004SJ-Kb
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 13:52:45 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A33E756
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 17:52:42 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f18so3775160wro.19
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 10:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sRv1pcx/3wFeRU/i/8rzTNP+VloRbOX+uk5PyDNU2+U=;
 b=g2V+1/IqonRyd46Y3STy5TIxBOqtZtr7E4GZz1TxB5DvoSrXH8/cuU9apXHybrd79s
 EWgRnFGiPCxc8jba+jiKlVfp3fPwjNBx/CM7RJLrGzQ/s7NQ9jAgzCQGOTujnBqw+pP0
 vdyFPuk112il5vU1z3wNGUJf+/K5MRO+7GagjAPSBf8m5BDV2KdZP2ckAnsIaMHYKfDz
 ACK+t5/TdB9eN9eN7n5y2yac0VcaSqcG5ln3HmLhAulAcnGxSGmZ/LIA5gjbrqo+v7Yf
 DbJUU35vDZCBWHPjGYTV2tqxcSJLENflPirAAnzUpI9eHBnl7+yQjR8/1ACPjJvzsL3z
 WQiQ==
X-Gm-Message-State: APjAAAXIBjceFLgVgjIjcNOMMIc3ookiVNYwmyElBqRibdjk004loW1F
 IcpgcUjF8ENRuxC0tkmEStXPaC49QSkKgMMUVsQNTsmMzqQxagjfOvufiP1UrOu+Z96itdAfPTn
 9QrKZtx4XV6LGyB0=
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr6659738wmj.57.1567187560847; 
 Fri, 30 Aug 2019 10:52:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNGVAtwOgiQlq+VERkHo7/ts4kIOC6pewmv+KJ2xBtFG6S05bDgkro7tGoNvIS7GS3Cqg30g==
X-Received: by 2002:a1c:23d7:: with SMTP id j206mr6659721wmj.57.1567187560658; 
 Fri, 30 Aug 2019 10:52:40 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id d16sm8270593wrj.47.2019.08.30.10.52.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2019 10:52:40 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190828231651.17176-1-richard.henderson@linaro.org>
 <20190828231651.17176-3-richard.henderson@linaro.org>
 <a7cf962f-eeb3-3628-4f33-c02292d4f07a@redhat.com>
 <50debd18-518a-ab16-2084-8848bd5f39e7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5592f142-429e-5f22-fda4-3f16c3493b90@redhat.com>
Date: Fri, 30 Aug 2019 19:52:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <50debd18-518a-ab16-2084-8848bd5f39e7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/8] exec: Factor out core logic of
 check_watchpoint()
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/19 3:21 AM, Richard Henderson wrote:
> On 8/29/19 10:26 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> -            wp->hitaddr =3D vaddr;
>>> +            wp->hitaddr =3D MAX(addr, wp->vaddr);
>>
>> When is addr > wp->vaddr?
>=20
> Both the watchpoint and the access are arbitrary ranges.
>=20
>   wp:    [ 1000               - 1008 ]
>   store:     [ 1002 - 1004 ]
>=20
>   wp:               [ 1004    - 1008 ]
>   store: [ 1000               - 1008 ]
>=20
> The old code would, for the first case, return 1002 and not the 1000 of=
 the
> watch point, which seems reasonable.  For the second case, we would set=
 1000,
> an address outside of the watchpoint.
>=20
> David's change makes sure that the address signaled is inside the watch=
point.
> I.e. leaving the first case unchanged and making the second  set 1004.
>=20
> It seems very reasonable to me.

Thanks for the very clear explanation :)

If you have time, few lines of comment around would be very appreciated..=
.

Now that it is clearer:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Regards,

Phil.

