Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B299AC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78552206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Fmc0HvxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78552206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHpg8-0007Y0-Kf
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <roger.pau@citrix.com>) id 1jHpfH-0006LX-NR
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <roger.pau@citrix.com>) id 1jHpfG-00011v-Cr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:08:51 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:64400)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <roger.pau@citrix.com>)
 id 1jHpfG-0000rG-1c
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1585318129;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=xikYltMbgLjSh78ZrrDz1xYgV3AvbeAt/3i0W663VKk=;
 b=Fmc0HvxCYnyks71j8d62pMD58auyPlHLgOxuFRmXTB2KXqWm51mWkSSy
 NIRHnM0/uK/kvT9W5iaVRcgZGaupuF8Dkv93QCeqC2v1umeVak/1QpDh/
 071iC/E6OKqNN7+Mh8q1LflhjB24Tm3yUeCWD+nET9ea/fg4RrCpOEHHt Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=roger.pau@citrix.com;
 spf=Pass smtp.mailfrom=roger.pau@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
 receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
 roger.pau@citrix.com designates 162.221.158.21 as permitted
 sender) identity=mailfrom; client-ip=162.221.158.21;
 receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="roger.pau@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
 ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
 envelope-from="roger.pau@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 9IulxIc9wp5bPWTRJsoNPiVcs2Kag5zKio8HCYcbfsDUpu/YlF31PGPk5CBqFpm8quIZF2TFjh
 gQ2r2T6SSNEdwCqVj7WkKkoOpDzfvNNfVIlcw3inK7F0MNGVDyc7x8zBElOevgjSW8FHWNXa/A
 6gz5qc2deU3T8j6ND5qQQ6TvZSKzHKSRd/L63/Z5WBTt5SJ+g2tUmUc9U04JHbUOl813R9vslx
 7N4Jq4htVJ+V851vER4ENhyhPnkpu7g2vncng7d+kveQM5m61mWa4jjLkbPsnvJa/LzEYiXrn4
 cuI=
X-SBRS: 2.7
X-MesageID: 15411107
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,312,1580792400"; d="scan'208";a="15411107"
Date: Fri, 27 Mar 2020 15:08:39 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] qemu-user: fix build with LLVM lld 10
Message-ID: <20200327140839.GB28583@Air-de-Roger>
References: <20200326134316.36059-1-roger.pau@citrix.com>
 <f71f7cf8-af7d-7b45-a026-8ab87e106759@linaro.org>
 <20200327101600.GA28583@Air-de-Roger> <87sghum3zv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sghum3zv.fsf@linaro.org>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.144
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
 Dimitry Andric <dim@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 27, 2020 at 11:28:04AM +0000, Alex Bennée wrote:
> 
> Roger Pau Monné <roger.pau@citrix.com> writes:
> 
> > On Thu, Mar 26, 2020 at 09:56:38AM -0700, Richard Henderson wrote:
> >> On 3/26/20 6:43 AM, Roger Pau Monne wrote:
> >> > lld 10.0.0 introduced a new linker option --image-base equivalent to
> >> > the GNU -Ttext-segment one, hence use it when available.
> >> > 
> >> > This fixes the build of QEMU on systems using lld 10 or greater.
> >> > 
> >> > Signed-off-by: Dimitry Andric <dim@FreeBSD.org>
> >> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> >> > ---
> >> > Cc: Laurent Vivier <laurent@vivier.eu>
> >> > Cc: Richard Henderson <richard.henderson@linaro.org>
> >> > Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> >> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> > Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> >> > ---
> >> 
> >> The Plan is still to drop this whole section of code.
> >> 
> >> However, it's still blocked on getting the x86_64 vsyscall patches upstream.
> >
> > While this doesn't materialize, could it be possible to get this patch
> > accepted?
> >
> > This is currently blocking the build of QEMU on FreeBSD HEAD, which
> > has already switched to LLVM 10.0.0.
> 
> I think the vsyscall patch has just been merged, however way I don't
> think targeting HEAD of a OS release during the rc phase is appropriate.

I'm not sure I understand what you mean. If QEMU doesn't build on
FreeBSD HEAD it won't build on the next release. Also the LLVM
toolchain used is not a development version AFAIK, but the actual
10.0.0 release, which QEMU should aim to support?

Can this be applied to stable branches then please if QEMU master
doesn't have that chunk in configure anymore?

FWIW, I've just looked at configure from git master branch and it
still has that exact same linker detection chunk that this patch is
trying to fix.

Thanks, Roger.

