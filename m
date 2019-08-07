Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D1BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E7721E6B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E7721E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLfx-0001qT-Fx
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvLeA-0007fL-5X
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvLe8-0008Ud-RD
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:06:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51990)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvLe8-0008UM-L7
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:06:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so81773363wma.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1wDs2caTSZ3qZnHCDzAjpJeMd08mUWXzM7/MdJj2lCw=;
 b=Sd8jCVH75WylWuRNgf9QNKbOI81nxjNIEb9aYERRr4dgDlLOiDlukr92LgEAIk0DJc
 0Gllzo5xyN2jhwTqDqh6khlVRFWcNmv+N6zBTGgZIovLZDT9TU1GIfwLSOB8lrF6tY2k
 AfpDjrfOu2BjBedlXgszFTemMMifh/SRXgi5oT1IuDqcMTSArSCXgX+w1X7IxpUfFpOB
 cHWu0ivpVB3oKc5f2Mq1pNY38ZAuJQEktm2/u0BcScAgQ4/v3C3tG7M3RLv5XbEj1u8a
 apWve5ZZV0dPAEb7YiPiMwsDZOHq9hvHCWu36hwsVlk3LcsjJVNCrNCzP+//IBmAjir2
 Ps8Q==
X-Gm-Message-State: APjAAAWkbkh0E7qXQOv0pfaX9wq5ZvV0AsXvhQdDYEeK0W4Woi4C1xnW
 wVK+d/Mm/veMship0jrZUh63tURXKpM=
X-Google-Smtp-Source: APXvYqzQUw7e2PXUlNhazjqMkgOx5JWvO0UVDPEmdblxS7D+6az7p4CiXOvbhN1sRTGzLYdKyExvpA==
X-Received: by 2002:a1c:107:: with SMTP id 7mr10993116wmb.84.1565183187392;
 Wed, 07 Aug 2019 06:06:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id c78sm128178392wmd.16.2019.08.07.06.06.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:06:26 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <87r25xi1y7.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3bcecd49-bf0e-8503-12d7-ac9dfeb444cb@redhat.com>
Date: Wed, 7 Aug 2019 15:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87r25xi1y7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 0/3] tests/tcg: disentangle makefiles
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

On 07/08/19 14:40, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> The tests/tcg rely a lot on per-target informations from
>> the QEMU makefiles, but most of the definitions in there
>> aren't really relevant to TCG tests.
>>
>> This series is just a cleanup, but it could also be
>> a useful start in making it possible to compile tests/tcg
>> out of QEMU's tree, and/or making it a submodule, and/or
>> unifying the system emulation tests with kvm-unit-tests.
> 
> Hmm something is throwing off configure and making it use my login shell
> instead of /bin/sh:
> 
>   libpmem support   no
>   libudev           yes
>   default devices   yes
>   ~/lsrc/qemu.git/tests/tcg/configure.sh (line 63): 'case' builtin not inside of switch block
>     case $arch in
>     ^
>   <W> fish: Error while reading file /home/alex/lsrc/qemu.git/tests/tcg/configure.sh

It's the ${SHELL} you found in patch 3.  The disadvantage of relying on
#! is that some people have bash in /usr/bin/bash rather than /bin/bash.
 But we already assume /bin/bash elsewhere so I can drop it.

Paolo

>>
>> Paolo
>>
>> Paolo Bonzini (3):
>>   tests/tcg: use EXTRA_CFLAGS everywhere
>>   tests/tcg: cleanup Makefile inclusions
>>   tests/tcg: move configuration to a sub-shell script
>>
>>  Makefile                                  |   1 +
>>  Makefile.target                           |   3 -
>>  configure                                 | 155 ++------------------
>>  tests/Makefile.include                    |  25 ++--
>>  tests/tcg/Makefile.include                |  88 ------------
>>  tests/tcg/Makefile.prereqs                |  18 +++
>>  tests/tcg/Makefile.probe                  |  31 ----
>>  tests/tcg/Makefile.qemu                   |  95 +++++++++++++
>>  tests/tcg/{Makefile => Makefile.target}   |  15 +-
>>  tests/tcg/aarch64/Makefile.include        |   8 --
>>  tests/tcg/aarch64/Makefile.softmmu-target |   4 +-
>>  tests/tcg/aarch64/Makefile.target         |  12 +-
>>  tests/tcg/alpha/Makefile.include          |   2 -
>>  tests/tcg/alpha/Makefile.softmmu-target   |   4 +-
>>  tests/tcg/arm/Makefile.include            |   8 --
>>  tests/tcg/arm/Makefile.softmmu-target     |   6 +-
>>  tests/tcg/configure.sh                    | 228 ++++++++++++++++++++++++++++++
>>  tests/tcg/cris/Makefile.include           |   6 -
>>  tests/tcg/hppa/Makefile.include           |   2 -
>>  tests/tcg/i386/Makefile.include           |   9 --
>>  tests/tcg/i386/Makefile.softmmu-target    |  12 +-
>>  tests/tcg/i386/Makefile.target            |  13 +-
>>  tests/tcg/m68k/Makefile.include           |   2 -
>>  tests/tcg/minilib/Makefile.target         |   2 +-
>>  tests/tcg/mips/Makefile.include           |  20 ---
>>  tests/tcg/ppc/Makefile.include            |  10 --
>>  tests/tcg/riscv/Makefile.include          |  10 --
>>  tests/tcg/s390x/Makefile.include          |   2 -
>>  tests/tcg/sh4/Makefile.include            |   4 -
>>  tests/tcg/sparc64/Makefile.include        |   2 -
>>  tests/tcg/x86_64/Makefile.softmmu-target  |  36 +++++
>>  tests/tcg/x86_64/Makefile.target          |   7 +-
>>  tests/tcg/xtensa/Makefile.include         |  11 --
>>  tests/tcg/xtensa/Makefile.softmmu-target  |   4 +-
>>  34 files changed, 435 insertions(+), 420 deletions(-)
>>  delete mode 100644 tests/tcg/Makefile.include
>>  create mode 100644 tests/tcg/Makefile.prereqs
>>  delete mode 100644 tests/tcg/Makefile.probe
>>  create mode 100644 tests/tcg/Makefile.qemu
>>  rename tests/tcg/{Makefile => Makefile.target} (90%)
>>  delete mode 100644 tests/tcg/aarch64/Makefile.include
>>  delete mode 100644 tests/tcg/alpha/Makefile.include
>>  delete mode 100644 tests/tcg/arm/Makefile.include
>>  create mode 100644 tests/tcg/configure.sh
>>  delete mode 100644 tests/tcg/cris/Makefile.include
>>  delete mode 100644 tests/tcg/hppa/Makefile.include
>>  delete mode 100644 tests/tcg/i386/Makefile.include
>>  delete mode 100644 tests/tcg/m68k/Makefile.include
>>  delete mode 100644 tests/tcg/mips/Makefile.include
>>  delete mode 100644 tests/tcg/ppc/Makefile.include
>>  delete mode 100644 tests/tcg/riscv/Makefile.include
>>  delete mode 100644 tests/tcg/s390x/Makefile.include
>>  delete mode 100644 tests/tcg/sh4/Makefile.include
>>  delete mode 100644 tests/tcg/sparc64/Makefile.include
>>  create mode 100644 tests/tcg/x86_64/Makefile.softmmu-target
>>  delete mode 100644 tests/tcg/xtensa/Makefile.include
> 
> 
> --
> Alex Bennée
> 


