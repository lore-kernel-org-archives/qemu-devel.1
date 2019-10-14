Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE38CECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40C320673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40C320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyNy-0004c4-G7
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iJxvs-0008CL-Qo
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iJxvr-0006q3-Jt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iJxvr-0006nW-B2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:31 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C30CD4E93D
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:50:29 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id n3so8341866wrt.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V43bapXD9sw+8B2T8zYi3/HKJs0Z97NhDdKGfhiLmvg=;
 b=kfUx9NvOU7ZlxhVdxOkRX1Jr2pOehRwN7uKfTzkWCM+2R5i16X7h9GqMDyxyui+n3G
 BceVq3ax73bIiIGARFtJvl2tF24wlklNsTv5Dnw25M2fB3K6pxa8jf43U9drgog5rKlH
 pDXn1rvk+SxmdFHZFIhzfy4Mk2GWFxKPav86nWBRCmYUNY9hdaQSHLb+VJ+aquL2QZsN
 bzHToWuyFaNEOSkXXItJqpUfv9pid+xpLLQ8IwLNQF485aMyZ5hcxE4yNvLq+g3aHwI+
 P7joc9Nn3b1HMJZKTboS0K7RIdIdE0b6f9oUhnZlWAiRkUB+3iIWuACJlBzuVBY7rqHa
 /1rQ==
X-Gm-Message-State: APjAAAWD1txUC/myrAFowY22agxM+rbY/xJDRDwiISyNVuy4JX6U4H0m
 B0ZJx/uyppxp5bYsz4oqyxQymhAnakyHHzlrK7HJjy29SnYoaRUbnUqGqvFsuLd7+hvaDshCS4c
 mEi+HsaeJEX92zVQ=
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr9789100wrs.158.1571050228407; 
 Mon, 14 Oct 2019 03:50:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzshqAW2qTgkX2LORW01nrJB4emyGvZ2FasA5UcuhfVHMKosIU4CLAkiOueeC95Wn/+QTdedQ==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr9789076wrs.158.1571050228071; 
 Mon, 14 Oct 2019 03:50:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id n7sm19337857wrt.59.2019.10.14.03.50.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 03:50:26 -0700 (PDT)
Subject: Re: test-aio-multithread assertion
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
 <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
 <CAFEAcA_cAaJ7Q=FNf8dZJuGAjjuCANW2QkMFFjfSLaSAFBN6Vw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f4cfc080-2084-0da5-e3ad-2f65aaed41d5@redhat.com>
Date: Mon, 14 Oct 2019 12:50:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cAaJ7Q=FNf8dZJuGAjjuCANW2QkMFFjfSLaSAFBN6Vw@mail.gmail.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/19 12:26, Peter Maydell wrote:
> On Thu, 5 Sep 2019 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Wed, 4 Sep 2019 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>
>>> Hi; I've been seeing intermittently on the BSDs this assertion
>>> running test-aio-multithread as part of 'make check':
>>>
>>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>>> tests/test-aio-multithread -m=quick -k --tap < /dev/null |
>>> ./scripts/tap-drive
>>> r.pl --test-name="test-aio-multithread"
>>> PASS 1 test-aio-multithread /aio/multi/lifecycle
>>> PASS 2 test-aio-multithread /aio/multi/schedule
>>> ERROR - too few tests run (expected 5, got 2)
>>> Assertion failed: (!qemu_lockcnt_count(&ctx->list_lock)), function
>>> aio_ctx_finalize, file /home/qemu/qemu-test.kaRA0o/src/util/async.c,
>>> line 283.
>>> Abort trap (core dumped)
>>> gmake: *** [/home/qemu/qemu-test.kaRA0o/src/tests/Makefile.include:905:
>>> check-unit] Error 1
>>>
>>> Anybody got any ideas?
>>
>> Here's a different intermittent assertion on Netbsd from test-aio-multithread:
>>
>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> tests/test-aio-multithread -m=quick
>> -k --tap < /dev/null | ./scripts/tap-driver.pl
>> --test-name="test-aio-multithread"
>> PASS 1 test-aio-multithread /aio/multi/lifecycle
>> PASS 2 test-aio-multithread /aio/multi/schedule
>> assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
>> "util/async.c", line 279, function "
>> aio_ctx_finalize"
>> ERROR - too few tests run (expected 5, got 2)
> 
> Just saw this QSLIST_EMPTY(&ctx->scheduled_coroutines) assertion
> from FreeBSD as well, so it's still around as a definite
> intermittent.

This could be similar to what Stefan fixed in commit 2362a28ea1, only in
the test infrastructure.

Paolo


