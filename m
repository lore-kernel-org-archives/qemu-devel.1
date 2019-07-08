Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739B7C606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B68920656
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B68920656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQsQ-00065P-FU
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkQrl-0005BK-TE
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkQrj-0003sz-W0
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:27:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkQrh-0003p1-Vo
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:27:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so15180659wmj.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 03:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bFeRc1s0e2lxaO0RdWKFfirN1xBhTJlFi5uOrqdkySk=;
 b=q4eQpJ3crKRdGCscGuE2gCQdNuOAUUg7tYyxZI0c3ijHlY78LZ+24PTKw5hZ/AK1gQ
 xkWXXxjBb6QWsryCfksF4K8nSq4WSP7qEj0AhOrbBD4wW44YZavJNs34MbewixnRqtqX
 zRytrDreRb1VAyglxhMZPO7H4F0qhaWQq957xL+s02dl6l5H2cznO9Ci7n8QQIjkUCTW
 RHYUYLZUK5EwYTfD2uc27U8aYKzFRhv3uMsDsDjyC3SvMd5pTl9PPp/TBIWPv1e7zDY4
 1p97Koh2cQdsHRP4kgV97x2heuUzO1ARYgnHzNvkK7Ti6MTH+QQm9QM0fmbfC+UFMb51
 wdOA==
X-Gm-Message-State: APjAAAUqU2INGmxzRvy3a74vn7ajefkpwJLUmf774H7LBkjTsyedh/BA
 zT1VRpPKBpsX2KZDds18Zd0LNA==
X-Google-Smtp-Source: APXvYqxN+G/nj66fU7aihqmJvdECwU4se3xYcrxeI3iTsNC8TsyKKA0PZGg5JR/58B4I2D5l9Xo/XA==
X-Received: by 2002:a05:600c:291:: with SMTP id
 17mr16067300wmk.32.1562581634198; 
 Mon, 08 Jul 2019 03:27:14 -0700 (PDT)
Received: from [192.168.1.103] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id o6sm31398725wra.27.2019.07.08.03.27.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 03:27:13 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
 <87d0iok4ai.fsf@dusky.pond.sub.org>
 <c4997dee-932c-eb57-23b9-4b51e8856f91@redhat.com>
 <874l3zhktx.fsf@dusky.pond.sub.org> <20190708093400.GB3082@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e396d430-1e6e-2e0b-454b-5c4208756742@redhat.com>
Date: Mon, 8 Jul 2019 12:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708093400.GB3082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/19 11:34 AM, Daniel P. Berrangé wrote:
> On Sat, Jul 06, 2019 at 06:02:18AM +0200, Markus Armbruster wrote:
>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>
>>> On 7/5/19 3:19 PM, Markus Armbruster wrote:
>>>> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
>>>>> On 7/5/19 10:07 AM, Stefan Hajnoczi wrote:
>>>>>> On Thu, Jul 04, 2019 at 11:28:37AM +0100, Daniel P. Berrangé wrote:
>>>>>>> On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote:
>> [...]
>>>>>>>> What is the concern about adding these environment variables to QEMU?
>>>>>>>>
>>>>>>>> It is convenient to be able to use tracing even if QEMU is invoked by
>>>>>>>> something you cannot modify/control.
>>>>>>>>
>>>>>>>> The main issues I see with environment variables are:
>>>>>>>>
>>>>>>>> 1. Security.  Is there a scenario where an attacker can use environment
>>>>>>>>    variables to influence the behavior of a QEMU process running at a
>>>>>>>>    different trust level?
>>>>
>>>> The common (and sad) solution for this is to require whatever runs $PROG
>>>> at a different trust level to scrub the environment.
>>>
>>> I hope people concerned by security build QEMU with the NOP trace backend.
>>
>> I sure hope at least one of our tracing backends (other than nop) can be
>> used safely in production.

I'm not saying production and security are orthogonal, but recent trend
in security seems to reduce code exposure by disabling component, so I'd
not be surprise if people who primary concern is strong security to use
the NOP trace backend as default.

> AFAIK, *all* of the trace backends are safe for use in production. The
> only questions are around performance in production.  If anyone knows of
> any security problems with specific backends we should either address them,
> or document the backend is unsafe.

I hope the tracing backend/frontends are safe. Now the trace events log
a bunch of interesting information, so I'd not be surprise if some
security researcher open a "QEMU information leak" CVE because we log
various guest pointers i.e.

Anyway, to stop bikeshedding this thread, can you add few lines about
why not use getenv() in the HACKING?

Thanks,

Phil.

