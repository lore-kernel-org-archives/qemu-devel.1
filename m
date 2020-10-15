Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4C4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC634206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+hMBC3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC634206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTA2f-0004vY-K5
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTA1A-0004PM-W9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:38:33 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kTA16-0004bT-PM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 16:38:32 -0400
Received: by mail-lf1-x143.google.com with SMTP id 184so221577lfd.6
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=dnrbhFI5mbVwMbaulvE8F+lgOMLTU9kji+w2ToSU0d4=;
 b=O+hMBC3cMTYh7YxjdobcWSD4SKjV83zNVnrF2vzbS3pnryxXKiiNZMEHNXsUHnZxoq
 IGju6RhELjv8LEhugL00e8S7FC3zkgWb0pUgmIOkAqpQp7t/G+Sr7XsUbOhu9WDD5H2b
 Kt8WILe1tLxjQFoQ8yRmfCz7LcGaE96ejN11G7F5vsmrbwNs8MJVYLizzQPh8rAuxcib
 Il9nxVfH5U3+ZcflpexefZb0OxpN9YbI0p2f7tEqi1mmKNT/M/KAtiwe8r5mSuGT/7F5
 FquDYqsHmbA71P2J7+NAliwUmZkfDoXY7npnYU/SMlNnPF5kPmkiIVbaCyQkmz86qkAy
 VLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=dnrbhFI5mbVwMbaulvE8F+lgOMLTU9kji+w2ToSU0d4=;
 b=CwuBFrFybbqrwYgn1zQA8HP+5Fv+mcd6+v6f0XV3xIvukI4olDzx+ujkhTl+H8xebJ
 95UFmJelyAdMkreB5VbrhEBFpoTZ1e7KRh9BsnC9xII0VP5fFCcyXVFxA5O/XwUCCDVo
 +wu3e1XCb6J2yDmZ8Kgf5s+MCISbs73LCZZ8TtdiAk4dT1p0xQqQb/m3B8uhXy181YaR
 nTaMq5JTLOvNT4hdImmJJx4CDEUntkgagp0wsUnFtEQD4k+gTC7zhRuoYqBRpGVLlao4
 83Af9N8Nm48z2pxWts8RSaN2CBlzYqIGgcldlxhJ5eNjd9VvAH3vbqOt8DZ0fiheSXAd
 D1tw==
X-Gm-Message-State: AOAM533IqWqZqPj7yoFzL+VpxyADe5HOeMiukbmniFk4Did/RPrbIf9f
 tG6Zi6VndKh+m2Jyci5bOl0MYNPmzbi7JEli/v0=
X-Google-Smtp-Source: ABdhPJyeSeju54aimuB+VRBFz/F/IWVcMfCEweiy7dc1VcAlixr4GS9LQrchjjZJlvmJPAdUJ8SF598DCyfeLssXwOk=
X-Received: by 2002:a19:383:: with SMTP id 125mr125225lfd.356.1602794305068;
 Thu, 15 Oct 2020 13:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201015201035.1964-1-luoyonggang@gmail.com>
 <20201015201035.1964-2-luoyonggang@gmail.com>
 <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_BtP6vgHpV8zS6U4dCgmB3npfbCOKGd1XOg9Jd0j8=nQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 16 Oct 2020 04:38:13 +0800
Message-ID: <CAE2XoE9C4r=dT0dOYKbF5tcVHxDgHEy02_3PWz-P+5d+xM+iCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] docs: Fixes build docs on msys2/mingw
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000033a58605b1bba149"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000033a58605b1bba149
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2020 at 4:30 AM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Thu, 15 Oct 2020 at 21:13, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  docs/conf.py                  |  2 +-
> >  docs/sphinx/kerneldoc.py      |  2 +-
> >  scripts/rst-sanitize.py       | 21 +++++++++++++++++++++
> >  tests/qapi-schema/meson.build |  5 +++--
> >  4 files changed, 26 insertions(+), 4 deletions(-)
> >  create mode 100644 scripts/rst-sanitize.py
> >
> > diff --git a/scripts/rst-sanitize.py b/scripts/rst-sanitize.py
> > new file mode 100644
> > index 0000000000..26060f1208
> > --- /dev/null
> > +++ b/scripts/rst-sanitize.py
> > @@ -0,0 +1,21 @@
> > +#!/usr/bin/env python3
> > +
> > +#
> > +# Script for remove cr line ending in file
> > +#
> > +# Authors:
> > +#  Yonggang Luo <luoyonggang@gmail.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2
> > +# or, at your option, any later version.  See the COPYING file in
> > +# the top-level directory.
> > +
> > +import sys
> > +
> > +def main(_program, file, *unused):
> > +    with open(file, 'rb') as content_file:
> > +        content =3D content_file.read()
> > +        sys.stdout.buffer.write(content.replace(b'\r', b''))
> > +
> > +if __name__ =3D=3D "__main__":
> > +    main(*sys.argv)
>
> Why doesn't the perl rune work? Your commit message doesn't say.


