Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45908C2BB84
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEA920716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwaRx0TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCEA920716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkE5-0000A8-0D
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDkCR-0006l1-0O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:02:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDkCN-0005vi-5J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599120141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xbyp+deDEedOtbxOED9Zw6DHWuKccePUvn4rtwEhYyc=;
 b=FwaRx0TVYJqslwkCRixSt2DS1OWPcH8qvhyUbcyWt54qvQEyZzXnrpPNTv3j9ykLVy6LyP
 VHxzjJFKApEczjybKR3Gh7p7o4y2eolZv1LVGLfaynlvGuo/VtIprFqNohGBto0EJ2SqLL
 RVww2HD0UMAl5wzmUPF0y/DzSCCzEhQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-DpWDY_H-MOiEnh47qtj5Ew-1; Thu, 03 Sep 2020 04:02:17 -0400
X-MC-Unique: DpWDY_H-MOiEnh47qtj5Ew-1
Received: by mail-ej1-f70.google.com with SMTP id f17so871958ejq.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xbyp+deDEedOtbxOED9Zw6DHWuKccePUvn4rtwEhYyc=;
 b=iytdP2p3e1bN0dnhuu3X4//Cd1UDXU65Qt2xzZcQCq34Sr8k1I5bYk6F5PWyquobYY
 JI+BQmx89cMXlGdvwDwjWvj8kylIMX4hlYigWYOulGIII0P1TzWUWgtBBHMHNnRHkKys
 IVLaxXbbNv3mDD/M1iPZKfr+bYwNsy7Lj+WjmpZKCjngcfpVEy4i0lHUb79u/Lr+k8kD
 JI3NZVYr+py+GxrQ4M8cu4Z+PJk5GMSaxrfXIdDWtNZxMgIrx+YQ1iok62gFfOMgR5N2
 cPOpzmexv+vkH7XBbdmLGKtCdhoiK5JmMHiYnupO0Xf5gzvrobeiz1DPO6BjZPiyVxBD
 HG9Q==
X-Gm-Message-State: AOAM531yX7ib1hDelYiEjV+hrKmo9Eu7uOcHkCoQC8gLrrbJhkLAi/fE
 l1ka5z8H9rgY2jFedrP3IE+ZE+2CHuleCyZ9XZPANI4UoprJIk893B0EQ9bPANwLpmQltBjaLf3
 PI3PvuC1wfIGtt455knyg8KOsajZqIfc=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr840024ejb.121.1599120135756; 
 Thu, 03 Sep 2020 01:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjryKxjTzi9nOkhTkXro7iUcrK3ehkbELY6UxYazKBYC7f7z23Z3IAMeehfBwxPd5xFNbxIB6FH/guBtZHObA=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr839996ejb.121.1599120135424; 
 Thu, 03 Sep 2020 01:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200903074313.1498-1-luoyonggang@gmail.com>
 <20200903074313.1498-11-luoyonggang@gmail.com>
In-Reply-To: <20200903074313.1498-11-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 10:02:04 +0200
Message-ID: <CABgObfa8ZSKY8cenrZiwKaEBbzP12tzf+XM=xAynE_EpM4ZLKQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] meson: Fixes qapi tests.
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a0227705ae642b14"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a0227705ae642b14
Content-Type: text/plain; charset="UTF-8"

Your patch is rewriting the whole file, I think there's a git option to fix
the line endings on commit.

Also the commit message should describe why it's failing. I can see you
added --strip-trailing-cr, but still it should be mentioned.

Paolo

