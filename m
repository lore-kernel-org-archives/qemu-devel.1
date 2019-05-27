Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C049BC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 05:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931422070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 05:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931422070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hV7uy-0002dj-NW
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 01:11:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hV7u9-00028I-ST
	for qemu-devel@nongnu.org; Mon, 27 May 2019 01:10:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hV7u7-0005zo-VS
	for qemu-devel@nongnu.org; Mon, 27 May 2019 01:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hV7u7-0005xr-7y
	for qemu-devel@nongnu.org; Mon, 27 May 2019 01:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BE7FC1306E4;
	Mon, 27 May 2019 05:10:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB5A60C6B;
	Mon, 27 May 2019 05:10:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 488131138648; Mon, 27 May 2019 07:10:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
	<db337f20-8b76-9214-533e-3e4b79c5c4d5@redhat.com>
	<87ef4peyg5.fsf@dusky.pond.sub.org>
	<14caabd5-34e3-260f-91e0-df93e8f1a02a@redhat.com>
Date: Mon, 27 May 2019 07:10:31 +0200
In-Reply-To: <14caabd5-34e3-260f-91e0-df93e8f1a02a@redhat.com> (Paolo
	Bonzini's message of "Fri, 24 May 2019 18:25:57 +0200")
Message-ID: <8736l032k8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 27 May 2019 05:10:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/05/19 21:57, Markus Armbruster wrote:
>>>> A large number of headers don't pass this test, by design or by
>>>> accident.  To keep things more manageable, exclude all headers outside
>>>> include/ for now.
>>> A lot of these, either in include/ or outside, are _meant_ to be
>>> included many times.  What about renaming those to .inc.h and
>>> whitelisting them in the script?
>> Yes, that would be nice.
>
> Another suggestion: are there headers that cannot even be included once
> (due to dependencies)?  Is it worth including a test for those even in
> the first iteration?
>
> .inc.h files would skip that test too.

I'm not sure I get what you mean.

Most headers failing the test fail it in the first #include: they fail
to conform to 2. Headers should normally include everything they need
beyond osdep.h.

The only way to fail in the second #include is a missing header guard.
If it's missing intentionally, it's "_meant_ to be included many times",
and you propose renaming to .inc.h.  Else, easy fix.

I think I'll make a list of headers that fail in the second #include,
and try to sort them into "intentional" and "bug" buckets.

