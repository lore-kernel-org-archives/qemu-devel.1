Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C56CC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4200921479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4200921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7N3r-0000Pu-9x
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7N2a-00080A-CL
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7N2Z-0000Oa-BJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:01:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41622)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7N2Z-0000OA-6W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:01:23 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 523E95D66B
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 17:01:22 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id i4so7640391wri.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 10:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PRv2w8D+rIJwG3wlxirXTy58sM70NkkOx7NgjRYdKD4=;
 b=ejYDuDdH0ldtcovUcEzWQlLE1dqabs1lknb5IvV4yj/GiqN2R/pOwp1lkvI+HavhjR
 Wq7Xc+msCqyBn9KAYyXgZC51QLvHAGeCPfg/0ZmhEO0Pl7gFJ1J8CsTEDjHSAvr/GVFz
 RWhbE4zteIMdDkhdd0aIYLq5YDPumIsREmwaWren8Lgg73L2u+NnegyN0VCPsPHIxeik
 TafC2P3Z3IpkzqmX7j44QnuRDBEOjjMYJTMApyDvsaEY0fZOkHUpJ6IlT2UurXaMttTt
 wL/zeHmyhv6aEbjLb1rki6W+wcNb7WtRJcpj3Xxwp1LheeCog8UDZQPNDZs5toYW4pkt
 jk5w==
X-Gm-Message-State: APjAAAWsYuj6KzhovfNhAPOB/Z/VedSuvgGP5lXCd/e6NaOkT6YFxk2w
 HGwfI7f7mKcZEDgrzL0t51jH+5iDB3R6N8nFI7ZM5EDQ7uIoqbCuzld5nwccRw24R3SM+fCFF3a
 292X33AMYg7OhAYs=
X-Received: by 2002:a5d:544b:: with SMTP id w11mr18759322wrv.316.1568048480755; 
 Mon, 09 Sep 2019 10:01:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzz+3YoGcsT6ZP2u/Rcrmgoik0MamSztJa7VD3v++dSclppS/sXALcuFgY18Mmka9/0xp5POg==
X-Received: by 2002:a5d:544b:: with SMTP id w11mr18758828wrv.316.1568048480503; 
 Mon, 09 Sep 2019 10:01:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1?
 ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id h7sm106216wmb.34.2019.09.09.10.01.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 10:01:19 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190807143523.15917-1-pbonzini@redhat.com>
 <CAHFMJ7tA08jsVVJCCcMp3Q+FA3PBKcYNq+yFS7y6Sw5f_K4_oA@mail.gmail.com>
 <87blw06srl.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e8b6d779-2e5b-e1ec-5d32-d2b1d3e83560@redhat.com>
Date: Mon, 9 Sep 2019 19:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87blw06srl.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] tests/tcg: disentangle makefiles
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/09/19 16:27, Alex Benn=C3=A9e wrote:
>> Ping?
>=20
> Sorry I should have said I've queued it to testing/next. I'll post the
> series shortly after I've squashed the last annoying python 3.<>6
> problem.

Great, thanks.

Paolo

