Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41122C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 22:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00FD2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 22:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mzFVMdby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00FD2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVkH5-0000FP-6M
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 18:08:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVkGE-0008LF-8l
	for qemu-devel@nongnu.org; Tue, 28 May 2019 18:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVkGC-0002hF-S5
	for qemu-devel@nongnu.org; Tue, 28 May 2019 18:07:58 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVkGC-0002b6-JY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 18:07:56 -0400
Received: by mail-ot1-x32f.google.com with SMTP id u11so19327801otq.7
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 15:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=oSw5BcdoPWZKnz+zMnJHC+UCf889Dak4GzEiw6PiBBs=;
	b=mzFVMdby3N8s0uKc32eYZBMkmwtw6QTdw7E2W37M030PIytQpZnqSVlOHioqzOtCIk
	Q/5Qkbw9XA1tZ2Yr3eoWqMvbss9ameJrgP7ihB8WxoGWgLtbPf49vJj08oCay0ln9QHS
	69QK4Nfw2Qg78SIaikgOeq8oZm1DyMLvBRvHPpkaSY9lg5OPTf1vIKQTrRONTxLFpJYP
	spqd5d3lxIu7rebX1CBr2WSmfZL/BNgMqiND2fa2OGuPqs2r8hUL+gZphSCrRzcB6mAK
	z3FqVLZSLZVEAJip65UzCYyphLvHg1SmWq9YTQi+FRTELpZlDKFOVNezqPhDxAe7wdaj
	Z3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=oSw5BcdoPWZKnz+zMnJHC+UCf889Dak4GzEiw6PiBBs=;
	b=a8PPlo2bg3UI5K7/gxWbzhqHMudwB3UjZf+n2FhlaoZl1uhf9C1/8IZWkg2uwSPKjA
	DbavjhK+CDc+4Ir9ZOko9M4Np1icRYcWDSzh3KU8CxU6MW3+GHrtJ25rHubFoXi6jhzk
	IhLbqY3qX9CG9RfCaUGuv0QYgCjIX3SJyBHb6oGEn7xy/1ShJ0KrLEwUGIyg7OP7kYIz
	/mkYIoWR3HlSgcHvKptBSVSFQrMEK915pS6HG8R+js0ECVsc8LeVnDX3eY2fEolR9Vfs
	d3qKsutoMsNbS6R7wNPTlPmgQfqILa9JsR/Zk9PiZgG8UkXHwU+o99R3tTQiBGV9wmvX
	kNYw==
X-Gm-Message-State: APjAAAUKVIgZt2DE7K9XO4GUUXiguOqKv02YFtMeP6FogS/FqckqPFYB
	wLbrUtGMig88mxNh5oLnPEV10TaMgxxPFLvNX9vXvQ==
X-Google-Smtp-Source: APXvYqw3DhuMpAVZWUuwtuslGveOMSbyBVxsB6ENjucXoKaVPsyCjl6dSwTrS5mRpgkaFNJ7zcZRhHk+by95BiVVqNI=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr41326439otp.91.1559081274472; 
	Tue, 28 May 2019 15:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_-DptTwe7dkbZ171HJ+DtXCAOKt08pja=4-QbQKJSEvQ@mail.gmail.com>
	<6382a25f-6af4-5ceb-5750-b23c5f053a48@redhat.com>
In-Reply-To: <6382a25f-6af4-5ceb-5750-b23c5f053a48@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2019 23:07:43 +0100
Message-ID: <CAFEAcA_Y39Zw72LEcpNdPirKY7o4sNBQVgX4i4dRf6R_9NM1xw@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32f
Subject: Re: [Qemu-devel] Sketch of a transition of QEMU docs to Sphinx
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 at 20:09, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 5/21/19 2:56 PM, Peter Maydell wrote:
> > Currently we have a vague plan that we should migrate our
> > documentation away from Texinfo to using Sphinx, plus some isolated
> > bits of documentation already in .rst format. This email is an attempt
> > to sketch out a transition plan for getting us from where we are today
> > to where (I think) we want to be.
> >
> >
> > WHERE WE ARE TODAY
> > ------------------
> >
> > I'm going to concentrate on the documentation that's installed by
> > 'make install', because anything else is for developers only, making
> > it lower priority to clean up and more amenable to messing around with
> > anyway.
> >
>
> To an extent, I'd like to emphasize that our "users" are increasingly
> developers from other projects and these internal docs are primarily
> useful for this crowd.
>
> > Currently we install:
> >
> > - in $DESTDIR/usr/local/share/doc/qemu:
> >  qemu-doc.html
> >  qemu-ga-ref.html
> >  qemu-qmp-ref.html
> >  qemu-doc.txt
> >  qemu-ga-ref.txt
> >  qemu-qmp-ref.txt
> >  interop/  (the only Sphinx manual we currently ship)
> >
>
> Oh, but this is exactly what I was referencing above, so nevermind.

