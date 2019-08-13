Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF34C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE7C206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE7C206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXJg-0003DY-TX
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35321)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hxXJB-0002T4-Ln
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hxXJ9-0001MI-JV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:57:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hxXJ8-0001LN-4w
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:57:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 484023082E44;
 Tue, 13 Aug 2019 13:57:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E65891CC;
 Tue, 13 Aug 2019 13:57:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34A081136444; Tue, 13 Aug 2019 15:57:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
Date: Tue, 13 Aug 2019 15:57:44 +0200
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Tue, 13 Aug 2019 13:49:33 +0100")
Message-ID: <87wofh5fs7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 13 Aug 2019 13:57:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 00/13] softfloat updates (include tweaks,
 rm LIT64)
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
Cc: Richard Henderson <rth@twiddle.net>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> Another iteration of updates for softfloat. Instead of moving the
> LIT64() macro from one file to another we convert the uses to the
> stdint.h macro. I did eliminate one of the uses by converting the
> squash_input_denormal functions to the new style code. However as you
> can see with the follow-up patch it bloated the code a little. I'd
> like to convert the x80 and 128bit FP functions to the new style but
> the challenge is seeing how we can get greater re-use of the common
> functions without bloating the generated code. However if we can do
> that we should eliminate a class of bugs in the current code.
>
> There are a bunch of minor checkpatch complaints as all touched lines
> haven't been fully converted to the proper brace style but I avoided
> do that to make the patch more readable.
>
> The following patches need review:
>    01 - fpu replace LIT64 usage with UINT64_C for special
>    02 - fpu convert float 16 32 64 _squash_denormal to ne
>    03 - fpu optimise float 16 32 64 _squash_denormal HACK
>    04 - fpu use min max values from stdint.h for integral
>    05 - fpu replace LIT64 with UINT64_C macros
>    06 - target m68k replace LIT64 with UINT64_C macros
>    07 - fpu remove the LIT64 macro

Richard had comments on PATCH 02+03.  Should I expect v4?

I'm asking because my '[PATCH v4 00/29] Tame a few "touch this,
recompile the world" headers' is ready, and I want to post the pull
request before it goes stale.  If this series is also ready, I can do
both together.  Else, it'll needs a rebase onto mine (one conflict,
resolving it necessitates a commit message update).

