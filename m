Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A18DC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34BF20684
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34BF20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVOp-0003lV-Ou
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHVC5-0007rU-A4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHVC4-0004Nb-4R
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHVC3-0004Lh-SA
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:45:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C48C7BDA9;
 Mon,  7 Oct 2019 15:45:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B0E5C1D4;
 Mon,  7 Oct 2019 15:44:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EF7EF1138648; Mon,  7 Oct 2019 17:44:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] netmap: support git-submodule build otption
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
 <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
Date: Mon, 07 Oct 2019 17:44:44 +0200
In-Reply-To: <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
 (Peter Maydell's message of "Mon, 7 Oct 2019 12:58:38 +0100")
Message-ID: <87a7acftlf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 07 Oct 2019 15:45:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 7 Oct 2019 at 11:50, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > Basically new submodules are a pain so we seek to minimize
>> > the use of them.
>>
>> I suggested making it a submodule upthread[*].  Let me try to distill
>> the conversation into a rationale.  Giuseppe, please correct mistakes.
>>
>> To make use of QEMU's netmap backend (CONFIG_NETMAP), you have to build
>> and install netmap software from sources[**].  Which pretty much ensures
>> developers compile with CONFIG_NETMAP off, and the code rots.
>>
>> For other dependencies that aren't readily available on common
>> development hosts (slirp, capstone), we use submodules to avoid such
>> rot.  If the system provides, we use that, and if it doesn't, we fall
>> back to the submodule.  This has served us well.
>
> I would put this differently. We don't use submodules to avoid
> code-rot. We use submodules where a dependency is needed for us
> to provide QEMU features that are sufficiently important that we
> want to provide them to users even if those users don't have the
> dependency available to them as a system library.
>
> There are lots of features of QEMU that only compile with sufficiently
> recent versions of dependencies, and we don't try to submodule-ize
> them because the features aren't really that important for the bulk
> of our users. For instance, we provided pixman as a submodule for
> a while because the features that require it (our graphics layer
> code) are important to almost all users. But we didn't provide
> spice as a module even when you pretty much needed to be
> running bleeding-edge redhat to satisfy the version dependency
> we had, because most users don't care about spice support.

The ability to compile close to everything in a single build tree is
nevertheless convenient for developers.  Submodules aren't necessary for
that as long as "bleeding-edge redhat" can do the job.  And it pretty
much can: in my "everything" tree, config.status shows less than two
dozen "no", and most of them are uninteresting for compile-testing
(e.g. tcmalloc and jemalloc), or simply impossible to have (e.g. KVM is
for Linux, HAX is not for Linux, can't have both).  netmap's "no" is one
of the few that is due to missing dependencies.  Another one is vde.

> Shipping our dependencies as submodules imposes real costs
> on the project (for instance we then need to track the upstream
> to see when we should be updating, including checking whether
> we need to update to fix security issues). Submodules should be
> the exception, not the rule.

Point taken.

[...]