PASS 3 test-qdev-global-props /qdev/properties/dynamic/global
PASS 4 test-qdev-global-props /qdev/properties/global/subclass
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
 ../../../../../CI-Tools/msys64/usr/bin/sh.EXE
C:/work/xemu/qemu/build/../tests/decode/check.sh python3 -B
C:/work/xemu/qemu/build/../tests/../scripts/decodetree.py
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
PYTHONPATH=3DC:/work/xemu/qemu/scripts PYTHONIOENCODING=3Dutf-8
../../../../CI-Tools/msys64/mingw64/bin/python3.exe
C:/work/xemu/qemu/build/../tests/qapi-schema/test-qapi.py
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-any.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-array.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-base.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-branch-if-invalid.js=
on
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-clash.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-enum-bool.j=
son
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-enum-int.js=
on
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-string.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-bool-string=
.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-num-string.=
json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-invalid-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-nested.json
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-alternate.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-any.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-array-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-array-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-bad-boxed.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-boxed-anon.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-boxed-string.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-int.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-member-array-bad.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-member-case.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-member-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-name-clash.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-union.json
C:/work/xemu/qemu/build/../tests/qapi-schema/args-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-base.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-data.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-ident.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-if.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-if-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-if-empty-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-if-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-type-bool.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-type-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/bad-type-int.json
C:/work/xemu/qemu/build/../tests/qapi-schema/base-cycle-direct.json
C:/work/xemu/qemu/build/../tests/qapi-schema/base-cycle-indirect.json
C:/work/xemu/qemu/build/../tests/qapi-schema/command-int.json
C:/work/xemu/qemu/build/../tests/qapi-schema/comments.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-alternate-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-boxed-command-arg.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-command-arg.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-enum-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-event-arg.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-feature.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-indent.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-section.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-symbol.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-union-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-before-include.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-before-pragma.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-duplicated-arg.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-duplicated-return.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-duplicated-since.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-empty-arg.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-empty-section.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-empty-symbol.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-good.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-interleaved-section.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-end.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-end2.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-return.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-section.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-start.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-missing-colon.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-missing-expr.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-missing-space.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-missing.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-no-symbol.json
C:/work/xemu/qemu/build/../tests/qapi-schema/doc-undoc-feature.json
C:/work/xemu/qemu/build/../tests/qapi-schema/double-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/duplicate-key.json
C:/work/xemu/qemu/build/../tests/qapi-schema/empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-bad-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-bad-name.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-bad-prefix.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-clash-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-dict-member-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-if-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-int-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-member-case.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-missing-data.json
C:/work/xemu/qemu/build/../tests/qapi-schema/enum-wrong-data.json
C:/work/xemu/qemu/build/../tests/qapi-schema/event-boxed-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/event-case.json
C:/work/xemu/qemu/build/../tests/qapi-schema/event-member-invalid-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/event-nest-struct.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-bad-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-deprecated-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-duplicate-name.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-if-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-missing-name.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-name-bad-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-no-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/features-unknown-key.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-array-branch.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-bad-base.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-bad-discriminator.j=
son
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-base-any.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-base-union.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-clash-member.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-discriminator-bad-n=
ame.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-inline.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-inline-invalid-dict=
.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-int-branch.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-invalid-branch-key.=
json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-invalid-discriminat=
or.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-invalid-if-discrimi=
nator.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-no-base.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-optional-discrimina=
tor.json
C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-string-discriminato=
r.json
C:/work/xemu/qemu/build/../tests/qapi-schema/funny-char.json
C:/work/xemu/qemu/build/../tests/qapi-schema/funny-word.json
C:/work/xemu/qemu/build/../tests/qapi-schema/ident-with-escape.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-before-err.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-cycle.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-extra-junk.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-nested-err.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-no-file.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-non-file.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-repetition.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-self-cycle.json
C:/work/xemu/qemu/build/../tests/qapi-schema/include-simple.json
C:/work/xemu/qemu/build/../tests/qapi-schema/indented-expr.json
C:/work/xemu/qemu/build/../tests/qapi-schema/leading-comma-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/leading-comma-object.json
C:/work/xemu/qemu/build/../tests/qapi-schema/missing-colon.json
C:/work/xemu/qemu/build/../tests/qapi-schema/missing-comma-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/missing-comma-object.json
C:/work/xemu/qemu/build/../tests/qapi-schema/missing-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/nested-struct-data.json
C:/work/xemu/qemu/build/../tests/qapi-schema/nested-struct-data-invalid-dic=
t.json
C:/work/xemu/qemu/build/../tests/qapi-schema/non-objects.json
C:/work/xemu/qemu/build/../tests/qapi-schema/oob-coroutine.json
C:/work/xemu/qemu/build/../tests/qapi-schema/oob-test.json
C:/work/xemu/qemu/build/../tests/qapi-schema/allow-preconfig-test.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-doc-required-crap.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-extra-junk.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-name-case-whitelist-cra=
p.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-non-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-returns-whitelist-crap.=
json
C:/work/xemu/qemu/build/../tests/qapi-schema/qapi-schema-test.json
C:/work/xemu/qemu/build/../tests/qapi-schema/quoted-structural-chars.json
C:/work/xemu/qemu/build/../tests/qapi-schema/redefined-builtin.json
C:/work/xemu/qemu/build/../tests/qapi-schema/redefined-command.json
C:/work/xemu/qemu/build/../tests/qapi-schema/redefined-event.json
C:/work/xemu/qemu/build/../tests/qapi-schema/redefined-type.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-command-q.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-enum-q.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-has.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-q.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-u.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-underscore.jso=
n
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-type-kind.json
C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-type-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/returns-alternate.json
C:/work/xemu/qemu/build/../tests/qapi-schema/returns-array-bad.json
C:/work/xemu/qemu/build/../tests/qapi-schema/returns-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/returns-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/returns-whitelist.json
C:/work/xemu/qemu/build/../tests/qapi-schema/string-code-point-31.json
C:/work/xemu/qemu/build/../tests/qapi-schema/string-code-point-127.json
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-base-clash-deep.json
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-base-clash.json
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-data-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-member-if-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-member-invalid-dict.jso=
n
C:/work/xemu/qemu/build/../tests/qapi-schema/struct-member-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/trailing-comma-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/trailing-comma-object.json
C:/work/xemu/qemu/build/../tests/qapi-schema/type-bypass-bad-gen.json
C:/work/xemu/qemu/build/../tests/qapi-schema/unclosed-list.json
C:/work/xemu/qemu/build/../tests/qapi-schema/unclosed-object.json
C:/work/xemu/qemu/build/../tests/qapi-schema/unclosed-string.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-base-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-base-no-discriminator.js=
on
C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-case.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-if-invalid.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-invalid-dict.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-clash-branches.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-empty.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-invalid-base.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-optional-branch.json
C:/work/xemu/qemu/build/../tests/qapi-schema/union-unknown.json
C:/work/xemu/qemu/build/../tests/qapi-schema/unknown-escape.json
C:/work/xemu/qemu/build/../tests/qapi-schema/unknown-expr-key.json
"C:/CI-Tools/msys64/mingw64/bin/python3.exe"
"C:/work/xemu/qemu/meson/meson.py" "--internal" "exe" "--capture"
"tests/qapi-schema/doc-good.ref.nocr" "--" "perl" "-pe" "$x =3D chr 13;
s/$x$//" "../tests/qapi-schema/doc-good.txt" && if test -e
tests/qapi-schema/doc-good.ref.nocr; then printf '%s\n'
tests/qapi-schema/doc-good.ref.nocr >
tests/qapi-schema/doc-good.ref.nocr.stamp; fi
syntax error at -e line 1, near "=3D"
Execution of -e aborted due to compilation errors.
make: *** [Makefile.ninja:2572=EF=BC=9Atests/qapi-schema/doc-good.ref.nocr.=
stamp]
=E9=94=99=E8=AF=AF 255
>
> > diff --git a/tests/qapi-schema/meson.build
b/tests/qapi-schema/meson.build
> > index 1f222a7a13..20a7641af8 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -251,18 +251,19 @@ qapi_doc_out =3D custom_target('QAPI rST doc',
> >  # using an explicit '\' character in the command arguments to
> >  # a custom_target(), as Meson will unhelpfully replace it with a '/'
> >  # (https://github.com/mesonbuild/meson/issues/1564)
> > +rst_sanitize_cmd =3D [find_program('../../scripts/rst-sanitize.py'),
'@INPUT@']
> >  qapi_doc_out_nocr =3D custom_target('QAPI rST doc newline-sanitized',
> >                                    output: ['doc-good.txt.nocr'],
> >                                    input: qapi_doc_out[0],
> >                                    build_by_default: build_docs,
> > -                                  command: ['perl', '-pe', '$x =3D chr
13; s/$x$//', '@INPUT@'],
> > +                                  command: rst_sanitize_cmd,
> >                                    capture: true)
> >
> >  qapi_doc_ref_nocr =3D custom_target('QAPI rST doc reference
newline-sanitized',
> >                                    output: ['doc-good.ref.nocr'],
> >                                    input: files('doc-good.txt'),
> >                                    build_by_default: build_docs,
> > -                                  command: ['perl', '-pe', '$x =3D chr
13; s/$x$//', '@INPUT@'],
> > +                                  command: rst_sanitize_cmd,
> >                                    capture: true)
>
> thanks
> -- PMM



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000033a58605b1bba149
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Fri, Oct 16, 2020 at 4:30 AM Peter Maydell &lt;=
<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt; On Thu, 15 Oct 2020 at 21:13, Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<=
br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto=
:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&=
gt; &gt; =C2=A0docs/conf.py =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; &gt; =C2=A0docs/sphinx/kerneldoc.py =
=C2=A0 =C2=A0 =C2=A0| =C2=A02 +-<br>&gt; &gt; =C2=A0scripts/rst-sanitize.py=
 =C2=A0 =C2=A0 =C2=A0 | 21 +++++++++++++++++++++<br>&gt; &gt; =C2=A0tests/q=
api-schema/meson.build | =C2=A05 +++--<br>&gt; &gt; =C2=A04 files changed, =
26 insertions(+), 4 deletions(-)<br>&gt; &gt; =C2=A0create mode 100644 scri=
pts/rst-sanitize.py<br>&gt; &gt;<br>&gt; &gt; diff --git a/scripts/rst-sani=
tize.py b/scripts/rst-sanitize.py<br>&gt; &gt; new file mode 100644<br>&gt;=
 &gt; index 0000000000..26060f1208<br>&gt; &gt; --- /dev/null<br>&gt; &gt; =
+++ b/scripts/rst-sanitize.py<br>&gt; &gt; @@ -0,0 +1,21 @@<br>&gt; &gt; +#=
!/usr/bin/env python3<br>&gt; &gt; +<br>&gt; &gt; +#<br>&gt; &gt; +# Script=
 for remove cr line ending in file<br>&gt; &gt; +#<br>&gt; &gt; +# Authors:=
<br>&gt; &gt; +# =C2=A0Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; +#<br>&gt; &gt; +# This wo=
rk is licensed under the terms of the GNU GPL, version 2<br>&gt; &gt; +# or=
, at your option, any later version.=C2=A0 See the COPYING file in<br>&gt; =
&gt; +# the top-level directory.<br>&gt; &gt; +<br>&gt; &gt; +import sys<br=
>&gt; &gt; +<br>&gt; &gt; +def main(_program, file, *unused):<br>&gt; &gt; =
+ =C2=A0 =C2=A0with open(file, &#39;rb&#39;) as content_file:<br>&gt; &gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0content =3D content_file.read()<br>&gt; &gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.stdout.buffer.write(content.replace(b&#39;\=
r&#39;, b&#39;&#39;))<br>&gt; &gt; +<br>&gt; &gt; +if __name__ =3D=3D &quot=
;__main__&quot;:<br>&gt; &gt; + =C2=A0 =C2=A0main(*sys.argv)<br>&gt;<br>&gt=
; Why doesn&#39;t the perl rune work? Your commit message doesn&#39;t say.<=
div><br></div><div><br>PASS 3 test-qdev-global-props /qdev/properties/dynam=
ic/global<br>PASS 4 test-qdev-global-props /qdev/properties/global/subclass=
<br>MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} =C2=
=A0../../../../../CI-Tools/msys64/usr/bin/sh.EXE C:/work/xemu/qemu/build/..=
/tests/decode/check.sh python3 -B C:/work/xemu/qemu/build/../tests/../scrip=
ts/decodetree.py<br>MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} %=
 255 + 1))} PYTHONPATH=3DC:/work/xemu/qemu/scripts PYTHONIOENCODING=3Dutf-8=
 ../../../../CI-Tools/msys64/mingw64/bin/python3.exe C:/work/xemu/qemu/buil=
