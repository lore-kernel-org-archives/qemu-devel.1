Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383B8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CC9E2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CC9E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZUu-0001vD-2q
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMZT9-0000Qx-Un
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMZT8-0004MQ-Rf
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMZT8-0004M6-Ls
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:19:38 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0EE46C047B68
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 15:19:37 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id e14so7432112wrm.21
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tI+UZ/7LHU2zuAO0TsEkmORfX3Yjgf8OSsp1iJet76w=;
 b=Y9FpNAizF47YO18OswiwZ/zOlnTnFo3+mU0tr0lvT+pJVtjZqXrGEcF7dQTx4bQQwQ
 SaFqqf6g3VRfpMqdvABDq6XRY7a9DIEjvqEInpJ1XVlunVe09qThNqQLcSKIzhrtL8eM
 xlHfIBd5gyS4MAvEBne6cUz/run/nUMbt9l8rUxURIaSBIb8TQGcK98vKrvlcisyPX8N
 VWkiLsTZBVmkoldRhs5aX6s4jTkGI/qvDRxx9mGOAtNQHfNkVap4GrOYzQkVViddAElN
 CLfsOQtb3CtywXXP1MxWPkWxaWDeYiKyQIr2+/zEBqyQ5u8WnhK9yvutFvw++anmIJnN
 W45w==
X-Gm-Message-State: APjAAAVwyDwp7ekI38uMAswfw4QoyaCT1WHZsWojxPdZO/Rf5befMcw8
 76mbiqdvIk9nuSh89hpxMwbLSAVu6G9JWlipt7reM7h0UDLGP37VggOn6P9I0DLD9MFkQmonhMG
 yVJ4N9q41j9cXpYY=
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr5661374wru.304.1571671175738; 
 Mon, 21 Oct 2019 08:19:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx50bBCV8ySlcmKQWqldCZsdORQQySDU9AD2KTttwTraLYI791TyZwXcxkckNctd6D5g1I7Qg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr5661352wru.304.1571671175470; 
 Mon, 21 Oct 2019 08:19:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:847b:6afc:17c:89dd?
 ([2001:b07:6468:f312:847b:6afc:17c:89dd])
 by smtp.gmail.com with ESMTPSA id b1sm7581643wru.83.2019.10.21.08.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 08:19:34 -0700 (PDT)
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021145839.12684-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1f02b1f0-1e09-9e89-50e4-5201eac00173@redhat.com>
Date: Mon, 21 Oct 2019 17:19:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021145839.12684-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/10/19 16:58, Peter Maydell wrote:
> Does having tcg/ be BSD-licensed gain the project anything?
> From my point of view I don't really see it as a cleanly
> separable module of code -- it's quite tightly integrated
> with the rest of QEMU, including code in accel/tcg which
> is variously GPL or LGPL.

I think the original idea was to reuse it outside QEMU, for example in
TCC (which is LGPLv2.1+) but that was a while ago.

Paolo

