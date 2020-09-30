Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F50BC47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA9C2071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1u5Ooek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA9C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe97-0000dn-IV
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNdvh-00034P-38; Wed, 30 Sep 2020 11:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNdvc-0006fa-Aw; Wed, 30 Sep 2020 11:22:04 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3666520759;
 Wed, 30 Sep 2020 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601479318;
 bh=yswQoqiLQCU5KuopekWmYl+nzUffqD6lN/FZd4aw8/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B1u5OoekBBQkx1+q+1F1MrijcOMLXEexdV0WDGTqXnVc9GfVY6fO65Nx2x/w90rtf
 /vhaCQIVahCKAvf8YLoU0JYp0CGPXCHN7PqPy/EYQSUYgf6fI7k73ormTQZG+hzXd5
 dKEAtWKzVNqz1V0fxoHO/6rFy+JH13fXlN5erVnI=
Date: Wed, 30 Sep 2020 08:21:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v5 03/14] hw/block/nvme: Introduce the Namespace Types
 definitions
Message-ID: <20200930152155.GB516327@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200928023528.15260-1-dmitry.fomichev@wdc.com>
 <20200928023528.15260-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928023528.15260-4-dmitry.fomichev@wdc.com>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 11:21:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Niklas Cassel <niklas.cassel@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 28, 2020 at 11:35:17AM +0900, Dmitry Fomichev wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Define the structures and constants required to implement
> Namespace Types support.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  hw/block/nvme-ns.h   |  2 ++
>  hw/block/nvme.c      |  2 +-
>  include/block/nvme.h | 74 +++++++++++++++++++++++++++++++++++---------
>  3 files changed, 63 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/block/nvme-ns.h b/hw/block/nvme-ns.h
> index 83734f4606..cca23bc0b3 100644
> --- a/hw/block/nvme-ns.h
> +++ b/hw/block/nvme-ns.h
> @@ -21,6 +21,8 @@
>  
>  typedef struct NvmeNamespaceParams {
>      uint32_t nsid;
> +    uint8_t  csi;
> +    QemuUUID uuid;

Neither of these new params are used anywhere in this patch.

