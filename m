Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813FEC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F5321E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F5321E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLiV-0006Yo-LW
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvLhq-0005SU-00
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvLhp-0002pj-1N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvLho-0002ob-Qb
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:10:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id p13so16747343wru.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BK3m+LNHNyJy6xLT81CVbY6jzob72XNSJLLxBMAvlWk=;
 b=bgEV1A5Kx+UfYUkqqKa70EWCS4zP2XhhHovacpLSIaa+tD3RIfo3CrERpAxoODd6sb
 bL5E2HvxtvCIoC4kt3XOc5OdWp36Tg/6EjgVl4bhmcnx1Dr7fB5qNDvY9LmH8ZbeYNhi
 n4KbqChtkQ9ZTj+bIT+CDqKP8srfCRGRWZJ6VodataKgye1fApwHVdLCTCEwwFvoie4B
 p3cApixHgliJCe0F+K5CKe6TIA2yuCfijRYwSqEHW2Uqa4JHuwXChQs17SxfCv5WtWFC
 8VPfdfJ/8dzP7lYdnAneSsFS72JNW/AeCMGg+ZD2t/LVwfn0syFyUilRVJEeFG5qwO+K
 HucQ==
X-Gm-Message-State: APjAAAVJvgVczknUk14Ovf+4SVcgb5fASKdXJNGLOQTtopwWJ8+LP80R
 CX+pTbkRZVlam/eyUtnJl+OnJjFiyRg=
X-Google-Smtp-Source: APXvYqxQf/aN1jib2qPdOD6IFNsM/GPdzisevQKwffx85j2IAfLIneDUKobRrxrIemerxaJv21fE3Q==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr10737405wrv.247.1565183414720; 
 Wed, 07 Aug 2019 06:10:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id a2sm95045633wmj.9.2019.08.07.06.10.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:10:14 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-2-pbonzini@redhat.com> <87o911i1fg.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <47a7ff81-4362-ac1a-a95c-4105e4682f3f@redhat.com>
Date: Wed, 7 Aug 2019 15:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87o911i1fg.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/tcg: use EXTRA_CFLAGS everywhere
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 14:51, Alex Bennée wrote:
>> For i386 specifically, this allows using the host GCC
>> to compile the i386 tests.  But, it should really be
>> done for all targets, unless we want to pass $(EXTRA_CFLAGS)
>> directly as part of $(CC).
> Hmm well for softmmu the tests take the decision:
> 
>   # For softmmu targets we include a different Makefile fragement as the
>   # build options for bare programs are usually pretty different. They
>   # are expected to provide their own build recipes.
> 
> So we are not expecting to handle multi-classing the system compiler to
> generate different binaries with a common build string.

We almost do, since we have

case "$cpu" in
    i386)
           CPU_CFLAGS="-m32"
           LDFLAGS="-m32 $LDFLAGS"
           cross_cc_i386=$cc
           cross_cc_cflags_i386="$CPU_CFLAGS"

So you can compile with "./configure --cpu=i386" and have it use "gcc
-m32" as a cross compiler on x86_64, also for TCG tests.  So it seemed
half-baked to me.

> To be honest I
> wonder if we should just drop the EXTRA_CFLAGS shenanigans in favour of
> an explicit compiler per target?

I don't know.  I think supporting "gcc -m32" on x86_64 is a good idea
though.  Yet another possibility is to use "--cross-cc-i386='gcc -m32'"
directly, but that would be a separate patch.  For these I really wanted
to have no semantic change.

Paolo

