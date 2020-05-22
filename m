Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12172C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0BF0206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="J3UdL6hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BF0206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6uH-0003IV-Vc
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jc6tX-0001wW-3E
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:35:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:40463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jc6tV-0004lO-Aa
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=s+1V0pEB50rYRyIwA7wXYUGxsJPR+9Evou9xWslXhjc=; b=J3UdL6hblWlKgIeR5YCdzqh2YB
 AcVpmmmPEFpEszSmLPMFap56pZLeCwTDHI010ay7Hy+kL3KFNeLMaJxLFS/vKPiAZBMwqwPF94Mj+
 T0LeO9QY7d4H7GKYH/QTSQrmvYZbVaRYObAZlzZEh8K2rR2jPnStHNGA6x8ORlwNr+6mMYSU6dpGO
 ClwwCn0F6989Pp6C7Q2KRWX6QZhojQhcZCHO/gK5LJZFE9b8+CBqnz96DnsUmx9Ko36vp4tkyZpQn
 ycJc9RyGRdLg8dgRCchZfmvJXh/TcEqsDL/GWLcKXVM1FLz48HM3oVf3w4q0oURYhlfzjPt+wNkti
 MPjwTFd9i16gzSAzdVr+SzDkGEKMGvSOjIDoEFEvTF9Df3BuIIIjKmPjKAxTSwe3d1XU/pOxh40Da
 8JCRLRnIadMDI+OU5FuHfiRXHJdRo6ErgjTJYfCVYSFKg2ybnsyUl0gh6naXkrvGU4pRBaT4NN/lN
 Vt1ZrTV+Is5hIWau85WFk9IgR2jZBeumnK3rK7m9n8dnvIr4tV8pC4EK4EPch8ulg3LCsaYZtSX9a
 GHm2HUcRyQvSM87ppQWpy9zqLBcrHyzlAgemT12dWXLsooejp/r22dQMhoDIs/3ISUVKtTspkOjhe
 Z/g05J/stnIWdFHUQQ7FBmQdGyBE+qOP+KP4DZfWg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, groug@kaod.org, paul@xen.org,
 anthony.perard@citrix.com, Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 3/3] xen/9pfs: increase max ring order to 9
Date: Fri, 22 May 2020 14:35:07 +0200
Message-ID: <33834763.32Gg69QpJT@silver>
In-Reply-To: <20200521192627.15259-3-sstabellini@kernel.org>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
 <20200521192627.15259-3-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:35:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 21. Mai 2020 21:26:27 CEST Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> The max order allowed by the protocol is 9. Increase the max order
> supported by QEMU to 9 to increase performance.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---
> Changes in v2:
> - patch added
> ---

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/xen-9p-backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 3c84c86ab8..a969fcc54c 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -21,7 +21,7 @@
> 
>  #define VERSIONS "1"
>  #define MAX_RINGS 8
> -#define MAX_RING_ORDER 8
> +#define MAX_RING_ORDER 9
> 
>  typedef struct Xen9pfsRing {
>      struct Xen9pfsDev *priv;

Best regards,
Christian Schoenebeck



