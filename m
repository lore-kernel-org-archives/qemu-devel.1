Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1CA21473
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4fM3wvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1CA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp9PI-0000qN-Cp
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 07:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9Oj-0000Q3-CI
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:53:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9Oe-0001sG-VK
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593258803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zuwuYKw1hNMBTsq6mTXJeWsztaAKZpCQ10jnJpTBNVQ=;
 b=Y4fM3wvb7z57vNdxNUVod0m3QDyj6T+wy4l69L9P1ktkdlXjzSnV5vOTPTFUI5v5LL/b9n
 C0UiglDevwltVnpc0pKkeIMPxLliHjuH/xf4r2Yq3qSqlvTXlI/fd6WQnZT+doKkJR5weN
 e9nEi2mjByvMqKlck2+fyURzh5tGiQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-UH0-7Zf9Ms-8m88ZVs-iAw-1; Sat, 27 Jun 2020 07:53:21 -0400
X-MC-Unique: UH0-7Zf9Ms-8m88ZVs-iAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C77C107ACCA;
 Sat, 27 Jun 2020 11:53:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48AC95BAD1;
 Sat, 27 Jun 2020 11:53:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C321B11384A6; Sat, 27 Jun 2020 13:53:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
References: <20200615204008.3069956-1-armbru@redhat.com>
 <CAFEAcA_EnwYq4je-_OQz22zpxeqcSjaZnP7ieN-CyHC3pJp2Zw@mail.gmail.com>
Date: Sat, 27 Jun 2020 13:53:17 +0200
In-Reply-To: <CAFEAcA_EnwYq4je-_OQz22zpxeqcSjaZnP7ieN-CyHC3pJp2Zw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 26 Jun 2020 19:28:39 +0100")
Message-ID: <87o8p4rahe.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 06:37:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 15 Jun 2020 at 21:43, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The following changes since commit 7d3660e79830a069f1848bb4fa1cdf8f666424fb:
>>
>>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-06-12 23:06:22 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-06-15
>>
>> for you to fetch changes up to b77b5b3dc7a4730d804090d359c57d33573cf85a:
>>
>>   MAINTAINERS: Make section QOM cover hw/core/*bus.c as well (2020-06-15 22:06:04 +0200)
>>
>> ----------------------------------------------------------------
>> QOM patches for 2020-06-15
>>
>> * Make "info qom-tree" show children sorted
>> * Fixes around device realization
>> * Rework how we plug into devices into their parent bus
>
> Hi. I've just noticed that this commit added new global-scope
> functions to header files without documentation comments, eg
>
> bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);

They actually have doc comments: next to their definition, just like the
functions they replace.

We've argued about whether to put them next to definitions or next to
declarations several times, and I'd prefer not to rehash all that now.

QEMU uses different styles of function comments.  I always try to make
my new function comments consistent with nearby existing ones, if any.

Sadly, not everybody does.  Qdev used to be locally consistent, but
we've let it degenerate into the current mess.  It's what happens when
major infrastructure subsystems have to go without a maintainer for
years.

> Please could you provide some follow-up patches that document them?
> I don't think we have any hope of getting people to follow whatever
> the correct new way to create/configure/realize devices is if we
> don't document it :-(   [Concrete example: I now have no idea
> how this is supposed to work after this patchset.]

Please check out my function comments, and if they leave you confused,
let's talk about improvements.

I'm content to use comment placement / formatting I dislike to make my
code blend in, but I'm not willing to do conversion work from a style I
like to style I dislike.  That's a job for someone who won't feel icky
afterwards :)