d/../tests/qapi-schema/test-qapi.py C:/work/xemu/qemu/build/../tests/qapi-s=
chema/alternate-any.json C:/work/xemu/qemu/build/../tests/qapi-schema/alter=
nate-array.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-base=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-branch-if-inva=
lid.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-clash.json =
C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-dict.json C=
:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-enum-bool.js=
on C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-enum-int=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-strin=
g.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflict-bool=
-string.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-conflic=
t-num-string.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-em=
pty.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-invalid-dic=
t.json C:/work/xemu/qemu/build/../tests/qapi-schema/alternate-nested.json C=
:/work/xemu/qemu/build/../tests/qapi-schema/alternate-unknown.json C:/work/=
xemu/qemu/build/../tests/qapi-schema/args-alternate.json C:/work/xemu/qemu/=
build/../tests/qapi-schema/args-any.json C:/work/xemu/qemu/build/../tests/q=
api-schema/args-array-empty.json C:/work/xemu/qemu/build/../tests/qapi-sche=
ma/args-array-unknown.json C:/work/xemu/qemu/build/../tests/qapi-schema/arg=
s-bad-boxed.json C:/work/xemu/qemu/build/../tests/qapi-schema/args-boxed-an=
on.json C:/work/xemu/qemu/build/../tests/qapi-schema/args-boxed-string.json=
 C:/work/xemu/qemu/build/../tests/qapi-schema/args-int.json C:/work/xemu/qe=
