Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BB2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0FC22202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDXm/9S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0FC22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4Ie-0000lZ-9I
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb4Hu-0008RG-Sc
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb4Hs-00077Y-Il
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604678906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7ttH0c6pT85wwaX8dz3E/b/zgRBAT3jYdUk+iGN0jY=;
 b=EDXm/9S6x9QEReJtP+BL2Ux7HofHAJrvrJcG/9eK3dsng+ZFYYmpLXTCqsQpzNlQSDz7c8
 wk4B29pVX8RmW2y9rLQwoiSW36ZYuYwYyYGCjWzTSp2W8UopXPYR0iHy2DkpsluEicKGY0
 rlOvRJGdj/6d4F0XgeX+t8Fe2fsvGxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-dJxuBQMSN0yX2Rk8_U3UVw-1; Fri, 06 Nov 2020 11:08:25 -0500
X-MC-Unique: dJxuBQMSN0yX2Rk8_U3UVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E36DF64158;
 Fri,  6 Nov 2020 16:08:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4FF375121;
 Fri,  6 Nov 2020 16:08:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 664341132BD6; Fri,  6 Nov 2020 17:08:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] scripts/checkpatch.pl: Modify the line length limit of
 the code
References: <20201105154208.12442-1-ganqixin@huawei.com>
 <CAFEAcA9QMBqF0Bm44q4m1d=QaPVBJodH9rwuYhGx5H6zy6ULcg@mail.gmail.com>
 <87d00qk51l.fsf@dusky.pond.sub.org>
 <CAFEAcA-_5vRbsi5fFpyLV2OyDX5TVrpAx7_Z43wqvb1zhQO_8w@mail.gmail.com>
 <37c519e4-d72b-944c-ed70-038f9c606be9@redhat.com>
 <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
Date: Fri, 06 Nov 2020 17:08:19 +0100
In-Reply-To: <CAFEAcA_a=vBjLM8_-KDkYfFuTLDW6cMsQ48or70uwwVusW2q7w@mail.gmail.com>
 (Peter Maydell's message of "Fri, 6 Nov 2020 14:16:07 +0000")
Message-ID: <87zh3ufoy4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P.
 Berrange" <berrange@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Nov 2020 at 14:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>> Can we keep the error please? Maybe 132 is the next display logical
>> limit once we increased the warning from 80 to 100.
>>
>> I understand hardware evolved, we have larger displays with better
>> resolution and can fit more characters in a line.
[...]
>
> Personally I just don't think checkpatch should be nudging people
> into folding 85-character lines, especially when there are
> multiple very similar lines in a row and only one would get
> folded, eg the prototypes in target/arm/helper.h -- some of
> these just edge beyond 80 characters and I think wrapping them
> is clearly worse for readability.

The warning's intent is "are you sure this line is better not broken?"
The problem is people treating it as an order that absolves them from
using good judgement instead.

I propose to fix it by phrasing the warning more clearly.  Instead of

    WARNING: line over 80 characters

we could say

    WARNING: line over 80 characters
    Please examine the line, and use your judgement to decide whether
    it should be broken.

>                                   If we don't want people
> sending us "style fix" patches which wrap >80 char lines
> (which I think we do not) then we shouldn't have checkpatch
> complain about them, because if it does then that's what we get.

I think that's throwing out the baby with the bathwater.

checkpatch's purpose is not guiding inexperienced developers to style
issues they can fix.  It is relieving maintainers of the tedium of
catching and explaining certain kinds of issues patches frequently have.

Neutering checks that have led inexperienced developers to post less
than useful patches may well relieve maintainers of having to reject
such patches.  But it comes a price: maintainers and contributors lose
automated help with checking useful patches.  I consider that a bad
trade.

We may want to discourage inexperienced contributors from sending us
style fix patches.  Fixing style takes good taste, which develops only
with experience.  Moreover, fixing up style builds only little
experience.  At best, it exercises "configure; make check" and the patch
submission process and running "make check").  There are better ways to
get your feet wet.


