Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A3EC47425
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A55E20789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXu3wz5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A55E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNErM-0000o7-Aa
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEpI-0007WL-E8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:33:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:46523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNEpE-000862-0b
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:33:48 -0400
Received: by mail-ej1-x62b.google.com with SMTP id z23so14683769ejr.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 05:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WUF6ivkworUJzlWH/TIDlvdb2/bOEjpzYYmcavvhOr4=;
 b=TXu3wz5YW9qcSQahbvC365q57APBdpzu7mpgFb5HVg/wHBt7GKGEH5JsEiEEp97uDO
 GdeYwitJxUCp1gUag7VhnkmbzSV8PoyjRVXnQLTmhN7zoJm4BAnuDc8tiyNAZwllx8MP
 tnaKIzj8a72iA9abP8kzN435bnEkq2PtJBg4A8/z61MtUoD+qyzR9cNCJbQe/Rq+uUuC
 iQwcrXJebH2CP7NGzhkiD0uBhQ0I2LiLLKZgJTycf/1nWZzAS43noRPl7kD/m5Mw+M8R
 LvktfMEpOXXU/+ZiXWC9yoru+rW2TUc2FknVJEsiSDT7bRja3R0Nsr1N53ECCyoO9C8b
 8jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WUF6ivkworUJzlWH/TIDlvdb2/bOEjpzYYmcavvhOr4=;
 b=b021UA8As+fUupBiL9lcrICHPjppcAVsTw+jgIy4y00IK1xqZGgDfXdazA6609Yxfy
 h3/47dfyDOzoUj9kzA3FkxdR2I/t71GDArx3GTF9GL5wqoUdEIjGSUlzg9q+piYyNLU4
 n+CQlZY6iU7B6+I6HeTxmgFGgKhc9RD2SAd6udk/GHnCUOBNrS6Jgfkx4TY0153HZAjQ
 eC2J3FUll/sppvubFRydMhF6fx8Bscui3WSwkZvAmHRNMq5sCMF7j5LCkc/ouXkQRr0J
 1hYMYsQZPCsYKEGzblpYFqzFvy9r5UcXZLui3sjIm8kkXSt19M/OfN0aqRVWHKYiH0Q9
 f0jQ==
X-Gm-Message-State: AOAM5334CYuTflzsgSG1EiZmTF/EUjHrOGvPv0pw+yzkx7hvLAjXckgo
 HwdDjcyadyAvK6ccaAd4hFQsPHCQ+sUCa+cuIHpCfg==
X-Google-Smtp-Source: ABdhPJzszE5VP5USwL0rV4Uqozer5w4sKg4juPL1ZHRGKPbocrnnJH3HJiXh0OuaTwSQTPRD6OD/HEoAapJLui7j6rk=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr3794341ejv.56.1601382822312; 
 Tue, 29 Sep 2020 05:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-16-peter.maydell@linaro.org>
 <877dscvkp5.fsf@dusky.pond.sub.org>
In-Reply-To: <877dscvkp5.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 13:33:30 +0100
Message-ID: <CAFEAcA_fQPYbf4TG3TayQ5Y5NBJCOq6wuBiqXZMp3MUVj7XFrA@mail.gmail.com>
Subject: Re: [PATCH v6 15/21] tests/qapi-schema: Add test of the rST QAPI
 doc-comment outputn
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 13:20, Markus Armbruster <armbru@redhat.com> wrote:
>
> In subject, s/outputn/output/
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Add a test of the rST output from the QAPI doc-comment generator,
> > similar to what we currently have that tests the Texinfo output.
> >
> > This is a bit more awkward with Sphinx, because the generated
> > output is not 100% under our control the way the QAPI-to-Texinfo
> > generator was. However, in practice Sphinx's plaintext output
> > generation has been identical between at least Sphinx 1.6 and
> > 3.0, so we use that. (The HTML output has had changes across
> > versions). We use an exact-match comparison check, with the
> > understanding that perhaps changes in a future Sphinx version
> > might require us to implement something more clever to cope
> > with variation in the output.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> It's not just the potential Sphinx version dependence that makes this
> awkward.
>
> We can no longer check what our doc generator does (at least not without
> substantial additional coding), we can only check what it does together
> with Sphinx.  We do so for one output format.
>
> Our doc generator output could change in ways that are not visible in
> the Sphinx output format we test, but are visible in some other output
> format.
>
> We choose to test plain text, because it has the lowest risk of unwanted
> Sphinx version dependence, even though it probably has the highest risk
> of "rendering stuff invisible".
>
> Certainly better than nothing, and probably the best we can do now, but
> let's capture the tradeoff in the commit message.  Perhaps:
>
>   This is a bit more awkward with Sphinx, because the generated output
>   is not 100% under our control the way the QAPI-to-Texinfo generator
>   was. We can't observe the data we generate, only the Sphinx
>   output. Two issues.
>
>   One, the output can vary with the Sphinx version.  In practice
>   Sphinx's plaintext output generation has been identical between at
>   least Sphinx 1.6 and 3.0, so we use that. (The HTML output has had
>   changes across versions). We use an exact-match comparison check, with
>   the understanding that perhaps changes in a future Sphinx version
>   might require us to implement something more clever to cope with
>   variation in the output.
>
>   Two, the test can only protect us from changes in the data we generate
>   that are visible in plain text.
>
> What do you think?

