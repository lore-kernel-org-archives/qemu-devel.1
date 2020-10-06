Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E24AC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65642206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6QQZn1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65642206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrbm-0001Pk-1s
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kPrar-0000tK-8Z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:21:45 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kPrap-000594-6w
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:21:44 -0400
Received: by mail-pj1-x1044.google.com with SMTP id x5so1310905pjv.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qIaZQS3HbyTjv/g2etusfT9JyxHP7d3TupGt6jXqf4k=;
 b=Y6QQZn1wwnKJXhr96kGWtiLTpC3WX56lIkP63/ACCL8LQPC732fk7yBYbwq3mmM7EL
 0gvNtTlxOuD5RrOiPm1w9pkgrDySNEmGj0CNjk/nb60iau3+h8FSfssHxBCCZrszLgu3
 G8f0rpwcYlgFsQwXboBZavsE3wYr+5nEToe+eTentoSztN6QKzhfhNFgNXwzmOiaflfI
 6/Q78T0qnqbXD5pi0KhstmuSM3zu4sPhHbPvmX2qpUvLakN/Diy13lOS2CrXHA1LMN2u
 amkpD7Oulf0XF75NSKIOInJGA56fiVFOzz5K71BrKRYvGCykIot4y3q8Z/KNNvOfTRKt
 zzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qIaZQS3HbyTjv/g2etusfT9JyxHP7d3TupGt6jXqf4k=;
 b=eN0A71DnR4wz0MvWM5uzY86X+WW/u6QAUhaAvi8AXh7r1NUNkFr+JBbqHEzGO4OjM9
 +dQ4+clfpmvWwepAQl4lXbgHMgH7xuKby7r61uV7Is0LeH9ZoOZJTTR1VlUXwjtn2CiJ
 ta3B8rFn2WUIVFISOB6dLTda8l/+px4z2Vw91sbwLIq5vX6FpNw6X/kHcLrX3ntxKA+L
 ImYQCQt1IMl0llA+iXyq9q/MA6v5K/XlwlHkrq2wykK208u/DIoVFdXLvnXvo91FS+ap
 EGbSZ8MHirrrypgVG6cwkfJj9yJ6kQyyyvfMPkj1fSseuOaM03A+sbdWinwsBIFHDzYj
 rQkw==
X-Gm-Message-State: AOAM531NTJXVoMr07zlEFyEiSGZIcxFgryur4M8OA5adv0Uw2tpCvGMw
 yhlsUNggHTjsCV+BZupJMaVUSRZPzTiIVSesAXg=
X-Google-Smtp-Source: ABdhPJyYTL6qaF1uzL8mYEsobTUFEL2o0oBnqlqTWbmnwWMhzXoORfy4bhVuPclvoC7G0TSFLNYCwy5p+jYMQYBq9mE=
X-Received: by 2002:a17:902:7687:b029:d2:8d1f:1079 with SMTP id
 m7-20020a1709027687b02900d28d1f1079mr4452269pll.2.1602008501199; Tue, 06 Oct
 2020 11:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
In-Reply-To: <20201005144615.GE5029@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 6 Oct 2020 19:21:29 +0100
Message-ID: <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
Subject: Re: KVM call for agenda for 2020-10-06
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1044.google.com
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 kvm-devel <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you everyone who joined the call. The meeting notes are below.

Stefan
---
*KVM Community Call - Tue Oct 6th
*Topic: QEMU CLI QAPI conversion

    * John Snow's summary of command-line options:
https://docs.google.com/spreadsheets/d/1OJvzDwLpo2XsGytNp9Pr-vYIrb0pWrFKBNP=
tOyH80ew/edit?usp=3Dsharing
    * What is the first milestone?
        * Is it QemuOpts for everything? Straight to QAPI? something else?
        * Markus: The goal is to represent the configuration interface
in QAPI types
            * Don't parse QemuOpts, go straight to QAPI
    * How do we distribute this work to multiple engineers?
        * Examples:
            * --blockdev API is used on the command-line
            * --display
            * qemu-storage-daemon command-line is largely QAPI-fied
    * Alex Bennee:
        * We should have a gold-standard reference with documentation
if we are to expect maintainers to convert their own flags
        * -> John Snow will work on this document
    * Do we have good examples of turning QemuOpts to QAPI?
        * 53 of our 93 CLI flags that take arguments are QemuOpts, so
this is a major component
        * Kevin: -monitor for the Qemu Storage Daemon, recently
    * John Snow: Final milestone might be an automated QAPI-based CLI
parser, but only once QAPI types have been defined

    * Does command-line order matter?
        * Two options: allow any order OR left-to-right ordering
        * Andrea Bolognani: Most users expect left-to-right ordering,
why allow any order?
        * Eduardo Habkost: Can we enforce left-to-right ordering or do
we need to follow the deprecation process?
        * Daniel Berrange: Solve compability by introducing new
binaries without the burden of backwards compability
            * Unclear whether we will reach consensus on this call
about this. Maybe raise it on qemu-devel. [stefanha]
            * Philippe: Easy command-line options (-drive) and
managent-friendly options (-blockdev) could be offered by different
binaries
                * Daniel Berrange: Focussing on one new binary is more
achievable

    * Board defaults, configuration file options
        * How to set properties on existing objects (e.g. board defaults)?
        * Andrea Bolognani: Perhaps represent the board defaults as a
list of ordered options, append user-provided options, and *only then*
create the object?
            * Currently the boards create QOM objects directly, they
don't involve QAPI
        * Stefan: How do QOM objects/properties fit into QAPI
CLI/configuration parsing?
            * QAPI objects are processed by functions that will create
QOM objects
        * Markus: -global is broken

    * Eduardo: Long-term goal to describe QOM properties in QAPI
        * Daniel Berrange: eliminate QOM boilerplate by describing
object properties in QAPI
        * Markus: It's hard to use QAPI because QOM properties are
dynamic and can change at runtime

    * Next steps
        * John Snow and Markus will work on reference documentation



Bluejeans Chat Log
    [ 9:02] Stefan Hajnoczi: https://etherpad.opendev.org/p/QEMUCLI
    [ 9:05] John Ferlan: @stefan - there are some people in a different roo=
m....
    [ 9:08] Daniel Berrange: if you're not talking please mute
    [ 9:24] Alex Benn=C3=A9e: I ran into this ordering stuff w.r.t
semihosting and chardevs so knowing how to properly order things in
the "new world" would be useful
    [ 9:33] Phil: YAML &anchor symbol is helpful to use a definition
from a previous layer
    [ 9:34] Mdasoh: It makes sense to have ordered options when you're
talking about putting objects within objects; at the same time it
doesn't make so much sense to order them when you're talking about
running them all through a BNF parser (flex+yacc?) for user-friendly
configuration. So of course there would be two layers, and you would
translate the unordered options into a set of encapsulating or ordered
options.
    [ 9:49] Andrea Bolognani: It Will Be Totally Different This Time=E2=84=
=A2
    [ 9:50] John Snow: ^ that's partly why I wanted to discuss this,
to set concrete goals and to be able to measure progress
    [ 9:51] Alex Benn=C3=A9e: I'm afraid I have to drop off for the school
run - look forward to reading the reference docs ;-)
    [ 9:51] John Snow: ^ ty Alex
    [10:00] Stefan Hajnoczi: I need to drop now. I'll send the meeting
notes to the mailing list. Bye!
    [10:00] Kevin: Same for me
    [10:00] John Snow: OK!

