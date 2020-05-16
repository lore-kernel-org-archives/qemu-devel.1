Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151DFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 10:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3AB20728
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 10:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="EGR1TqpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3AB20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZu4R-0001wc-1x
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 06:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZu3j-0001HE-OV
 for qemu-devel@nongnu.org; Sat, 16 May 2020 06:28:47 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:33109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jZu3i-0007Gq-A5
 for qemu-devel@nongnu.org; Sat, 16 May 2020 06:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XpOhw97F8mFZL2kXOTqunDjxpTGiRj5Zs3yGovQCRnk=; b=EGR1TqpBAqMnc7g1eL1MQBNRem
 25EojQ6fMM/97u7w3uQtfOKRud3IPK8bY69CLH43A0kUBXNVgJos2n1XhNGTkQNf8+cytfJrNw5tj
 ahX9fM4QIkGrv1IpMo/3Vkrb49FNUct8/p4/4//miMpZtAIcSIH2DGQInPVlwEeHn7mvWTAkLH1xK
 No8wFKTJdJ9Zf3kqGHxBjJEMngWGPYC4/dsVA7y4cr269bZkVpC5F/iHf3amnoMIrS1D2WShbD6vS
 faPnERPXM8PBPZe1jq+Bd7iuDBIKRV6PXEqAOfQSNBTm45dwrtvGtSEiBKj7d99GAqCye7UskTwgg
 ujPQvmWhyTf1isD3seuOo573NRJln6H3D27owGTmyvLkOrV6uY5eAoMADeTFPi4FWHrjNnK0A7evX
 1nZxD4HDgCaLhUlxPD03AhXX6hVBwycAoEIcBhTUXWKL542fbBeb2rhPKT8GQIrDFT8PIBr5Azswu
 PzAr2n0ve2ktJdC/75ZRCK9Jgl23X7dto56qBLm1nDFxOUd3cwcvyfWXeRx1S03ksL7stLmw+KZD+
 KSiotYjDk5Qle60Y5oNjhdS4tyiQZBtBya42iNWFsOkV2lS8mm2NlrP/IHSujVzSX3hFM7lSUeu1e
 fcjwiC0P6nCXStTTSbzi0ewoSrBd4SzNA7Jn7N+rU=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Dan Robertson <dan@dlrobertson.com>, Greg Kurz <groug@kaod.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/1] 9pfs: include linux/limits.h for XATTR_SIZE_MAX
Date: Sat, 16 May 2020 12:28:16 +0200
Message-ID: <1618865.Jf4vGVxVId@silver>
In-Reply-To: <20200515203015.7090-2-dan@dlrobertson.com>
References: <20200515203015.7090-1-dan@dlrobertson.com>
 <20200515203015.7090-2-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 06:28:43
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

On Freitag, 15. Mai 2020 22:30:15 CEST Dan Robertson wrote:
> linux/limits.h should be included for the XATTR_SIZE_MAX definition used
> by v9fs_xattrcreate.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  hw/9pfs/9p.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index a2a14b5979..68c2df7333 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/qtest.h"
>  #include "qemu/xxhash.h"
>  #include <math.h>
> +#include <linux/limits.h>
> 
>  int open_fd_hw;
>  int total_open_fd;

Usually I would say that should be wrapped in some OS conditional way, but as 
usage of XATTR_SIZE_MAX is currently not in 9p code either, it's Ok for now.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Best regards,
Christian Schoenebeck



