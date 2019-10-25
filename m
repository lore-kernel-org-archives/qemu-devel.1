Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75134CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E4C21872
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 20:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E4C21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6bM-0001ak-Us
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 16:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>) id 1iO6M5-0007Ct-Sb
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <agraf@csgraf.de>) id 1iO6M4-00039w-Fe
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:38:41 -0400
Received: from mail.csgraf.de ([188.138.100.120]:52044
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <agraf@csgraf.de>) id 1iO6M4-000390-8r
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 16:38:40 -0400
Received: from 38f9d3867b82.ant.amazon.com (unknown [3.122.114.9])
 by csgraf.de (Postfix) with ESMTPSA id ADB8439003C2;
 Fri, 25 Oct 2019 22:38:36 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] tcg/LICENSE: Remove no-longer-true statement that
 TCG is BSD-licensed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191025155848.17362-1-peter.maydell@linaro.org>
From: Alexander Graf <agraf@csgraf.de>
Message-ID: <af059b21-94bb-c8c5-6d4a-6b104386c7e6@csgraf.de>
Date: Fri, 25 Oct 2019 22:38:34 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025155848.17362-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.138.100.120
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 25.10.19 17:58, Peter Maydell wrote:
> Since 2008 the tcg/LICENSE file has not changed: it claims that
> everything under tcg/ is BSD-licensed.
>
> This is not true and hasn't been true for years: in 2013 we
> accepted the tcg/aarch64 target code under a GPLv2-or-later
> license statement. We also have generic vector optimisation
> code under the LGPL2.1-or-later, and the TCI backend is
> GPLv2-or-later. Further, many of the files are not BSD
> licensed but MIT licensed.
>
> We don't really consider the tcg subdirectory to be a distinct
> part of QEMU anyway.
>
> This patchset adds explicit licensing/copyright comments to
> the three files which were missing them, removes the
> inaccurate tcg/LICENSE file, and updates the top-level
> LICENSE file to be more accurate about the current state
> of the licenses used in the code in tcg/.
>
> If we want a policy that tcg/ code has a restricted
> permitted set of licenses, then we really need to have
> this enforced by checkpatch -- history demonstrates that
> just writing it in tcg/LICENSE does not prevent code under
> other licenses getting in. In the v1 email thread nobody
> seemed to be very strongly arguing for this, though, and
> at this point we would need to make an active effort to
> track down contributors and get relicensing statements.
> If anybody wants to push that effort now would be a good
> time to volunteer :-)
>
> Note on the licensing for the tcg-target.opc.h files:
>   * I've used the same license as the rest of the relevant
>     backend, which is to say GPL2-or-later for tcg/aarch64
>     and MIT for tcg/i386 and tcg/ppc.
>   * In all 3 cases, the only people who've made contributions
>     to the files are Richard Henderson and (for aarch64) Alex Benn=C3=A9=
e
>
> Richard, Alex -- an acked-by for the relevant patches would
> be nice (or if you intended a different license for the
> contributions than I have assumed please say so!)


Thanks for cleaning up the license mess :)

Reviewed-by: Alexander Graf <agraf@csgraf.de>

Alex



