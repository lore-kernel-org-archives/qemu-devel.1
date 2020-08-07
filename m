Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C37221744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 07:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhStHx6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C37221744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xG8-0006Tm-TH
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 03:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3xFM-00063W-Py
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 03:57:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28509
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3xFI-0008De-Kp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596787014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTHp3psuODV3JlkVE/KCYTero/Uy2hNuXKGsIzBzdB8=;
 b=QhStHx6dOXdUVcF7x2hI799Or9iQvKIjIs/f7eaHE7D+7Ust7bKwx9TbMTPGG9JEArchN2
 L5sqTlez2cT8NfK5FL1wcHsmwwafpOuKVZ8SmrhlDfEnkHaVlS4RsElB6kFoWgyJp1Fgje
 cJd647npnxLnHS0c1rEMM52Jh1egnNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-MxapyYIWO--r1OtWae_2dQ-1; Fri, 07 Aug 2020 03:56:48 -0400
X-MC-Unique: MxapyYIWO--r1OtWae_2dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A05B80183C;
 Fri,  7 Aug 2020 07:56:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B0E45DA7A;
 Fri,  7 Aug 2020 07:56:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFAA01132801; Fri,  7 Aug 2020 09:56:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
Date: Fri, 07 Aug 2020 09:56:42 +0200
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com> (Paolo
 Bonzini's message of "Thu, 6 Aug 2020 21:13:56 +0200")
Message-ID: <87364y28jp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:21:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, alex.bennee@linaro.org,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> This the more or less final version of the Meson conversion.  Due to
> the sheer size of the series you have been CCed only on the cover
> letter.

Perfect timing: right before I drop off for two weeks of vacation.  I'm
excused!  *Maniacal laughter*

> The series reaches the point where Makefile.target and unnest-vars
> can be removed, and all builds become non-recursive.  I have also
> converted parts of the testsuite, notably qtest since it is needed
> for fuzzing.  What's left for _after_ the merge is: 1) unit tests;
> 2) moving the rest of installation to meson (for which I have patches);
> 3) moving feature detection from configure to meson.
>
> Things I still haven't tested:
> - fuzzing
> - non-x86/Linux builds
> - static builds
> - Docker and VM builds
>
> Things I have checked:
> - x86 builds
> - modules
> - "make install"
> - internal slirp/dtc/capstone.

Have you run it through our CI?

> It should be more or less bisectable.  I have not tried building
> _all_ steps, but I have tried both before and after each major one.
>
> Build system rebuild rules seem to work reliably.

Is it faster in common build scenarios?

> After a week or quite intense rebasing, my impression is more or less
> the same as last December: Meson looks more daunting, but it is actually
> much nicer to work with.

Not a particularly high bar to cross: our Makefiles are full of the kind
of black magic that keeps simple things simple (which is quite an
achievement; kudos!), and makes not-so-simple things really hard.

I think it's now time to plan the end game, preferably without even more
weeks of intense rebasing.

Do we have consensus to move forward with Meson?  If yes, I'd like to
propose to aim for merging as early as practical in the 5.2 cycle.
Rationale: rebasing build system changes on top of the Meson work is
probably easier than rebasing the Meson work, and avoids turning Paolo
into an overworked bottleneck.

In more detail:

1. Pick a tentative deadline.

2. Cover the testing gaps and get as much review as we can until then.
   Fix defects as we go.

3. If the known defects are expected to disrupt others too much, goto 1.
   Do not worry about unknown defects at this point.

4. Merge.

5. Deal with the fallout.

Opinions?

> The diffstat so far is not very favorable, but remember that:
>
> 1) the series leaves quite a few nearly-obsolete bits in configure,
> Makefile and rules.mak (over 200 lines only in the makefiles).
>
> 2) configure test conversion will be where meson really shines.  I
> included a couple examples just to show
>
>     meson: convert VNC and dependent libraries to meson
>        4 files changed, 44 insertions(+), 134 deletions(-)
>
>     meson: move SDL and SDL-image detection to meson
>        5 files changed, 30 insertions(+), 144 deletions(-)
>
>     meson: replace create-config with meson configure_file
>        6 files changed, 80 insertions(+), 168 deletions(-)
>
> 3) the idea behind using Makefile generators is to have stable
> code written in a high-level language instead of Makefile magic
> that tends to grow by accretion.  So even though ninjatool is
> large at 1000 lines of Python, it can already be considered mature
> or even "done".  It had only ~15 lines changed since the last post,
> and whenever debugging meson.build issues looking at build.ninja has
> always (literally!) been enough.

The major drawback with generating code is usually having to debug the
generated code.  Your experience of not having to do that is
encouraging.

> Available on git://github.com/bonzini/qemu branch meson-poc-next.


