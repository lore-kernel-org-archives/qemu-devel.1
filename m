Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1993C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FDA216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FDA216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUawH-0003OE-0K
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUavR-0002xx-Fb
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUavP-0001k5-Nc
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:02:16 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:5387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUavP-0001jc-08
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:02:15 -0400
IronPort-SDR: zimuJulNTAa0V8fk+B/Nxu0tqwLy6htgsS6Acaq6q8qHLlim86tSIV+ddSrcKRyYubDTj6CNu8
 C2t6pEv1ZXNA95X+xcNl5yBeIDS/3vP34R3QYgapFaSFmA68U0HySIssELqdoI0h2kUb8k3v29
 0rH2hR1tIPgnCc9Tne3+G5q5v869iSbHiccN+QVEhYtrvzuBsirnBYfnBxtvnHXoY0eMurD0qJ
 wbSO9C/EYeAK6pgP4ouGQW9XGpcru6RVtRcty39ye6XMXa7j7vGBUCmwrY9lL+kf8ow1uEvFdm
 Hsc=
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; d="scan'208";a="48376527"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 01 May 2020 11:02:12 -0800
IronPort-SDR: 4bF+2jMBmFKxcUkrLj5TA4j8r46e0o+FVqcVTFJWi+jvqw5vMJTgROe8PFUzYD0MI+eOWRr3bp
 cv32pc2+JEMec0b5PxbWrQjhB9m8AT0nTf3HulXcIIJA9RrNCYtg3K56HPW5SgFtaqcSTaIOUr
 9TXNvDxuW4/tAZLGYN348SW/EneLbsFZu9nBNauQijIC7I8hVIjRrkSlZaokP4vTqS+3+1gz8P
 1XnjkCdS3/dsOlo6qCUXDx24lFEAk637B3M8xSuwTUqOyFaFXeiJ3QnJGeA0+8zaLuFaWPxW7W
 VIU=
Date: Fri, 1 May 2020 19:02:06 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/4] softfloat: fix floatx80 pseudo-denormal addition /
 subtraction
In-Reply-To: <87h7wziivc.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2005011859030.26026@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005010037350.30535@digraph.polyomino.org.uk>
 <87h7wziivc.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-125435037-1588359726=:26026"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.141.98;
 envelope-from=joseph_myers@mentor.com; helo=esa2.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 15:02:12
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.141.98
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

---1152306461-125435037-1588359726=:26026
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Alex Bennée wrote:

> 
> Joseph Myers <joseph@codesourcery.com> writes:
> 
> > The softfloat function addFloatx80Sigs, used for addition of values
> > with the same sign and subtraction of values with opposite sign, fails
> > to handle the case where the two values both have biased exponent zero
> > and there is a carry resulting from adding the significands, which can
> > occur if one or both values are pseudo-denormals (biased exponent
> > zero, explicit integer bit 1).  Add a check for that case, so making
> > the results match those seen on x86 hardware for pseudo-denormals.
> 
> Hmm running the super detailed test:
> 
>   fp-test -s -l 2 -r all  extF80_add extF80_sub
> 
> I don't see any difference between before and after the patch. This
> makes me wonder if we are (or rather TestFloat) is missing something in
> it's test case.

It could well only be testing kinds of floating-point representations that 
are meaningful in IEEE interchange formats.  Pseudo-denormals don't exist 
in IEEE interchange formats (and nor do pseudo-NaNs, pseudo-infinities and 
un-normals, which are dealt with in floatx80_invalid_encoding).

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-125435037-1588359726=:26026--

