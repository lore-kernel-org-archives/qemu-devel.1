Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87742C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D95E21E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D95E21E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJDP-0000k9-N8
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvJD0-0000Ew-Rm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvJCz-0006Tp-QY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:30:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvJCz-0006TU-Km
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:30:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so90771838wrl.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UM5YvCew+HQNPMQHOpJg9h3QnMPIpS38TT8+gIz4DCg=;
 b=rwmR8sXsVaF1klIJatuqKw4Xm8wrkAq6F4lPL3mPqweo4age6adnUeAGHFd7owPfFp
 lxAMmM25qziEyXT4VmelWsw1abl24LWMbKD0DbwqMKqVBMk7EEwYHD0+yXDCczZBC3u7
 Z5xpk7i2IPox3hm/E1bgwwXyqW0hapYeExr9lbKCxOKuc98BUpvYHxUZDyg3I/QMjpmA
 PkZrIJ32KcvmURyxegLnkKVJZg88wMCM7bGYTH75mMJF0b/peKuWWf/iqIhXANsYh9Ph
 U06EKhI7U3RyM6ikV+aSe5Vyv7lLoVKSkuDIkSd/jthsxo78jglbDe64JyO1qmSAKm5m
 /47g==
X-Gm-Message-State: APjAAAUzya/cZ77RN7vG+qtwUHWnzaq1QLuMkYDZwJHbtIHFWPHh0j6O
 bMGlw6DfWRifKt84gv7QCpiAeJDZEyQ=
X-Google-Smtp-Source: APXvYqyUPkkIsEuOcD+mN4yZxUWTskeczD4JB2gKkmcO6boKgj6vqlrswrVOaaC65OkYzN/rqKyKfg==
X-Received: by 2002:adf:eb4e:: with SMTP id u14mr9922394wrn.168.1565173816417; 
 Wed, 07 Aug 2019 03:30:16 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id u6sm87439734wml.9.2019.08.07.03.30.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:30:15 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-8-armbru@redhat.com>
 <20190807093222.GE13267@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e9cf5ea6-8699-d527-cb52-8d497706c299@redhat.com>
Date: Wed, 7 Aug 2019 12:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190807093222.GE13267@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 07/29] trace: Do not include qom/cpu.h
 into generated trace.h
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

On 8/7/19 11:32 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 06, 2019 at 05:14:13PM +0200, Markus Armbruster wrote:
>> docs/devel/tracing.txt explains "since many source files include
>> trace.h, [the generated trace.h use] a minimum of types and other
>> header files included to keep the namespace clean and compile times
>> and dependencies down."
>>
>> Commit 4815185902 "trace: Add per-vCPU tracing states for events with
>> the 'vcpu' property" made them all include qom/cpu.h via
>> control-internal.h.  qom/cpu.h in turn includes about thirty headers.
>> Ouch.
>>
>> Per-vCPU tracing is currently not supported in sub-directories'
>> trace-events.  In other words, qom/cpu.h can only be used in
>> trace-root.h, not in any trace.h.
>>
>> Split trace/control-vcpu.h off trace/control.h and
>> trace/control-internal.h.  Have the generated trace.h include
>> trace/control.h (which no longer includes qom/cpu.h), and trace-root.h
>> include trace/control-vcpu.h (which includes it).
>>
>> The resulting improvement is a bit disappointing: in my "build
>> everything" tree, some 1100 out of 6600 objects (not counting tests
>> and objects that don't depend on qemu/osdep.h) depend on a trace.h,
>> and about 600 of them no longer depend on qom/cpu.h.  But more than
>> 1300 others depend on trace-root.h.  More work is clearly needed.
>> Left for another day.
>>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  block/block-backend.c         |  1 +
>>  qom/object.c                  |  1 +
>>  scripts/tracetool/format/c.py |  1 +
>>  scripts/tracetool/format/h.py |  7 +++-
>>  trace/control-internal.h      | 25 --------------
>>  trace/control-vcpu.h          | 63 +++++++++++++++++++++++++++++++++++
>>  trace/control.h               | 24 -------------
>>  trace/qmp.c                   |  2 +-
>>  ui/vnc.c                      |  1 +
>>  9 files changed, 74 insertions(+), 51 deletions(-)
>>  create mode 100644 trace/control-vcpu.h
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>