mu/build/../tests/qapi-schema/args-invalid.json C:/work/xemu/qemu/build/../=
tests/qapi-schema/args-member-array-bad.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/args-member-case.json C:/work/xemu/qemu/build/../tests/qapi-=
schema/args-member-unknown.json C:/work/xemu/qemu/build/../tests/qapi-schem=
a/args-name-clash.json C:/work/xemu/qemu/build/../tests/qapi-schema/args-un=
ion.json C:/work/xemu/qemu/build/../tests/qapi-schema/args-unknown.json C:/=
work/xemu/qemu/build/../tests/qapi-schema/bad-base.json C:/work/xemu/qemu/b=
uild/../tests/qapi-schema/bad-data.json C:/work/xemu/qemu/build/../tests/qa=
pi-schema/bad-ident.json C:/work/xemu/qemu/build/../tests/qapi-schema/bad-i=
f.json C:/work/xemu/qemu/build/../tests/qapi-schema/bad-if-empty.json C:/wo=
rk/xemu/qemu/build/../tests/qapi-schema/bad-if-empty-list.json C:/work/xemu=
/qemu/build/../tests/qapi-schema/bad-if-list.json C:/work/xemu/qemu/build/.=
./tests/qapi-schema/bad-type-bool.json C:/work/xemu/qemu/build/../tests/qap=
i-schema/bad-type-dict.json C:/work/xemu/qemu/build/../tests/qapi-schema/ba=
d-type-int.json C:/work/xemu/qemu/build/../tests/qapi-schema/base-cycle-dir=
ect.json C:/work/xemu/qemu/build/../tests/qapi-schema/base-cycle-indirect.j=
son C:/work/xemu/qemu/build/../tests/qapi-schema/command-int.json C:/work/x=
emu/qemu/build/../tests/qapi-schema/comments.json C:/work/xemu/qemu/build/.=
./tests/qapi-schema/doc-bad-alternate-member.json C:/work/xemu/qemu/build/.=
./tests/qapi-schema/doc-bad-boxed-command-arg.json C:/work/xemu/qemu/build/=
../tests/qapi-schema/doc-bad-command-arg.json C:/work/xemu/qemu/build/../te=
sts/qapi-schema/doc-bad-enum-member.json C:/work/xemu/qemu/build/../tests/q=
api-schema/doc-bad-event-arg.json C:/work/xemu/qemu/build/../tests/qapi-sch=
ema/doc-bad-feature.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-b=
ad-indent.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-section=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-bad-symbol.json C:/w=
ork/xemu/qemu/build/../tests/qapi-schema/doc-bad-union-member.json C:/work/=
xemu/qemu/build/../tests/qapi-schema/doc-before-include.json C:/work/xemu/q=
emu/build/../tests/qapi-schema/doc-before-pragma.json C:/work/xemu/qemu/bui=
ld/../tests/qapi-schema/doc-duplicated-arg.json C:/work/xemu/qemu/build/../=
tests/qapi-schema/doc-duplicated-return.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/doc-duplicated-since.json C:/work/xemu/qemu/build/../tests/q=
api-schema/doc-empty-arg.json C:/work/xemu/qemu/build/../tests/qapi-schema/=
doc-empty-section.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-emp=
ty-symbol.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-good.json C=
:/work/xemu/qemu/build/../tests/qapi-schema/doc-interleaved-section.json C:=
/work/xemu/qemu/build/../tests/qapi-schema/doc-invalid-end.json C:/work/xem=
u/qemu/build/../tests/qapi-schema/doc-invalid-end2.json C:/work/xemu/qemu/b=
uild/../tests/qapi-schema/doc-invalid-return.json C:/work/xemu/qemu/build/.=
./tests/qapi-schema/doc-invalid-section.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/doc-invalid-start.json C:/work/xemu/qemu/build/../tests/qapi=
-schema/doc-missing-colon.json C:/work/xemu/qemu/build/../tests/qapi-schema=
/doc-missing-expr.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-mis=
sing-space.json C:/work/xemu/qemu/build/../tests/qapi-schema/doc-missing.js=
on C:/work/xemu/qemu/build/../tests/qapi-schema/doc-no-symbol.json C:/work/=
xemu/qemu/build/../tests/qapi-schema/doc-undoc-feature.json C:/work/xemu/qe=
mu/build/../tests/qapi-schema/double-type.json C:/work/xemu/qemu/build/../t=
ests/qapi-schema/duplicate-key.json C:/work/xemu/qemu/build/../tests/qapi-s=
chema/empty.json C:/work/xemu/qemu/build/../tests/qapi-schema/enum-bad-memb=
er.json C:/work/xemu/qemu/build/../tests/qapi-schema/enum-bad-name.json C:/=
work/xemu/qemu/build/../tests/qapi-schema/enum-bad-prefix.json C:/work/xemu=
/qemu/build/../tests/qapi-schema/enum-clash-member.json C:/work/xemu/qemu/b=
uild/../tests/qapi-schema/enum-dict-member-unknown.json C:/work/xemu/qemu/b=
uild/../tests/qapi-schema/enum-if-invalid.json C:/work/xemu/qemu/build/../t=
ests/qapi-schema/enum-int-member.json C:/work/xemu/qemu/build/../tests/qapi=
-schema/enum-member-case.json C:/work/xemu/qemu/build/../tests/qapi-schema/=
enum-missing-data.json C:/work/xemu/qemu/build/../tests/qapi-schema/enum-wr=
ong-data.json C:/work/xemu/qemu/build/../tests/qapi-schema/event-boxed-empt=
y.json C:/work/xemu/qemu/build/../tests/qapi-schema/event-case.json C:/work=
/xemu/qemu/build/../tests/qapi-schema/event-member-invalid-dict.json C:/wor=
k/xemu/qemu/build/../tests/qapi-schema/event-nest-struct.json C:/work/xemu/=
qemu/build/../tests/qapi-schema/features-bad-type.json C:/work/xemu/qemu/bu=
ild/../tests/qapi-schema/features-deprecated-type.json C:/work/xemu/qemu/bu=
ild/../tests/qapi-schema/features-duplicate-name.json C:/work/xemu/qemu/bui=
ld/../tests/qapi-schema/features-if-invalid.json C:/work/xemu/qemu/build/..=
/tests/qapi-schema/features-missing-name.json C:/work/xemu/qemu/build/../te=
sts/qapi-schema/features-name-bad-type.json C:/work/xemu/qemu/build/../test=
s/qapi-schema/features-no-list.json C:/work/xemu/qemu/build/../tests/qapi-s=
chema/features-unknown-key.json C:/work/xemu/qemu/build/../tests/qapi-schem=
a/flat-union-array-branch.json C:/work/xemu/qemu/build/../tests/qapi-schema=
/flat-union-bad-base.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat=
-union-bad-discriminator.json C:/work/xemu/qemu/build/../tests/qapi-schema/=
flat-union-base-any.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-=
union-base-union.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-uni=
on-clash-member.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-unio=
n-discriminator-bad-name.json C:/work/xemu/qemu/build/../tests/qapi-schema/=
flat-union-empty.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-uni=
on-inline.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-inli=
ne-invalid-dict.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-unio=
n-int-branch.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-union-i=
nvalid-branch-key.json C:/work/xemu/qemu/build/../tests/qapi-schema/flat-un=
ion-invalid-discriminator.json C:/work/xemu/qemu/build/../tests/qapi-schema=
/flat-union-invalid-if-discriminator.json C:/work/xemu/qemu/build/../tests/=
qapi-schema/flat-union-no-base.json C:/work/xemu/qemu/build/../tests/qapi-s=
chema/flat-union-optional-discriminator.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/flat-union-string-discriminator.json C:/work/xemu/qemu/build=
/../tests/qapi-schema/funny-char.json C:/work/xemu/qemu/build/../tests/qapi=
-schema/funny-word.json C:/work/xemu/qemu/build/../tests/qapi-schema/ident-=
with-escape.json C:/work/xemu/qemu/build/../tests/qapi-schema/include-befor=
e-err.json C:/work/xemu/qemu/build/../tests/qapi-schema/include-cycle.json =
C:/work/xemu/qemu/build/../tests/qapi-schema/include-extra-junk.json C:/wor=
k/xemu/qemu/build/../tests/qapi-schema/include-nested-err.json C:/work/xemu=
/qemu/build/../tests/qapi-schema/include-no-file.json C:/work/xemu/qemu/bui=
ld/../tests/qapi-schema/include-non-file.json C:/work/xemu/qemu/build/../te=
sts/qapi-schema/include-repetition.json C:/work/xemu/qemu/build/../tests/qa=
pi-schema/include-self-cycle.json C:/work/xemu/qemu/build/../tests/qapi-sch=
ema/include-simple.json C:/work/xemu/qemu/build/../tests/qapi-schema/indent=
ed-expr.json C:/work/xemu/qemu/build/../tests/qapi-schema/leading-comma-lis=
t.json C:/work/xemu/qemu/build/../tests/qapi-schema/leading-comma-object.js=
on C:/work/xemu/qemu/build/../tests/qapi-schema/missing-colon.json C:/work/=
xemu/qemu/build/../tests/qapi-schema/missing-comma-list.json C:/work/xemu/q=
emu/build/../tests/qapi-schema/missing-comma-object.json C:/work/xemu/qemu/=
build/../tests/qapi-schema/missing-type.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/nested-struct-data.json C:/work/xemu/qemu/build/../tests/qap=
i-schema/nested-struct-data-invalid-dict.json C:/work/xemu/qemu/build/../te=
sts/qapi-schema/non-objects.json C:/work/xemu/qemu/build/../tests/qapi-sche=
ma/oob-coroutine.json C:/work/xemu/qemu/build/../tests/qapi-schema/oob-test=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/allow-preconfig-test.jso=
n C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-doc-required-crap.jso=
n C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-extra-junk.json C:/wo=
rk/xemu/qemu/build/../tests/qapi-schema/pragma-name-case-whitelist-crap.jso=
n C:/work/xemu/qemu/build/../tests/qapi-schema/pragma-non-dict.json C:/work=
/xemu/qemu/build/../tests/qapi-schema/pragma-unknown.json C:/work/xemu/qemu=
/build/../tests/qapi-schema/pragma-returns-whitelist-crap.json C:/work/xemu=
/qemu/build/../tests/qapi-schema/qapi-schema-test.json C:/work/xemu/qemu/bu=
ild/../tests/qapi-schema/quoted-structural-chars.json C:/work/xemu/qemu/bui=
ld/../tests/qapi-schema/redefined-builtin.json C:/work/xemu/qemu/build/../t=
ests/qapi-schema/redefined-command.json C:/work/xemu/qemu/build/../tests/qa=
pi-schema/redefined-event.json C:/work/xemu/qemu/build/../tests/qapi-schema=
/redefined-type.json C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-=
command-q.json C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-enum-q=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-has.json=
 C:/work/xemu/qemu/build/../tests/qapi-schema/reserved-member-q.json C:/wor=
