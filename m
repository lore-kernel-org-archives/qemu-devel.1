Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49ADCC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F0E21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F0E21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41883 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMyC-0001NS-Bd
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvMxH-0000Be-0G
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:30:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvMxF-0003gj-C1
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:30:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvMxE-0003eV-Tr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:30:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so91653610wrm.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=inpRVJG9V7YMIy/G/lQyU+9pCZGwO5E7/wYny9PixLU=;
 b=Mr4qKLv06YGbTZiXtxXzxY9CDUAoA2CY74LQUh7bhSCce6g2zJKazL4zi74gMdxghm
 Po0JORHNp+HPBkhrABa0GZU8rwtqfAu7W3C7mLyV8ukR4VfNoqcGfH6R2K7yHigrPUMX
 mJThYN9xT/oc2uKrTxTp00tcZ00U79A2WrdTUCH0gKj8+IGTCuqQRiWRYbkgAIHw/vdl
 eozsxrJ/lORfNGVLeFjEpj2eRlzZtwVQpfjdFBXVvTrRGcf39weQ4HRi1tgbSpeHpTqF
 f8759R6zQqotjQyK1tS85sSuig2dOfwAR0Tp/AoB1PymWagsbqMhHTVtoXGOCIYKTli1
 yrvA==
X-Gm-Message-State: APjAAAW5uvFGFprWV7OQjRdBDQ7IRlKWYvNg2BoFPl7YChBhPgStXY0X
 Ao33CS4+t9/EHIXdKBRTD0O9Xrc3XDM=
X-Google-Smtp-Source: APXvYqzKETLBxaTQEKy1Dh7elMdSIG6huPbzpEn4EwLwfmksmW8LIxO+iT9C0D1hF05rQcrfFUtJig==
X-Received: by 2002:a5d:4e90:: with SMTP id e16mr11199463wru.339.1565188212484; 
 Wed, 07 Aug 2019 07:30:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id 32sm85350297wrh.76.2019.08.07.07.30.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 07:30:11 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <87r25xi1y7.fsf@linaro.org> <3bcecd49-bf0e-8503-12d7-ac9dfeb444cb@redhat.com>
 <35301c4b-8743-1e29-0f6e-968afec5faa7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5882e101-19cb-8092-5248-1762625fdcb3@redhat.com>
Date: Wed, 7 Aug 2019 16:30:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <35301c4b-8743-1e29-0f6e-968afec5faa7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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

On 07/08/19 15:33, Eric Blake wrote:
> On 8/7/19 8:06 AM, Paolo Bonzini wrote:
>> On 07/08/19 14:40, Alex Bennée wrote:
>>>
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> The tests/tcg rely a lot on per-target informations from
>>>> the QEMU makefiles, but most of the definitions in there
>>>> aren't really relevant to TCG tests.
>>>>
>>>> This series is just a cleanup, but it could also be
>>>> a useful start in making it possible to compile tests/tcg
>>>> out of QEMU's tree, and/or making it a submodule, and/or
>>>> unifying the system emulation tests with kvm-unit-tests.
>>>
>>> Hmm something is throwing off configure and making it use my login shell
>>> instead of /bin/sh:
>>>
>>>   libpmem support   no
>>>   libudev           yes
>>>   default devices   yes
>>>   ~/lsrc/qemu.git/tests/tcg/configure.sh (line 63): 'case' builtin not inside of switch block
>>>     case $arch in
>>>     ^
>>>   <W> fish: Error while reading file /home/alex/lsrc/qemu.git/tests/tcg/configure.sh
>>
>> It's the ${SHELL} you found in patch 3.  The disadvantage of relying on
>> #! is that some people have bash in /usr/bin/bash rather than /bin/bash.
>>  But we already assume /bin/bash elsewhere so I can drop it.
> 
> Rather, we use '#!/usr/bin/env bash' to find bash anywhere.

Nevermind - this script is pure Bourne shell.  The only fix needed should be

diff --git a/configure b/configure
index eeeda8760a..f216f3f9d9 100755
--- a/configure
+++ b/configure
@@ -6468,12 +6468,6 @@ if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
   echo "warning: Python 3 will be required for building future versions of QEMU" >&2
 fi
 
-(for i in $cross_cc_vars; do
-  export $i
-done
-export target_list source_path
-${SHELL-/bin/sh} $source_path/tests/tcg/configure.sh)
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" >config-all-disas.mak
@@ -7844,6 +7838,12 @@ for f in $LINKS ; do
     fi
 done
 
+(for i in $cross_cc_vars; do
+  export $i
+done
+export target_list source_path
+$source_path/tests/tcg/configure.sh)
+
 # temporary config to build submodules
 for rom in seabios vgabios ; do
     config_mak=roms/$rom/config.mak

