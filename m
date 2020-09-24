Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2733C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337C82076D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 13:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnSOAilI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337C82076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLRH1-0005fV-4D
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 09:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLRGF-0004lU-Mo
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:26:11 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:45232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLRG9-0003b9-RZ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 09:26:11 -0400
Received: by mail-ej1-x630.google.com with SMTP id i26so4415879ejb.12
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W9sBZ1D3FeWEwSqR0OXsStgm+06piW+45wc8xzqQ1Uk=;
 b=xnSOAilI5QN3ozStJhyIsNfsnCzGCg6dEE6PP8MyxtJ+9ymX8WZRw3DperxatoNpI+
 S6W5xSdh4w5T8zJlqgUMThGuk1uZ2vdE246jkw558j0yHJXND6yRbCXQ5mneBiTSHSzB
 n/whPKBDtNLwn0ulq22O/HwP6zrJcy0bKj4b+z2s2Xu7m6GFHCf4af4nGnUyf5ucZDJJ
 NbuStZhfHjKXRP6G8JLknFdX4SpPsS2bdntWFZ5JzpsMU0/K3QuR64sKmouCiEg9GWyp
 9cA12VHFyAG5Z5XEVbGCq7HNv4wkGuSL4Y1i9RmKEHG2o4w01GnbK6U7Alm4KYtQPY1y
 ScRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W9sBZ1D3FeWEwSqR0OXsStgm+06piW+45wc8xzqQ1Uk=;
 b=b7aTCbdZt4Xc+9EYubm4wErOIFbzrhZkhDNBq0HmcBjng57i3QJXkn5nRk7Otkcsy9
 qtxp708iuURa5Wn+PAf+stC1jjkEBhb85A1FVQLprQQOxdtUs9q2tQ7oR/Zpl402aS3z
 s4+gYM2K8jyA1BM/I+Af8DCacBvNvoNSFk6/GOvb+25G9CDXrai966oV8Oa072PymVG9
 TTtv42dtY3WXkoXGw2hQEeYXmN5IopP0YNAUtfGOvnDTpKMnK0gdPtCdyXu4hUcAgM+m
 0GdPW9xbRKxx12F2TAbWaY4oLL3ZfrGMbp+BMs6qTajf3RlP2KvC/6GBxEIaxAqrFpqQ
 N68Q==
X-Gm-Message-State: AOAM531pQYOpgDD87SYFIiGJbvFV0mVE4dOSK9/MidoH2x9CI7XFmIOc
 maOSz2YumDdKpmQEwkeSMPPkb5gMscwHGL8MrPz9pQ==
X-Google-Smtp-Source: ABdhPJzciKdW9wsIXB1getpEuAYIfwdsAHfV03OUPaDm+BtHMFDtLKgq/pxntQ2JQO6U6LwkH7EVduVQlq1s0cAYnFY=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr1002769ejb.382.1600953962866; 
 Thu, 24 Sep 2020 06:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-10-peter.maydell@linaro.org>
 <875z8t913t.fsf@dusky.pond.sub.org>
 <CAFEAcA_X6gA7XTAXwcCLa-08UWpwg_AhBVKyTfsDrq53R4rH0A@mail.gmail.com>
 <877dsmrq9x.fsf@dusky.pond.sub.org>
In-Reply-To: <877dsmrq9x.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 14:25:51 +0100
Message-ID: <CAFEAcA8A=xJ8b2q1aNPQnn5CevW0Eds9o-_VEGJ=Pav5__EYLQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/20] docs/sphinx: Add new qapi-doc Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 at 12:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 4 Sep 2020 at 13:29, Markus Armbruster <armbru@redhat.com> wrote:
> >> Got a pointer to "Writing Sphinx Extensions for Dummies" or similar?
> >
> > The upstream documentation on extending Sphinx is probably
> > a good place to start; in particular the tutorials are useful:
> >
> > https://www.sphinx-doc.org/en/master/development/index.html
>
> Do you think having this link in a comment could help future readers /
> maintainers?

Easy enough to add it, and it doesn't hurt.

> > OK, how about:
> >
> > # The purpose of this extension is to read the documentation comments
> > # in QAPI schema files, and insert them all into the current document.
> > #
> > # It implements one new rST directive, "qapi-doc::".
> > # Each qapi-doc:: directive takes one argument, which is the
> > # path of the .json file to process, relative to the source tree.
> > #
> > # The docs/conf.py file must set the qapidoc_srctree config value to
> > # the root of the QEMU source tree.
> >
> > ?
>
> Works for me with "pathname" instead of "path".  I'd also write "schema
> file" instead of ".json file", but that's a matter of taste and up to
> you.

Fixed.

