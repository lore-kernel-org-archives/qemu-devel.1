Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9F0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7388C2078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 13:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8WfUarh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7388C2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHcH-00006k-He
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 09:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFHbi-00083s-TX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:54:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFHbh-00034t-39
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 09:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599486891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DEn+MAr3F5qGsJoMedT0iiAfliz0qLcQNHItZIqD00U=;
 b=Y8WfUarhg9KuRz4pN+acwjprdTygdRtB7sfOq/iy27uM6qFKF6qac3r72cfM13DSqdnsyG
 JN7DNhFMRMbmVhe7fFZ/owSIRxsfV8+EtGQS40h7ERUs+IGj/5lW8N97EcmSuaTxe7MLuY
 jFfqKISruG9fxXSsCYz9wjCkPFl+rws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-7n4gUnoZPP-plHymxUfaDw-1; Mon, 07 Sep 2020 09:54:49 -0400
X-MC-Unique: 7n4gUnoZPP-plHymxUfaDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD3771DDF3;
 Mon,  7 Sep 2020 13:54:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4ED747C6;
 Mon,  7 Sep 2020 13:54:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E70A01132B59; Mon,  7 Sep 2020 15:54:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
Date: Mon, 07 Sep 2020 15:54:37 +0200
In-Reply-To: <87ime52wxd.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Thu, 30 Jul 2020 11:07:26 +0200")
Message-ID: <877dt5ofoi.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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
Cc: "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Mar?= =?utf-8?Q?c-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Andrea Bolognani <abologna@redhat.com> writes:
>
>> The various schemas included in QEMU use a JSON-based format which
>> is, however, strictly speaking not valid JSON.
>>
>> As a consequence, when vim tries to apply syntax highlight rules
>> for JSON (as guessed from the file name), the result is an unreadable
>> mess which mostly consist of red markers pointing out supposed errors
>> in, well, pretty much everything.
>>
>> Using Python syntax highlighting produces much better results, and
>> in fact these files already start with specially-formatted comments
>> that instruct Emacs to process them as if they were Python files.
>>
>> This commit adds the equivalent special comments for vim.
>>
>> Signed-off-by: Andrea Bolognani <abologna@redhat.com>
>
> Naming QAPI schema files .json even though their contents isn't was a
> mistake.  Correcting it would be a pain.  If we correct it, then the
> sooner the better.
>
> Renaming them to .py gives decent editor support out of the box.  Their
> contents isn't quite Python, though: true vs. True, false vs. False.  Do
> we care?  Only a few dozen occurences; they could be adjusted.
>
> Renaming them to .qapi would perhaps be less confusing, for the price of
> "out of the box".
>
> Thoughts?

Let me try to summarize the discussion from my point of view.

Basing a DSL on some existing syntax has its advantages: the learning
curve is slightly more gentle, and we get some tooling for free, notably
editor support.

Basing on JSON was a mistake: JSON is designed for data interchange, not
for programming.

To make it fit for programming, we extended it, losing much of what we
gained by basing on existing syntax.

Use of .json file names for the resulting bastard is confusing.

Among the confused are editors.  We unconfuse them one by one by telling
them to treat the files as Python.  Works, because the syntax happens to
be a strict subset of Python's.

We discussed swapping out the base syntax layer for one that is actually
fit for purpose (and doesn't need extending), e.g. YAML.  Radical
change, benefits need to justify the cost.  Possible benefits:

* Better ergonomics for developers

  Depends on what we pick for a base, and how we use it.

  We discussed YAML at some length.  It's complex, and the way it
  assigns types is at odds with the QAPI schema's needs.  I doubt YAML
  could improve ergonomics all that much.

* Not having to maintain our own code for the lower layer

  Replacing the (trivial) JSON parser by glue for an off-the-shelf
  parser is quite unlikely to pay off.

  Replacing the (non-trivial) doc comment parser could be a win, but no
  credible replacements have been suggested so far.

* Make the schema more easily consumable by other programs

  Parsing is the easy part of this problem.  Making the easy part easier
  won't make the total problem appreciably easier.

Right now, I doubt the benefits are worth the cost.  To make me
reconsider, write a concise memo stating the goals, their benefits, the
possible ways to get there, and their cost.

More modest ways to stop our confusing misuse of .json:

* Rename QAPI schema files to .qapi, keep unconfusing tools one by one
  by telling them to treat the files as Python.

* Rename QAPI schema files to .py.  Optionally rename false, true to
  False, True in the schema language, so the schema expressions are
  semantically valid Python.  Humans might still find .py confusing.

* Rename QAPI schema files to .js, change comments from # to //.

* Keep .json, change comments from # to // and strings from ' to ".

  This is still not JSON, but should be close enough to make common
  tooling work.

The last two are too much churn for too little benefit, in my opinion.

I'm willing to do either of the first two.  If you have a preference,
let me know.


