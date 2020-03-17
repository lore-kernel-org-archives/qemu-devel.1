Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A304CC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61206206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMCTygXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61206206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEC0M-0002Sm-HY
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jEBzR-0001kb-W6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jEBzQ-0004rl-9T
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:10:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35729)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jEBzQ-0004jZ-1G
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:10:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id m3so21907309wmi.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zo0b+Ld2kUZGo34u+IHVoEWPRA80GcluhKNKSWk47Mg=;
 b=HMCTygXVZdIY7iQBFgrkkBtnec//BigisRsTH/7u+GOqq5oixfIam99ydWamM9Epo0
 UO0HlCx5kyPvgGPzgSYYqYos7H62CqGKldp4vjT31/sEDpJaNVYB9P3kWiIk26h/PYl9
 2pT+Drbkv8vEqdyh5XD8QVup6DcEXkAfE2HmgiBbyaUIjYCXRMwfkyICTSH1JbH11/lI
 jy4itqZe99Bn1afP6IflW4mq/lbAPTEcxCx2vv1yn341ikGrLiZbQc9IQ2uaqCdKRHiL
 wHlRQtFMcqE1DtYxHH2IASmTf0VYMnCynaqZmo0fb8dfbr1kDJ4HCjnOTXw//bPEDWiP
 EYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zo0b+Ld2kUZGo34u+IHVoEWPRA80GcluhKNKSWk47Mg=;
 b=b4+qfNclQHK7V3eaqjUTJxYCN6LH83UwDI+95fqxOdnxXwL8jg82wY/vG3+7vykNmZ
 yLodOLeqY8tbbiGhWqXu50HK7AEOp8v9jMzs4bMnz+zvfFthTgieXfjbjrznCrKAqx5K
 wjbl+K9aTSTQbAcVKEkLQeb5FEG9YcUA4WX8SGRfu5h13H0W7iGX5c2jkYWfPRSzyJ7l
 yehKyFr1420puve5wDRP8dCaL2i9n8xI6AbvdQz8hoadJNAwuDLluk9fw7jSN8S2yCQD
 2wY9Hi2vEIue3iGzJy4r7pwtRpVHUdehrwv9X2Xt6862KdWhZzModh1sPijwV2plSLPB
 iHpA==
X-Gm-Message-State: ANhLgQ1YPwjdQyBfcX8faiBAf9RYaq1dnkHyGFFunWyWyGQdB8J7mnh6
 hF8szunMPBy8PwsIgb80BALru76xY3sPzJWvdJg=
X-Google-Smtp-Source: ADFU+vuYrn3Krp/n/3xGIrw1t3F2kPGHBT24NSqebFnYjTR1AmkQPwa8osYBxxK9mrmwZ1eU1KkQlt5o5Kav4wC9T08=
X-Received: by 2002:a7b:c153:: with SMTP id z19mr5065052wmi.37.1584450634571; 
 Tue, 17 Mar 2020 06:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200317115459.31821-1-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Mar 2020 14:10:22 +0100
Message-ID: <CAJ+F1CLfvaLeTEj60PW6srwynA=N5ZCXxTM3ZORMFR_fkjkXiQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/34] Configurable policy for handling deprecated
 interfaces
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, libvir-list@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, Mar 17, 2020 at 12:55 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> This series extends QMP introspection to cover deprecation.
> Additionally, new option -compat lets you configure what to do when
> deprecated interfaces get used.  This is intended for testing users of
> the management interfaces.  It is experimental.
>
> -compat deprecated-input=3D<in-policy> configures what to do when
> deprecated input is received.  Available policies:
>
> * accept: Accept deprecated commands and arguments (default)
> * reject: Reject them
> * crash: Crash
>
> -compat deprecated-output=3D<out-policy> configures what to do when
> deprecated output is sent.  Available output policies:
>
> * accept: Emit deprecated command results and events (default)
> * hide: Suppress them
>
> For now, -compat covers only deprecated syntactic aspects of QMP.  We
> may want to extend it to cover semantic aspects, CLI, and experimental
> features.


I suggest to use a qmp- prefix for qmp-related policies.

