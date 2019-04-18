Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E688C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62C2217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62C2217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH2Ju-0007su-S9
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:22:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH2J4-0007Xm-24
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH2J3-0004W2-3q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH2J2-0004Vj-IG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:22:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D39230ADBB1;
	Thu, 18 Apr 2019 08:22:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4688F600C2;
	Thu, 18 Apr 2019 08:22:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id CB5B81138648; Thu, 18 Apr 2019 10:21:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Date: Thu, 18 Apr 2019 10:21:59 +0200
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com> (Paolo
	Bonzini's message of "Wed, 6 Mar 2019 19:12:33 +0100")
Message-ID: <87v9zbpvtk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 18 Apr 2019 08:22:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] converting build system to Meson?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>,
	=?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau
	<marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418082159.KNCw2tELpXVgvtzmym_87-GE5NOz_WhzZeqzt2qyptM@z>

Paolo Bonzini <pbonzini@redhat.com> writes:

> Hi all,
>
> lately I have been thinking of converting the QEMU build system to
> Meson.  Meson is a relatively new build system that can replace
> Autotools or hand-written Makefiles such as QEMU; as a die-hard
> Autotools fan, I must say that Meson is by far better than anything else
> that has ever tried to replace Autotools, and actually has the potential
> to do so.
>
> Advantages of Meson that directly matter for QEMU include:
>
> - build definitions in a very readable and user friendly DSL, which
> supports looping and conditions.
>
> - ability to introspect the build definitions so that you can find out
> what is built without building it (the DSL is not Turing complete and
> most objects in it are immutable, so it cannot be abused that much :))
>
> - support for a non-recursive build from per-subdirectory input (similar
> to Makefile.objs)

Could Meson build the $(TARGET_DIRS) non-recursively?

I'm asking because I find the make recursion there annoying.  As usual
with recursion, we have to dumb down dependencies: if anything made by
the recursion needs X, then everything does.  If making X fails, we
don't recurse.  Defeats -k.

> - ease of distributing a full copy of Meson to support distros that ship
> an older version (no dependencies apart from Python 3.5).  At 40000
> lines of Python, Meson is relatively small.

[...]

