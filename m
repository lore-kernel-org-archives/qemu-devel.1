Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73568C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511DC2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511DC2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb72m-0005YH-8Y
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jb6yk-0001XR-4a
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:28:38 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:5934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jb6yi-0000vl-0d
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:28:37 -0400
IronPort-SDR: 1MBPt1kyS3eb1+fN2HAKKaCbG+BNUX1yd73SI20Pp/49KIMxKDNHoIFtRGZWExWkseP5qhIQ7z
 XWOcCJY8W6a9yOv2Ppytre9S9+Gqgizu4hwd39P7D9Lag7NBuREg6D/9HIaIubxsKM3nr8DFsf
 c/u03QcVfyHLAjLoI+6LGPSCaiM9NGIniIdHgPsSxzoz15BNTti2c8TVFpnhJZIDAWovmO0/S0
 xyTTgt4uXP6X9pAMdNie/+Xb0c4k6+hIGEtE9d3v1AQ2BWUmDhUykaanE/C+R8u3F42ub3mETz
 nZM=
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; d="scan'208";a="49058277"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 19 May 2020 10:28:33 -0800
IronPort-SDR: 0+uHDvnzbK8sRSXuXv/CkTfFkNfEXSPcXum0pbYsVvpfDu4HvQzLTD+5gF/Brp9SjO/BzvY/X0
 UnoRS6Fo6uCCrXg29zDQiaU9pQvdyZaFuqQjybCEhKxwCQvrS7kjsIon8C/d4eUG9DRozPQUsN
 KhdGDR2/j5YwaldxvOaREi6Unke95cFxl8VInjeo07ZDlh/vUoBNdLbxSU5DvAJG7CDBwVRjis
 0Msc1I8b+qa9eVpOlH7j41UMRk3mb2uQrA1xX3oI5hZTuigJuCXSMcZ/FGGnDtJn7MWNDRIq3o
 Xp8=
Date: Tue, 19 May 2020 18:28:27 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] target/i386: fix IEEE x87 floating-point exception
 raising
In-Reply-To: <76d7fa28-5dd9-3af4-f663-d251bbdbf4f4@linaro.org>
Message-ID: <alpine.DEB.2.21.2005191825580.10766@digraph.polyomino.org.uk>
References: <alpine.DEB.2.21.2005152117400.3469@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005152120280.3469@digraph.polyomino.org.uk>
 <5dd2d81c-cedd-7835-6b3c-7e089254dc95@linaro.org>
 <alpine.DEB.2.21.2005191757210.10766@digraph.polyomino.org.uk>
 <76d7fa28-5dd9-3af4-f663-d251bbdbf4f4@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 14:28:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020, Richard Henderson wrote:

> > Note that another bug in the x87 emulation is the lack of setting C1 for 
> > most instructions with inexact results based on the direction of rounding 
> > (which will require a new feature to be added to the softfloat code to 
> > record that information so the x87 emulation can use it).
> 
> Wow, I don't believe I ever knew about that detail.

musl libc uses it to get correctly rounded double-precision sqrt with x87 
arithmetic.  (glibc instead temporarily sets the rounding precision to 
achieve the same goal.)

-- 
Joseph S. Myers
joseph@codesourcery.com

