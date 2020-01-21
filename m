Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21205C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0862253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:18:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0862253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrYM-00035Q-4b
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrezanin@redhat.com>) id 1itrSs-0006CU-HV
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1itrSr-0007Ue-8w
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:12:58 -0500
Received: from 212-4-128-36.cust.selfnet.cz ([212.4.128.36]:60030
 helo=workimage.localdomain) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <mrezanin@redhat.com>) id 1itrSr-0007U3-1M
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:12:57 -0500
Received: by workimage.localdomain (Postfix, from userid 1000)
 id 631591CB58E; Tue, 21 Jan 2020 12:06:37 +0100 (CET)
Date: Tue, 21 Jan 2020 12:06:37 +0100
From: Miroslav Rezanina <mrezanin@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] Makefile: add missing mkdir MANUAL_BUILDDIR
Message-ID: <20200121110637.4pzkxbyepgozk4q3@lws.brq.redhat.com>
References: <20200120163400.603449-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120163400.603449-1-stefanha@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.4.128.36
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 04:34:00PM +0000, Stefan Hajnoczi wrote:
> The MANUAL_BUILDDIR directory is automatically created by sphinx-build
> for the other targets.  The index.html target does not use sphinx-build
> so we must manually create the directory to avoid the following error:
> 
>   GEN     docs/built/index.html
>   /bin/sh: docs/built/index.html: No such file or directory
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Makefile b/Makefile
> index afa5cb6548..6562b0dc97 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1022,6 +1022,7 @@ $(MANUAL_BUILDDIR)/interop/qemu-ga.8: $(call manual-deps,interop)
>  	$(call build-manual,interop,man)
>  
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-version.h
> +	@mkdir -p "$(MANUAL_BUILDDIR)"
>  	$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
>               "GEN","$@")
>  
> -- 
> 2.24.1
> 

Fixing our issues with build,

Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>

