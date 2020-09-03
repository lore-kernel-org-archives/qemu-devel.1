Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC74C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED49206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew7MLk6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED49206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjzQ-0008JJ-Vr
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjud-0000Zt-KZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:43758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjua-0003uY-Th
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:44:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id f18so1600906pfa.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XFDBLTs60eOSYLuVLk2iUO8fBuKWazdIEw2K2TmK4fE=;
 b=Ew7MLk6cVRSkPPzhU/SRj272x7jfPI26WW2HSUmCs4ePq8HwHpiFw0cnaDiSQjxliF
 neMZ+u2S2YnvMsuNsZJmHTSVHzmTZu7FGbW2Vr0dzfqftTDhu+YGaQlP+EU0SXil6agk
 PRxt/C+3BDOiImWXHtKrO372w+HOzbdzOmIWBYZhi8tEnoGDa3Kpot5tyaT3iNOU91+E
 hseG68hZY4MFmR1OBFUIXkFgRHU/7eD+G0Ds7oSUWzdftiTAO1/jMBMGDcahgr8sjRPh
 D5o24qnvG9RI5/Y4eGoEDmjLMxcuUWRi82lii7jX8V7m7ExftlQo3t2BHqLyNfjfD4i0
 HITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XFDBLTs60eOSYLuVLk2iUO8fBuKWazdIEw2K2TmK4fE=;
 b=h4LWEehsvomjQgFjYDnOmDBC/0tvesujDZy4uZRObKYKITqQvMuFWMSKOocd8q0z0i
 S2DVeopGGwwY1La8gA1G16IzLtK4bIbyBjZewifh7GvG1mpYcEWqwb/3uSfqztSUn8Y9
 QAAqAB84AUurCHIJ9JaQkgmWGvdc92NtiKeHBBBSEwpelmvSSeZ2Cx5m5Z3V+YtLXcvY
 aj+6WYIWgIS5+suZRskRrWv8/97WNiTC4LrWKgxFSBvURuhlI1DsLOI8qblWkSLGoOq7
 an1ehrKe9a8iyheRgCVPzI+7lwYMy5t4T3RlIVr39x2Wz1O7FVnsJhSVS1MnKtxCqlYE
 CPZQ==
X-Gm-Message-State: AOAM532zPvqKaxWc+3twFlA+Lamj1Dyyw/LbYHEX77Gz0QIuFnPnnfnY
 GtcV9O71i+zNPv6MBwmg/baFeb300W7JETHI
X-Google-Smtp-Source: ABdhPJzdldktEhDoJEnR8tSsBVjo5PhA8Hc7nWa3dgpX+JgAWsjbv8gvIAvxaK17vsfyjhlXGN7bqQ==
X-Received: by 2002:a63:ba49:: with SMTP id l9mr1983782pgu.101.1599119038878; 
 Thu, 03 Sep 2020 00:43:58 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:58 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] meson: Fixes qapi tests.
