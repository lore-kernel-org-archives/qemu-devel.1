Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A54CC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 04:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39AD206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 04:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39AD206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht2ZE-0000gw-41
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 00:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36728)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1ht2Yq-0000GO-ER
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 00:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ht2Yp-0001Be-Ek
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 00:19:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ht2Yp-0001BU-9Y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 00:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 67CCF81F07;
 Thu,  1 Aug 2019 04:19:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13C9D60BEC;
 Thu,  1 Aug 2019 04:19:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 651741138619; Thu,  1 Aug 2019 06:19:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
Date: Thu, 01 Aug 2019 06:19:24 +0200
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 31 Jul 2019 17:06:25 +0100")
Message-ID: <87a7cty0tv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 01 Aug 2019 04:19:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH  v4 00/54] plugins for TCG
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
Cc: bobby.prani@gmail.com, cota@braap.org, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> This is the latest iteration of the plugins series. The main changes
> from the last version are:
>
>   - dropped passing of haddr to plugins
>
> This makes the code for handling the plugins less invasive in the
> softmmu path at the cost of offloading processing to the plugin if it
> wants the value. We rely on the fact that the TLB is per vCPU so a
> helper can just trigger a re-query of the TLB to get the final
> address.
>
> Part of that change involved embedding the MMU index in the meminfo
> field for tracing. I see there are some other patches on the list for
> messing with TCGMemOp so there might be a clash coming up.
>
>   - translator_ld goes direct to softmmu/user functions
>
> I also mark the [SOFTMMU_]CODE_ACCESS helpers as deprecated. There is
> more work to be done to clean up all the current uses of code access
> helpers but ideally the only thing that should be peaking at code is
> the translator loop itself. However a bunch of helpers have taken to
> using code loading functions to peak at the instruction just executed
> to figure out what to do. Once those have been fixed then we can
> remove those helpers.
>
> Other more minor fixes can be found documented bellow the --- in the
> individual patches.
>
> This series also includes the semihosting patches as they are a
> pre-requisite for the translator_ld patches for ARM.
>
> Once the tree opens up for development again I hope to get the
> semihosting and trivial clean-up patches merged quickly so the patch
> count for the plugins patches proper can be reduced a bit.

Next time, please explain briefly what TCG plugins are about right in
your cover letter.  I had to go hunting for this.  Found "[PATCH v4
11/54] docs/devel: add plugins.rst design document".

Please advise why TCG plugins don't undermine the GPL.  Any proposal to
add a plugin interface needs to do that.