k/xemu/qemu/build/../tests/qapi-schema/reserved-member-u.json C:/work/xemu/=
qemu/build/../tests/qapi-schema/reserved-member-underscore.json C:/work/xem=
u/qemu/build/../tests/qapi-schema/reserved-type-kind.json C:/work/xemu/qemu=
/build/../tests/qapi-schema/reserved-type-list.json C:/work/xemu/qemu/build=
/../tests/qapi-schema/returns-alternate.json C:/work/xemu/qemu/build/../tes=
ts/qapi-schema/returns-array-bad.json C:/work/xemu/qemu/build/../tests/qapi=
-schema/returns-dict.json C:/work/xemu/qemu/build/../tests/qapi-schema/retu=
rns-unknown.json C:/work/xemu/qemu/build/../tests/qapi-schema/returns-white=
list.json C:/work/xemu/qemu/build/../tests/qapi-schema/string-code-point-31=
.json C:/work/xemu/qemu/build/../tests/qapi-schema/string-code-point-127.js=
on C:/work/xemu/qemu/build/../tests/qapi-schema/struct-base-clash-deep.json=
 C:/work/xemu/qemu/build/../tests/qapi-schema/struct-base-clash.json C:/wor=
k/xemu/qemu/build/../tests/qapi-schema/struct-data-invalid.json C:/work/xem=
u/qemu/build/../tests/qapi-schema/struct-member-if-invalid.json C:/work/xem=
u/qemu/build/../tests/qapi-schema/struct-member-invalid-dict.json C:/work/x=
emu/qemu/build/../tests/qapi-schema/struct-member-invalid.json C:/work/xemu=
/qemu/build/../tests/qapi-schema/trailing-comma-list.json C:/work/xemu/qemu=
/build/../tests/qapi-schema/trailing-comma-object.json C:/work/xemu/qemu/bu=
ild/../tests/qapi-schema/type-bypass-bad-gen.json C:/work/xemu/qemu/build/.=
./tests/qapi-schema/unclosed-list.json C:/work/xemu/qemu/build/../tests/qap=
i-schema/unclosed-object.json C:/work/xemu/qemu/build/../tests/qapi-schema/=
unclosed-string.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-bas=
e-empty.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-base-no-dis=
criminator.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-c=
ase.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-if-inval=
id.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-branch-invalid-d=
ict.json C:/work/xemu/qemu/build/../tests/qapi-schema/union-clash-branches.=
json C:/work/xemu/qemu/build/../tests/qapi-schema/union-empty.json C:/work/=
xemu/qemu/build/../tests/qapi-schema/union-invalid-base.json C:/work/xemu/q=
emu/build/../tests/qapi-schema/union-optional-branch.json C:/work/xemu/qemu=
/build/../tests/qapi-schema/union-unknown.json C:/work/xemu/qemu/build/../t=
ests/qapi-schema/unknown-escape.json C:/work/xemu/qemu/build/../tests/qapi-=
schema/unknown-expr-key.json<br>&quot;C:/CI-Tools/msys64/mingw64/bin/python=
3.exe&quot; &quot;C:/work/xemu/qemu/meson/meson.py&quot; &quot;--internal&q=
uot; &quot;exe&quot; &quot;--capture&quot; &quot;tests/qapi-schema/doc-good=
.ref.nocr&quot; &quot;--&quot; &quot;perl&quot; &quot;-pe&quot; &quot;$x =
=3D chr 13; s/$x$//&quot; &quot;../tests/qapi-schema/doc-good.txt&quot; &am=
p;&amp; if test -e tests/qapi-schema/doc-good.ref.nocr; then printf &#39;%s=
\n&#39; tests/qapi-schema/doc-good.ref.nocr &gt; tests/qapi-schema/doc-good=
.ref.nocr.stamp; fi<br>syntax error at -e line 1, near &quot;=3D&quot;<br>E=
xecution of -e aborted due to compilation errors.<br>make: *** [Makefile.ni=
nja:2572=EF=BC=9Atests/qapi-schema/doc-good.ref.nocr.stamp] =E9=94=99=E8=AF=
=AF 255<br>&gt;<br>&gt; &gt; diff --git a/tests/qapi-schema/meson.build b/t=
ests/qapi-schema/meson.build<br>&gt; &gt; index 1f222a7a13..20a7641af8 1006=
44<br>&gt; &gt; --- a/tests/qapi-schema/meson.build<br>&gt; &gt; +++ b/test=
s/qapi-schema/meson.build<br>&gt; &gt; @@ -251,18 +251,19 @@ qapi_doc_out =
=3D custom_target(&#39;QAPI rST doc&#39;,<br>&gt; &gt; =C2=A0# using an exp=
licit &#39;\&#39; character in the command arguments to<br>&gt; &gt; =C2=A0=
# a custom_target(), as Meson will unhelpfully replace it with a &#39;/&#39=
;<br>&gt; &gt; =C2=A0# (<a href=3D"https://github.com/mesonbuild/meson/issu=
es/1564">https://github.com/mesonbuild/meson/issues/1564</a>)<br>&gt; &gt; =
+rst_sanitize_cmd =3D [find_program(&#39;../../scripts/rst-sanitize.py&#39;=
), &#39;@INPUT@&#39;]<br>&gt; &gt; =C2=A0qapi_doc_out_nocr =3D custom_targe=
t(&#39;QAPI rST doc newline-sanitized&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output: [&#39;doc-good.txt.nocr&#39;],<br=
>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: qapi_d=
oc_out[0],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0build_by_default: build_docs,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0command: [&#39;perl&#39;, &#39;-pe&#39;, &#39;$x =3D chr 1=
3; s/$x$//&#39;, &#39;@INPUT@&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0command: rst_sanitize_cmd,<br>&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true)<br>&gt; &gt;<br>&gt=
; &gt; =C2=A0qapi_doc_ref_nocr =3D custom_target(&#39;QAPI rST doc referenc=
e newline-sanitized&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0output: [&#39;doc-good.ref.nocr&#39;],<br>&gt; &gt; =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input: files(&#39;doc-good.txt=
&#39;),<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bu=
ild_by_default: build_docs,<br>&gt; &gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0command: [&#39;perl&#39;, &#39;-pe&#39;, &#39;$x =3D chr 13; s=
/$x$//&#39;, &#39;@INPUT@&#39;],<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0command: rst_sanitize_cmd,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0capture: true)<br>&gt;<br>&gt; thanks<br>=
&gt; -- PMM<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000033a58605b1bba149--

