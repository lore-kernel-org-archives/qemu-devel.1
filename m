Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A82C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E67A206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 17:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E67A206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUZ35-0006au-QV
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUZ23-0005kA-QM
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUZ22-0006UZ-2U
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:00:58 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:51351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUZ21-0006UC-7i
 for qemu-devel@nongnu.org; Fri, 01 May 2020 13:00:57 -0400
IronPort-SDR: ta/IA2Tt5ec8+osaV1jzJhWSjge+QGPN6Kay9q6hvBynAfyhukbGUV0vH0vNdA4k9OcKRROu+h
 4aLkBMxlb8PmkLJKTgMjHVxOfcsI2cKOYKE3HAQq9X546WOjZe1H9uByfQUF64PhjBhoHLAzlc
 752BRjwkO6eob3kPkkMsvo9YW7pY+dk7QuQZ4xDbOQk7fO4JAfD9jZS1UdyMRwIh2Z61OjBJPG
 u9GI90W1xQh+gnyTvtk+Wl/P3/O5h9e9lawcqGUvvHTtUvbZNPDTonv6GKfJtRQR/VUIGNXCSZ
 p8E=
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; d="scan'208";a="50444519"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 01 May 2020 09:00:54 -0800
IronPort-SDR: NY1roipdQJn7lexCopcuHf9rMeU0uK+aVrIzXdjgZboy6aFIIB0u0RlPg0hU0107+zbiGZnE2c
 4Iv0fBGuMXh3v6omap3kK0v63d4pMZks1KpDEaaQBi8krvAvSwaSTHXec7wy+RkjhXtL5NoF9t
 rmA3n1AwHrzvRpRiGLu0foCyv4XD00RWBZatdDJRSVs96VspPmYfj8QFJUsthLVTwQ3ZG/aIrK
 SBrQczaIdrfXhQEUVip0cvZphTuHfzfE2FdC1aDABOR5GkCz+bRxI31YBfOBTKbMdkvjqPGR6I
 p18=
Date: Fri, 1 May 2020 17:00:49 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 1/4] softfloat: silence sNaN for conversions to/from
 floatx80
In-Reply-To: <87k11viq9h.fsf@linaro.org>
Message-ID: <alpine.DEB.2.21.2005011630260.26026@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005010036120.30535@digraph.polyomino.org.uk>
 <87k11viq9h.fsf@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="-1152306461-1712233323-1588352449=:26026"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 13:00:54
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

---1152306461-1712233323-1588352449=:26026
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

On Fri, 1 May 2020, Alex Bennée wrote:

> I still see some failures for:
> 
>   f64_to_extF80
>   f128_to_extF80

Running what I think are those tests, I see e.g.

./fp-test -s -l 1 -r all f64_to_extF80
>> Testing f64_to_extF80
768 tests total.
Errors found in f64_to_extF80:
-368.FFFF8000000FF
        => -3F68.FFFFC0000007F800 .....  expected -3F68.FFFFC00000000000 ....x

which looks like it's a test of the floatx80 format with 24-bit precision.

If that's what this is testing, then:

(a) float64_to_floatx80 would need, in 24-bit mode, to call 
roundAndPackFloatx80 rather than just packFloatx80, to get appropriate 
rounding;

(b) float128_to_floatx80 would need to use the dynamically specified 
rounding precision in its call to roundAndPackFloatx80 instead of 
hardcoded 80;

(c) but i386 instruction semantics are that a load of a double value into 
a floating-point register, in the 24-bit mode, does *not* convert the 
significand to 24-bit precision, but loads the full 53-bit-precision value 
into the register, so making such a change to float64_to_floatx80 would 
render it incorrect for i386 emulation without changes to the target/i386 
code to adjust the rounding precision used for loads;

(d) float128_to_floatx80 shouldn't actually be used by any QEMU target, 
because no supported CPU architecture has support for both formats in 
hardware (although I made my sNaN change to the conversions between them 
anyway for completeness).

-- 
Joseph S. Myers
joseph@codesourcery.com
---1152306461-1712233323-1588352449=:26026--

