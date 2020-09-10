Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071BDC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D0B21941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAXQ83qL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D0B21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIjz-0003gB-7O
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGIj9-00033l-Lc
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:18:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGIj5-00072e-Ud
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599729522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uzE2BQxbH+WqIhzfhK97g2ym6oIhgiFzVgIEVTbVPvE=;
 b=BAXQ83qL7ovrKubJDIeq5C8/N+5CZ+zxQZjJGzFml4NWrk1M/D8g1afpWYXZ3ap5rue2GY
 P/AzuFtxgptZ65JB/K1tn9UJFSSv5+Yj6Qfx5fOP3JglN+4S1p6LGWe+1MVXcccyqXckcx
 NdPXkVbpYMWW2J8TOdBPp2jfgZ//KFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-50YMkbwWNdG6P5nHSMGpeA-1; Thu, 10 Sep 2020 05:18:41 -0400
X-MC-Unique: 50YMkbwWNdG6P5nHSMGpeA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1126618BA28F;
 Thu, 10 Sep 2020 09:18:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22BC260BF1;
 Thu, 10 Sep 2020 09:18:34 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:18:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
Message-ID: <20200910091833.GD7100@linux.fritz.box>
References: <20200908093113.47564-2-stefanha@redhat.com>
 <f5de1038-5bf3-8bd4-d664-45d6f201ae9b@redhat.com>
 <20200908142308.GD8175@linux.fritz.box>
 <87h7s7z9g4.fsf@dusky.pond.sub.org>
 <20200909075222.GA5219@linux.fritz.box>
 <87v9gnw3q2.fsf@dusky.pond.sub.org>
 <20200909132225.GE5219@linux.fritz.box>
 <87y2ljt1fi.fsf@dusky.pond.sub.org>
 <20200909153859.GF5219@linux.fritz.box>
 <87pn6uryzj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87pn6uryzj.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:02:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.09.2020 um 07:18 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 09.09.2020 um 17:28 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > Am 09.09.2020 um 14:10 hat Markus Armbruster geschrieben:
> >> >> Kevin Wolf <kwolf@redhat.com> writes:
> [...]
> >> >> > There are orders that I can't get this way.
> >> >> 
> >> >> You're right, ordering by first include is not completely general.
> >> >> 
> >> >> >                                             For example, if I want to
> >> >> > have "Block devices" documented before "Background jobs", there is no
> >> >> > way to add includes to actually get this order without having
> >> >> > "Background jobs" as a subsection in "Block devices".
> >> >> 
> >> >> "Background jobs" is job.json.
> >> >> 
> >> >> "Block devices" is block.json, which includes block-core.json, which
> >> >> includes job.json.
> >> >> 
> >> >> To be able to put "Block devices" first, you'd have to break the chain
> >> >> from block.json to job.json.  Which might even be an improvement:
> >> >> 
> >> >> $ wc -l qapi/*.json | awk '$1 >= 1000 { print }'
> >> >>   5527 qapi/block-core.json
> >> >>   1722 qapi/migration.json
> >> >>   1617 qapi/misc.json
> >> >>   1180 qapi/ui.json
> >> >>  17407 total
> >> >> 
> >> >> Could we split block-core.json into several cohesive parts?
> >> >
> >> > Possibly. However, while it would be an improvement generally speaking,
> >> > how does this change the specific problem? All of the smaller files will
> >> > be included by block.json (or whatever file provides the "Block devices"
> >> > chapter in the documentation) and at least one of them will still have
> >> > to include job.json.
> >> 
> >> Splitting block-core.json can help only if other modules then use less
> >> than all the parts.  In particular, as long as block.json includes the
> >> same stuff, it'll surely still include jobs.json.  Could it include
> >> less?
> >
> > Not if the documentation wants to have a single chapter for the block
> > layer instead of many small block related top-level chapters.
> >
> > Otherwise we could include some things directly from qapi-schema.json,
> > but obviously, that would still have to be after job.json for some
> > parts.
> 
> You're right.
> 
> Being unable to talk about something before you define it may not be all
> bad, though :)

Yes, as long as the resulting order is what we want anyway, this is not
a problem.

I'm just not sure if we will always be aware of the include structure
without tool support so that we would always declare the dependencies
first. Nobody checks the headlines in the documentation after making
schema changes.

Kevin


