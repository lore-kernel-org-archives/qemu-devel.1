Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF14C7618A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 05:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED5120644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 05:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmtTr-0000RF-7z
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 01:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hmtTf-0008U9-6Z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hmtTe-0005FS-35
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48120)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hmtTd-0005D7-TX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 01:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 553278535D;
 Mon, 15 Jul 2019 05:24:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5EC55C232;
 Mon, 15 Jul 2019 05:24:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 29A081138648; Mon, 15 Jul 2019 07:24:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
 <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
 <20190708101919.GF3082@redhat.com>
 <267315a5-9969-9bfb-b4f6-57c61890fae4@ilande.co.uk>
 <87lfx4wry6.fsf@dusky.pond.sub.org>
 <98789380-7402-535b-0db9-b6c90af2f161@ilande.co.uk>
Date: Mon, 15 Jul 2019 07:24:36 +0200
In-Reply-To: <98789380-7402-535b-0db9-b6c90af2f161@ilande.co.uk> (Mark
 Cave-Ayland's message of "Fri, 12 Jul 2019 20:34:26 +0100")
Message-ID: <87lfwzzx7v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 15 Jul 2019 05:24:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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
 Philippe =?utf-8?Q?Mathieu-Dau?= =?utf-8?Q?d=C3=A9?= <philmd@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:

> On 11/07/2019 15:45, Markus Armbruster wrote:
>
>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>> 
>>> Something also looks a bit odd with distclean here on a fresh checkout:
>>>
>>> build@ezio:~/src/qemu/git/tmp/qemu$ make distclean
>>>   LD      recurse-clean.mo
>>> cc: fatal error: no input files
>>> compilation terminated.
>>> rules.mak:118: recipe for target 'recurse-clean.mo' failed
>>> make: *** [recurse-clean.mo] Error 1
>> 
>> This one should be fixed in master (commit 8d358a5ea08).  If it's still
>> broken for you, let me know.
>
> Yes, this is certainly looking much better! There still seems to be something wrong
> with the tests/ subdirectory with your "make install" patch applied to git master if
> I attempt a "make distclean" after a successful "make V=1 -j2 install" in an
> out-of-tree build:
>
> build@ezio:~/src/qemu/git/obj$ ../qemu/configure '--target-list=x86_64-softmmu
> sparc64-softmmu sparc-softmmu ppc-softmmu arm-softmmu'
> '--prefix=/home/build/rel-qemu-git' '--disable-pie' '--enable-debug'
> build@ezio:~/src/qemu/git/obj$ make V=1 -j2 install
>
> (lots of build output cut, but completes successfully)
>
> build@ezio:~/src/qemu/git/obj$ make distclean
> Makefile:85: rules.mak: No such file or directory
> Makefile:437: tests/Makefile.include: No such file or directory
> cat: VERSION: No such file or directory
> Makefile:1127: tests/docker/Makefile.include: No such file or directory
> Makefile:1128: tests/vm/Makefile.include: No such file or directory
> make: *** No rule to make target 'tests/vm/Makefile.include'.  Stop.

Double-checking: is this with my '[PATCH for-4.1] Makefile: Fix "make
install" when "make all" needs work' applied?

