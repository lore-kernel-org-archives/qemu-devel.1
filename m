Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F6C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D181D2082E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgr7MeJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D181D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0QpR-0007bH-26
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:11:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j0Qoc-0006yR-8E
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j0Qoa-0008WP-4I
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:10:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j0Qoa-0008Ss-0Q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581171030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9HWanvKMGp3N86l0TME35TSPJm06r5n3DCYbihXwNFM=;
 b=hgr7MeJledvlG6EE5i2AA7uoMc68scU28916pYiXfN74G8ZIj0Ev/Qdqy06fy4HKao29lp
 beZU+Zxzpvw/TBJNWdMjbAvEyhLaXFLNYzN2Nbbk5iBEVF7NjjhXsT+fou3qi7rxg3WtgR
 fsLtfns9JG7cDMmc/vcPwe5LxvEJ4G0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-jc8PzEtENuOVkPmAWZwpBg-1; Sat, 08 Feb 2020 09:10:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 288831005513;
 Sat,  8 Feb 2020 14:10:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2C860BE1;
 Sat,  8 Feb 2020 14:10:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6F48B11386A7; Sat,  8 Feb 2020 15:10:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 19/29] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-20-peter.maydell@linaro.org>
 <87r1z6pg0x.fsf@dusky.pond.sub.org>
 <CAFEAcA_T-Muy0NOj1uufB=QCxsn0hMvDnD-KoCz1Dv-+v71i5w@mail.gmail.com>
Date: Sat, 08 Feb 2020 15:10:20 +0100
In-Reply-To: <CAFEAcA_T-Muy0NOj1uufB=QCxsn0hMvDnD-KoCz1Dv-+v71i5w@mail.gmail.com>
 (Peter Maydell's message of "Fri, 7 Feb 2020 16:13:16 +0000")
Message-ID: <87h801jhkj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jc8PzEtENuOVkPmAWZwpBg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

> On Fri, 7 Feb 2020 at 15:35, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > Our current QAPI doc-comment markup allows section headers
>> > (introduced with a leading '=3D' or '=3D=3D') anywhere in any document=
ation
>> > comment.  This works for texinfo because the texi generator simply
>> > prints a texinfo heading directive at that point in the output
>> > stream.  For rST generation, since we're assembling a tree of
>> > docutils nodes, this is awkward because a new section implies
>> > starting a new section node at the top level of the tree and
>> > generating text into there.
>> >
>> > New section headings in the middle of the documentation of a command
>> > or event would be pretty nonsensical, and in fact we only ever output
>> > new headings using 'freeform' doc comment blocks whose only content
>> > is the single line of the heading, with two exceptions, which are in
>> > the introductory freeform-doc-block at the top of
>> > qapi/qapi-schema.json.
>> >
>> > Split that doc-comment up so that the heading lines are in their own
>> > doc-comment.  This will allow us to tighten the specification to
>> > insist that heading lines are always standalone, rather than
>> > requiring the rST document generator to look at every line in a doc
>> > comment block and handle headings in odd places.
>
>> I figure this is a minimally invasive patch to avoid complications in
>> your rST generator.  I'm afraid it sweeps the actual problem under the
>> rug, namely flaws in our parsing and representation of doc comments.
>>
>> The doc comment parser doesn't recognize headings.  Instead, that's done
>> somewhere in the bowels of the Texinfo generator.  Works as long as the
>> input is "sane", happily generates invalid Texinfo otherwise, see
>> tests/qapi-schema/doc-bad-section.json.
>>
>> The proper fix is to make the parser recognize headers in the places
>> where headers make sense, and reject them elsewhere.
>>
>> But maybe we don't have to.  Do you plan to support full rST in doc
>> comments?  If yes, why have our own syntax for headings?  Why not leave
>> it to rST?  If no, do you plan to support a subset of rST?  If yes,
>> define it, please.  How will it be enforced?
>
> Doc comments do support full rST. However, (as the commit message
> here notes), if you're generating a tree of docutils nodes and
> one of them has a section heading in it then you'll get a result
> that looks like this:
>
> [root]
>   - [ some section created by the script for a QAPI command ]
>   - [ some section ]
>       - [text nodes, etc going into this section]
>       - [a section resulting from rST parsing the header inside the docst=
ring]
>   - [ next section created by the script for a QAPI command ]
>
> (ie you'll have defined a subsection within whatever document
> paragraph/section the current command is documenting, not
> a new top-level subsection which subsequent commands will
> become children of)
>
> What you actually want is that the new header results in
> a differently structured tree:
> [root]
>   - [ some section created by the script for a QAPI command ]
>   - [ some section ]
>       - [text nodes, etc going into this section]
>   - [ a new top level section whose header is whatever this header is ]
>      - [ next section created by the script is a child of that section ]
>      - [ etc ]
>
> There's no way to get that without actually noticing and handling
> headings specially as being something entirely different from
> a lump of documentation text. "A heading is a single-line special-case
> of a freeform comment" happens to be the way we mark up headings
> now in 99% of cases, so that's what I implemented. (The Sphinx
> extension will complain if there's trailing junk lines after
> a heading line at the beginning of a freeform comment block.
> If you use '=3D=3D something' in a line in the middle of a doc
> comment, we'll just interpret that as rST source, which is to
> say a couple of literal equals signs at the start of a line.)

A couple of remarks.

Silently passing a "# =3D=3D something" line to rST for literal
(mis-)interpretation is not nice.  It's the kind of indifference that
led to the messes you cleaned up in PATCH 04 and 08.  If the '=3D' markup
is only valid in certain places, it should be rejected where it isn't.

By refusing to translate "# =3D=3D something" to rST (silently or loudly,
doesn't matter), the first tree structure becomes impossible.  Except
when I do the translating myself: I can put an *rST* section wherever I
want.

I'm still having difficulties understanding what exactly we gain by
translating '=3D' markup to rST.

By the way, your implementation rejects

    ##
    # =3D Introduction
    # xxx
    ##

but silently accepts

    ##
    # xxx
    # =3D Introduction
    ##

doc-good.json has more instances of this issue.  Before your series, we
actually check we generate the Texinfo we expect for it.  I can't find
where you cover this now.  It has saved me from my screwups more than
once, so I don't want to lose that.

Now let's put my doubts and your possible bugs / omissions aside and
assume we want '=3D' markup, and we want to keep the resulting sections
out of "sections created by the script for a QAPI command".

A schema's documentation is a sequence of comment blocks.

Each comment block is either a definition comment block or a free form
comment block.

Before your series, we recognize '=3D' markup everywhere, but that's
basically wrong (see "flaws in our parsing and representation of doc
comments" above).  It should be accepted only in free-form comment
blocks.

That way, the free-form comment blocks build a section structure, and
the definition comment blocks slot their stuff into this structure.

Form a language design perspective, I can't see the need for restricting
'=3D' further to occur only by themselves.

Is it an issue of implementation perhaps?


