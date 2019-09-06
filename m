Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E5FC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33B120838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPFsCsvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33B120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6KIJ-0001l8-0K
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6KHS-00010q-Eo
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6KHQ-0007Ag-Ri
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:52:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35727)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6KHQ-00079e-Ep
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:52:24 -0400
Received: by mail-wr1-x442.google.com with SMTP id g7so7799179wrx.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=2v+08++CQDqgk/ESOt4jGHqig40orXN4oX1wqCmG8jQ=;
 b=IPFsCsvG5HI05uN8yxrlgiy8ZV0VakaFOKGTWLTQAoVtH7pTu9827pk5+/bcZmRE2o
 mCbyCrIz3Ct42BFi435It5AhET3vJPzmBHMrz66Apr32Wl/PhJ8MAPyOTRuvZrqPriUC
 huKPZBuCXGUiGLfm42tXth07IMRCe+lz6QV372bhPKDaHOIwHtA85cIQj+Z5IRbTSOe4
 bgD9kTpEw4wsfCCG3qKUjMlnL4KXCA19ciDG2Y8m3m7imWpDoN3BNMOjPcUDU0u3HILB
 sH1ahU4o/xr3cxx9yBfhA/4oixOpaOzGH0bOLOpyn3m1cswUSn2U0/WaUP9XCi985YEw
 +xuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=2v+08++CQDqgk/ESOt4jGHqig40orXN4oX1wqCmG8jQ=;
 b=uivSAu9QlDmnMjDZ6GxsG65sSiSDIe9Hbnv3aMbYX80KZWBTkDEmSisPIZT3aHiafE
 5cDF5E/nYNkhivuE7OeCRtCBWD6sBrMIF8E3q/8f5l4cBMUoLI+q6Io8IX20a83ISrM9
 oqcR8n8CIe3wQ3TeuLk1SUUl4ha4LRWxEQeO57RPE9zh+okDudEDQJXIUOH0txeHnYOz
 z7nE2Oc7QHchWTNJlXC/NDumGnndjvGAG+SYPwWqn5WfmmPGrn4sSiiGuIMle2JgfWL3
 slozlRwxx/4Cgku3rsFuE04eZyLaJIi4ZSt1rz68/KB2/6OKA5XeXphSlb1B/j22qmLO
 y1HA==
X-Gm-Message-State: APjAAAWU8xTW3308WkJQhd3PlKPsiRqIC7VQa/PCjMQ62wQ5mbXEPjhW
 6rBy2MdJRyptFPbxMyto3ziYIw==
X-Google-Smtp-Source: APXvYqxRlHONFGfmC+qHJD+ywr9ETvLE6Z/ZM1bZz+tuCgZGSz2YTN1Q1vKCGU/xPjVL+oHpX1PIpw==
X-Received: by 2002:a05:6000:14d:: with SMTP id
 r13mr8688216wrx.136.1567799543081; 
 Fri, 06 Sep 2019 12:52:23 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o22sm12257114wra.96.2019.09.06.12.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 12:52:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C10FF1FF87;
 Fri,  6 Sep 2019 20:52:21 +0100 (BST)
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87a7cty0tv.fsf@dusky.pond.sub.org>
Date: Fri, 06 Sep 2019 20:52:21 +0100
Message-ID: <875zm5yzgq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
Cc: bobby.prani@gmail.com, cota@braap.org, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Hi,
>>
>> This is the latest iteration of the plugins series. The main changes
>> from the last version are:
>>
>>   - dropped passing of haddr to plugins
>>
>> This makes the code for handling the plugins less invasive in the
>> softmmu path at the cost of offloading processing to the plugin if it
>> wants the value. We rely on the fact that the TLB is per vCPU so a
>> helper can just trigger a re-query of the TLB to get the final
>> address.
>>
>> Part of that change involved embedding the MMU index in the meminfo
>> field for tracing. I see there are some other patches on the list for
>> messing with TCGMemOp so there might be a clash coming up.
>>
>>   - translator_ld goes direct to softmmu/user functions
>>
>> I also mark the [SOFTMMU_]CODE_ACCESS helpers as deprecated. There is
>> more work to be done to clean up all the current uses of code access
>> helpers but ideally the only thing that should be peaking at code is
>> the translator loop itself. However a bunch of helpers have taken to
>> using code loading functions to peak at the instruction just executed
>> to figure out what to do. Once those have been fixed then we can
>> remove those helpers.
>>
>> Other more minor fixes can be found documented bellow the --- in the
>> individual patches.
>>
>> This series also includes the semihosting patches as they are a
>> pre-requisite for the translator_ld patches for ARM.
>>
>> Once the tree opens up for development again I hope to get the
>> semihosting and trivial clean-up patches merged quickly so the patch
>> count for the plugins patches proper can be reduced a bit.
>
> Next time, please explain briefly what TCG plugins are about right in
> your cover letter.  I had to go hunting for this.  Found "[PATCH v4
> 11/54] docs/devel: add plugins.rst design document".

I'll provide a better overview in my next cover letter.

> Please advise why TCG plugins don't undermine the GPL.  Any proposal to
> add a plugin interface needs to do that.

I'm not sure what we can say about this apart from "ask your lawyer".
I'm certainly not proposing we add any sort of language about what
should and shouldn't be allowed to use the plugin interface. I find it
hard to see how anyone could argue code written to interface with the
plugin API couldn't be considered a derived work.

There are two use cases I have in mind:

The first is FLOSS developers writing interesting tools that can take
advantage of QEMU's control of the system to do experiments that are
tricky with other setups (Valgrind is limited to same-arch, Dynamo/Pin
are user-space only). I want these experiments to be easy to do without
having to keep hacking and re-hacking QEMU's core code. I would hope
QEMU developers would up-stream theirs into the QEMU source tree but I
can imagine academics will have open source code that will only ever sit
in their paper's repository.

The other is users who currently maintain hacked up internal copies of
QEMU as a test bed for whatever piece of silicon they are brewing behind
closed doors. This code would never be distributed (hence never be a GPL
issue) and is generally kept private because it's IP sensitive
(e.g: experimenting with different cache models). If we can provide an
interface that allows them to keep their experiments private and
separate from changes to the core code then maybe apart from making
their lives a bit easier we will see some non-IP sensitive contributions
come back to the upstream. I live in hope ;-)

--
Alex Benn=C3=A9e

