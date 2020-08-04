Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA763C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0C0A22B40
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fKAf8HON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C0A22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2t8v-0003BI-Mg
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2t7x-0002S1-0T
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:20:57 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:16065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1k2t7v-0007XK-1L
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1596532855;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0YqTm8Wb4K9XKQSC3g7togEL7aTIVm8AWDi9Gqx1kAM=;
 b=fKAf8HONe8n1cXZijRkDY6ltZoD5hBM3OUrqIhlmkIJNDg/m85cIJV85
 kiAUGFouvuQfMnKlOThpcD58xirKwn/VCAo3a6Aew2WvEKdw70cDGJ6QL
 JhNmyXAXrQo0br82jGRkhr6z7TDt3+JXq8Jd1SCCV74G8Lk5cqcbjVYVQ A=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: mkDWYMpTe+0YcZjSXoM1iQw9PH9oKlyIwnALZB6VQtHcM6CZaDUcTXIHCRsqEG3ZKKltbNlDTM
 1rTHpAFUWv/H+304+vK+T+YFCHdmDGPS44Eapvr+bZuzWNSlB4Mm62nXaSGKDaD3Th6YcxTHrJ
 E//VA8AsDwSQTMd5EbmQmj29guus6D0GiOfFIEakEO6NvXPqzZcYDEZxDyfPSUdTgTUey6NAeU
 eahzJ+HREgk6DNOHwvldFqoPAPJ2MCKgBPeoQwrb+mx+qb6q1U0iwX+YLM8Zh9lLmvGYMuLU68
 skI=
X-SBRS: 3.7
X-MesageID: 23979240
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,433,1589256000"; d="scan'208";a="23979240"
Date: Tue, 4 Aug 2020 10:20:48 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1 v2 1/1] accel/xen: Fix xen_enabled() behavior on
 target-agnostic objects
Message-ID: <20200804092048.GE2866@perard.uk.xensource.com>
References: <20200804074930.13104-1-philmd@redhat.com>
 <20200804074930.13104-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804074930.13104-2-philmd@redhat.com>
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=anthony.perard@citrix.com; helo=esa5.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 05:20:52
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Paul Durrant <pdurrant@amazon.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 09:49:30AM +0200, Philippe Mathieu-Daudé wrote:
> CONFIG_XEN is generated by configure and stored in "config-target.h",
> which is (obviously) only include for target-specific objects.
> This is a problem for target-agnostic objects as CONFIG_XEN is never
> defined and xen_enabled() is always inlined as 'false'.
> 
> Fix by following the KVM schema, defining CONFIG_XEN_IS_POSSIBLE
> when we don't know to force the call of the non-inlined function,
> returning the xen_allowed boolean.
> 
> Fixes: da278d58a092 ("accel: Move Xen accelerator code under accel/xen/")
> Reported-by: Paul Durrant <pdurrant@amazon.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

This time, I've also check that build all targets works...

I'll prepare the pull request right away.

Thank you,

-- 
Anthony PERARD