Yes, seems worth recording that in the commit message (especially
now you've written the text :-)).

> > +# Test the document-comment document generation code by running a test schema
> > +# file through Sphinx's plain-text builder and comparing the result against
> > +# a golden reference. This is in theory susceptible to failures if Sphinx
> > +# changes its output, but the text output has historically been very stable
> > +# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
> > +# texinfo or HTML generation, both of which have had changes. We might
>
> Texinfo
>
> > +# need to add more sophisticated logic here in future for some sort of
> > +# fuzzy comparison if future Sphinx versions produce different text,
> > +# but for now the simple comparison suffices.
> > +qapi_doc_out = custom_target('QAPI rST doc',
> > +                             output: ['doc-good.txt'],
> > +                             input: files('doc-good.json', 'doc-good.rst'),
>
> Gawk at my Meson ignorance...
>
> Looks like this builds doc-good.txt from doc.good.json and doc-good.rst.
>
> doc-good.txt is also a source file.  Works, because we use a separate
> build tree.  Might be confusing, though.

Yes. We could change the name of the reference source file that
we have checked into the git repo if you wanted. (The output file
written by Sphinx has to be the same name as the input .rst file AFAICT.)

> > +                             build_by_default: build_docs,
> > +                             depend_files: sphinx_extn_depends,
> > +                             # We use -E to suppress Sphinx's caching, because
> > +                             # we want it to always really run the QAPI doc
> > +                             # generation code. It also means we don't
> > +                             # clutter up the build dir with the cache.
> > +                             command: [SPHINX_ARGS,
> > +                                       '-b', 'text', '-E',
> > +                                       '-c', meson.source_root() / 'docs',
> > +                                       '-D', 'master_doc=doc-good',
> > +                                       meson.current_source_dir(),
> > +                                       meson.current_build_dir()])
> > +
> > +# Fix possible inconsistency in line endings in generated output and
> > +# in the golden reference (which could otherwise cause test failures
> > +# on Windows hosts). Unfortunately diff --strip-trailing-cr
> > +# is GNU-diff only. The odd-looking perl is because we must avoid
> > +# using an explicit '\' character in the command arguments to
> > +# a custom_target(), as Meson will unhelpfully replace it with a '/'
> > +# (https://github.com/mesonbuild/meson/issues/1564)
>
> Rather disappointing.
>
> > +qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
> > +                                  output: ['doc-good.txt.nocr'],
> > +                                  input: qapi_doc_out[0],
> > +                                  build_by_default: build_docs,
> > +                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
> > +                                  capture: true)
>
> I figure this strips \r from the build tree's doc-good.txt.

Close; it turns either CRLF or LF into the host OS's
line-ending sequence (see below).

> > +qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
> > +                                  output: ['doc-good.ref.nocr'],
> > +                                  input: files('doc-good.txt'),
> > +                                  build_by_default: build_docs,
> > +                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
> > +                                  capture: true)
>
> Uh, this strips it from the source tree's doc-good.txt, right?  Why is
> that necessary?

This is in case the user has a setup that eg has git
doing line-ending conversion on checkout somehow. As a
non-Windows user I opted to be belt-and-braces about
converting both files to a known-consistent line ending.
It's also necessary because the perl rune isn't really
"delete \r"; it's "delete any \r and then output the
line with the OS line ending" because the files it processes
are being read and written in text mode. So the output
will be \r\n on Windows and \n on Unix; the test passes
in both cases because both files have the same
line endings after conversion.

thanks
-- PMM

