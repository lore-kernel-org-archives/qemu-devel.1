Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C1C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 198CE2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 14:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/bmaWVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198CE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsrU-00023S-76
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 10:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxsq2-0000gP-Uc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:01:47 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:34822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxspx-0008Mg-EX
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 10:01:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id d4so15146515otk.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=szrYo0+/01kyqzyD6v2ECmzRfRMPG1FJb1hfl64GppQ=;
 b=I/bmaWVh0NGiaSwAUG1jxnD9h2+hMKPbuVqzq+6LEbpNF/YqGsvQlc4Uzh2nTEcxjt
 nrAt/rqTjpfU/fiQ5bRPDy0jbH8OIZ1IHJVforqxok8YfP5Wkj1iK+2PRFRYO5BIhcu9
 tVTr+lDc2g/NcezmlDr3sZINbygF55DNg5KXifENj1+fHN7L4z7KGRahjX3XtCRitxKK
 WOP4T4SHUf2gbLbwQPZFZJS6M+0cWzl2r9oJDEoBo3Wd5Noc7RTJiFTqMGjibpdsEebP
 SDcF5noZlbLcGcJruU9bJj6oVNcTHLoq4iUonCNI5UltclYWL/OuElQCNf8nPx8OI8mh
 JkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=szrYo0+/01kyqzyD6v2ECmzRfRMPG1FJb1hfl64GppQ=;
 b=kVxs/jOZv9bCAmBnXfKQ4Hoe7wlLWqzVVXGlcjPrdAAIQ7r8XV5zZNIZJi40EJNzzZ
 X92rymE9GwRrxg8EuNWFS8bOThkmp6fVrW/WZFviqgLR1gBsOhLWQ0pyrKi3WoJgkCWV
 QtiDHyCRJNIg7pkGnxx+pj2zx9e3eG8AXg4I0sQ1TEFgzecUtCB4uF6XCPq2/x2sTrKq
 GP4IfOK0qnFt1QT7XeHft3WDArdn+OgW++MptdCXzee+ZF62Juq7ttuV3xJ+LcoIHOUa
 q8qNI4Gc9ukVfDcDPJR76reTUQ/qLGLeA8kS2IVkRfrEvF3yWUtdH2zP1vBr7429VAdM
 OW+Q==
X-Gm-Message-State: AOAM530KQQS4bv9kuHsNLD7K5hFOWf/T+B55avQinxlH7KNxiw7AIKOH
 PRIh6Jq7LLrxy3dnBpaj0r1SRyTRKzrlHGxwTucv6pc6L4s=
X-Google-Smtp-Source: ABdhPJzjjD0+mBgYXm7UtZ4BcC9RbKrT4/qgnFduZAWSM1prMygxx3NOJprLVKw6afId6XO8gRkSNTHhPj4UdjRfFTE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr25238513oto.135.1595340099436; 
 Tue, 21 Jul 2020 07:01:39 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 15:01:28 +0100
Message-ID: <CAFEAcA_rFLk2Fs1ibHH7YnR38K-nGjKas5SkPP8ReubHfHtvMQ@mail.gmail.com>
Subject: error reporting from pre_load etc callbacks
To: QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(This was pointed out to me off-list.)

What is the intended API of the pre_load() etc callbacks?
docs/devel/migration.rst doesn't say, and there's no doc comment
in include/migration/vmstate.h. Most actual device implementations
of the hooks seem to return 0 on success and -1 on failure.
But the callers of the hooks like vmstate_load_state() seem to
assume they return negative-errnos: a non-zero return value
is just propagated up to the caller, and can end up for
instance treated as negative-errno in process_incoming_migration_co():
        error_report("load of migration failed: %s", strerror(-ret));
which results in nonsensical error messages to the user like:
 qemu-system-aarch64: load of migration failed: Operation not permitted


More generally, it would be nice if a pre_load/post_load/etc
hook could report an error more precisely than just yes/no
or even than just an errno: in the case of arm CPU loading
we could in theory report more detail like which register the
kernel didn't handle...

thanks
-- PMM

