Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF23C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD8E4206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ec29A2XT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8E4206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc35i-0006Xy-Lo
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:03:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc33o-0004qc-Nd
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kc33m-0004PB-TU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604912516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RCQaDlRaOcD7BK1tBAH/BgdwobVhUUGHtxEgwYScgZc=;
 b=Ec29A2XTTQ9rZrFpGUCPdcMbNS2yjkB7cP23WKKgXD4nW/zYFInlePYjo05bvS0z/O1pZ8
 rUEa71ITWnhGBsTp4T23POL5Ke8Sq61EIV91anlMqNJtvmsNINX8KlGEx6nlhlJqmo5XNX
 rKxEyRpj9kVJhW5MGW82DjCd5Yue/Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-PtL6ltZJNH6UZxWc3sf-yA-1; Mon, 09 Nov 2020 04:01:54 -0500
X-MC-Unique: PtL6ltZJNH6UZxWc3sf-yA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BE857244;
 Mon,  9 Nov 2020 09:01:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C87D60DA0;
 Mon,  9 Nov 2020 09:01:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B4631132BD6; Mon,  9 Nov 2020 10:01:48 +0100 (CET)
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
 <87zh3ufoy4.fsf@dusky.pond.sub.org>
 <CAFEAcA-3a8gYRPzk4jzv3QfLAw3tL74LoFTMy+VhXZA3QdOfPg@mail.gmail.com>
Date: Mon, 09 Nov 2020 10:01:48 +0100
In-Reply-To: <CAFEAcA-3a8gYRPzk4jzv3QfLAw3tL74LoFTMy+VhXZA3QdOfPg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 6 Nov 2020 16:19:31 +0000")
Message-ID: <87mtzqsy2r.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gan Qixin <ganqixin@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Chenqun
 \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 6 Nov 2020 at 16:08, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > Personally I just don't think checkpatch should be nudging people
>> > into folding 85-character lines, especially when there are
>> > multiple very similar lines in a row and only one would get
>> > folded, eg the prototypes in target/arm/helper.h -- some of
>> > these just edge beyond 80 characters and I think wrapping them
>> > is clearly worse for readability.
>>
>> The warning's intent is "are you sure this line is better not broken?"
>> The problem is people treating it as an order that absolves them from
>> using good judgement instead.
>>
>> I propose to fix it by phrasing the warning more clearly.  Instead of
>>
>>     WARNING: line over 80 characters
>>
>> we could say
>>
>>     WARNING: line over 80 characters
>>     Please examine the line, and use your judgement to decide whether
>>     it should be broken.
>
> I would suggest that for a line over 80 characters and less than
> 85 characters, the answer is going to be "better not broken"
> a pretty high percentage of the time; that is, the warning
> has too many false positives, and we should tune it to have fewer.
>
> And the lure of "produce no warnings" is a strong one, so
> we should be at least cautious about what our tooling is
> nudging us into doing.

CODING_STYLE.rst: "Lines should be 80 characters; try not to make them
longer."  I'd like to keep the tooling we have to help us with trying
not to make them longer.

If we have lost the ability to differentiate between "warning" and
"error", call it something else.