> PATCH 01-04: Documentation fixes
> PATCH 05-10: Test improvements
> PATCH 11-24: Add feature flags to remaining user-defined types and to
>              struct members
> PATCH 25-26: New special feature 'deprecated', visible in
>              introspection
> PATCH 27-34: New -compat to set policy for handling stuff marked with
>              feature 'deprecated'
>
> v4:
> PATCH 05+07: Temporary memory leak plugged [Marc-Andr=C3=A9]
> PATCH 23: Rewritten [Marc-Andr=C3=A9]
> PATCH 24: Comment typo [Marc-Andr=C3=A9]
> PATCH 30: Memory leaks plugged
>
> v3:
> * Rebased, non-trivial conflicts in PATCH 01+26+27+34 due to RST
>   conversion and code motion
> * PATCH 28-29: Old PATCH 28 split up to ease review
> * PATCH 30-31: New
> * PATCH 32-33: Old PATCH 29 split up to ease review
>
> Comparison to RFC (24 Oct 2019):
> * Cover arguments and results in addition to commands and events
> * Half-baked "[RFC PATCH 18/19] qapi: Include a warning in the
>   response to a deprecated command" dropped
>
> See also last item of
>     Subject: Minutes of KVM Forum BoF on deprecating stuff
>     Date: Fri, 26 Oct 2018 16:03:51 +0200
>     Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.htm=
l
>
> Cc: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: libguestfs@redhat.com
> Cc: libvir-list@redhat.com
> Cc: Daniel P. Berrange <berrange@redhat.com>
> Cc: Peter Krempa <pkrempa@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
>
> Markus Armbruster (34):
>   qemu-doc: Belatedly document QMP command arg & result deprecation
>   qapi: Belatedly update doc comment for @wait deprecation
>   docs/devel/qapi-code-gen: Clarify allow-oob introspection
>   docs/devel/qapi-code-gen: Document 'features' introspection
>   tests/test-qmp-cmds: Factor out qmp_dispatch() test helpers
>   tests/test-qmp-cmds: Check responses more thoroughly
>   tests/test-qmp-cmds: Simplify test data setup
>   tests/test-qmp-event: Simplify test data setup
>   tests/test-qmp-event: Use qobject_is_equal()
>   tests/test-qmp-event: Check event is actually emitted
>   qapi/schema: Clean up around QAPISchemaEntity.connect_doc()
>   qapi: Add feature flags to remaining definitions
>   qapi: Consistently put @features parameter right after @ifcond
>   qapi/introspect: Rename *qlit* to reduce confusion
>   qapi/introspect: Factor out _make_tree()
>   qapi/schema: Change _make_features() to a take feature list
>   qapi/schema: Reorder classes so related ones are together
>   qapi/schema: Rename QAPISchemaObjectType{Variant,Variants}
>   qapi/schema: Call QAPIDoc.connect_member() in just one place
>   qapi: Add feature flags to struct members
>   qapi: Inline do_qmp_dispatch() into qmp_dispatch()
>   qapi: Simplify how qmp_dispatch() deals with QCO_NO_SUCCESS_RESP
>   qapi: Simplify how qmp_dispatch() gets the request ID
>   qapi: Replace qmp_dispatch()'s TODO comment by an explanation
>   qapi: New special feature flag "deprecated"
>   qapi: Mark deprecated QMP parts with feature 'deprecated'
>   qemu-options: New -compat to set policy for deprecated interfaces
>   qapi: Implement deprecated-output=3Dhide for QMP command results
>   qapi: Implement deprecated-output=3Dhide for QMP events
>   qapi: Implement deprecated-output=3Dhide for QMP event data
>   qapi: Implement deprecated-output=3Dhide for QMP introspection
>   qapi: Implement deprecated-input=3Dreject for QMP commands
>   qapi: Implement deprecated-input=3Dreject for QMP command arguments
>   qapi: New -compat deprecated-input=3Dcrash
>
>  docs/devel/qapi-code-gen.txt                  |  79 ++-
>  docs/system/deprecated.rst                    |  48 +-
>  tests/qapi-schema/doc-good.texi               |  32 ++
>  qapi/block-core.json                          |  48 +-
>  qapi/block.json                               |  30 +-
>  qapi/char.json                                |   1 +
>  qapi/compat.json                              |  52 ++
>  qapi/control.json                             |  11 +-
>  qapi/introspect.json                          |  28 +-
>  qapi/machine.json                             |  34 +-
>  qapi/migration.json                           |  36 +-
>  qapi/misc.json                                |  13 +-
>  qapi/qapi-schema.json                         |   1 +
>  include/qapi/compat-policy.h                  |  20 +
>  include/qapi/qmp/dispatch.h                   |   1 +
>  include/qapi/qobject-input-visitor.h          |   9 +
>  include/qapi/qobject-output-visitor.h         |   9 +
>  include/qapi/visitor-impl.h                   |   3 +
>  include/qapi/visitor.h                        |   9 +
>  monitor/monitor-internal.h                    |   3 -
>  monitor/misc.c                                |   2 -
>  monitor/qmp-cmds-control.c                    | 102 +++-
>  qapi/qapi-visit-core.c                        |   9 +
>  qapi/qmp-dispatch.c                           | 149 +++---
>  qapi/qobject-input-visitor.c                  |  29 ++
>  qapi/qobject-output-visitor.c                 |  20 +
>  qemu-storage-daemon.c                         |   2 -
>  softmmu/vl.c                                  |  17 +
>  tests/test-qmp-cmds.c                         | 249 +++++----
>  tests/test-qmp-event.c                        | 203 +++-----
>  qapi/Makefile.objs                            |   8 +-
>  qapi/trace-events                             |   1 +
>  qemu-options.hx                               |  22 +
>  scripts/qapi/commands.py                      |  20 +-
>  scripts/qapi/doc.py                           |  16 +-
>  scripts/qapi/events.py                        |  24 +-
>  scripts/qapi/expr.py                          |  14 +-
>  scripts/qapi/introspect.py                    | 104 ++--
>  scripts/qapi/schema.py                        | 488 ++++++++++--------
>  scripts/qapi/types.py                         |   8 +-
>  scripts/qapi/visit.py                         |  28 +-
>  tests/Makefile.include                        |   1 +
>  tests/qapi-schema/alternate-base.err          |   2 +-
>  tests/qapi-schema/doc-good.json               |  22 +-
>  tests/qapi-schema/doc-good.out                |  18 +
>  .../qapi-schema/features-deprecated-type.err  |   2 +
>  .../qapi-schema/features-deprecated-type.json |   3 +
>  .../qapi-schema/features-deprecated-type.out  |   0
>  tests/qapi-schema/qapi-schema-test.json       |  51 +-
>  tests/qapi-schema/qapi-schema-test.out        |  48 +-
>  tests/qapi-schema/test-qapi.py                |  26 +-
>  51 files changed, 1393 insertions(+), 762 deletions(-)
>  create mode 100644 qapi/compat.json
>  create mode 100644 include/qapi/compat-policy.h
>  create mode 100644 tests/qapi-schema/features-deprecated-type.err
>  create mode 100644 tests/qapi-schema/features-deprecated-type.json
>  create mode 100644 tests/qapi-schema/features-deprecated-type.out
>
> --
> 2.21.1
>


--=20
Marc-Andr=C3=A9 Lureau

