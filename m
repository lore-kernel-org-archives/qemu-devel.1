Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F420C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766A6206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJ4H-0001qS-Iy
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iIHJb-0008Fk-4P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iIHJZ-0001Xd-Uh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1iIHJR-0001T4-QW; Wed, 09 Oct 2019 15:07:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A65929B29C;
 Wed,  9 Oct 2019 19:07:51 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-151.rdu2.redhat.com
 [10.10.122.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05CDD179C9;
 Wed,  9 Oct 2019 19:07:44 +0000 (UTC)
Date: Wed, 9 Oct 2019 15:07:43 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Message-ID: <20191009190743.GA6019@localhost.localdomain>
References: <20191005154748.21718-1-f4bug@amsat.org>
 <20191005154748.21718-2-f4bug@amsat.org>
 <CAFEAcA8ME5U5=rNLRSvNx7LmanqHhn_KWj6qtgym_=W1M9WDoA@mail.gmail.com>
 <20191008214907.GA28137@localhost.localdomain>
 <CAFEAcA9DzeObmtsc2VJmw=1yruANZ6ajY2SG0cAPdehkeRN3wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9DzeObmtsc2VJmw=1yruANZ6ajY2SG0cAPdehkeRN3wA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 09 Oct 2019 19:07:51 +0000 (UTC)
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
Cc: =?iso-8859-1?Q?Fr=E9d=E9ric?= Basse <contact@fredericb.info>,
 Maksim Kozlov <m.kozlov@samsung.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>, Dmitry Solodkiy <d.solodkiy@samsung.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 02:38:02PM +0100, Peter Maydell wrote:
> On Tue, 8 Oct 2019 at 22:49, Cleber Rosa <crosa@redhat.com> wrote:
> >
> > I find it hard to judge precisely how much of a third-party some of
> > these are.  I remember Philippe mentioning that one of them, I guess
> > the images used on linux_ssh_mips_malta.py, were "as official as it
> > gets" (my words, from my often misleading memory).
> >
> > Reproducibility is definitely an issue, in the sense given that some
> > of these can indeed go away, but as long as they're available the hash
> > recorded in the test should guarantee that we're running the same
> > images.
> >
> > Do you think we should do something different here?
> 
> I'm not sure, which is why I asked whether this new test
> was in line with what we've done previously. Since these
> are just test cases and we don't redistribute them to
> other people there's less of a traceability/reproducibility
> worry, and if we check hashes on download that cuts off
> a lot of "fail to notice if the image changes for some
> reason" possible problems.
> 
> thanks
> -- PMM
> 

Yep, because I have no clue how to do improve on this (redistributing
the binaries is definitely not on the improvement side, and neither
is not testing some machine types), the current approach seems good.

Thanks for checking in and giving feedback!

- Cleber.

