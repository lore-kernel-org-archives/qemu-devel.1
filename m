Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BE0C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F136216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F136216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb6R-0005ZE-GH
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUb5s-0005AA-Gl
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUb5q-0002s3-Vn
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:13:03 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:8817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUb5q-0002qJ-8u
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:13:02 -0400
IronPort-SDR: sr9/IG8ywSgODUufu2Gc708j9cEVNLHJYe6XuSN63rIgnhhlgmBE99f1fAyXPdcs0NWmBnWCKC
 7EYoCmRtq+pWHiokwdBF08VzWa2MRhryi19nZs9YJ6aUg8nvw7qEfPGbmtPuJtX1BSXKNFQ7ft
 Nga3KbhTcmwwmGcGlE4YtiY4oPd8b61LXH0JuBd961IXeoo7eiJel69JOhAVfcGCY4Pi/cMLU6
 ulDroz/f/rV1DYefeBJgKzod0YoKzfR8m8yUHSH52SvM4a5TVqKl9OjGFCwXxDyAreEwmcZgcN
 Jyo=
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; d="scan'208";a="50449388"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa1.mentor.iphmx.com with ESMTP; 01 May 2020 11:12:59 -0800
IronPort-SDR: 21+knrnRgo8thPF6yP42sQkvctBLX4pMnhZV+I7IDcgRisFNHq8H8C5YDRDql9CT18NDKXBQjg
 rH3v95cj93utGHkQiBNuR7SbEWv+X29W6Qk7WYEdA9aB8emZ3PE3YwlcEtmX2P3rvIEMk/cCMT
 TZXkN6hvs8bGZRwTziLsuj4G1nTBZqjIQh4vWFEicZ0CVWrhZLjiVep3e1zGKo15pehu1n6N4I
 AjgPmS0z5buaRF0StSxbqdYJ+2l/MNU9Bv2MV8duNUXjTW7HBt2V+VvB7uUYK3Iz/Y7AALy3jd
 t5c=
Date: Fri, 1 May 2020 19:12:54 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/4] softfloat: fix floatx80 pseudo-denormal
 comparisons
In-Reply-To: <87d07niidw.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2005011911420.26026@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
 <87d07niidw.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-1072893692-1588360374=:26026"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 15:12:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.129.153
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---1152306461-1072893692-1588360374=:26026
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Alex Bennée wrote:

> 
> Joseph Myers <joseph@codesourcery.com> writes:
> 
> > The softfloat floatx80 comparisons fail to allow for pseudo-denormals,
> > which should compare equal to corresponding values with biased
> > exponent 1 rather than 0.  Add an adjustment for that case when
> > comparing numbers with the same sign.
> >
> > Note that this fix only changes floatx80_compare_internal, not the
> > other more specific comparison operations.  That is the only
> > comparison function for floatx80 used in the i386 port, which is the
> > only supported port with these pseudo-denormal semantics.
> 
> Again I can't see anything that triggers this although I noticed
> le_quiet has been fixed in the meantime. lt_quiet still fails with:

It looks like this test is only testing the separate comparison functions, 
which aren't used in the i386 port and which I didn't change, not anything 
that uses floatx80_compare_internal.  (That's apart from probably not 
covering pseudo-denormals either.)

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-1072893692-1588360374=:26026--

