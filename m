Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD68C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A21720829
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="BInAm7bS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A21720829
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRNd-0006PE-Ui
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTRIP-0001BX-Ub
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:05:29 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:27586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTRIN-0005fp-TC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1602860727;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lzQYHByc9rCyTSqeD2dVH4ACwWaigXIrDdagCmA+pJc=;
 b=BInAm7bST+VYcpBQLmFYfd6xCHXXKfB4V1tQc/Cs49hJ5f1uexliRwEZ
 iGyK3BRrouShs1IRPbfpzgNkjvyDDL6jh+B3pr+aYgFH0mi8z7zFwwy8E
 MImNIq3WxcTvpV8VL5LhFXxJ2Ush3orh1PGVe75SB21neCMOoOT3Dv8yq 0=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 8xrsJXClWkgNoBBsL3od8vw5BuwDctmtaWKaLGuyACzzj+7cYljg5NTteI5HRnhC7FxKWPDppG
 pflLdsXdkaofdbUt2IAxnH75q6vBTJ85FLlv3LNCoJUFupdHYhKBseZ0wtaTLEbajzXDSOFbns
 WUysT5hhQDlpfO7t1WvSOlWBxu6ZDxWPKa0DUDKeSWlX51e6mPJnbWsC32WpOPBvhTteZprxM0
 QHgJOMzsHmxmyZdhenrk5Z4cIMllKL8Z73PyJQpHTd7t+KtXL0k+noEOBxuhJmhhSGf9TQYVwH
 YGU=
X-SBRS: 2.5
X-MesageID: 30227108
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,383,1596513600"; d="scan'208";a="30227108"
Date: Fri, 16 Oct 2020 16:05:14 +0100
To: Jason Andryuk <jandryuk@gmail.com>
CC: <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>, Stefano
 Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 3/3] accel: Add xen CpusAccel using dummy-cpus
Message-ID: <20201016150514.GA3105841@perard.uk.xensource.com>
References: <20201013140511.5681-1-jandryuk@gmail.com>
 <20201013140511.5681-4-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013140511.5681-4-jandryuk@gmail.com>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 11:05:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Tue, Oct 13, 2020 at 10:05:11AM -0400, Jason Andryuk wrote:
> Xen was broken by commit 1583a3898853 ("cpus: extract out qtest-specific
> code to accel/qtest").  Xen relied on qemu_init_vcpu() calling
> qemu_dummy_start_vcpu() in the default case, but that was replaced by
> g_assert_not_reached().
> 
> Add a minimal "CpusAccel" for Xen using the dummy-cpus implementation
> used by qtest.
> 
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

