Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E46EC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEF9217BA
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 14:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/z3Beas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEF9217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0RLE-0008J8-A1
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 09:44:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j0RKe-0007ua-5R
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0RKc-0008GA-8O
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:43:39 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:37044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0RKc-0008FZ-24
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 09:43:38 -0500
Received: by mail-oi1-x236.google.com with SMTP id q84so5011190oic.4
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cwpb7fikghgZWonDpahs2ENNETMNNb4HyI9ZIm9+Z8Y=;
 b=F/z3BeasMbuwEsG03xwof3QHzWq9Oo0XIUqz1cRAiQi0DNX1aG4NDN2rkXoUKORIEd
 zChCNc3r6oCVc9sfXF9Qt4K917bWllt0WqJkui7EY656IXBUkH0g+St+DGTI8Ob+H3ZO
 btOtixyYuZpSOxLAzVr0Q0qZaNuyu2ypNAZD+DaUEWg2GuyTdnuNyBqlLztfdXF5mxwM
 e/DNIpQYHyWaEpPLqN3JSivKkAK9ZgL2HKUd3cAFlNTVBiNAuIAUB2Cl7EqYOn467zmM
 Sz1oOHRW6/j5Q0jNV2Q6HVSQIOF0PcmV4nCQP3ww9K/HRJZdGApJVZf/4zjm5OWL8AGu
 oBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cwpb7fikghgZWonDpahs2ENNETMNNb4HyI9ZIm9+Z8Y=;
 b=LqH4rr6qKBS33clZFeM9gRw0EnV9j8cuOuNZzWY+jNy7eyX95BPT35iZChhs59q0/H
 6pegHj9gRGhoShtvEBQzN96IaITMlY89zxhG5ziu0OeeRtwLHK4z9BCc8Ty5mD1+dkmi
 VQSmfIHYQMFNXc4019fkzPPpj1n1JrXLje4xZjZ6D27eNVN/80be93rZg+qyoQ3crvrY
 wjJaKc6zwbKayOhD9I+3WUUzMcgmXyUe7Xb02FdQN/fmC2/tt/3vZ3quYwiMahwrBKmx
 +cYEN7vTd1a3dLkT9kAC3bP0c19nbzH+SVFrXoinUEcvkon/iFb/lcE22xLii38REpVP
 KUlA==
X-Gm-Message-State: APjAAAUMoyLEuw1R56HeNMkCjVlnCMns3/gXYujRMmvsbO/6Ddr1NBJu
 ar9BZb80o99KF3YJcgQATOd7arlaY0WV2+ZbQoDhluYy
X-Google-Smtp-Source: APXvYqz+8dKy2S5c1I5BSfMN/IM/FJ+rfMeBOb8VpKb89joVZ0RVkPEeXkmNZy3Ky/4H3Fy/+m1nF1JZloQhaJy9GEU=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr5680033oiy.170.1581173016873; 
 Sat, 08 Feb 2020 06:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-20-peter.maydell@linaro.org>
 <87r1z6pg0x.fsf@dusky.pond.sub.org>
 <CAFEAcA_T-Muy0NOj1uufB=QCxsn0hMvDnD-KoCz1Dv-+v71i5w@mail.gmail.com>
 <87h801jhkj.fsf@dusky.pond.sub.org>
