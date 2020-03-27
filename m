Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738D5C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:17:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A70A20705
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 10:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Ncw64GiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A70A20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHm2x-0006kY-Do
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 06:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1jHm2D-0006Kf-4l
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1jHm2A-0001Xn-6C
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:16:15 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:43359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1jHm29-0001O2-Ra
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 06:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585304174;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0sSB3HL4+SA1oSdXSuB/H6dcqudJM+ELK9tOeleZHD0=;
 b=Ncw64GiEvkNHJ/FCpg2nx9AwqGKLbl7ch5app0QoALtBTSk5eRG+zxqx
 9zJgEN+LiRr9uXqB9D2OJRPaWJLwWdwq1UptnvZycwQ3zC3tzBieAr7lR
 iHGzqhfqs+REaUOltHCbh2kmfD0sqBbRkDPWvxsPoy5nIul1CWFqWllCa k=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: qgp51EfJDzVn1cpLId4lgIVa30l1Pq9meOnu2uBquvpjXsUs5xrOlyaz8i8uEFWMGQ2JODZQUE
 TGRQXjAypC6zXk3s0HtbD4bu53P9SJFJglQpOecpbYptGIWZnm0rheah9W5b8FDj228Hgjk/l8
 HkyEy7ciKkbpBzfLlZSZTLN12HHho8dBQkfmSLCgemyeUX9uvJ4Z0+PnLiipNz8xgS4EhKT8xn
 HnV/gIhZjncGGlZz6/zHJiiqHOb3A2EeU8PFonxw7gTfUp//sYgHlx4ChXI0hif/myuExKTP7B
 JF4=
X-SBRS: 2.7
X-MesageID: 14958511
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,311,1580792400"; d="scan'208";a="14958511"
Date: Fri, 27 Mar 2020 11:16:00 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
Message-ID: <20200327101600.GA28583@Air-de-Roger>
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.142
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Dimitry Andric <dim@FreeBSD.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
> > lld 10.0.0 introduced a new linker option --image-base equivalent to
> > the GNU -Ttext-segment one, hence use it when available.
> > 
> > This fixes the build of QEMU on systems using lld 10 or greater.
> > 
> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Laurent Vivier <laurent@vivier.eu>
> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> > ---
> 
> The Plan is still to drop this whole section of code.
> 
> However, it's still blocked on getting the x86_64 vsyscall patches upstream.

While this doesn't materialize, could it be possible to get this patch
accepted?

This is currently blocking the build of QEMU on FreeBSD HEAD, which
has already switched to LLVM 10.0.0.

Thanks, Roger.

