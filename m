Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C79C48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB1D214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 17:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52935 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXqj-00088e-IB
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgXWE-0006Vg-ED
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgXWD-0004c3-FG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hgXWD-0004az-6o
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 72217308427C;
 Thu, 27 Jun 2019 16:45:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5A21001DFD;
 Thu, 27 Jun 2019 16:45:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB01211386A0; Thu, 27 Jun 2019 18:45:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <87tvcbc9ul.fsf@dusky.pond.sub.org>
 <655a1ac0-bbd9-9798-4e44-478f94afb86f@redhat.com>
Date: Thu, 27 Jun 2019 18:45:02 +0200
In-Reply-To: <655a1ac0-bbd9-9798-4e44-478f94afb86f@redhat.com> (Paolo
 Bonzini's message of "Thu, 27 Jun 2019 18:01:13 +0200")
Message-ID: <87ftnvasfl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 16:45:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Should configure --enable-debug add -Og to CFLAGS?
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/06/19 17:43, Markus Armbruster wrote:
>> The fine manual advises:
>> 
>> '-O0'
>>      Reduce compilation time and make debugging produce the expected
>>      results.  This is the default.
>> [...]
>> '-Og'
>>      Optimize debugging experience.  '-Og' should be the optimization
>>      level of choice for the standard edit-compile-debug cycle, offering
>>      a reasonable level of optimization while maintaining fast
>>      compilation and a good debugging experience.  It is a better choice
>>      than '-O0' for producing debuggable code because some compiler
>>      passes that collect debug information are disabled at '-O0'.
>> 
>> Our configure --enable-debug effectively picks -O0.  Should it pick -Og
>> instead?
>> 
>
>     commit 48e56d503e18bd1e8a75463fd7cc1580bf7e7650
>     Author: Paolo Bonzini <pbonzini@redhat.com>
>     Date:   Tue Mar 6 11:32:44 2018 +0100
>
>     Revert "build-sys: compile with -Og or -O1 when --enable-debug"
>
>     This reverts commit 906548689e37ab6cca1e93b3f8d9327a4e17e8af.
>     Even with -Og, the debug experience is noticeably worse
>     because gdb shows a lot more "<optimised out>" variables and
>     function arguments.
>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> :(

Aha, GCC's documentation is more aspirational than factual here.
Nevermind!