Right. The devel/ manual is for things which are purely
QEMU internals -- autogenerated internal API docs,
how TCG works, that kind of thing. (What we have so far
is in docs/devel/.) The interop/ manual is the one for
QEMU's interfaces to other projects.

> > Sphinx supports a "plain text" output format, which will create a
> > one-big-text-file for each of the four installed manuals. It might
> > also be possible to generate some kind of "one .txt file per input
> > .rst file" format, but that would require a greater amount of messing
> > about.  (The sphinx text builder doesn't do this and so you'd need to
> > get make to invoke sphinx once per rst file in each manual, which will
> > be awkward.) Or we could just say "it's 2019, the HTML documentation
> > is the official format, that (and manpages) is what we ship". Opinions?
> >
>
> I am not sure what the value in plaintext Sphinx docs are, since they
> lose the hyperlinks ... unless you keep it in ReST or Markdown format,
> and then you could just install the source documents, no?
>
> I just seem to think that most of the text-only purists are also the
> type to already have the source tree checked out somewhere.
>
> As long as we've got HTML + manpages, I think we're doing OK.

That tends to be my opinion (especially since we don't for instance
check the text output to make sure it hasn't rendered in some
way that introduces problems). I just wanted to give people
an opportunity to say "I like the way we currently ship plain text".

> > (1) qemu-ga-ref and qemu-qmp-ref will become part of the interop/
> > manual. This requires:
> >  * adding rst-generation support to qapi-gen.py
> >  * converting the hand-written texinfo parts to rst
> >  * listing those new .rst files in docs/interop/index.rst
> >  * makefile runes to create manpages via the 'man' sphinx builder
> >    from docs/interop/qemu-ga-ref.rst and qemu-qmp-ref.rst
> >  * there is a tests/qapi-schema/doc-good.test.texi which I think
> >    is acting as a test of the texi doc generation; this should
> >    be converted to test the rst doc generation instead
> >  * delete all the old texinfo build machinery, install runes, etc
> >
>
> Good riddance. I assume this also means we need to rewrite the QAPI
> comments to use Sphinx-ese instead of Texi-ese.

Yes, if we auto-inline comment text we would need to update
the markup (as with the .hx file stuff I mention later).
(I guess in theory if there's only a very limited set of
markups used we could make the rst generation translate from
the current format to rst, but I think we'd be better off
having the format really match our current documentation.)

> I think that'd be good, though, because it means we get proper lexing
> and parsing on our examples. Especially in places where we
> cross-reference; for example -- QMP has this trick where our commands
> don't take any arguments themselves but rather define a data type it
> expects as input.
>
> In the output manual, this means that we don't document the arguments
> near the function, which is awful.
>
> Sphinx can help us cross-reference these things better.

Yes, at least in theory. I haven't looked into how difficult
it is to get Sphinx to actually make things refer to each other,
but it really ought to be doable.


> > Comments on this whole proposal (whether I've forgotten anything
> > about our current setup, whether we really do want to go to the
> > place I've suggested we go, etc) welcome.

> It looks good to me overall -- any progress towards a unified manual
> with automatic checking of any sort is an improvement.
>
> I'll try to keep an eye on it over the summer and see if I can't help
> nudge the block layer documents along the path to something unified.
> I've written one custom extension now, so what's a few more?
>
> I also wrote a hasty script that tried to unify the qemu-img.texi and
> qemu-img help outputs and removed one more usage of the hxtool, but it's
> only a stopgap and wasn't something like proper sphinx integration, but
> maybe I could keep working in that area soon.

Thanks.

> I would also like to say that it would be useful to host our HTML docs
> online such that we can point to the different versions, like you can
> with the official python docs. They often have a little dropdown where
> you can switch between 3.5/3.6/3.7 or so on and see the difference on
> that exact page. It'd just simply be nice to be able to do the same for
> QMP docs.

Yes, definitely, although this is I think somewhat orthogonal to
the format we use to create them.

thanks
-- PMM

