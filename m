Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A262C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6C02085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6C02085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRUG-0000mb-IM
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46655)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgRRu-0007hA-A2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgRRt-0007Ih-38
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:16:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53103)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgRRs-0007Ea-Se
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:16:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so5152393wms.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GQnycGQAUslwSC0Yblf4RS8efXdMfWm90KEG77Wbd+o=;
 b=sF2i7tTtKPsuo670d3nOSvtus4Dh2RGehJ5f/renTVaMFONZRbuWbBBgFTHQvB6GLE
 XjJNMz1bq6TOJKuU3FkxoFMxq/GZ+JW2UJdltZazbHwe9l2UiGsW0kWUIQsht1LDHcnU
 YB73gN64Yy57xdw6LTIfRgTrLKwf+XEAqdyMJPfI+4+ZxGTd83sMdPddaDCUZ2H22CfC
 0cLuZd+PRrHXuizEwY7349lEPbGvSzPAH80SfNJfL1Ojl2JBdgau3DpRNGOEKRuBM7Cy
 i7yHm6SiF9SH8cZHZpyD6FvIRLqAuiRNASyqhjJ4T5gd0CFb/G/sh4YVX3qvjkWOiBJN
 Ro/g==
X-Gm-Message-State: APjAAAXAJ/wtv0F2G4ZUn46z4pecOvZjealdkzuBT0xSUbYC9cHWiNx1
 73yiaA2V401IQUWyNSSh3so8QTbpQEI=
X-Google-Smtp-Source: APXvYqwC+RTAAvcx5KebV9W8BNycy8VZ4np7Z+NR3i1Laktuu5ItvuQZeQMh/RwNaWQJ/7CDnZyTrw==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74mr2790638wmg.43.1561630567769; 
 Thu, 27 Jun 2019 03:16:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:41bc:c7e6:75c9:c69f?
 ([2001:b07:6468:f312:41bc:c7e6:75c9:c69f])
 by smtp.gmail.com with ESMTPSA id o126sm5814629wmo.1.2019.06.27.03.16.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 03:16:06 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
Date: Thu, 27 Jun 2019 12:16:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627090353.GA24929@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 11:03, Daniel P. Berrangé wrote:
> On Mon, Jun 10, 2019 at 01:14:57PM +0200, Paolo Bonzini wrote:
>> The Meson build system is integrated in the existing configure/make steps
>> by invoking Meson from the configure script and converting Meson's build.ninja
>> rules to an included Makefile.
> 
> Why did you take the route of converting ninja rules into makefile
> rules, as opposed to just having some stub makefile rules which
> directly invoke ninja where needed ?

There are two parts of this.  One is practical and has to do with
supporting a step-by-step transition.  Using ninja2make makes it trivial
to have make build products that depend on meson build products, and
this way bottom up is a natural direction to do the conversion, which is
bottom up.  You'd start from libqemuutil.a and code generators (tracing
+ QAPI), then go to the tools and the emulators.

The second is a design decision that simplifying the Make/meson
integration is *not* a goal.  Rather the goals are: 1) making the
transition easier on developers; 2) avoiding magic in meson.build at all
costs.  More specifically:

- it should remain trivial to do things that used to be trivial, and
most "make" invocations should be kept the same at least until
everything is converted and we can perhaps declare a flag day.  People
are used to "make check" or "make subdir-x86_64-softmmu", those should
continue to work while the transition is in progress.

- it should be possible to modify meson.build without knowing QEMU
specific details, and that should be _already_ possible now at the
beginning of the transition (to avoid creating technical debt).  This
means keeping the magic confined in Makefile rules and external scripts,
while having a pretty plain meson.build.

I expect testing might also require some hand-holding, because "meson
test" does not integrate with "make -j" and to keep supporting our "make
check-*" targets.  However, until the make->ninja flag day we could
generate tap-driver Makefile rules from "meson introspect --tests"
output.  Basically I'm dropping Makefile magic in favor of build rule
generators are written in high-level languages.

> Obviously this series is just some initial integration, but eventually
> when we get a complete conversion, I think it will look pretty wierd
> if we're still converting ninja to make.

I agree; once all the build rules are converted the Makefile could be as
simple as

	all:
	include config.mak
	include tests/docker/Makefile.include
	include tests/vm/Makefile.include
	.NOTPARALLEL:
	%:
		ninja $@

	subdir-%-softmmu:
		ninja qemu-system-$*

	subdir-%-linux-user:
		ninja qemu-$*

	check:
		$(MESON) test

	check-%:
		$(MESON) test --suite $*

etc. (and likewise the configure script could just translate the command
line options before invoking meson).  But for now, since rules are
written half in meson and half in make, ninja2make seems the most
transparent way to integrate the two.

> Part of the downside of our current build system is that although it
> uses make, the usage is wierd and QEMU specific structure. It would
> be a shame to pick meson and then again use it is a way that is wierd
> and QEMU specific.

I agree, this is why it's important to have at least a standard meson.build.

Some knowledge of config-host.mak is needed, because meson.build uses
declare_dependency() instead of dependency() to link with libraries that
were already found by configure, but that's it.

Paolo

