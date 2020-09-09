Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C1EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552662166E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd6QEsI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552662166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFywU-0002xC-3b
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 08:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFyvi-00022K-FC
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:10:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFyvf-0003tq-O1
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 08:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599653422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c3Ks/jyIxMTMHZMNZDljKWJcib+X3CRWTizd/VHA+n8=;
 b=Yd6QEsI2vbEupGXIY58h94+8AnLDdbNu944xhCKga7kjeIhF2iyXFicMsWB1AGxx/7B50D
 QboJi6slsrTBQYl0hz3yQUnw7/j+c7R/QaLiUBC4oLUpterHwEklYskfdrWdb3OMwZk0Eb
 2Hck3bUfqpwMYxYFvwZB0+seCKw24Yc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-aGukhV1ZPf-XcMAbre40mw-1; Wed, 09 Sep 2020 08:10:20 -0400
X-MC-Unique: aGukhV1ZPf-XcMAbre40mw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58E218B9F40;
 Wed,  9 Sep 2020 12:10:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C8947D4FA;
 Wed,  9 Sep 2020 12:10:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1C7E113865F; Wed,  9 Sep 2020 14:10:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-2-stefanha@redhat.com>
 <f5de1038-5bf3-8bd4-d664-45d6f201ae9b@redhat.com>
 <20200908142308.GD8175@linux.fritz.box>
 <87h7s7z9g4.fsf@dusky.pond.sub.org>
 <20200909075222.GA5219@linux.fritz.box>
Date: Wed, 09 Sep 2020 14:10:13 +0200
In-Reply-To: <20200909075222.GA5219@linux.fritz.box> (Kevin Wolf's message of
 "Wed, 9 Sep 2020 09:52:22 +0200")
Message-ID: <87v9gnw3q2.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
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

> Am 09.09.2020 um 09:38 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Am 08.09.2020 um 14:03 hat Laszlo Ersek geschrieben:
>> >> Hi Stefan,
>> >> 
>> >> On 09/08/20 11:31, Stefan Hajnoczi wrote:
>> >> > block-core.json is included from several places. It has no way of
>> >> > knowing what header level (h1, h2, ...) is appropriate. Sphinx reports
>> >> > errors when it encounters an h2 header where it expects an h1 header.
>> >> > This issue prevents the next patch from generating documentation for
>> >> > qemu-storage-daemon QMP commands.
>> >> > 
>> >> > Move the header into parents so that the correct header level can be
>> >> > used. Note that transaction.json is not updated since it doesn't seem to
>> >> > need a header.
>> >> > 
>> >> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> >> > ---
>> >> >  docs/interop/firmware.json | 4 ++++
>> >> >  qapi/block-core.json       | 4 ----
>> >> >  qapi/block.json            | 1 +
>> >> >  3 files changed, 5 insertions(+), 4 deletions(-)
>> >> > 
>> >> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
>> >> > index 989f10b626..48af327f98 100644
>> >> > --- a/docs/interop/firmware.json
>> >> > +++ b/docs/interop/firmware.json
>> >> > @@ -15,6 +15,10 @@
>> >> >  ##
>> >> >  
>> >> >  { 'include' : 'machine.json' }
>> >> > +
>> >> > +##
>> >> > +# == Block devices
>> >> > +##
>> >> >  { 'include' : 'block-core.json' }
>> >> >  
>> >> >  ##
>> >> 
>> >> I think "docs/interop/firmware.json" deserves the same treatment as
>> >> "transaction.json".
>> >> 
>> >> It's been a long time since I last looked at a rendered view of
>> >> "docs/interop/firmware.json", but it only includes "block-core.json" so
>> >> it can refer to some block-related types (@BlockdevDriver seems like the
>> >> main, or only, one).
>> >> 
>> >> I wouldn't expect the rendered view of "firmware.json" to have a section
>> >> header saying "Block devices".
>> >> 
>> >> I think it should be fine to drop this hunk (and my CC along with it ;))
>> >
>> > I think this is actually a more general problem with the way we generate
>> > the documentation. For example, the "Background jobs" documentation ends
>> > up under "Block Devices" just because qapi-schema.json includes
>> > block-core.json before job.json and block-core.json includes job.json to
>> > be able to access some types.
>> 
>> The doc generator is stupid and greedy (which also makes it
>> predictable): a module's documentation is emitted where it is first
>> included.
>> 
>> For full control of the order, have the main module include all
>> sub-modules in the order you want.
>
> This works as long as the order that we want is consistent with the
> requirement that every file must be included by qapi-schea.json before
> it is included by any other file (essentially making the additional
> includes in other files useless).

These other includes are not useless: they are essential for generating
self-contained headers.

When MOD.json includes SUBMOD.json, then the generated qapi-FOO-MOD.h
include qapi-FOO-SUBMOD.h.  When every module pulls in the modules it
requires, so do the generated headers.  When a module doesn't, its
generated headers won't compile unless you manually include the missing
generated headers it requires.

> Is this the order that we want?
>
> If so, we could support following the rule consistently by making double
> include of a file an error.

Breaks our simple & stupid way to generate self-contained headers.

>> Alternatively, add just enough includes to get the order you want.
>
> There are orders that I can't get this way.

You're right, ordering by first include is not completely general.

>                                             For example, if I want to
> have "Block devices" documented before "Background jobs", there is no
> way to add includes to actually get this order without having
> "Background jobs" as a subsection in "Block devices".

"Background jobs" is job.json.

"Block devices" is block.json, which includes block-core.json, which
includes job.json.

To be able to put "Block devices" first, you'd have to break the chain
from block.json to job.json.  Which might even be an improvement:

$ wc -l qapi/*.json | awk '$1 >= 1000 { print }'
  5527 qapi/block-core.json
  1722 qapi/migration.json
  1617 qapi/misc.json
  1180 qapi/ui.json
 17407 total

Could we split block-core.json into several cohesive parts?

>> > Maybe we should always look for the least nested include directive to
>> > figure out where the documentation should be placed. Then things
>> > directly referenced by qapi-schema.json would always be on the top
>> > level.
>> >
>> > Possibly we would then want to remove some includes from
>> > qapi-schema.json and include them only from some other file to group
>> > documentation sections that actually make sense to be grouped together.
>> 
>> I doubt implementing this feature would pay back the invested time.
>> Manually controlling the order like I described above is not much of a
>> burden, isn't it?
>
> Depends on whether we are okay with the limitations of the tool
> dictating the order of sections in our documentation.

Fair enough.


