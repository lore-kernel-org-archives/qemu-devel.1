Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D9C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0848D2084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko1MqT8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0848D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1Jn-00052K-O5
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbusch@kernel.org>) id 1iz1J1-0004DR-Os
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbusch@kernel.org>) id 1iz1Iz-0005j0-Oe
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbusch@kernel.org>)
 id 1iz1Ix-0005Up-5o; Tue, 04 Feb 2020 11:44:03 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1145E2082E;
 Tue,  4 Feb 2020 16:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580834642;
 bh=5Z3fi/evkwiBSjQr+HcMniCvJfzJKoMv3ksjkHw2wII=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ko1MqT8if6AjG+VmHuHVFxv9r4OEJPGUwjZDpsqS+QqnV67SL0GfRjGg2TN0auKSk
 WMt53tzeq+DAUR+ikARBLFdS5NwX0HI5HwwqayPS9H6crI1HurOIodmB/Fat5Aa6SX
 dUvwgxnmcOgoa0EMbLP3y3gMVUc673m/0dj5Nayk=
Date: Wed, 5 Feb 2020 01:43:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v5 26/26] nvme: make lba data size configurable
Message-ID: <20200204164358.GC6823@redsun51.ssa.fujisawa.hgst.com>
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095232eucas1p2b3264104447a42882f10edb06608ece5@eucas1p2.samsung.com>
 <20200204095208.269131-27-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204095208.269131-27-k.jensen@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 04, 2020 at 10:52:08AM +0100, Klaus Jensen wrote:
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/block/nvme-ns.c | 2 +-
>  hw/block/nvme-ns.h | 4 +++-
>  hw/block/nvme.c    | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/nvme-ns.c b/hw/block/nvme-ns.c
> index 0e5be44486f4..981d7101b8f2 100644
> --- a/hw/block/nvme-ns.c
> +++ b/hw/block/nvme-ns.c
> @@ -18,7 +18,7 @@ static int nvme_ns_init(NvmeNamespace *ns)
>  {
>      NvmeIdNs *id_ns = &ns->id_ns;
>  
> -    id_ns->lbaf[0].ds = BDRV_SECTOR_BITS;
> +    id_ns->lbaf[0].ds = ns->params.lbads;
>      id_ns->nuse = id_ns->ncap = id_ns->nsze =
>          cpu_to_le64(nvme_ns_nlbas(ns));
>  
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index b564bac25f6d..f1fe4db78b41 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -7,10 +7,12 @@
>  
>  #define DEFINE_NVME_NS_PROPERTIES(_state, _props) \
>      DEFINE_PROP_DRIVE("drive", _state, blk), \
> -    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0)
> +    DEFINE_PROP_UINT32("nsid", _state, _props.nsid, 0), \
> +    DEFINE_PROP_UINT8("lbads", _state, _props.lbads, BDRV_SECTOR_BITS)

I think we need to validate the parameter is between 9 and 12 before
trusting it can be used safely.

Alternatively, add supported formats to the lbaf array and let the host
decide on a live system with the 'format' command.

