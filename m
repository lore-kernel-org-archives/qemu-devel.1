Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCCD21D7D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2mfQvkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCCD21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG05L-0002ra-Fv
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG03b-0000pO-6N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kG03Z-0004PC-3U
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 09:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599657755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=759snmECYdh/5c2jhvEO1JM0ehZnfkh+l/ubVOXmNrM=;
 b=R2mfQvkFOV7uRBR5lk+UY+wLhrT0toPX7ELlyO9b7x2Y+KT4/Iv013MMJZbVb2zCB3sbeo
 vdij3esOmcpDwjHqaRsczBuEPZzv3K5N4w7Ikc1ULnFN3/jxIzi5MnYsru4CWfC6OOfl98
 GCDN4JUDVkQBq59ZNbgLVvsXW6QaRCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-ENIODjybPYa7uwyfjj1AGQ-1; Wed, 09 Sep 2020 09:22:33 -0400
X-MC-Unique: ENIODjybPYa7uwyfjj1AGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73E02800462;
 Wed,  9 Sep 2020 13:22:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-221.ams2.redhat.com [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CFBC83560;
 Wed,  9 Sep 2020 13:22:27 +0000 (UTC)
Date: Wed, 9 Sep 2020 15:22:25 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
Message-ID: <20200909132225.GE5219@linux.fritz.box>
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-2-stefanha@redhat.com>
 <f5de1038-5bf3-8bd4-d664-45d6f201ae9b@redhat.com>
 <20200908142308.GD8175@linux.fritz.box>
 <87h7s7z9g4.fsf@dusky.pond.sub.org>
 <20200909075222.GA5219@linux.fritz.box>
 <87v9gnw3q2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87v9gnw3q2.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 09.09.2020 um 14:10 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 09.09.2020 um 09:38 hat Markus Armbruster geschrieben:
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > Am 08.09.2020 um 14:03 hat Laszlo Ersek geschrieben:
> >> >> Hi Stefan,
> >> >> 
> >> >> On 09/08/20 11:31, Stefan Hajnoczi wrote:
> >> >> > block-core.json is included from several places. It has no way of
> >> >> > knowing what header level (h1, h2, ...) is appropriate. Sphinx reports
> >> >> > errors when it encounters an h2 header where it expects an h1 header.
> >> >> > This issue prevents the next patch from generating documentation for
> >> >> > qemu-storage-daemon QMP commands.
> >> >> > 
> >> >> > Move the header into parents so that the correct header level can be
> >> >> > used. Note that transaction.json is not updated since it doesn't seem to
> >> >> > need a header.
> >> >> > 
> >> >> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> >> > ---
> >> >> >  docs/interop/firmware.json | 4 ++++
> >> >> >  qapi/block-core.json       | 4 ----
> >> >> >  qapi/block.json            | 1 +
> >> >> >  3 files changed, 5 insertions(+), 4 deletions(-)
> >> >> > 
> >> >> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> >> >> > index 989f10b626..48af327f98 100644
> >> >> > --- a/docs/interop/firmware.json
> >> >> > +++ b/docs/interop/firmware.json
> >> >> > @@ -15,6 +15,10 @@
> >> >> >  ##
> >> >> >  
> >> >> >  { 'include' : 'machine.json' }
> >> >> > +
> >> >> > +##
> >> >> > +# == Block devices
> >> >> > +##
> >> >> >  { 'include' : 'block-core.json' }
> >> >> >  
> >> >> >  ##
> >> >> 
> >> >> I think "docs/interop/firmware.json" deserves the same treatment as
> >> >> "transaction.json".
> >> >> 
> >> >> It's been a long time since I last looked at a rendered view of
> >> >> "docs/interop/firmware.json", but it only includes "block-core.json" so
> >> >> it can refer to some block-related types (@BlockdevDriver seems like the
> >> >> main, or only, one).
> >> >> 
> >> >> I wouldn't expect the rendered view of "firmware.json" to have a section
> >> >> header saying "Block devices".
> >> >> 
> >> >> I think it should be fine to drop this hunk (and my CC along with it ;))
> >> >
> >> > I think this is actually a more general problem with the way we generate
> >> > the documentation. For example, the "Background jobs" documentation ends
> >> > up under "Block Devices" just because qapi-schema.json includes
> >> > block-core.json before job.json and block-core.json includes job.json to
> >> > be able to access some types.
> >> 
> >> The doc generator is stupid and greedy (which also makes it
> >> predictable): a module's documentation is emitted where it is first
> >> included.
> >> 
> >> For full control of the order, have the main module include all
> >> sub-modules in the order you want.
> >
> > This works as long as the order that we want is consistent with the
> > requirement that every file must be included by qapi-schea.json before
> > it is included by any other file (essentially making the additional
> > includes in other files useless).
> 
> These other includes are not useless: they are essential for generating
> self-contained headers.
> 
> When MOD.json includes SUBMOD.json, then the generated qapi-FOO-MOD.h
> include qapi-FOO-SUBMOD.h.  When every module pulls in the modules it
> requires, so do the generated headers.  When a module doesn't, its
> generated headers won't compile unless you manually include the missing
> generated headers it requires.

Hm, right. So we're using includes for two different purposes, but just
from looking at the include line, you can't know which one it is.

> > Is this the order that we want?
> >
> > If so, we could support following the rule consistently by making double
> > include of a file an error.
> 
> Breaks our simple & stupid way to generate self-contained headers.
> 
> >> Alternatively, add just enough includes to get the order you want.
> >
> > There are orders that I can't get this way.
> 
> You're right, ordering by first include is not completely general.
> 
> >                                             For example, if I want to
> > have "Block devices" documented before "Background jobs", there is no
> > way to add includes to actually get this order without having
> > "Background jobs" as a subsection in "Block devices".
> 
> "Background jobs" is job.json.
> 
> "Block devices" is block.json, which includes block-core.json, which
> includes job.json.
> 
> To be able to put "Block devices" first, you'd have to break the chain
> from block.json to job.json.  Which might even be an improvement:
> 
> $ wc -l qapi/*.json | awk '$1 >= 1000 { print }'
>   5527 qapi/block-core.json
>   1722 qapi/migration.json
>   1617 qapi/misc.json
>   1180 qapi/ui.json
>  17407 total
> 
> Could we split block-core.json into several cohesive parts?

Possibly. However, while it would be an improvement generally speaking,
how does this change the specific problem? All of the smaller files will
be included by block.json (or whatever file provides the "Block devices"
chapter in the documentation) and at least one of them will still have
to include job.json.

(As it happens, the block export series splits off a block-export QAPI
module, but it's probably small enough to be barely noticable in this
comparison.)

Kevin


