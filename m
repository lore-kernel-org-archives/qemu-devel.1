Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924A7C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:02:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616EF2085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 13:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616EF2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgU2p-0006Is-Oi
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgTzr-0005jg-1E
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgTzp-0005no-Pu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:59:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgTzp-0005mv-Jj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:59:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so2432842wre.12
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Lvr6L15N+7nvfRl9EwfpRrHBBp/1/kXCVBnglf06x0=;
 b=stvwLTYfEEoGzPFJYWRe9DRaDHdmfFCg08bGDgc1CAk3dTiH/3fkz0UObrQ9EPISkD
 XTfTy3E/p3pbOjTd4D3Wd/UoIKj6Voea7zMs3gWT4+D5W5zJa5BEiFRPQbMm00bIg2Pn
 g9zNDCVF68fs2I5x0ahiCl6ECcZkBt959YMD9Il1QTu08/0hORlH+tmF/kmbtE4xuReR
 Hp2DY9lNloltNmDrZ+iMeIxBOEF5G3+dxPtffLkZ+5i3o9UkKREGyAWgfWY+rSCR3c5x
 Frlk2TS4Q+/4ueSLF69KhEChBowE0HzQ5iZLEZBHv7LQklUbnbHON/klzqF1YeGAJ3vN
 8xxw==
X-Gm-Message-State: APjAAAXaotJCuQkLSmOBDk31rK5L0motVvV6IHOaTpydH2kfanALs0ua
 rlM8JbO/b2N5Fiwo1f8wTRyQl3PXc/Y=
X-Google-Smtp-Source: APXvYqzfI11HgH5uqDWUrh3LHysSnb4tyJhQPYtli/TPfbdN5loNByU5ULZ+RJSrvKXWsDsCMlRfsQ==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr3092738wrm.218.1561640364017; 
 Thu, 27 Jun 2019 05:59:24 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b6sm1421565wrx.85.2019.06.27.05.59.23
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 05:59:23 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
 <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
 <87blyjfc87.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef92c495-bb7d-01fb-6c3a-3dd6ae47c46c@redhat.com>
Date: Thu, 27 Jun 2019 14:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87blyjfc87.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 14:23, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>> On 27/06/19 11:03, Daniel P. Berrangé wrote:
>> There are two parts of this.  One is practical and has to do with
>> supporting a step-by-step transition.  Using ninja2make makes it trivial
>> to have make build products that depend on meson build products, and
>> this way bottom up is a natural direction to do the conversion, which is
>> bottom up.  You'd start from libqemuutil.a and code generators (tracing
>> + QAPI), then go to the tools and the emulators.
> 
> *If* the conversion is too big a task to permit doing it all at once,
> then the step by step strategy you describe makes sense to me.
> 
> The trouble with step by step is running out of steam before the final
> step.  That would leave us worse off.  Even an overly protracted
> conversion would be bad.

Agreed.  But hey, Makefile.objs is 2000 lines of lists of files, it is
boring but it cannot take that long to convert.  So it's not really
about being _possible_ to do it all at once, it's mostly about the
manageability of conflicts.

> Thus, my standard question on any proposed step-by-step conversion:
> commitment to finishing it?  I'd be quite happy to take your word for
> it.

I cannot really make such a commitment now, but perhaps I can (or I and
someone else can) once a little more of the conversion is ready.
Especially QAPI and trace generators, since those are where most of the
magic resides.  I can try that since your reaction wasn't of total
disgust. :)

>> The second is a design decision that simplifying the Make/meson
>> integration is *not* a goal.  Rather the goals are: 1) making the
>> transition easier on developers; 2) avoiding magic in meson.build at all
>> costs.  More specifically:
>>
> Your plan confines new magic to "Makefile rules and external scripts".
> We'll get actual reduction only if we can retire or at least radically
> simplify them at some point.

But even before that, we'll get *practical* reduction if it hacking the
Makefile rules and external scripts becomes rare enough.  See for
example kconfig, where # of people hacking minikconf.py is much less
than # of people hacking default-configs.

> I'm more ambivalent on (1).  Yes, making the transition easier for
> developers is worth hiding a certain amount of magic out of their way.

It's especially worth during the transition.  Once Makefile.objs is gone
I agree we can afford more radical changes, but let's cross that bridge
when we get there.

>> I expect testing might also require some hand-holding, because "meson
>> test" does not integrate with "make -j" and to keep supporting our "make
>> check-*" targets.  However, until the make->ninja flag day we could
>> generate tap-driver Makefile rules from "meson introspect --tests"
>> output.  Basically I'm dropping Makefile magic in favor of build rule
>> generators are written in high-level languages.
> 
> A PoC for selected tests would be nice.

Fair enough.

> Ignorant question: could the switch to Meson enable doing less in
> configure?  It's big and sloooow.

It would be smaller since the DSL is more compact than shell scripts,
probably not much faster as the same tasks still have to be done.  But
perhaps in the future Meson can parallelize them, and then we'd get that
for free.

Paolo