Date: Thu,  3 Sep 2020 15:43:11 +0800
Message-Id: <20200903074313.1498-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The error are:
+@end table
+
+@end deftypefn
+
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qapi-schema/meson.build | 451 +++++++++++++++++-----------------
 1 file changed, 226 insertions(+), 225 deletions(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..67ba0a5ebd 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -1,225 +1,226 @@
-test_env =3D environment()
-test_env.set('PYTHONPATH', meson.source_root() / 'scripts')
-test_env.set('PYTHONIOENCODING', 'utf-8')
-
-schemas =3D [
-  'alternate-any.json',
-  'alternate-array.json',
-  'alternate-base.json',
-  'alternate-branch-if-invalid.json',
-  'alternate-clash.json',
-  'alternate-conflict-dict.json',
-  'alternate-conflict-enum-bool.json',
-  'alternate-conflict-enum-int.json',
-  'alternate-conflict-string.json',
-  'alternate-conflict-bool-string.json',
-  'alternate-conflict-num-string.json',
-  'alternate-empty.json',
-  'alternate-invalid-dict.json',
-  'alternate-nested.json',
-  'alternate-unknown.json',
-  'args-alternate.json',
-  'args-any.json',
-  'args-array-empty.json',
-  'args-array-unknown.json',
-  'args-bad-boxed.json',
-  'args-boxed-anon.json',
-  'args-boxed-string.json',
-  'args-int.json',
-  'args-invalid.json',
-  'args-member-array-bad.json',
-  'args-member-case.json',
-  'args-member-unknown.json',
-  'args-name-clash.json',
-  'args-union.json',
-  'args-unknown.json',
-  'bad-base.json',
-  'bad-data.json',
-  'bad-ident.json',
-  'bad-if.json',
-  'bad-if-empty.json',
-  'bad-if-empty-list.json',
-  'bad-if-list.json',
-  'bad-type-bool.json',
-  'bad-type-dict.json',
-  'bad-type-int.json',
-  'base-cycle-direct.json',
-  'base-cycle-indirect.json',
-  'command-int.json',
-  'comments.json',
-  'doc-bad-alternate-member.json',
-  'doc-bad-boxed-command-arg.json',
-  'doc-bad-command-arg.json',
-  'doc-bad-enum-member.json',
-  'doc-bad-event-arg.json',
-  'doc-bad-feature.json',
-  'doc-bad-section.json',
-  'doc-bad-symbol.json',
-  'doc-bad-union-member.json',
-  'doc-before-include.json',
-  'doc-before-pragma.json',
-  'doc-duplicated-arg.json',
-  'doc-duplicated-return.json',
-  'doc-duplicated-since.json',
-  'doc-empty-arg.json',
-  'doc-empty-section.json',
-  'doc-empty-symbol.json',
-  'doc-good.json',
-  'doc-interleaved-section.json',
-  'doc-invalid-end.json',
-  'doc-invalid-end2.json',
-  'doc-invalid-return.json',
-  'doc-invalid-section.json',
-  'doc-invalid-start.json',
-  'doc-missing-colon.json',
-  'doc-missing-expr.json',
-  'doc-missing-space.json',
-  'doc-missing.json',
-  'doc-no-symbol.json',
-  'doc-undoc-feature.json',
-  'double-type.json',
-  'duplicate-key.json',
-  'empty.json',
-  'enum-bad-member.json',
-  'enum-bad-name.json',
-  'enum-bad-prefix.json',
-  'enum-clash-member.json',
-  'enum-dict-member-unknown.json',
-  'enum-if-invalid.json',
-  'enum-int-member.json',
-  'enum-member-case.json',
-  'enum-missing-data.json',
-  'enum-wrong-data.json',
-  'event-boxed-empty.json',
-  'event-case.json',
-  'event-member-invalid-dict.json',
-  'event-nest-struct.json',
-  'features-bad-type.json',
-  'features-deprecated-type.json',
-  'features-duplicate-name.json',
-  'features-if-invalid.json',
-  'features-missing-name.json',
-  'features-name-bad-type.json',
-  'features-no-list.json',
-  'features-unknown-key.json',
-  'flat-union-array-branch.json',
-  'flat-union-bad-base.json',
-  'flat-union-bad-discriminator.json',
-  'flat-union-base-any.json',
-  'flat-union-base-union.json',
-  'flat-union-clash-member.json',
-  'flat-union-discriminator-bad-name.json',
-  'flat-union-empty.json',
-  'flat-union-inline.json',
-  'flat-union-inline-invalid-dict.json',
-  'flat-union-int-branch.json',
-  'flat-union-invalid-branch-key.json',
-  'flat-union-invalid-discriminator.json',
-  'flat-union-invalid-if-discriminator.json',
-  'flat-union-no-base.json',
-  'flat-union-optional-discriminator.json',
-  'flat-union-string-discriminator.json',
-  'funny-char.json',
-  'funny-word.json',
-  'ident-with-escape.json',
-  'include-before-err.json',
-  'include-cycle.json',
-  'include-extra-junk.json',
-  'include-nested-err.json',
-  'include-no-file.json',
-  'include-non-file.json',
-  'include-repetition.json',
-  'include-self-cycle.json',
-  'include-simple.json',
-  'indented-expr.json',
-  'leading-comma-list.json',
-  'leading-comma-object.json',
-  'missing-colon.json',
-  'missing-comma-list.json',
-  'missing-comma-object.json',
-  'missing-type.json',
-  'nested-struct-data.json',
-  'nested-struct-data-invalid-dict.json',
-  'non-objects.json',
-  'oob-test.json',
-  'allow-preconfig-test.json',
-  'pragma-doc-required-crap.json',
-  'pragma-extra-junk.json',
-  'pragma-name-case-whitelist-crap.json',
-  'pragma-non-dict.json',
-  'pragma-unknown.json',
-  'pragma-returns-whitelist-crap.json',
-  'qapi-schema-test.json',
-  'quoted-structural-chars.json',
-  'redefined-builtin.json',
-  'redefined-command.json',
-  'redefined-event.json',
-  'redefined-type.json',
-  'reserved-command-q.json',
-  'reserved-enum-q.json',
-  'reserved-member-has.json',
-  'reserved-member-q.json',
-  'reserved-member-u.json',
-  'reserved-member-underscore.json',
-  'reserved-type-kind.json',
-  'reserved-type-list.json',
-  'returns-alternate.json',
-  'returns-array-bad.json',
-  'returns-dict.json',
-  'returns-unknown.json',
-  'returns-whitelist.json',
-  'string-code-point-31.json',
-  'string-code-point-127.json',
-  'struct-base-clash-deep.json',
-  'struct-base-clash.json',
-  'struct-data-invalid.json',
-  'struct-member-if-invalid.json',
-  'struct-member-invalid-dict.json',
-  'struct-member-invalid.json',
-  'trailing-comma-list.json',
-  'trailing-comma-object.json',
-  'type-bypass-bad-gen.json',
-  'unclosed-list.json',
-  'unclosed-object.json',
-  'unclosed-string.json',
-  'union-base-empty.json',
-  'union-base-no-discriminator.json',
-  'union-branch-case.json',
-  'union-branch-if-invalid.json',
-  'union-branch-invalid-dict.json',
-  'union-clash-branches.json',
-  'union-empty.json',
-  'union-invalid-base.json',
-  'union-optional-branch.json',
-  'union-unknown.json',
-  'unknown-escape.json',
-  'unknown-expr-key.json',
-]
-
-# Because people may want to use test-qapi.py from the command line, we
-# are not using the "#! /usr/bin/env python3" trick here.  See
-# docs/devel/build-system.txt
-test('QAPI schema regression tests', python, args: files('test-qapi.py', s=
chemas),
-     env: test_env, suite: ['qapi-schema', 'qapi-frontend'])
-
-diff =3D find_program('diff')
-
-qapi_doc =3D custom_target('QAPI doc',
-                         output: ['doc-good-qapi-doc.texi',
-                                  'doc-good-qapi-commands.c', 'doc-good-qa=
pi-commands.h',
-                                  'doc-good-qapi-emit-events.c', 'doc-good=
-qapi-emit-events.h',
-                                  'doc-good-qapi-events.c', 'doc-good-qapi=
-events.h',
-                                  'doc-good-qapi-init-commands.c', 'doc-go=
od-qapi-init-commands.h',
-                                  'doc-good-qapi-introspect.c', 'doc-good-=
qapi-introspect.h',
-                                  'doc-good-qapi-types.c', 'doc-good-qapi-=
types.h',
-                                  'doc-good-qapi-visit.c', 'doc-good-qapi-=
visit.h' ],
-                         input: files('doc-good.json'),
-                         command: [ qapi_gen, '-o', meson.current_build_di=
r(),
-                                    '-p', 'doc-good-', '@INPUT0@' ],
-                         depend_files: qapi_gen_depends)
-
-# "full_path()" needed here to work around
-# https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].fu=
ll_path()],
-     depends: qapi_doc,
-     suite: ['qapi-schema', 'qapi-doc'])
+test_env =3D environment()=0D
+test_env.set('PYTHONPATH', meson.source_root() / 'scripts')=0D
+test_env.set('PYTHONIOENCODING', 'utf-8')=0D
+=0D
+schemas =3D [=0D
+  'alternate-any.json',=0D
+  'alternate-array.json',=0D
+  'alternate-base.json',=0D
+  'alternate-branch-if-invalid.json',=0D
+  'alternate-clash.json',=0D
+  'alternate-conflict-dict.json',=0D
+  'alternate-conflict-enum-bool.json',=0D
+  'alternate-conflict-enum-int.json',=0D
+  'alternate-conflict-string.json',=0D
+  'alternate-conflict-bool-string.json',=0D
+  'alternate-conflict-num-string.json',=0D
+  'alternate-empty.json',=0D
+  'alternate-invalid-dict.json',=0D
+  'alternate-nested.json',=0D
+  'alternate-unknown.json',=0D
+  'args-alternate.json',=0D
+  'args-any.json',=0D
+  'args-array-empty.json',=0D
+  'args-array-unknown.json',=0D
+  'args-bad-boxed.json',=0D
+  'args-boxed-anon.json',=0D
+  'args-boxed-string.json',=0D
+  'args-int.json',=0D
+  'args-invalid.json',=0D
+  'args-member-array-bad.json',=0D
+  'args-member-case.json',=0D
+  'args-member-unknown.json',=0D
+  'args-name-clash.json',=0D
+  'args-union.json',=0D
+  'args-unknown.json',=0D
+  'bad-base.json',=0D
+  'bad-data.json',=0D
+  'bad-ident.json',=0D
+  'bad-if.json',=0D
+  'bad-if-empty.json',=0D
+  'bad-if-empty-list.json',=0D
+  'bad-if-list.json',=0D
+  'bad-type-bool.json',=0D
+  'bad-type-dict.json',=0D
+  'bad-type-int.json',=0D
+  'base-cycle-direct.json',=0D
+  'base-cycle-indirect.json',=0D
+  'command-int.json',=0D
+  'comments.json',=0D
+  'doc-bad-alternate-member.json',=0D
+  'doc-bad-boxed-command-arg.json',=0D
+  'doc-bad-command-arg.json',=0D
+  'doc-bad-enum-member.json',=0D
+  'doc-bad-event-arg.json',=0D
+  'doc-bad-feature.json',=0D
+  'doc-bad-section.json',=0D
+  'doc-bad-symbol.json',=0D
+  'doc-bad-union-member.json',=0D
+  'doc-before-include.json',=0D
+  'doc-before-pragma.json',=0D
+  'doc-duplicated-arg.json',=0D
+  'doc-duplicated-return.json',=0D
+  'doc-duplicated-since.json',=0D
+  'doc-empty-arg.json',=0D
+  'doc-empty-section.json',=0D
+  'doc-empty-symbol.json',=0D
+  'doc-good.json',=0D
+  'doc-interleaved-section.json',=0D
+  'doc-invalid-end.json',=0D
+  'doc-invalid-end2.json',=0D
+  'doc-invalid-return.json',=0D
+  'doc-invalid-section.json',=0D
+  'doc-invalid-start.json',=0D
+  'doc-missing-colon.json',=0D
+  'doc-missing-expr.json',=0D
+  'doc-missing-space.json',=0D
+  'doc-missing.json',=0D
+  'doc-no-symbol.json',=0D
+  'doc-undoc-feature.json',=0D
+  'double-type.json',=0D
+  'duplicate-key.json',=0D
+  'empty.json',=0D
+  'enum-bad-member.json',=0D
+  'enum-bad-name.json',=0D
+  'enum-bad-prefix.json',=0D
+  'enum-clash-member.json',=0D
+  'enum-dict-member-unknown.json',=0D
+  'enum-if-invalid.json',=0D
+  'enum-int-member.json',=0D
+  'enum-member-case.json',=0D
+  'enum-missing-data.json',=0D
+  'enum-wrong-data.json',=0D
+  'event-boxed-empty.json',=0D
+  'event-case.json',=0D
+  'event-member-invalid-dict.json',=0D
+  'event-nest-struct.json',=0D
+  'features-bad-type.json',=0D
+  'features-deprecated-type.json',=0D
+  'features-duplicate-name.json',=0D
+  'features-if-invalid.json',=0D
+  'features-missing-name.json',=0D
+  'features-name-bad-type.json',=0D
+  'features-no-list.json',=0D
+  'features-unknown-key.json',=0D
+  'flat-union-array-branch.json',=0D
+  'flat-union-bad-base.json',=0D
+  'flat-union-bad-discriminator.json',=0D
+  'flat-union-base-any.json',=0D
+  'flat-union-base-union.json',=0D
+  'flat-union-clash-member.json',=0D
+  'flat-union-discriminator-bad-name.json',=0D
+  'flat-union-empty.json',=0D
+  'flat-union-inline.json',=0D
+  'flat-union-inline-invalid-dict.json',=0D
+  'flat-union-int-branch.json',=0D
+  'flat-union-invalid-branch-key.json',=0D
+  'flat-union-invalid-discriminator.json',=0D
+  'flat-union-invalid-if-discriminator.json',=0D
+  'flat-union-no-base.json',=0D
+  'flat-union-optional-discriminator.json',=0D
+  'flat-union-string-discriminator.json',=0D
+  'funny-char.json',=0D
+  'funny-word.json',=0D
+  'ident-with-escape.json',=0D
+  'include-before-err.json',=0D
+  'include-cycle.json',=0D
+  'include-extra-junk.json',=0D
+  'include-nested-err.json',=0D
+  'include-no-file.json',=0D
+  'include-non-file.json',=0D
+  'include-repetition.json',=0D
+  'include-self-cycle.json',=0D
+  'include-simple.json',=0D
+  'indented-expr.json',=0D
+  'leading-comma-list.json',=0D
+  'leading-comma-object.json',=0D
+  'missing-colon.json',=0D
+  'missing-comma-list.json',=0D
+  'missing-comma-object.json',=0D
+  'missing-type.json',=0D
+  'nested-struct-data.json',=0D
+  'nested-struct-data-invalid-dict.json',=0D
+  'non-objects.json',=0D
+  'oob-test.json',=0D
+  'allow-preconfig-test.json',=0D
+  'pragma-doc-required-crap.json',=0D
+  'pragma-extra-junk.json',=0D
+  'pragma-name-case-whitelist-crap.json',=0D
+  'pragma-non-dict.json',=0D
+  'pragma-unknown.json',=0D
+  'pragma-returns-whitelist-crap.json',=0D
+  'qapi-schema-test.json',=0D
+  'quoted-structural-chars.json',=0D
+  'redefined-builtin.json',=0D
+  'redefined-command.json',=0D
+  'redefined-event.json',=0D
+  'redefined-type.json',=0D
+  'reserved-command-q.json',=0D
+  'reserved-enum-q.json',=0D
+  'reserved-member-has.json',=0D
+  'reserved-member-q.json',=0D
+  'reserved-member-u.json',=0D
+  'reserved-member-underscore.json',=0D
+  'reserved-type-kind.json',=0D
+  'reserved-type-list.json',=0D
+  'returns-alternate.json',=0D
+  'returns-array-bad.json',=0D
+  'returns-dict.json',=0D
+  'returns-unknown.json',=0D
+  'returns-whitelist.json',=0D
+  'string-code-point-31.json',=0D
+  'string-code-point-127.json',=0D
+  'struct-base-clash-deep.json',=0D
+  'struct-base-clash.json',=0D
+  'struct-data-invalid.json',=0D
+  'struct-member-if-invalid.json',=0D
+  'struct-member-invalid-dict.json',=0D
+  'struct-member-invalid.json',=0D
+  'trailing-comma-list.json',=0D
+  'trailing-comma-object.json',=0D
+  'type-bypass-bad-gen.json',=0D
+  'unclosed-list.json',=0D
+  'unclosed-object.json',=0D
+  'unclosed-string.json',=0D
+  'union-base-empty.json',=0D
+  'union-base-no-discriminator.json',=0D
+  'union-branch-case.json',=0D
+  'union-branch-if-invalid.json',=0D
+  'union-branch-invalid-dict.json',=0D
+  'union-clash-branches.json',=0D
+  'union-empty.json',=0D
+  'union-invalid-base.json',=0D
+  'union-optional-branch.json',=0D
+  'union-unknown.json',=0D
+  'unknown-escape.json',=0D
+  'unknown-expr-key.json',=0D
+]=0D
+=0D
+# Because people may want to use test-qapi.py from the command line, we=0D
+# are not using the "#! /usr/bin/env python3" trick here.  See=0D
+# docs/devel/build-system.txt=0D
+test('QAPI schema regression tests', python, args: files('test-qapi.py', s=
chemas),=0D
+     env: test_env, suite: ['qapi-schema', 'qapi-frontend'])=0D
+=0D
+diff =3D find_program('diff')=0D
+=0D
+qapi_doc =3D custom_target('QAPI doc',=0D
+                         output: ['doc-good-qapi-doc.texi',=0D
+                                  'doc-good-qapi-commands.c', 'doc-good-qa=
pi-commands.h',=0D
+                                  'doc-good-qapi-emit-events.c', 'doc-good=
-qapi-emit-events.h',=0D
+                                  'doc-good-qapi-events.c', 'doc-good-qapi=
-events.h',=0D
+                                  'doc-good-qapi-init-commands.c', 'doc-go=
od-qapi-init-commands.h',=0D
+                                  'doc-good-qapi-introspect.c', 'doc-good-=
qapi-introspect.h',=0D
+                                  'doc-good-qapi-types.c', 'doc-good-qapi-=
types.h',=0D
+                                  'doc-good-qapi-visit.c', 'doc-good-qapi-=
visit.h' ],=0D
+                         input: files('doc-good.json'),=0D
+                         command: [ qapi_gen, '-o', meson.current_build_di=
r(),=0D
+                                    '-p', 'doc-good-', '@INPUT0@' ],=0D
+                         depend_files: qapi_gen_depends)=0D
+=0D
+# "full_path()" needed here to work around=0D
+# https://github.com/mesonbuild/meson/issues/7585=0D
+test('QAPI doc', diff, args: ['--strip-trailing-cr',=0D
+                              '-u', files('doc-good.texi'), qapi_doc[0].fu=
ll_path()],=0D
+     depends: qapi_doc,=0D
+     suite: ['qapi-schema', 'qapi-doc'])=0D
--=20
2.28.0.windows.1


