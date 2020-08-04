Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D7FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B352076C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2VY2H4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B352076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2rxR-0001Jh-Mg
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2rwh-0000n5-M6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:05:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2rwf-0005Ta-Up
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596528313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCDPa9M0bHNz1496Ad/ZUL2B4XlLEWxa4zwU0BFN03A=;
 b=T2VY2H4Qb8OF/Isrpd7ZHchDMNnDFxrtqHAlBPqYgboKpnSDmZJ1NQBuKec7x6wp5aD4sP
 PmpfWTITYo0FGod/yKJCSuU1NhFZXS8Zw+IRE54SdMKn5XjTTmuncWmMILJbnU1z24acas
 x6RMfJsMOlGUsj2NJsApWBRp8MMembc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-G8oyVfUKNZG9wgN2uEK51A-1; Tue, 04 Aug 2020 04:04:07 -0400
X-MC-Unique: G8oyVfUKNZG9wgN2uEK51A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9636679EC0;
 Tue,  4 Aug 2020 08:04:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD78288F3F;
 Tue,  4 Aug 2020 08:03:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 19B041132FD2; Tue,  4 Aug 2020 10:03:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
Date: Tue, 04 Aug 2020 10:03:55 +0200
In-Reply-To: <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Aug 2020 19:19:37 +0200")
Message-ID: <87k0yeg7mc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/08/20 18:03, Markus Armbruster wrote:
>>> In general it seems like a good idea to use a standard file format and
>>> not "a standard file format except for two characters". :)  We also
>>> wouldn't be having discussions on editors.
>> 
>> No argument.  But towards which standard file format should the schema
>> evolve?
>> 
>> * Standard JSON: no comments, no go
>> 
>> * JSON with # comments: need to change strings from ' to "
>> 
>> * JavaScript: need to change comments from # to //
>> 
>> * Python: may want to switch bool literals from true, false to True,
>>   False
>
> Second or third, I'd say.  I dislike using .py because a stream of
> Python objects doesn't really have a meaning in Python:

It does have a meaning: compute a bunch of dictionaries and throw them
away.  Its useless as a program, but it's not meaningless.

>                                                         that's the
> difference between .js and .json.

True.  RFC 4626: "JSON is a subset of JavaScript, but it is a safe
subset that excludes assignment and invocation."[*]

An analogous subset of Python is possible, but has not been formally
defined as far as I know.

> Third requires someone to do the work in the parser.  Unlikely.

The pain of tweaking the parser is likely dwarved several times over by
the pain of the flag day.

>>> That said, after a bit more research I'm skeptical about the possibility
>>> of using an off-the-shelf parser because most of them either don't
>>> support comments, or are based on YAJL which simply discards comments.
>>>
>>> Since '//' comments are harder to parse than "#" comments, this would
>>> actually _add_ code instead of removing it.  Also since our doc comment
>>> syntax uses "##" as a delimiter, we'd have to bikeshed what the doc
>>> comments would look like ("//!", "///", etc.).
>> 
>> Doc comments don't have to be comments in the schema language.  They
>> could be doc strings.  Requires decent support for long strings, which
>> JSON does not provide.
>
> Exactly.  This was the appeal of YAML (or StrictYAML so that Norwegians
> don't turn into Falsians) as far as I understood.  But if we were to go
> YAML, I'd rather have make doc strings part of the YAML document too.
> That is what Nir suggested, it makes sense but someone has to write the
> conversion code.

To write a converter, you first have to understand the doc comment
language.  It's a bit of a mess, because it was fitted to existing
conventions to reduce churn.

Peter Maydell has patches to generate rST instead of Texinfo.  They
affect the doc comment language.  I expect to merge them for 5.2.

>> If all we want is decent editor support out of the box, then rename to
>> .py, and drop the modelines.  No merge conflicts, no git-blame
>> pollution.
>
> Another possibility is to rename to .qapi and keep Python modelines as a
> hack that does work.

Yes.


[*] Unfortunately, this has become a statement of intent, not a
description of reality, due to JSON design accidents.


