Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363922075A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 05:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7f7GQtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363922075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGEzN-0002M5-5J
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 01:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGEyh-0001po-OF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:18:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kGEyf-0006sO-Kj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 01:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599715112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrKSGavK3FFzQ2XyQFbtmbieIFaRzBmw5McPQSG/SN0=;
 b=X7f7GQtDBpNeFEPWFc1hwsa13E6m9bB+/famNZhoyreS2iL38TloFDNkZZCM9LUJgi9M2G
 Y0nAlr1JjWk1wdufi+MEfb/7hTMbaD1S6FfGkeYP58zQLQtP2y7dFXwGD3GKSAebtrzt7k
 6wguJSOQGf1+d/XFRGw4g0oy3m6jl74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-HHmBhWaRO6GK1cte2zmQAQ-1; Thu, 10 Sep 2020 01:18:30 -0400
X-MC-Unique: HHmBhWaRO6GK1cte2zmQAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A981006708;
 Thu, 10 Sep 2020 05:18:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2996B46;
 Thu, 10 Sep 2020 05:18:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FCB6113865F; Thu, 10 Sep 2020 07:18:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-2-stefanha@redhat.com>
 <f5de1038-5bf3-8bd4-d664-45d6f201ae9b@redhat.com>
 <20200908142308.GD8175@linux.fritz.box>
 <87h7s7z9g4.fsf@dusky.pond.sub.org>
 <20200909075222.GA5219@linux.fritz.box>
 <87v9gnw3q2.fsf@dusky.pond.sub.org>
 <20200909132225.GE5219@linux.fritz.box>
 <87y2ljt1fi.fsf@dusky.pond.sub.org>
 <20200909153859.GF5219@linux.fritz.box>
Date: Thu, 10 Sep 2020 07:18:24 +0200
In-Reply-To: <20200909153859.GF5219@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 9 Sep 2020 17:38:59 +0200")
Message-ID: <87pn6uryzj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 09.09.2020 um 17:28 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 09.09.2020 um 14:10 hat Markus Armbruster geschrieben:
>> >> Kevin Wolf <kwolf@redhat.com> writes:
[...]
>> >> > There are orders that I can't get this way.
>> >> 
>> >> You're right, ordering by first include is not completely general.
>> >> 
>> >> >                                             For example, if I want to
>> >> > have "Block devices" documented before "Background jobs", there is no
>> >> > way to add includes to actually get this order without having
>> >> > "Background jobs" as a subsection in "Block devices".
>> >> 
>> >> "Background jobs" is job.json.
>> >> 
>> >> "Block devices" is block.json, which includes block-core.json, which
>> >> includes job.json.
>> >> 
>> >> To be able to put "Block devices" first, you'd have to break the chain
>> >> from block.json to job.json.  Which might even be an improvement:
>> >> 
>> >> $ wc -l qapi/*.json | awk '$1 >= 1000 { print }'
>> >>   5527 qapi/block-core.json
>> >>   1722 qapi/migration.json
>> >>   1617 qapi/misc.json
>> >>   1180 qapi/ui.json
>> >>  17407 total
>> >> 
>> >> Could we split block-core.json into several cohesive parts?
>> >
>> > Possibly. However, while it would be an improvement generally speaking,
>> > how does this change the specific problem? All of the smaller files will
>> > be included by block.json (or whatever file provides the "Block devices"
>> > chapter in the documentation) and at least one of them will still have
>> > to include job.json.
>> 
>> Splitting block-core.json can help only if other modules then use less
>> than all the parts.  In particular, as long as block.json includes the
>> same stuff, it'll surely still include jobs.json.  Could it include
>> less?
>
> Not if the documentation wants to have a single chapter for the block
> layer instead of many small block related top-level chapters.
>
> Otherwise we could include some things directly from qapi-schema.json,
> but obviously, that would still have to be after job.json for some
> parts.

You're right.

Being unable to talk about something before you define it may not be all
bad, though :)


