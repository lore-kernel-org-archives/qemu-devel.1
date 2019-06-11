Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CBC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E8C212F5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 07:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="NMTh9abD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8C212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1habNT-0000DL-TJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 03:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38880)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <fam@euphon.net>) id 1habM1-0007dw-B3
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fam@euphon.net>) id 1habLz-00017B-D7
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 03:38:01 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17972
 helo=sender1.zoho.com.cn)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fam@euphon.net>)
 id 1habLv-0000zt-OM; Tue, 11 Jun 2019 03:37:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560238619; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=cQdc2sJj3gwLeHye3ixr8Wnf0IuumC1bMZ39fBOFBjwB3R035+52/FrkmdWPlm1Pc6kcLNEW5y2iPO6UgEkaElovHB9YLKPTM1ovSRaDVejaDEmVoxz1cUAayDUPjMV9lpPPqN7RgBkn/Rr+CgYYVpgVLjZkQPA78wrx7YMKE/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1560238619;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results;
 bh=LPLaTOyZoeZVOW5QmYMxjxb3GjkIxBa+T7Z3gquysBo=; 
 b=ehroL+quKRc8g9Lr1/AXSOfFJaP8sPp/g2xwhVymbfWqNq3Kn3i1QUQYmN+s8Uzt/nwXfPBlQWTSKwd/nzvkIGrg46KqMEOxtC9ux7eUmAuulcEoj33qFrRyfJ2wZXi1xzFiP7YSf2Fs3ZFhATSfDT8L0TMH5rPuBQlbwI/H5hA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1560238619; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 l=1025; bh=LPLaTOyZoeZVOW5QmYMxjxb3GjkIxBa+T7Z3gquysBo=;
 b=NMTh9abDB0K/83AWi2hYTrOk//fbIbMfyoI7aeEWqmtX5+tx37IRasMFKSc0SwoZ
 lfvSNVAErTtM0RR8ikXxmev+JottgNtk18XcFINfQcP2YMIgTuvUZHQSAmwstCnASHr
 zfmzr2CvZul1AEf7qr5K80L+iZcdNFf5wAL6bsMY=
Received: from localhost (120.52.147.48 [120.52.147.48]) by mx.zoho.com.cn
 with SMTPS id 1560238615899205.03763929128093;
 Tue, 11 Jun 2019 15:36:55 +0800 (CST)
Date: Tue, 11 Jun 2019 15:36:53 +0800
From: Fam Zheng <fam@euphon.net>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611073653.bfp22e6s4jed2qdx@debian>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-3-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-3-mehta.aaru20@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 163.53.93.243
Subject: Re: [Qemu-devel] [PATCH v5 02/12] qapi/block-core: add option for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06/10 19:18, Aarushi Mehta wrote:
> Option only enumerates for hosts that support it.
> 
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1defcde048..db7eedd058 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2792,11 +2792,13 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring (since 4.1)
>  #
>  # Since: 2.9
>  ##
>  { 'enum': 'BlockdevAioOptions',
> -  'data': [ 'threads', 'native' ] }
> +  'data': [ 'threads', 'native',
> +            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }

Question: 'native' has a dependency on libaio but it doesn't have the
condition.  Is the inconsistency intended?

>  
>  ##
>  # @BlockdevCacheOptions:
> -- 
> 2.17.1
> 