Il gio 3 set 2020, 09:44 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> The error are:
> +@end table
> +
> +@end deftypefn
> +
> make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qapi-schema/meson.build | 451 +++++++++++++++++-----------------
>  1 file changed, 226 insertions(+), 225 deletions(-)
>
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
> index c87d141417..67ba0a5ebd 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -1,225 +1,226 @@
> -test_env = environment()
> -test_env.set('PYTHONPATH', meson.source_root() / 'scripts')
> -test_env.set('PYTHONIOENCODING', 'utf-8')
> -
> -schemas = [
> -  'alternate-any.json',
> -  'alternate-array.json',
> -  'alternate-base.json',
> -  'alternate-branch-if-invalid.json',
> -  'alternate-clash.json',
> -  'alternate-conflict-dict.json',
> -  'alternate-conflict-enum-bool.json',
> -  'alternate-conflict-enum-int.json',
> -  'alternate-conflict-string.json',
> -  'alternate-conflict-bool-string.json',
> -  'alternate-conflict-num-string.json',
> -  'alternate-empty.json',
> -  'alternate-invalid-dict.json',
> -  'alternate-nested.json',
> -  'alternate-unknown.json',
> -  'args-alternate.json',
> -  'args-any.json',
> -  'args-array-empty.json',
> -  'args-array-unknown.json',
> -  'args-bad-boxed.json',
> -  'args-boxed-anon.json',
> -  'args-boxed-string.json',
> -  'args-int.json',
> -  'args-invalid.json',
> -  'args-member-array-bad.json',
> -  'args-member-case.json',
> -  'args-member-unknown.json',
> -  'args-name-clash.json',
> -  'args-union.json',
> -  'args-unknown.json',
> -  'bad-base.json',
> -  'bad-data.json',
> -  'bad-ident.json',
> -  'bad-if.json',
> -  'bad-if-empty.json',
> -  'bad-if-empty-list.json',
> -  'bad-if-list.json',
> -  'bad-type-bool.json',
> -  'bad-type-dict.json',
> -  'bad-type-int.json',
> -  'base-cycle-direct.json',
> -  'base-cycle-indirect.json',
> -  'command-int.json',
> -  'comments.json',
> -  'doc-bad-alternate-member.json',
> -  'doc-bad-boxed-command-arg.json',
> -  'doc-bad-command-arg.json',
> -  'doc-bad-enum-member.json',
> -  'doc-bad-event-arg.json',
> -  'doc-bad-feature.json',
> -  'doc-bad-section.json',
> -  'doc-bad-symbol.json',
> -  'doc-bad-union-member.json',
> -  'doc-before-include.json',
> -  'doc-before-pragma.json',
> -  'doc-duplicated-arg.json',
> -  'doc-duplicated-return.json',
> -  'doc-duplicated-since.json',
> -  'doc-empty-arg.json',
> -  'doc-empty-section.json',
> -  'doc-empty-symbol.json',
> -  'doc-good.json',
> -  'doc-interleaved-section.json',
> -  'doc-invalid-end.json',
> -  'doc-invalid-end2.json',
> -  'doc-invalid-return.json',
> -  'doc-invalid-section.json',
> -  'doc-invalid-start.json',
> -  'doc-missing-colon.json',
> -  'doc-missing-expr.json',
> -  'doc-missing-space.json',
> -  'doc-missing.json',
> -  'doc-no-symbol.json',
> -  'doc-undoc-feature.json',
> -  'double-type.json',
> -  'duplicate-key.json',
> -  'empty.json',
> -  'enum-bad-member.json',
> -  'enum-bad-name.json',
> -  'enum-bad-prefix.json',
> -  'enum-clash-member.json',
> -  'enum-dict-member-unknown.json',
> -  'enum-if-invalid.json',
> -  'enum-int-member.json',
> -  'enum-member-case.json',
> -  'enum-missing-data.json',
> -  'enum-wrong-data.json',
> -  'event-boxed-empty.json',
> -  'event-case.json',
> -  'event-member-invalid-dict.json',
> -  'event-nest-struct.json',
> -  'features-bad-type.json',
> -  'features-deprecated-type.json',
> -  'features-duplicate-name.json',
> -  'features-if-invalid.json',
> -  'features-missing-name.json',
> -  'features-name-bad-type.json',
> -  'features-no-list.json',
> -  'features-unknown-key.json',
> -  'flat-union-array-branch.json',
> -  'flat-union-bad-base.json',
> -  'flat-union-bad-discriminator.json',
> -  'flat-union-base-any.json',
> -  'flat-union-base-union.json',
> -  'flat-union-clash-member.json',
> -  'flat-union-discriminator-bad-name.json',
> -  'flat-union-empty.json',
> -  'flat-union-inline.json',
> -  'flat-union-inline-invalid-dict.json',
> -  'flat-union-int-branch.json',
> -  'flat-union-invalid-branch-key.json',
> -  'flat-union-invalid-discriminator.json',
> -  'flat-union-invalid-if-discriminator.json',
> -  'flat-union-no-base.json',
> -  'flat-union-optional-discriminator.json',
> -  'flat-union-string-discriminator.json',
> -  'funny-char.json',
> -  'funny-word.json',
> -  'ident-with-escape.json',
> -  'include-before-err.json',
> -  'include-cycle.json',
> -  'include-extra-junk.json',
> -  'include-nested-err.json',
> -  'include-no-file.json',
> -  'include-non-file.json',
> -  'include-repetition.json',
> -  'include-self-cycle.json',
> -  'include-simple.json',
> -  'indented-expr.json',
> -  'leading-comma-list.json',
> -  'leading-comma-object.json',
> -  'missing-colon.json',
> -  'missing-comma-list.json',
> -  'missing-comma-object.json',
> -  'missing-type.json',
> -  'nested-struct-data.json',
> -  'nested-struct-data-invalid-dict.json',
> -  'non-objects.json',
> -  'oob-test.json',
> -  'allow-preconfig-test.json',
> -  'pragma-doc-required-crap.json',
> -  'pragma-extra-junk.json',
> -  'pragma-name-case-whitelist-crap.json',
> -  'pragma-non-dict.json',
> -  'pragma-unknown.json',
> -  'pragma-returns-whitelist-crap.json',
> -  'qapi-schema-test.json',
> -  'quoted-structural-chars.json',
> -  'redefined-builtin.json',
> -  'redefined-command.json',
> -  'redefined-event.json',
> -  'redefined-type.json',
> -  'reserved-command-q.json',
> -  'reserved-enum-q.json',
> -  'reserved-member-has.json',
> -  'reserved-member-q.json',
> -  'reserved-member-u.json',
> -  'reserved-member-underscore.json',
> -  'reserved-type-kind.json',
> -  'reserved-type-list.json',
> -  'returns-alternate.json',
> -  'returns-array-bad.json',
> -  'returns-dict.json',
> -  'returns-unknown.json',
> -  'returns-whitelist.json',
> -  'string-code-point-31.json',
> -  'string-code-point-127.json',
> -  'struct-base-clash-deep.json',
> -  'struct-base-clash.json',
> -  'struct-data-invalid.json',
> -  'struct-member-if-invalid.json',
> -  'struct-member-invalid-dict.json',
> -  'struct-member-invalid.json',
> -  'trailing-comma-list.json',
> -  'trailing-comma-object.json',
> -  'type-bypass-bad-gen.json',
> -  'unclosed-list.json',
> -  'unclosed-object.json',
> -  'unclosed-string.json',
> -  'union-base-empty.json',
> -  'union-base-no-discriminator.json',
> -  'union-branch-case.json',
> -  'union-branch-if-invalid.json',
> -  'union-branch-invalid-dict.json',
> -  'union-clash-branches.json',
> -  'union-empty.json',
> -  'union-invalid-base.json',
> -  'union-optional-branch.json',
> -  'union-unknown.json',
> -  'unknown-escape.json',
> -  'unknown-expr-key.json',
> -]
> -
> -# Because people may want to use test-qapi.py from the command line, we
> -# are not using the "#! /usr/bin/env python3" trick here.  See
> -# docs/devel/build-system.txt
> -test('QAPI schema regression tests', python, args: files('test-qapi.py',
> schemas),
> -     env: test_env, suite: ['qapi-schema', 'qapi-frontend'])
> -
> -diff = find_program('diff')
> -
> -qapi_doc = custom_target('QAPI doc',
> -                         output: ['doc-good-qapi-doc.texi',
> -                                  'doc-good-qapi-commands.c',
> 'doc-good-qapi-commands.h',
> -                                  'doc-good-qapi-emit-events.c',
> 'doc-good-qapi-emit-events.h',
> -                                  'doc-good-qapi-events.c',
> 'doc-good-qapi-events.h',
> -                                  'doc-good-qapi-init-commands.c',
> 'doc-good-qapi-init-commands.h',
> -                                  'doc-good-qapi-introspect.c',
> 'doc-good-qapi-introspect.h',
> -                                  'doc-good-qapi-types.c',
> 'doc-good-qapi-types.h',
> -                                  'doc-good-qapi-visit.c',
> 'doc-good-qapi-visit.h' ],
> -                         input: files('doc-good.json'),
> -                         command: [ qapi_gen, '-o',
> meson.current_build_dir(),
> -                                    '-p', 'doc-good-', '@INPUT0@' ],
> -                         depend_files: qapi_gen_depends)
> -
> -# "full_path()" needed here to work around
> -# https://github.com/mesonbuild/meson/issues/7585
> -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> -     depends: qapi_doc,
> -     suite: ['qapi-schema', 'qapi-doc'])
> +test_env = environment()
> +test_env.set('PYTHONPATH', meson.source_root() / 'scripts')
> +test_env.set('PYTHONIOENCODING', 'utf-8')
> +
> +schemas = [
> +  'alternate-any.json',
> +  'alternate-array.json',
> +  'alternate-base.json',
> +  'alternate-branch-if-invalid.json',
> +  'alternate-clash.json',
> +  'alternate-conflict-dict.json',
> +  'alternate-conflict-enum-bool.json',
> +  'alternate-conflict-enum-int.json',
> +  'alternate-conflict-string.json',
> +  'alternate-conflict-bool-string.json',
> +  'alternate-conflict-num-string.json',
> +  'alternate-empty.json',
> +  'alternate-invalid-dict.json',
> +  'alternate-nested.json',
> +  'alternate-unknown.json',
> +  'args-alternate.json',
> +  'args-any.json',
> +  'args-array-empty.json',
> +  'args-array-unknown.json',
> +  'args-bad-boxed.json',
> +  'args-boxed-anon.json',
> +  'args-boxed-string.json',
> +  'args-int.json',
> +  'args-invalid.json',
> +  'args-member-array-bad.json',
> +  'args-member-case.json',
> +  'args-member-unknown.json',
> +  'args-name-clash.json',
> +  'args-union.json',
> +  'args-unknown.json',
> +  'bad-base.json',
> +  'bad-data.json',
> +  'bad-ident.json',
> +  'bad-if.json',
> +  'bad-if-empty.json',
> +  'bad-if-empty-list.json',
> +  'bad-if-list.json',
> +  'bad-type-bool.json',
> +  'bad-type-dict.json',
> +  'bad-type-int.json',
> +  'base-cycle-direct.json',
> +  'base-cycle-indirect.json',
> +  'command-int.json',
> +  'comments.json',
> +  'doc-bad-alternate-member.json',
> +  'doc-bad-boxed-command-arg.json',
> +  'doc-bad-command-arg.json',
> +  'doc-bad-enum-member.json',
> +  'doc-bad-event-arg.json',
> +  'doc-bad-feature.json',
> +  'doc-bad-section.json',
> +  'doc-bad-symbol.json',
> +  'doc-bad-union-member.json',
> +  'doc-before-include.json',
> +  'doc-before-pragma.json',
> +  'doc-duplicated-arg.json',
> +  'doc-duplicated-return.json',
> +  'doc-duplicated-since.json',
> +  'doc-empty-arg.json',
> +  'doc-empty-section.json',
> +  'doc-empty-symbol.json',
> +  'doc-good.json',
> +  'doc-interleaved-section.json',
> +  'doc-invalid-end.json',
> +  'doc-invalid-end2.json',
> +  'doc-invalid-return.json',
> +  'doc-invalid-section.json',
> +  'doc-invalid-start.json',
> +  'doc-missing-colon.json',
> +  'doc-missing-expr.json',
> +  'doc-missing-space.json',
> +  'doc-missing.json',
> +  'doc-no-symbol.json',
> +  'doc-undoc-feature.json',
> +  'double-type.json',
> +  'duplicate-key.json',
> +  'empty.json',
> +  'enum-bad-member.json',
> +  'enum-bad-name.json',
> +  'enum-bad-prefix.json',
> +  'enum-clash-member.json',
> +  'enum-dict-member-unknown.json',
> +  'enum-if-invalid.json',
> +  'enum-int-member.json',
> +  'enum-member-case.json',
> +  'enum-missing-data.json',
> +  'enum-wrong-data.json',
> +  'event-boxed-empty.json',
> +  'event-case.json',
> +  'event-member-invalid-dict.json',
> +  'event-nest-struct.json',
> +  'features-bad-type.json',
> +  'features-deprecated-type.json',
> +  'features-duplicate-name.json',
> +  'features-if-invalid.json',
> +  'features-missing-name.json',
> +  'features-name-bad-type.json',
> +  'features-no-list.json',
> +  'features-unknown-key.json',
> +  'flat-union-array-branch.json',
> +  'flat-union-bad-base.json',
> +  'flat-union-bad-discriminator.json',
> +  'flat-union-base-any.json',
> +  'flat-union-base-union.json',
> +  'flat-union-clash-member.json',
> +  'flat-union-discriminator-bad-name.json',
> +  'flat-union-empty.json',
> +  'flat-union-inline.json',
> +  'flat-union-inline-invalid-dict.json',
> +  'flat-union-int-branch.json',
> +  'flat-union-invalid-branch-key.json',
> +  'flat-union-invalid-discriminator.json',
> +  'flat-union-invalid-if-discriminator.json',
> +  'flat-union-no-base.json',
> +  'flat-union-optional-discriminator.json',
> +  'flat-union-string-discriminator.json',
> +  'funny-char.json',
> +  'funny-word.json',
> +  'ident-with-escape.json',
> +  'include-before-err.json',
> +  'include-cycle.json',
> +  'include-extra-junk.json',
> +  'include-nested-err.json',
> +  'include-no-file.json',
> +  'include-non-file.json',
> +  'include-repetition.json',
> +  'include-self-cycle.json',
> +  'include-simple.json',
> +  'indented-expr.json',
> +  'leading-comma-list.json',
> +  'leading-comma-object.json',
> +  'missing-colon.json',
> +  'missing-comma-list.json',
> +  'missing-comma-object.json',
> +  'missing-type.json',
> +  'nested-struct-data.json',
> +  'nested-struct-data-invalid-dict.json',
> +  'non-objects.json',
> +  'oob-test.json',
> +  'allow-preconfig-test.json',
> +  'pragma-doc-required-crap.json',
> +  'pragma-extra-junk.json',
> +  'pragma-name-case-whitelist-crap.json',
> +  'pragma-non-dict.json',
> +  'pragma-unknown.json',
> +  'pragma-returns-whitelist-crap.json',
> +  'qapi-schema-test.json',
> +  'quoted-structural-chars.json',
> +  'redefined-builtin.json',
> +  'redefined-command.json',
> +  'redefined-event.json',
> +  'redefined-type.json',
> +  'reserved-command-q.json',
> +  'reserved-enum-q.json',
> +  'reserved-member-has.json',
> +  'reserved-member-q.json',
> +  'reserved-member-u.json',
> +  'reserved-member-underscore.json',
> +  'reserved-type-kind.json',
> +  'reserved-type-list.json',
> +  'returns-alternate.json',
> +  'returns-array-bad.json',
> +  'returns-dict.json',
> +  'returns-unknown.json',
> +  'returns-whitelist.json',
> +  'string-code-point-31.json',
> +  'string-code-point-127.json',
> +  'struct-base-clash-deep.json',
> +  'struct-base-clash.json',
> +  'struct-data-invalid.json',
> +  'struct-member-if-invalid.json',
> +  'struct-member-invalid-dict.json',
> +  'struct-member-invalid.json',
> +  'trailing-comma-list.json',
> +  'trailing-comma-object.json',
> +  'type-bypass-bad-gen.json',
> +  'unclosed-list.json',
> +  'unclosed-object.json',
> +  'unclosed-string.json',
> +  'union-base-empty.json',
> +  'union-base-no-discriminator.json',
> +  'union-branch-case.json',
> +  'union-branch-if-invalid.json',
> +  'union-branch-invalid-dict.json',
> +  'union-clash-branches.json',
> +  'union-empty.json',
> +  'union-invalid-base.json',
> +  'union-optional-branch.json',
> +  'union-unknown.json',
> +  'unknown-escape.json',
> +  'unknown-expr-key.json',
> +]
> +
> +# Because people may want to use test-qapi.py from the command line, we
> +# are not using the "#! /usr/bin/env python3" trick here.  See
> +# docs/devel/build-system.txt
> +test('QAPI schema regression tests', python, args: files('test-qapi.py',
> schemas),
> +     env: test_env, suite: ['qapi-schema', 'qapi-frontend'])
> +
> +diff = find_program('diff')
> +
> +qapi_doc = custom_target('QAPI doc',
> +                         output: ['doc-good-qapi-doc.texi',
> +                                  'doc-good-qapi-commands.c',
> 'doc-good-qapi-commands.h',
> +                                  'doc-good-qapi-emit-events.c',
> 'doc-good-qapi-emit-events.h',
> +                                  'doc-good-qapi-events.c',
> 'doc-good-qapi-events.h',
> +                                  'doc-good-qapi-init-commands.c',
> 'doc-good-qapi-init-commands.h',
> +                                  'doc-good-qapi-introspect.c',
> 'doc-good-qapi-introspect.h',
> +                                  'doc-good-qapi-types.c',
> 'doc-good-qapi-types.h',
> +                                  'doc-good-qapi-visit.c',
> 'doc-good-qapi-visit.h' ],
> +                         input: files('doc-good.json'),
> +                         command: [ qapi_gen, '-o',
> meson.current_build_dir(),
> +                                    '-p', 'doc-good-', '@INPUT0@' ],
> +                         depend_files: qapi_gen_depends)
> +
> +# "full_path()" needed here to work around
> +# https://github.com/mesonbuild/meson/issues/7585
> +test('QAPI doc', diff, args: ['--strip-trailing-cr',
> +                              '-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> +     depends: qapi_doc,
> +     suite: ['qapi-schema', 'qapi-doc'])
> --
> 2.28.0.windows.1
>
>

--000000000000a0227705ae642b14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Your patch is rewriting the whole file, I think ther=
e&#39;s a git option to fix the line endings on commit.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Also the commit message should describe why=
 it&#39;s failing. I can see you added --strip-trailing-cr, but still it sh=
ould be mentioned.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"g=
mail_attr">Il gio 3 set 2020, 09:44 Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">The error are:<br>
+@end table<br>
+<br>
+@end deftypefn<br>
+<br>
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/qapi-schema/meson.build | 451 +++++++++++++++++----------------=
-<br>
=C2=A01 file changed, 226 insertions(+), 225 deletions(-)<br>
<br>
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build<=
br>
index c87d141417..67ba0a5ebd 100644<br>
--- a/tests/qapi-schema/meson.build<br>
+++ b/tests/qapi-schema/meson.build<br>
@@ -1,225 +1,226 @@<br>
-test_env =3D environment()<br>
-test_env.set(&#39;PYTHONPATH&#39;, meson.source_root() / &#39;scripts&#39;=
)<br>
-test_env.set(&#39;PYTHONIOENCODING&#39;, &#39;utf-8&#39;)<br>
-<br>
-schemas =3D [<br>
-=C2=A0 &#39;alternate-any.json&#39;,<br>
-=C2=A0 &#39;alternate-array.json&#39;,<br>
-=C2=A0 &#39;alternate-base.json&#39;,<br>
-=C2=A0 &#39;alternate-branch-if-invalid.json&#39;,<br>
-=C2=A0 &#39;alternate-clash.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-dict.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-enum-bool.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-enum-int.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-string.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-bool-string.json&#39;,<br>
-=C2=A0 &#39;alternate-conflict-num-string.json&#39;,<br>
-=C2=A0 &#39;alternate-empty.json&#39;,<br>
-=C2=A0 &#39;alternate-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;alternate-nested.json&#39;,<br>
-=C2=A0 &#39;alternate-unknown.json&#39;,<br>
-=C2=A0 &#39;args-alternate.json&#39;,<br>
-=C2=A0 &#39;args-any.json&#39;,<br>
-=C2=A0 &#39;args-array-empty.json&#39;,<br>
-=C2=A0 &#39;args-array-unknown.json&#39;,<br>
-=C2=A0 &#39;args-bad-boxed.json&#39;,<br>
-=C2=A0 &#39;args-boxed-anon.json&#39;,<br>
-=C2=A0 &#39;args-boxed-string.json&#39;,<br>
-=C2=A0 &#39;args-int.json&#39;,<br>
-=C2=A0 &#39;args-invalid.json&#39;,<br>
-=C2=A0 &#39;args-member-array-bad.json&#39;,<br>
-=C2=A0 &#39;args-member-case.json&#39;,<br>
-=C2=A0 &#39;args-member-unknown.json&#39;,<br>
-=C2=A0 &#39;args-name-clash.json&#39;,<br>
-=C2=A0 &#39;args-union.json&#39;,<br>
-=C2=A0 &#39;args-unknown.json&#39;,<br>
-=C2=A0 &#39;bad-base.json&#39;,<br>
-=C2=A0 &#39;bad-data.json&#39;,<br>
-=C2=A0 &#39;bad-ident.json&#39;,<br>
-=C2=A0 &#39;bad-if.json&#39;,<br>
-=C2=A0 &#39;bad-if-empty.json&#39;,<br>
-=C2=A0 &#39;bad-if-empty-list.json&#39;,<br>
-=C2=A0 &#39;bad-if-list.json&#39;,<br>
-=C2=A0 &#39;bad-type-bool.json&#39;,<br>
-=C2=A0 &#39;bad-type-dict.json&#39;,<br>
-=C2=A0 &#39;bad-type-int.json&#39;,<br>
-=C2=A0 &#39;base-cycle-direct.json&#39;,<br>
-=C2=A0 &#39;base-cycle-indirect.json&#39;,<br>
-=C2=A0 &#39;command-int.json&#39;,<br>
-=C2=A0 &#39;comments.json&#39;,<br>
-=C2=A0 &#39;doc-bad-alternate-member.json&#39;,<br>
-=C2=A0 &#39;doc-bad-boxed-command-arg.json&#39;,<br>
-=C2=A0 &#39;doc-bad-command-arg.json&#39;,<br>
-=C2=A0 &#39;doc-bad-enum-member.json&#39;,<br>
-=C2=A0 &#39;doc-bad-event-arg.json&#39;,<br>
-=C2=A0 &#39;doc-bad-feature.json&#39;,<br>
-=C2=A0 &#39;doc-bad-section.json&#39;,<br>
-=C2=A0 &#39;doc-bad-symbol.json&#39;,<br>
-=C2=A0 &#39;doc-bad-union-member.json&#39;,<br>
-=C2=A0 &#39;doc-before-include.json&#39;,<br>
-=C2=A0 &#39;doc-before-pragma.json&#39;,<br>
-=C2=A0 &#39;doc-duplicated-arg.json&#39;,<br>
-=C2=A0 &#39;doc-duplicated-return.json&#39;,<br>
-=C2=A0 &#39;doc-duplicated-since.json&#39;,<br>
-=C2=A0 &#39;doc-empty-arg.json&#39;,<br>
-=C2=A0 &#39;doc-empty-section.json&#39;,<br>
-=C2=A0 &#39;doc-empty-symbol.json&#39;,<br>
-=C2=A0 &#39;doc-good.json&#39;,<br>
-=C2=A0 &#39;doc-interleaved-section.json&#39;,<br>
-=C2=A0 &#39;doc-invalid-end.json&#39;,<br>
-=C2=A0 &#39;doc-invalid-end2.json&#39;,<br>
-=C2=A0 &#39;doc-invalid-return.json&#39;,<br>
-=C2=A0 &#39;doc-invalid-section.json&#39;,<br>
-=C2=A0 &#39;doc-invalid-start.json&#39;,<br>
-=C2=A0 &#39;doc-missing-colon.json&#39;,<br>
-=C2=A0 &#39;doc-missing-expr.json&#39;,<br>
-=C2=A0 &#39;doc-missing-space.json&#39;,<br>
-=C2=A0 &#39;doc-missing.json&#39;,<br>
-=C2=A0 &#39;doc-no-symbol.json&#39;,<br>
-=C2=A0 &#39;doc-undoc-feature.json&#39;,<br>
-=C2=A0 &#39;double-type.json&#39;,<br>
-=C2=A0 &#39;duplicate-key.json&#39;,<br>
-=C2=A0 &#39;empty.json&#39;,<br>
-=C2=A0 &#39;enum-bad-member.json&#39;,<br>
-=C2=A0 &#39;enum-bad-name.json&#39;,<br>
-=C2=A0 &#39;enum-bad-prefix.json&#39;,<br>
-=C2=A0 &#39;enum-clash-member.json&#39;,<br>
-=C2=A0 &#39;enum-dict-member-unknown.json&#39;,<br>
-=C2=A0 &#39;enum-if-invalid.json&#39;,<br>
-=C2=A0 &#39;enum-int-member.json&#39;,<br>
-=C2=A0 &#39;enum-member-case.json&#39;,<br>
-=C2=A0 &#39;enum-missing-data.json&#39;,<br>
-=C2=A0 &#39;enum-wrong-data.json&#39;,<br>
-=C2=A0 &#39;event-boxed-empty.json&#39;,<br>
-=C2=A0 &#39;event-case.json&#39;,<br>
-=C2=A0 &#39;event-member-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;event-nest-struct.json&#39;,<br>
-=C2=A0 &#39;features-bad-type.json&#39;,<br>
-=C2=A0 &#39;features-deprecated-type.json&#39;,<br>
-=C2=A0 &#39;features-duplicate-name.json&#39;,<br>
-=C2=A0 &#39;features-if-invalid.json&#39;,<br>
-=C2=A0 &#39;features-missing-name.json&#39;,<br>
-=C2=A0 &#39;features-name-bad-type.json&#39;,<br>
-=C2=A0 &#39;features-no-list.json&#39;,<br>
-=C2=A0 &#39;features-unknown-key.json&#39;,<br>
-=C2=A0 &#39;flat-union-array-branch.json&#39;,<br>
-=C2=A0 &#39;flat-union-bad-base.json&#39;,<br>
-=C2=A0 &#39;flat-union-bad-discriminator.json&#39;,<br>
-=C2=A0 &#39;flat-union-base-any.json&#39;,<br>
-=C2=A0 &#39;flat-union-base-union.json&#39;,<br>
-=C2=A0 &#39;flat-union-clash-member.json&#39;,<br>
-=C2=A0 &#39;flat-union-discriminator-bad-name.json&#39;,<br>
-=C2=A0 &#39;flat-union-empty.json&#39;,<br>
-=C2=A0 &#39;flat-union-inline.json&#39;,<br>
-=C2=A0 &#39;flat-union-inline-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;flat-union-int-branch.json&#39;,<br>
-=C2=A0 &#39;flat-union-invalid-branch-key.json&#39;,<br>
-=C2=A0 &#39;flat-union-invalid-discriminator.json&#39;,<br>
-=C2=A0 &#39;flat-union-invalid-if-discriminator.json&#39;,<br>
-=C2=A0 &#39;flat-union-no-base.json&#39;,<br>
-=C2=A0 &#39;flat-union-optional-discriminator.json&#39;,<br>
-=C2=A0 &#39;flat-union-string-discriminator.json&#39;,<br>
-=C2=A0 &#39;funny-char.json&#39;,<br>
-=C2=A0 &#39;funny-word.json&#39;,<br>
-=C2=A0 &#39;ident-with-escape.json&#39;,<br>
-=C2=A0 &#39;include-before-err.json&#39;,<br>
-=C2=A0 &#39;include-cycle.json&#39;,<br>
-=C2=A0 &#39;include-extra-junk.json&#39;,<br>
-=C2=A0 &#39;include-nested-err.json&#39;,<br>
-=C2=A0 &#39;include-no-file.json&#39;,<br>
-=C2=A0 &#39;include-non-file.json&#39;,<br>
-=C2=A0 &#39;include-repetition.json&#39;,<br>
-=C2=A0 &#39;include-self-cycle.json&#39;,<br>
-=C2=A0 &#39;include-simple.json&#39;,<br>
-=C2=A0 &#39;indented-expr.json&#39;,<br>
-=C2=A0 &#39;leading-comma-list.json&#39;,<br>
-=C2=A0 &#39;leading-comma-object.json&#39;,<br>
-=C2=A0 &#39;missing-colon.json&#39;,<br>
-=C2=A0 &#39;missing-comma-list.json&#39;,<br>
-=C2=A0 &#39;missing-comma-object.json&#39;,<br>
-=C2=A0 &#39;missing-type.json&#39;,<br>
-=C2=A0 &#39;nested-struct-data.json&#39;,<br>
-=C2=A0 &#39;nested-struct-data-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;non-objects.json&#39;,<br>
-=C2=A0 &#39;oob-test.json&#39;,<br>
-=C2=A0 &#39;allow-preconfig-test.json&#39;,<br>
-=C2=A0 &#39;pragma-doc-required-crap.json&#39;,<br>
-=C2=A0 &#39;pragma-extra-junk.json&#39;,<br>
-=C2=A0 &#39;pragma-name-case-whitelist-crap.json&#39;,<br>
-=C2=A0 &#39;pragma-non-dict.json&#39;,<br>
-=C2=A0 &#39;pragma-unknown.json&#39;,<br>
-=C2=A0 &#39;pragma-returns-whitelist-crap.json&#39;,<br>
-=C2=A0 &#39;qapi-schema-test.json&#39;,<br>
-=C2=A0 &#39;quoted-structural-chars.json&#39;,<br>
-=C2=A0 &#39;redefined-builtin.json&#39;,<br>
-=C2=A0 &#39;redefined-command.json&#39;,<br>
-=C2=A0 &#39;redefined-event.json&#39;,<br>
-=C2=A0 &#39;redefined-type.json&#39;,<br>
-=C2=A0 &#39;reserved-command-q.json&#39;,<br>
-=C2=A0 &#39;reserved-enum-q.json&#39;,<br>
-=C2=A0 &#39;reserved-member-has.json&#39;,<br>
-=C2=A0 &#39;reserved-member-q.json&#39;,<br>
-=C2=A0 &#39;reserved-member-u.json&#39;,<br>
-=C2=A0 &#39;reserved-member-underscore.json&#39;,<br>
-=C2=A0 &#39;reserved-type-kind.json&#39;,<br>
-=C2=A0 &#39;reserved-type-list.json&#39;,<br>
-=C2=A0 &#39;returns-alternate.json&#39;,<br>
-=C2=A0 &#39;returns-array-bad.json&#39;,<br>
-=C2=A0 &#39;returns-dict.json&#39;,<br>
-=C2=A0 &#39;returns-unknown.json&#39;,<br>
-=C2=A0 &#39;returns-whitelist.json&#39;,<br>
-=C2=A0 &#39;string-code-point-31.json&#39;,<br>
-=C2=A0 &#39;string-code-point-127.json&#39;,<br>
-=C2=A0 &#39;struct-base-clash-deep.json&#39;,<br>
-=C2=A0 &#39;struct-base-clash.json&#39;,<br>
-=C2=A0 &#39;struct-data-invalid.json&#39;,<br>
-=C2=A0 &#39;struct-member-if-invalid.json&#39;,<br>
-=C2=A0 &#39;struct-member-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;struct-member-invalid.json&#39;,<br>
-=C2=A0 &#39;trailing-comma-list.json&#39;,<br>
-=C2=A0 &#39;trailing-comma-object.json&#39;,<br>
-=C2=A0 &#39;type-bypass-bad-gen.json&#39;,<br>
-=C2=A0 &#39;unclosed-list.json&#39;,<br>
-=C2=A0 &#39;unclosed-object.json&#39;,<br>
-=C2=A0 &#39;unclosed-string.json&#39;,<br>
-=C2=A0 &#39;union-base-empty.json&#39;,<br>
-=C2=A0 &#39;union-base-no-discriminator.json&#39;,<br>
-=C2=A0 &#39;union-branch-case.json&#39;,<br>
-=C2=A0 &#39;union-branch-if-invalid.json&#39;,<br>
-=C2=A0 &#39;union-branch-invalid-dict.json&#39;,<br>
-=C2=A0 &#39;union-clash-branches.json&#39;,<br>
-=C2=A0 &#39;union-empty.json&#39;,<br>
-=C2=A0 &#39;union-invalid-base.json&#39;,<br>
-=C2=A0 &#39;union-optional-branch.json&#39;,<br>
-=C2=A0 &#39;union-unknown.json&#39;,<br>
-=C2=A0 &#39;unknown-escape.json&#39;,<br>
-=C2=A0 &#39;unknown-expr-key.json&#39;,<br>
-]<br>
-<br>
-# Because people may want to use test-qapi.py from the command line, we<br=
>
-# are not using the &quot;#! /usr/bin/env python3&quot; trick here.=C2=A0 =
See<br>
-# docs/devel/build-system.txt<br>
-test(&#39;QAPI schema regression tests&#39;, python, args: files(&#39;test=
-qapi.py&#39;, schemas),<br>
-=C2=A0 =C2=A0 =C2=A0env: test_env, suite: [&#39;qapi-schema&#39;, &#39;qap=
i-frontend&#39;])<br>
-<br>
-diff =3D find_program(&#39;diff&#39;)<br>
-<br>
-qapi_doc =3D custom_target(&#39;QAPI doc&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0output: [&#39;doc-good-qapi-doc.texi&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-commands.c=
&#39;, &#39;doc-good-qapi-commands.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-emit-event=
s.c&#39;, &#39;doc-good-qapi-emit-events.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-events.c&#=
39;, &#39;doc-good-qapi-events.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-init-comma=
nds.c&#39;, &#39;doc-good-qapi-init-commands.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-introspect=
.c&#39;, &#39;doc-good-qapi-introspect.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-types.c&#3=
9;, &#39;doc-good-qapi-types.h&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-visit.c&#3=
9;, &#39;doc-good-qapi-visit.h&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0input: files(&#39;doc-good.json&#39;),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0command: [ qapi_gen, &#39;-o&#39;, meson.current_build_dir=
(),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-p&#39;, &#39;doc=
-good-&#39;, &#39;@INPUT0@&#39; ],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0depend_files: qapi_gen_depends)<br>
-<br>
-# &quot;full_path()&quot; needed here to work around<br>
-# <a href=3D"https://github.com/mesonbuild/meson/issues/7585" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/iss=
ues/7585</a><br>
-test(&#39;QAPI doc&#39;, diff, args: [&#39;-u&#39;, files(&#39;doc-good.te=
xi&#39;), qapi_doc[0].full_path()],<br>
-=C2=A0 =C2=A0 =C2=A0depends: qapi_doc,<br>
-=C2=A0 =C2=A0 =C2=A0suite: [&#39;qapi-schema&#39;, &#39;qapi-doc&#39;])<br=
>
+test_env =3D environment()<br>
+test_env.set(&#39;PYTHONPATH&#39;, meson.source_root() / &#39;scripts&#39;=
)<br>
+test_env.set(&#39;PYTHONIOENCODING&#39;, &#39;utf-8&#39;)<br>
+<br>
+schemas =3D [<br>
+=C2=A0 &#39;alternate-any.json&#39;,<br>
+=C2=A0 &#39;alternate-array.json&#39;,<br>
+=C2=A0 &#39;alternate-base.json&#39;,<br>
+=C2=A0 &#39;alternate-branch-if-invalid.json&#39;,<br>
+=C2=A0 &#39;alternate-clash.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-dict.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-enum-bool.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-enum-int.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-string.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-bool-string.json&#39;,<br>
+=C2=A0 &#39;alternate-conflict-num-string.json&#39;,<br>
+=C2=A0 &#39;alternate-empty.json&#39;,<br>
+=C2=A0 &#39;alternate-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;alternate-nested.json&#39;,<br>
+=C2=A0 &#39;alternate-unknown.json&#39;,<br>
+=C2=A0 &#39;args-alternate.json&#39;,<br>
+=C2=A0 &#39;args-any.json&#39;,<br>
+=C2=A0 &#39;args-array-empty.json&#39;,<br>
+=C2=A0 &#39;args-array-unknown.json&#39;,<br>
+=C2=A0 &#39;args-bad-boxed.json&#39;,<br>
+=C2=A0 &#39;args-boxed-anon.json&#39;,<br>
+=C2=A0 &#39;args-boxed-string.json&#39;,<br>
+=C2=A0 &#39;args-int.json&#39;,<br>
+=C2=A0 &#39;args-invalid.json&#39;,<br>
+=C2=A0 &#39;args-member-array-bad.json&#39;,<br>
+=C2=A0 &#39;args-member-case.json&#39;,<br>
+=C2=A0 &#39;args-member-unknown.json&#39;,<br>
+=C2=A0 &#39;args-name-clash.json&#39;,<br>
+=C2=A0 &#39;args-union.json&#39;,<br>
+=C2=A0 &#39;args-unknown.json&#39;,<br>
+=C2=A0 &#39;bad-base.json&#39;,<br>
+=C2=A0 &#39;bad-data.json&#39;,<br>
+=C2=A0 &#39;bad-ident.json&#39;,<br>
+=C2=A0 &#39;bad-if.json&#39;,<br>
+=C2=A0 &#39;bad-if-empty.json&#39;,<br>
+=C2=A0 &#39;bad-if-empty-list.json&#39;,<br>
+=C2=A0 &#39;bad-if-list.json&#39;,<br>
+=C2=A0 &#39;bad-type-bool.json&#39;,<br>
+=C2=A0 &#39;bad-type-dict.json&#39;,<br>
+=C2=A0 &#39;bad-type-int.json&#39;,<br>
+=C2=A0 &#39;base-cycle-direct.json&#39;,<br>
+=C2=A0 &#39;base-cycle-indirect.json&#39;,<br>
+=C2=A0 &#39;command-int.json&#39;,<br>
+=C2=A0 &#39;comments.json&#39;,<br>
+=C2=A0 &#39;doc-bad-alternate-member.json&#39;,<br>
+=C2=A0 &#39;doc-bad-boxed-command-arg.json&#39;,<br>
+=C2=A0 &#39;doc-bad-command-arg.json&#39;,<br>
+=C2=A0 &#39;doc-bad-enum-member.json&#39;,<br>
+=C2=A0 &#39;doc-bad-event-arg.json&#39;,<br>
+=C2=A0 &#39;doc-bad-feature.json&#39;,<br>
+=C2=A0 &#39;doc-bad-section.json&#39;,<br>
+=C2=A0 &#39;doc-bad-symbol.json&#39;,<br>
+=C2=A0 &#39;doc-bad-union-member.json&#39;,<br>
+=C2=A0 &#39;doc-before-include.json&#39;,<br>
+=C2=A0 &#39;doc-before-pragma.json&#39;,<br>
+=C2=A0 &#39;doc-duplicated-arg.json&#39;,<br>
+=C2=A0 &#39;doc-duplicated-return.json&#39;,<br>
+=C2=A0 &#39;doc-duplicated-since.json&#39;,<br>
+=C2=A0 &#39;doc-empty-arg.json&#39;,<br>
+=C2=A0 &#39;doc-empty-section.json&#39;,<br>
+=C2=A0 &#39;doc-empty-symbol.json&#39;,<br>
+=C2=A0 &#39;doc-good.json&#39;,<br>
+=C2=A0 &#39;doc-interleaved-section.json&#39;,<br>
+=C2=A0 &#39;doc-invalid-end.json&#39;,<br>
+=C2=A0 &#39;doc-invalid-end2.json&#39;,<br>
+=C2=A0 &#39;doc-invalid-return.json&#39;,<br>
+=C2=A0 &#39;doc-invalid-section.json&#39;,<br>
+=C2=A0 &#39;doc-invalid-start.json&#39;,<br>
+=C2=A0 &#39;doc-missing-colon.json&#39;,<br>
+=C2=A0 &#39;doc-missing-expr.json&#39;,<br>
+=C2=A0 &#39;doc-missing-space.json&#39;,<br>
+=C2=A0 &#39;doc-missing.json&#39;,<br>
+=C2=A0 &#39;doc-no-symbol.json&#39;,<br>
+=C2=A0 &#39;doc-undoc-feature.json&#39;,<br>
+=C2=A0 &#39;double-type.json&#39;,<br>
+=C2=A0 &#39;duplicate-key.json&#39;,<br>
+=C2=A0 &#39;empty.json&#39;,<br>
+=C2=A0 &#39;enum-bad-member.json&#39;,<br>
+=C2=A0 &#39;enum-bad-name.json&#39;,<br>
+=C2=A0 &#39;enum-bad-prefix.json&#39;,<br>
+=C2=A0 &#39;enum-clash-member.json&#39;,<br>
+=C2=A0 &#39;enum-dict-member-unknown.json&#39;,<br>
+=C2=A0 &#39;enum-if-invalid.json&#39;,<br>
+=C2=A0 &#39;enum-int-member.json&#39;,<br>
+=C2=A0 &#39;enum-member-case.json&#39;,<br>
+=C2=A0 &#39;enum-missing-data.json&#39;,<br>
+=C2=A0 &#39;enum-wrong-data.json&#39;,<br>
+=C2=A0 &#39;event-boxed-empty.json&#39;,<br>
+=C2=A0 &#39;event-case.json&#39;,<br>
+=C2=A0 &#39;event-member-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;event-nest-struct.json&#39;,<br>
+=C2=A0 &#39;features-bad-type.json&#39;,<br>
+=C2=A0 &#39;features-deprecated-type.json&#39;,<br>
+=C2=A0 &#39;features-duplicate-name.json&#39;,<br>
+=C2=A0 &#39;features-if-invalid.json&#39;,<br>
+=C2=A0 &#39;features-missing-name.json&#39;,<br>
+=C2=A0 &#39;features-name-bad-type.json&#39;,<br>
+=C2=A0 &#39;features-no-list.json&#39;,<br>
+=C2=A0 &#39;features-unknown-key.json&#39;,<br>
+=C2=A0 &#39;flat-union-array-branch.json&#39;,<br>
+=C2=A0 &#39;flat-union-bad-base.json&#39;,<br>
+=C2=A0 &#39;flat-union-bad-discriminator.json&#39;,<br>
+=C2=A0 &#39;flat-union-base-any.json&#39;,<br>
+=C2=A0 &#39;flat-union-base-union.json&#39;,<br>
+=C2=A0 &#39;flat-union-clash-member.json&#39;,<br>
+=C2=A0 &#39;flat-union-discriminator-bad-name.json&#39;,<br>
+=C2=A0 &#39;flat-union-empty.json&#39;,<br>
+=C2=A0 &#39;flat-union-inline.json&#39;,<br>
+=C2=A0 &#39;flat-union-inline-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;flat-union-int-branch.json&#39;,<br>
+=C2=A0 &#39;flat-union-invalid-branch-key.json&#39;,<br>
+=C2=A0 &#39;flat-union-invalid-discriminator.json&#39;,<br>
+=C2=A0 &#39;flat-union-invalid-if-discriminator.json&#39;,<br>
+=C2=A0 &#39;flat-union-no-base.json&#39;,<br>
+=C2=A0 &#39;flat-union-optional-discriminator.json&#39;,<br>
+=C2=A0 &#39;flat-union-string-discriminator.json&#39;,<br>
+=C2=A0 &#39;funny-char.json&#39;,<br>
+=C2=A0 &#39;funny-word.json&#39;,<br>
+=C2=A0 &#39;ident-with-escape.json&#39;,<br>
+=C2=A0 &#39;include-before-err.json&#39;,<br>
+=C2=A0 &#39;include-cycle.json&#39;,<br>
+=C2=A0 &#39;include-extra-junk.json&#39;,<br>
+=C2=A0 &#39;include-nested-err.json&#39;,<br>
+=C2=A0 &#39;include-no-file.json&#39;,<br>
+=C2=A0 &#39;include-non-file.json&#39;,<br>
+=C2=A0 &#39;include-repetition.json&#39;,<br>
+=C2=A0 &#39;include-self-cycle.json&#39;,<br>
+=C2=A0 &#39;include-simple.json&#39;,<br>
+=C2=A0 &#39;indented-expr.json&#39;,<br>
+=C2=A0 &#39;leading-comma-list.json&#39;,<br>
+=C2=A0 &#39;leading-comma-object.json&#39;,<br>
+=C2=A0 &#39;missing-colon.json&#39;,<br>
+=C2=A0 &#39;missing-comma-list.json&#39;,<br>
+=C2=A0 &#39;missing-comma-object.json&#39;,<br>
+=C2=A0 &#39;missing-type.json&#39;,<br>
+=C2=A0 &#39;nested-struct-data.json&#39;,<br>
+=C2=A0 &#39;nested-struct-data-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;non-objects.json&#39;,<br>
+=C2=A0 &#39;oob-test.json&#39;,<br>
+=C2=A0 &#39;allow-preconfig-test.json&#39;,<br>
+=C2=A0 &#39;pragma-doc-required-crap.json&#39;,<br>
+=C2=A0 &#39;pragma-extra-junk.json&#39;,<br>
+=C2=A0 &#39;pragma-name-case-whitelist-crap.json&#39;,<br>
+=C2=A0 &#39;pragma-non-dict.json&#39;,<br>
+=C2=A0 &#39;pragma-unknown.json&#39;,<br>
+=C2=A0 &#39;pragma-returns-whitelist-crap.json&#39;,<br>
+=C2=A0 &#39;qapi-schema-test.json&#39;,<br>
+=C2=A0 &#39;quoted-structural-chars.json&#39;,<br>
+=C2=A0 &#39;redefined-builtin.json&#39;,<br>
+=C2=A0 &#39;redefined-command.json&#39;,<br>
+=C2=A0 &#39;redefined-event.json&#39;,<br>
+=C2=A0 &#39;redefined-type.json&#39;,<br>
+=C2=A0 &#39;reserved-command-q.json&#39;,<br>
+=C2=A0 &#39;reserved-enum-q.json&#39;,<br>
+=C2=A0 &#39;reserved-member-has.json&#39;,<br>
+=C2=A0 &#39;reserved-member-q.json&#39;,<br>
+=C2=A0 &#39;reserved-member-u.json&#39;,<br>
+=C2=A0 &#39;reserved-member-underscore.json&#39;,<br>
+=C2=A0 &#39;reserved-type-kind.json&#39;,<br>
+=C2=A0 &#39;reserved-type-list.json&#39;,<br>
+=C2=A0 &#39;returns-alternate.json&#39;,<br>
+=C2=A0 &#39;returns-array-bad.json&#39;,<br>
+=C2=A0 &#39;returns-dict.json&#39;,<br>
+=C2=A0 &#39;returns-unknown.json&#39;,<br>
+=C2=A0 &#39;returns-whitelist.json&#39;,<br>
+=C2=A0 &#39;string-code-point-31.json&#39;,<br>
+=C2=A0 &#39;string-code-point-127.json&#39;,<br>
+=C2=A0 &#39;struct-base-clash-deep.json&#39;,<br>
+=C2=A0 &#39;struct-base-clash.json&#39;,<br>
+=C2=A0 &#39;struct-data-invalid.json&#39;,<br>
+=C2=A0 &#39;struct-member-if-invalid.json&#39;,<br>
+=C2=A0 &#39;struct-member-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;struct-member-invalid.json&#39;,<br>
+=C2=A0 &#39;trailing-comma-list.json&#39;,<br>
+=C2=A0 &#39;trailing-comma-object.json&#39;,<br>
+=C2=A0 &#39;type-bypass-bad-gen.json&#39;,<br>
+=C2=A0 &#39;unclosed-list.json&#39;,<br>
+=C2=A0 &#39;unclosed-object.json&#39;,<br>
+=C2=A0 &#39;unclosed-string.json&#39;,<br>
+=C2=A0 &#39;union-base-empty.json&#39;,<br>
+=C2=A0 &#39;union-base-no-discriminator.json&#39;,<br>
+=C2=A0 &#39;union-branch-case.json&#39;,<br>
+=C2=A0 &#39;union-branch-if-invalid.json&#39;,<br>
+=C2=A0 &#39;union-branch-invalid-dict.json&#39;,<br>
+=C2=A0 &#39;union-clash-branches.json&#39;,<br>
+=C2=A0 &#39;union-empty.json&#39;,<br>
+=C2=A0 &#39;union-invalid-base.json&#39;,<br>
+=C2=A0 &#39;union-optional-branch.json&#39;,<br>
+=C2=A0 &#39;union-unknown.json&#39;,<br>
+=C2=A0 &#39;unknown-escape.json&#39;,<br>
+=C2=A0 &#39;unknown-expr-key.json&#39;,<br>
+]<br>
+<br>
+# Because people may want to use test-qapi.py from the command line, we<br=
>
+# are not using the &quot;#! /usr/bin/env python3&quot; trick here.=C2=A0 =
See<br>
+# docs/devel/build-system.txt<br>
+test(&#39;QAPI schema regression tests&#39;, python, args: files(&#39;test=
-qapi.py&#39;, schemas),<br>
+=C2=A0 =C2=A0 =C2=A0env: test_env, suite: [&#39;qapi-schema&#39;, &#39;qap=
i-frontend&#39;])<br>
+<br>
+diff =3D find_program(&#39;diff&#39;)<br>
+<br>
+qapi_doc =3D custom_target(&#39;QAPI doc&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0output: [&#39;doc-good-qapi-doc.texi&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-commands.c=
&#39;, &#39;doc-good-qapi-commands.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-emit-event=
s.c&#39;, &#39;doc-good-qapi-emit-events.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-events.c&#=
39;, &#39;doc-good-qapi-events.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-init-comma=
nds.c&#39;, &#39;doc-good-qapi-init-commands.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-introspect=
.c&#39;, &#39;doc-good-qapi-introspect.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-types.c&#3=
9;, &#39;doc-good-qapi-types.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;doc-good-qapi-visit.c&#3=
9;, &#39;doc-good-qapi-visit.h&#39; ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0input: files(&#39;doc-good.json&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0command: [ qapi_gen, &#39;-o&#39;, meson.current_build_dir=
(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-p&#39;, &#39;doc=
-good-&#39;, &#39;@INPUT0@&#39; ],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0depend_files: qapi_gen_depends)<br>
+<br>
+# &quot;full_path()&quot; needed here to work around<br>
+# <a href=3D"https://github.com/mesonbuild/meson/issues/7585" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/iss=
ues/7585</a><br>
+test(&#39;QAPI doc&#39;, diff, args: [&#39;--strip-trailing-cr&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;-u&#39;, files(&#39;doc-good.texi&#39;=
), qapi_doc[0].full_path()],<br>
+=C2=A0 =C2=A0 =C2=A0depends: qapi_doc,<br>
+=C2=A0 =C2=A0 =C2=A0suite: [&#39;qapi-schema&#39;, &#39;qapi-doc&#39;])<br=
>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--000000000000a0227705ae642b14--