In-Reply-To: <87h801jhkj.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 8 Feb 2020 14:43:25 +0000
Message-ID: <CAFEAcA8bPqNa=RRyNrt+9RL0ja56Qq8-xmNnp=vg6wz7-jmrhQ@mail.gmail.com>
Subject: Re: [PATCH 19/29] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 14:10, Markus Armbruster <armbru@redhat.com> wrote:
> A couple of remarks.
>
> Silently passing a "# == something" line to rST for literal
> (mis-)interpretation is not nice.  It's the kind of indifference that
> led to the messes you cleaned up in PATCH 04 and 08.  If the '=' markup
> is only valid in certain places, it should be rejected where it isn't.
>
> By refusing to translate "# == something" to rST (silently or loudly,
> doesn't matter), the first tree structure becomes impossible.  Except
> when I do the translating myself: I can put an *rST* section wherever I
> want.
>
> I'm still having difficulties understanding what exactly we gain by
> translating '=' markup to rST.

We don't translate '=' markup to rST. We use it as the way
the input document tells us about the structure of the
tree of docutils sections it wants us to create. No rST
markup is ever involved in that process.

If we wanted to do something with '# == something' in actual
chunks of doc comment, we would have to specifically scan
the doc comment for that. Currently we simply pass doc
comments to the rST parser to be parsed. Then you have
to document the syntax of a doc comment as "rST, except
that as a special case a line starting == doesn't do what
it does in normal rST text but is a syntax error".

What I would like is:
 * doc comments are simply rST, and we interpret them as
   rST by passing them directly to the rST parser. (We do
   special case the "@var means ``var``" markup, but I
   would rather keep to a minimum the number of things we
   special case in that way.)
 * headings and subheadings affect the entire document
   structure; they are not rST source and are never
   interpreted as rST source or sent to the rST parser.
   They are a thing all of their own, not a bit of markup
   within a larger doc comment.
 * not to gratuitously change the way we in practice
   mark up headings in our document, because that makes
   the texi->rST transition harder for no clear gain.
   If we absolutely must mark them up in some other way
   than we do today, I can implement that, but it feels
   like unnecessary work.

> By the way, your implementation rejects
>
>     ##
>     # = Introduction
>     # xxx
>     ##
>
> but silently accepts
>
>     ##
>     # xxx
>     # = Introduction
>     ##

Yes. I could treat all freeform comments that aren't
the special one-line heading/subheading as being normal
freeform comments, which would avoid this inconsistency.
That's probably better.

> doc-good.json has more instances of this issue.  Before your series, we
> actually check we generate the Texinfo we expect for it.  I can't find
> where you cover this now.  It has saved me from my screwups more than
> once, so I don't want to lose that.

Yes, we no longer have a test case for "do we generate what we
expect to". That's harder to do with a Sphinx extension because
we don't ever output rST source anywhere that we could compare
to an expected version. (We still have the existing tests that
the doc comments spit out by parser.py match expected output.)
I'm dubious about running Sphinx and comparing the generated HTML
because that seems like it would be vulnerable to test failures
if Sphinx internals change the fine detail of how it outputs HTML.

> Now let's put my doubts and your possible bugs / omissions aside and
> assume we want '=' markup, and we want to keep the resulting sections
> out of "sections created by the script for a QAPI command".
>
> A schema's documentation is a sequence of comment blocks.
>
> Each comment block is either a definition comment block or a free form
> comment block.
>
> Before your series, we recognize '=' markup everywhere, but that's
> basically wrong (see "flaws in our parsing and representation of doc
> comments" above).  It should be accepted only in free-form comment
> blocks.
>
> That way, the free-form comment blocks build a section structure, and
> the definition comment blocks slot their stuff into this structure.
>
> Form a language design perspective, I can't see the need for restricting
> '=' further to occur only by themselves.
>
> Is it an issue of implementation perhaps?

Do you mean: could we make the implementation take a freeform
comment block like:

##
# = Foo
#
# Some text
#
# = Bar
#
# More text
##

and parse through that text to split it up into

- "start new level-1 section with heading 'Foo'"
- "a freeform comment block '\nSome text\n\n'" (for current section)
- "start new level-1 section with heading 'Bar'"
- "a freeform comment block '\nMore text\n\n'" (for current section)

so that the input rST doesn't need to mark off the headings
as being in their own freeform comment block ?

Yes, we could do that, and it wouldn't be too hard.
My issues with that are:

(1) you now don't have a way to literally write '= Foo'
to be interpreted the way that rST would interpret it
in a comment block that's otherwise just "any
rST markup is fine".

(2) it falsely suggests that headings are OK in
doc comment blocks and are just another kind of
markup within a doc comment, when they aren't, and
we're really just providing syntactic sugar here

(3) it obscures the actual structure of the
document, which is

 [root node]
  [section]
     [title 'Foo']
     [Text 'Some text']
  [section]
     [title 'Bar']
     [Text 'More text']

where "Some text" and "More text" are in entirely
different sections, even though they're in the same
doc comment block. (If 'Foo' is a subsection and
'Bar' a section, the text can end up even further
separated within the document tree.)

(4) it breaks a general approach within the handling
of doc comments, which is that we build the document
based on the various bits of information about the
symbol, etc, but a chunk of text from a document
comment is handled simply by handing it off to
the rST parser, not by doing some script-specific
pre-parsing and mangling of it and then handing it
to the rST parser. This in turn means that we need
to document the syntax of comment blocks as not
just "it's rST with the @var-means-``var`` extra"
but "it's rST, with @var-means-``var``, and = Foo
is invalid most places but within a freeform block
means this other thing". I think that minimising
the number of extras we add on top of "the syntax
for a block of text in a doc comment is rST"
makes things less confusing.

thanks
-- PMM

