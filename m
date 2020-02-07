Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13751C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE65521775
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRCmZeA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE65521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06Hf-0001qV-2K
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j06G2-0008DQ-6u
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j06G0-0005Zx-N4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:13:29 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46416)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j06G0-0005Za-G3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:13:28 -0500
Received: by mail-oi1-x241.google.com with SMTP id a22so2437316oid.13
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qPLDJtP9+F0OaWMVHTeBUofOxEZIxYjF4PIkfSkREIk=;
 b=pRCmZeA/WKDwlXwgLDJNyS7zdhA7owsh9vgtnAGg3fBCtNIi3y3uVvSzO1EMxC6jH5
 CRPs4szS1PLsvu5WyxlbPK2uNx1DxUO3STPr3H8SChTuWFbc/3dSQE+GQ3S5aJO12gMe
 athLEkR1Plmn+6jzUgO3WEXHJIV0RN5a3+PyyAGEKIXx2sK21e6INn1q7AcyB/ak2znQ
 6xN+SL1HgMv99rAK0S4ExVDIZ+ta/WvLGamrcKg6oh1rtmFoiAf2f1pgjl6XerUOKUEg
 /y3LNfdMJZwmf5M7mGvOPrBVtLvX069dVUjpRmLEKIGX/YPAYmVckRDIv/l1fESslqhJ
 fL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qPLDJtP9+F0OaWMVHTeBUofOxEZIxYjF4PIkfSkREIk=;
 b=ZjvmeuvL0Q93F8oGOUktYWujkQfMpQ4foECGRwHX5I1Cbz/15v2vTSKDlNxt3Mf88b
 FmZmwhv1DKbav0of6QsAJXQBiyeR6OKkV7yOCUw+WTJdFLm26bBNuttr5tPqjRquVnRw
 cx5T3ZX9dXnTmyiaNJlM0pXCA66Ic2G96r1+CPKIBeLyYXo1Iy5D8FzGf9os/TIgUr0H
 XLgQYfMqAp6SMyOcljrVBoiuJ0Q5y3G7w4fIn1ozZ7M0pqQ91kW4PO+35YJnhRTHec37
 YRQQCTLrS3/nDx2vAwjzxmCvFAl61CrVay38O7Ebyq/cn3Rr9vRvkbcvLCPv5oi//MgR
 rhcA==
X-Gm-Message-State: APjAAAVS8ccPyTFNWu6LM2aiqdO2RJizXnzTvkhZWHrAh13WDnL5NNSt
 1iMvqSwfngHV/sSqArPqVeO4bT+f+iYJlSMITH/2oA==
X-Google-Smtp-Source: APXvYqys8EJVAt7ikIxqH4ulZZZecyjwSBiDenkNH9ukoVbn3SyyDaMF1jDBx/tiO76Yat4ElXxOx4YKxDA+Nv2jQQA=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2497240oic.48.1581092007710; 
 Fri, 07 Feb 2020 08:13:27 -0800 (PST)
MIME-Version: 1.0
References: <20200206173040.17337-1-peter.maydell@linaro.org>
 <20200206173040.17337-20-peter.maydell@linaro.org>
 <87r1z6pg0x.fsf@dusky.pond.sub.org>
In-Reply-To: <87r1z6pg0x.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 16:13:16 +0000
Message-ID: <CAFEAcA_T-Muy0NOj1uufB=QCxsn0hMvDnD-KoCz1Dv-+v71i5w@mail.gmail.com>
Subject: Re: [PATCH 19/29] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 15:35, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Our current QAPI doc-comment markup allows section headers
> > (introduced with a leading '=' or '==') anywhere in any documentation
> > comment.  This works for texinfo because the texi generator simply
> > prints a texinfo heading directive at that point in the output
> > stream.  For rST generation, since we're assembling a tree of
> > docutils nodes, this is awkward because a new section implies
> > starting a new section node at the top level of the tree and
> > generating text into there.
> >
> > New section headings in the middle of the documentation of a command
> > or event would be pretty nonsensical, and in fact we only ever output
> > new headings using 'freeform' doc comment blocks whose only content
> > is the single line of the heading, with two exceptions, which are in
> > the introductory freeform-doc-block at the top of
> > qapi/qapi-schema.json.
> >
> > Split that doc-comment up so that the heading lines are in their own
> > doc-comment.  This will allow us to tighten the specification to
> > insist that heading lines are always standalone, rather than
> > requiring the rST document generator to look at every line in a doc
> > comment block and handle headings in odd places.

> I figure this is a minimally invasive patch to avoid complications in
> your rST generator.  I'm afraid it sweeps the actual problem under the
> rug, namely flaws in our parsing and representation of doc comments.
>
> The doc comment parser doesn't recognize headings.  Instead, that's done
> somewhere in the bowels of the Texinfo generator.  Works as long as the
> input is "sane", happily generates invalid Texinfo otherwise, see
> tests/qapi-schema/doc-bad-section.json.
>
> The proper fix is to make the parser recognize headers in the places
> where headers make sense, and reject them elsewhere.
>
> But maybe we don't have to.  Do you plan to support full rST in doc
> comments?  If yes, why have our own syntax for headings?  Why not leave
> it to rST?  If no, do you plan to support a subset of rST?  If yes,
> define it, please.  How will it be enforced?

Doc comments do support full rST. However, (as the commit message
here notes), if you're generating a tree of docutils nodes and
one of them has a section heading in it then you'll get a result
that looks like this:

[root]
  - [ some section created by the script for a QAPI command ]
  - [ some section ]
      - [text nodes, etc going into this section]
      - [a section resulting from rST parsing the header inside the docstring]
  - [ next section created by the script for a QAPI command ]

(ie you'll have defined a subsection within whatever document
paragraph/section the current command is documenting, not
a new top-level subsection which subsequent commands will
become children of)

What you actually want is that the new header results in
a differently structured tree:
[root]
  - [ some section created by the script for a QAPI command ]
  - [ some section ]
      - [text nodes, etc going into this section]
  - [ a new top level section whose header is whatever this header is ]
     - [ next section created by the script is a child of that section ]
     - [ etc ]

There's no way to get that without actually noticing and handling
headings specially as being something entirely different from
a lump of documentation text. "A heading is a single-line special-case
of a freeform comment" happens to be the way we mark up headings
now in 99% of cases, so that's what I implemented. (The Sphinx
extension will complain if there's trailing junk lines after
a heading line at the beginning of a freeform comment block.
If you use '== something' in a line in the middle of a doc
comment, we'll just interpret that as rST source, which is to
say a couple of literal equals signs at the start of a line.)

thanks
-- PMM

