Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7FAC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2248120693
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2248120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1zD-0006pp-5Z
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hs1yh-0006Ku-6D
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hs1yg-0006Jq-9S
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:29:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37353)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hs1yg-0006JY-2x
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:29:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so35927311wrr.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I7NkafK7iKCWJePaH6bhgC3xxsuchS6wzyVqLwxmutY=;
 b=f82t/tYRfwA+MK2Fa9mKo1rbuE92PXKrJwtQndLNr4Ur3n/zGL8sPcWpiw0hPHTwSV
 FjqRsdWy2a5k0E+I17bKZRZB9g2juWH1TVfA289dFRVIYnGgq4bZ82KFU1vI/mRLDSO5
 VVHVM0TWFSLrbpuGdl1GGLIg01pwefUX+rq6DWRl9MI59G57chR022mVx070iLY0uX75
 Wj6WP6uH3LDqSstPHGt/ZnrhFNviMqINr8Xt2P2xt71+AXL2Od/VxGE6xa7Pl81uvJIg
 6/EEBDYGvKwurEiSzOdlkOHkuZZB2DkNMusamVsge0KQYfFGjUs8eLKc/Db/9pdw9850
 PL1w==
X-Gm-Message-State: APjAAAWwuMS9jA0yK95TdK2Ys7u8u6dEqtdSeO5ubWDnaYu43++5YGYb
 mK1wo4UDhwfytYAlaIyWsF3Vb3B4kMo=
X-Google-Smtp-Source: APXvYqyDcBrJDuf2ecY/YKpkDLRKZ9tRdXQFg68NBKIMjovMr5u4SM19LCKjyfXlFTIK+YIeCPn9bw==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr123527799wrr.147.1564392596864; 
 Mon, 29 Jul 2019 02:29:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id c4sm48251389wrt.86.2019.07.29.02.29.55
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 02:29:56 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
 <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
 <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <aa4801a9-ad0f-a6b8-e167-1fc5f4e6925e@redhat.com>
Date: Mon, 29 Jul 2019 11:29:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 11:21, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 09:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> There is no case where we're using per-.o file CFLAGS for anything other
>> than dependencies.
> 
> disas/libvixl is a counterexample -- we use per-.o-file CFLAGS for:
>  * suppressing warnings in third-party code we don't want to
>    carry local modifications to
>  * dealing with a NetBSD weirdness about header inclusion order

The NetBSD thing could be worked around with a static library but
instead those -D options could be added as global C++ flags:

    __STDC_LIMIT_MACROS and __STDC_CONSTANT_MACROS are a workaround to
    allow C++ programs to use stdint.h macros specified in the C99
    standard that aren't in the C++ standard.

Likewise, the -Wno-sign-compare probably should be added to all files
for GCC <=4.6, but in fact we don't support anymore GCC 4.6 so it can go
away.

Paolo