> The doc string is confusing (I figure you borrowed the it along with the
> code).  str.join() works just fine for arrays.  It's not the kind of
> iterable that's the problem, it's the kind of thing the iterable yields:
> str.join() wants str, we have. docutils.node.literal.
>
> The lazy solution is to delete the confusing doc string.
>
> Here's my attempt at a non-lazy solution:
>
>     """Yield the members of *iterable* interspersed with *separator*."""

Docstring updated to that text.

> >> I think I'd rather have a separate _node_for_ifcond().  Not a demand.
> >
> > I'm not sure what you have in mind here, so I'll leave it as it is :-)
>
> _nodes_for_sections() is used like this:
>
>         self._add_doc(WHAT,
>                       [self._nodes_for_WHAT(doc, ...),
>                        self._nodes_for_features(doc),
>                        self._nodes_for_sections(doc, ifcond)])
>
> ._add_doc()'s second argument is a list of nodes for sections.
>
> ._nodes_for_WHAT() computes the nodes specific to the kind of thing
> we're processing: enum, object, alternate, command, event.
>
> ._nodes_for_features() computes the nodes for the feature section.
>
> ._nodes_for_sections() computes both the nodes for additional sections
> and the nodes for the ifcond section.
>
> I'd compute the nodes for the ifcond section in their own function, to
> keep .nodes_for_sections() focused on just one purpose.

Oh, OK, that makes sense. The name "_nodes_for_ifcond" is already
taken, though, so I'll call it "_nodes_for_if_section".

> >> Makes me wonder why you build two levels in the first place.
> >
> > This is probably just me not being a very experienced Python
> > programmer. What's the syntax for passing _add_doc the single list
> > which is just the concatenation of the various lists that
> > the _nodes_for_* methods return ?
>
> You could replace
>
>                       [self._nodes_for_WHAT(doc, ...),
>                        self._nodes_for_features(doc),
>                        self._nodes_for_sections(doc, ifcond)])
>
> by
>
>                       self._nodes_for_WHAT(doc, ...)
>                       + self._nodes_for_features(doc)
>                       + self._nodes_for_sections(doc, ifcond)
>
> Operator + concatenates sequences.

Right. We also need to change some of the _nodes_for_whatever
functions that were sometimes returning just a single node
(eg "return section") to instead return a one-element list
("return [section]"), and make them return [] where they were
previously returning None. But this seems like a good change,
as then all these functions consistently return a list
(which might have 0, 1 or many elements).

> > How do I get a QAPIError from within one of the
> > visit_* or freeform methods of a QAPISchemaVisitor ?
>
> The visit_ methods take an info argument.  With that:
>
>     raise QAPISemError(info, "the error message")

We need to launder it into an ExtensionError, so
   qapierr = QAPISemError(info, "message")
   raise ExtensionError(str(qapierr))

but otherwise this works nicely, and you get:

Extension error:
In file included from
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../qapi/qapi-schema.json:72:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/../qapi/block.json:4:
section or subsection heading must be in its own doc comment block

(Or we could do the launder-QAPIError-into-ExtensionError
in run() by extending the scope of its try..except, as I think
you suggest below.)

> > (Aside: what was your conclusion on the question of section
> > headers, anyway? I need to go back and re-read the older
> > threads but I think that is still an unresolved topic...)
>
> If I remember correctly, I disliked "[PATCH 19/29]
> qapi/qapi-schema.json: Put headers in their own doc-comment blocks",
> because "it sweeps the actual problem under the rug, namely flaws in our
> parsing and representation of doc comments."
>
> Our documentation has a tree structure.  Ideally, we'd represent it as a
> tree.  I figure such a tree would suit you well: you could translate
> more or less 1:1 to Sphinx nodes.
>
> We currently have a two-level list instead: a list of blocks (either
> definition or free-form), where each block has a list of sections (see
> QAPIDoc's doc string).
>
> My commit dcdc07a97c "qapi: Make section headings start a new doc
> comment block" was a minimally invasive patch to get us closer to a
> (partially flattened) tree.  Kind of collects the dirt in an (hopefully
> obvious) pile next to the rug.

Ah, yes, I'd forgotten that commit. So I can drop the bit of
code you disliked previously that insists on section headings
being in their own freeform block (handling "header line followed
by freeform text" is easy). That also incidentally means we're down
to only one parser-error in the qapidoc.py, which is the one that
catches mis-ordered section headings (eg using '=== header' when
you hadn't previously used '== header').

> You could finish the job and rework the representation into a tree.
> That would be lovely.  I appreciate help with cleaning up existing QAPI
> messes very much, but do not feel obliged.
>
> You could work with the two-level list as is, relying on the fact that a
> '=' can only occur right at the start of a free-form block.

I'll take this option, I think.

> You could tweak the two-level list just a bit, so that the heading
> becomes properly represented, and you don't have to match free-form body
> section text to find it.

thanks
-- PMM

