Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A18C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2645D204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILLxZLLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2645D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hBA-0001tp-2B
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3hA1-0001Pb-Fm
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:46:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45744
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3h9y-00038s-Nn
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 10:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596725181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+HkPQL3qRrvRAv+vPLfdnohRhoEej74ED/EtXmWoEu8=;
 b=ILLxZLLzowR5EKIv8+E4BmNT5U3CCMfPcBgXWD9A+4xWbE9EWkr6ma+7rM43mTRWBYvGyu
 XRB600yCUhlIN1PH8KTJzHc7gM1+X0im2vBOedgkWoOlTrS4BrfdyT1scmEjuBVBgc9w5a
 ZUrX361c0+CzD+DssRHXnnR4/9TmMEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-9QSyIfefO4SrT_9NH1otBw-1; Thu, 06 Aug 2020 10:46:17 -0400
X-MC-Unique: 9QSyIfefO4SrT_9NH1otBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88FC058;
 Thu,  6 Aug 2020 14:46:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0F582DE93;
 Thu,  6 Aug 2020 14:46:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 67D331132801; Thu,  6 Aug 2020 16:46:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 04/18] tests/qapi/doc-good.json: Clean up markup
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-5-peter.maydell@linaro.org>
 <87eeolnt25.fsf@dusky.pond.sub.org>
 <CAFEAcA-nk3+W-on=tsW_8OY==MriMyeJFQ=_tFjHkaoj5mUA_A@mail.gmail.com>
Date: Thu, 06 Aug 2020 16:46:11 +0200
In-Reply-To: <CAFEAcA-nk3+W-on=tsW_8OY==MriMyeJFQ=_tFjHkaoj5mUA_A@mail.gmail.com>
 (Peter Maydell's message of "Wed, 5 Aug 2020 14:41:25 +0100")
Message-ID: <87364z6de4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 5 Aug 2020 at 14:03, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> The subject is a bit misleading.  The markup doesn't need cleanup.  It
>> purposefully tests corner cases of the doc comment parser.  For some of
>> them, the conversion to rST will change the meaning.  This commit tweaks
>> the test so it passes before and after the conversion.  Makes it a worse
>> test for the doc comment parser, which doesn't matter, because the code
>> in question is about to be deleted.
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > doc-good.json tests some oddities of markup that we don't want to
>> > accept.  Make them match the more restrictive rST syntax:
>> >
>> >  * in a single list the bullet types must all match
>> >  * lists must have leading and following blank lines
>> >  * indentation is important
>>
>> Actually, indentation has always been important, but the conversion to
>> rST changes where and how it matters.
>
> Mmm. More specifically, indentation was previously unimportant
> within a multiline block of text, and is now important there.
>
>> >  * the '|' example syntax is going to go away entirely, so stop
>> >    testing it
>>
>> Before the series, we (try to) cover all doc markup here.
>>
>> The series replaces the doc markup language by rST + a little extra.
>> The test must still cover the little extra then, and covering a bit of
>> rST to ensure basic sanity won't hurt.
>>
>> Correct?
>>
>> I'm asking because a "yes" explains why we can drop coverage without
>> replacement: it's appropriate when the markup in question is replaced by
>> rST.
>
> I guess so. We still want some test coverage of the stuff the
> doc-comment parser is doing that's actually looking for
> arguments and so on; we don't really need to check that
> rst is rst.
>
> It's been a while since I wrote this patch, but basically IIRC
> it's "make the minimal changes necessary so that the test does
> not start failing for the parser changes that will follow".

That's okay, but the commit message could be clearer.  Perhaps:

    tests/qapi/doc-good.json: Prepare for qapi-doc Sphinx extension

    doc-good.json tests doc comment parser corner cases.  We're about to
    largely replace it by a Sphinx extension, which will have different
    corner cases.  Tweak the test so it passes both with the old parser
    and the Sphinx extension, by making it match the more restrictive
    rST syntax:

     * in a single list the bullet types must all match
     * lists must have leading and following blank lines
     * indentation is important
     * the '|' example syntax is going to go away entirely, so stop
       testing it

    This will avoid the tests spuriously breaking when we tighten up the
    parser code in the following commits.

>> > This will avoid the tests spuriously breaking when we tighten up the
>> > parser code in the following commits.
>
>> > @@ -62,7 +62,7 @@
>> >  ##
>> >  # @Base:
>> >  # @base1:
>>
>> Here, indentation is relevant even before the series: @base: is only
>> recognized as an argument section when it's not indented.
>>
>> > -#   the first member
>> > +# the first member
>>
>> Why do you need to unindent this line?
>
> Because in the tightened syntax, you can either have:
>
> @foo: line 1
>       line 2
>
> (the definition part of the argument is multiple lines of
> rST, which all must be lined up to start at the same column)
>
> or
>
> @foo:
> line1
> line2
>
> (the definition is multiple lines of rST, which all start
> in column 1)
>
> But
> @foo:
>    line1
>
> is neither of the above, and will be invalid.
>
> The old parser simply stripped all the leading whitespace
> from this kind of multiline lump-of-doc-text. That doesn't
> work for rST because we want to be able to have doc-text
> where leading whitespace matters. So we need to know how
> many characters of whitespace to delete from each line. The
> two options above basically correspond to the two major
> pre-existing kinds of doc-comment.
>
> Compare commit 26ec4e53f2bf0a381, which fixed up the
> doc comments in qapi/ proper to follow this "one of
> these two indent models, but not anything else" pattern.

Ah, now I remember.

Remind me, how is messed up doc comment indentation reported in the
brave new Sphinx world?

>> >  ##
>> >  { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
>> >
>> > @@ -101,7 +101,7 @@
>> >  ##
>> >  # @Alternate:
>> >  # @i: an integer
>> > -# @b is undocumented
>> > +#     @b is undocumented
>>
>> Why do you need to indent this line?
>
> Again, because it needs to follow one of the two
> indent patterns described above. Either no text
> following the "@i:" and all lines start in column 1,
> or all lines have to start in the same column as
> the text following the "@i:". In this case I went for
> option 2.
>
> The test input is a bit odd because it's talking
> about @b in the description-text for @i, but there
> you go. You could alternatively add a newline
> after the @i: line to put the text "@b is undocumented"
> into the doc-text for the whole @Alternate struct
> rather than into the doc-text for the @i member.

The test's purpose is to be mean to the doc parser, not pleasant to the
reader's eye ;)

The doc before the patch tests the (less than ideal) handling of a
mistake that is easy to make, namely forgetting the ':' after the member
name.

Your change is okay.

>> >  { 'alternate': 'Alternate',
>> >    'data': { 'i': 'int', 'b': 'bool' } }
>> > @@ -115,7 +115,7 @@
>> >  # @arg1: the first argument
>> >  #
>> >  # @arg2: the second
>> > -# argument
>> > +#        argument
>>
>> Why do you need to indent this line?
>
> As above, beacuse it's not in either of the
> two standard "this is what indent for a multi-line
> bit of doc text for an argument can be" patterns.

Thanks!

Preferably with an improved commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>


