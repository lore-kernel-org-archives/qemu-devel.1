Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B022C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F402065C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ym8kyjLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F402065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Jga-0008FL-6o
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3Jfo-0007nA-Ul
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:41:40 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3Jfm-00044w-PE
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:41:40 -0400
Received: by mail-ot1-x342.google.com with SMTP id e11so9138748otk.4
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HsuIM3HcDs4Odv5Rktjb6zxNIosCPFUZMA1sSXdBOec=;
 b=ym8kyjLJ71E0GvOV95ZU6EX7+A8xBLiFepou/0f2o0oYo696p3H+psg4ugjwWB/QuJ
 LU+8KuPITwJTUssWjVgsJkZ6MdPvmOQ3wwtTvxU/t4uWJWR412Rr+wn1POppEnI6mFe2
 dXttQhmDCMpUKPvYxrXHBv5+UoLqKAZZ7iEyNRRKZifWjeyV/RntwoE6olOq3P/yWRsp
 r2MTLX7otFty6cyaegJcgY/0WUmLlW//N9OCryAE6hTuOu9pn2tz8TV3/O0qeebUlQ+O
 +Ux8XnOVnPxDgoX0PvrliQe6BmUz87kZw8Eot+J4VomD94mQgIguzUUm0/cg3+HQCbZQ
 l1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HsuIM3HcDs4Odv5Rktjb6zxNIosCPFUZMA1sSXdBOec=;
 b=a74KtEYL/P9XkZcR/3RG7tssNHzwM/VEjSMSOaEBzAjC4AVs2EvT4Ec6lhtTKKNFbh
 Eb+cX90xRflLZdu4gM1FCDeWpPc6jnr/yddP8nRS8Rfmm+Kc3fKyn8Kjs7U9dRTWNXRm
 Ah3qJm3BREdss3QWcV1ANnntiwpdmdtiC8CCrbwJKqe02nm18FUYZVE0EYvb6gdoCm0n
 OEFs+SdkdiDI2DZQJAj6n9C8eg1LQVcpDFqzYyOAoFDo1yqioXEReKR5W3QSEBptu35T
 0ZK22OMX5MJWzRq3DbTiLGZ1FLkohCwJl8wFJC7Iw83i5gwfW2QiKcf/WWiubktl9Mcc
 gU8A==
X-Gm-Message-State: AOAM530F2248KPfSxKKzL/+b3x8tOdoK/BPAAcHCWQOT4Z1nb2cfDccZ
 6u9ywUVWQiGvFBV6ZGOP9WExNZ5CyeWThTI1zzesLA==
X-Google-Smtp-Source: ABdhPJwh9W83bHqFob4OOBdG2nezqtKXqHLNwjW1cRXCJLq3Z/MNk2IN0iJl0wct8j7s9Bsb4y3n5huVzP2rJnE2tao=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr2673052otb.91.1596634896488; 
 Wed, 05 Aug 2020 06:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-5-peter.maydell@linaro.org>
 <87eeolnt25.fsf@dusky.pond.sub.org>
In-Reply-To: <87eeolnt25.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Aug 2020 14:41:25 +0100
Message-ID: <CAFEAcA-nk3+W-on=tsW_8OY==MriMyeJFQ=_tFjHkaoj5mUA_A@mail.gmail.com>
Subject: Re: [PATCH v4 04/18] tests/qapi/doc-good.json: Clean up markup
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 14:03, Markus Armbruster <armbru@redhat.com> wrote:
>
> The subject is a bit misleading.  The markup doesn't need cleanup.  It
> purposefully tests corner cases of the doc comment parser.  For some of
> them, the conversion to rST will change the meaning.  This commit tweaks
> the test so it passes before and after the conversion.  Makes it a worse
> test for the doc comment parser, which doesn't matter, because the code
> in question is about to be deleted.
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > doc-good.json tests some oddities of markup that we don't want to
> > accept.  Make them match the more restrictive rST syntax:
> >
> >  * in a single list the bullet types must all match
> >  * lists must have leading and following blank lines
> >  * indentation is important
>
> Actually, indentation has always been important, but the conversion to
> rST changes where and how it matters.

Mmm. More specifically, indentation was previously unimportant
within a multiline block of text, and is now important there.

> >  * the '|' example syntax is going to go away entirely, so stop
> >    testing it
>
> Before the series, we (try to) cover all doc markup here.
>
> The series replaces the doc markup language by rST + a little extra.
> The test must still cover the little extra then, and covering a bit of
> rST to ensure basic sanity won't hurt.
>
> Correct?
>
> I'm asking because a "yes" explains why we can drop coverage without
> replacement: it's appropriate when the markup in question is replaced by
> rST.

I guess so. We still want some test coverage of the stuff the
doc-comment parser is doing that's actually looking for
arguments and so on; we don't really need to check that
rst is rst.

It's been a while since I wrote this patch, but basically IIRC
it's "make the minimal changes necessary so that the test does
not start failing for the parser changes that will follow".

> > This will avoid the tests spuriously breaking when we tighten up the
> > parser code in the following commits.

> > @@ -62,7 +62,7 @@
> >  ##
> >  # @Base:
> >  # @base1:
>
> Here, indentation is relevant even before the series: @base: is only
> recognized as an argument section when it's not indented.
>
> > -#   the first member
> > +# the first member
>
> Why do you need to unindent this line?

Because in the tightened syntax, you can either have:

@foo: line 1
      line 2

(the definition part of the argument is multiple lines of
rST, which all must be lined up to start at the same column)

or

@foo:
line1
line2

(the definition is multiple lines of rST, which all start
in column 1)

But
@foo:
   line1

is neither of the above, and will be invalid.

The old parser simply stripped all the leading whitespace
from this kind of multiline lump-of-doc-text. That doesn't
work for rST because we want to be able to have doc-text
where leading whitespace matters. So we need to know how
many characters of whitespace to delete from each line. The
two options above basically correspond to the two major
pre-existing kinds of doc-comment.

Compare commit 26ec4e53f2bf0a381, which fixed up the
doc comments in qapi/ proper to follow this "one of
these two indent models, but not anything else" pattern.

> >  ##
> >  { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
> >
> > @@ -101,7 +101,7 @@
> >  ##
> >  # @Alternate:
> >  # @i: an integer
> > -# @b is undocumented
> > +#     @b is undocumented
>
> Why do you need to indent this line?

Again, because it needs to follow one of the two
indent patterns described above. Either no text
following the "@i:" and all lines start in column 1,
or all lines have to start in the same column as
the text following the "@i:". In this case I went for
option 2.

The test input is a bit odd because it's talking
about @b in the description-text for @i, but there
you go. You could alternatively add a newline
after the @i: line to put the text "@b is undocumented"
into the doc-text for the whole @Alternate struct
rather than into the doc-text for the @i member.

> >  { 'alternate': 'Alternate',
> >    'data': { 'i': 'int', 'b': 'bool' } }
> > @@ -115,7 +115,7 @@
> >  # @arg1: the first argument
> >  #
> >  # @arg2: the second
> > -# argument
> > +#        argument
>
> Why do you need to indent this line?

As above, beacuse it's not in either of the
two standard "this is what indent for a multi-line
bit of doc text for an argument can be" patterns.

thanks
-- PMM

