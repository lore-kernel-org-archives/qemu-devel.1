Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7714C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC69821773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="pQ786MQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC69821773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39315 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFHq-0005rm-1N
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:37:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1hJFE7-0002eh-JT
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1hJF0b-0005p1-Ho
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:20:10 -0400
Received: from mail.synology.com ([211.23.38.101]:42594 helo=synology.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuchenlin@synology.com>)
	id 1hJF0Y-0005KW-Al; Wed, 24 Apr 2019 06:20:07 -0400
Received: from _ (localhost [127.0.0.1])
	by synology.com (Postfix) with ESMTPA id 791C41EC50077;
	Wed, 24 Apr 2019 18:19:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1556101194; bh=2nd5wBtJ6g5bAfeZy3+2Pko79kqdIaiN0MBMUbbbu8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=pQ786MQVDvvKYu5bKONFBD758XocDkoaPPI54fjoKS2qyaQAo9hX8CeMMdngOrtQl
	j9fj6y39qcIybKPMsgD8Kl1FeSdW2pNCZun9kRI9FAMOL+9XuQb6UTGdo//ONAA2Ih
	50clRSY5CoMgl/kjZsQ1X3wXslAQTuFghwz2mUtU=
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Date: Wed, 24 Apr 2019 18:19:54 +0800
To: Sam Eiderman <shmuel.eiderman@oracle.com>
In-Reply-To: <20190424074901.31430-2-shmuel.eiderman@oracle.com>
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
	<20190424074901.31430-2-shmuel.eiderman@oracle.com>
Message-ID: <4da5f516c2a2512e87709141f4c2b4e2@synology.com>
X-Sender: yuchenlin@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.23.38.101
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] vmdk: Fix comment
 regarding max l1_size coverage
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: yuchenlin via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: yuchenlin <yuchenlin@synology.com>
Cc: fam@euphon.net, kwolf@redhat.com,
	Qemu-block <qemu-block-bounces+yuchenlin=synology.com@nongnu.org>,
	eyal.moscovici@oracle.com, qemu-block@nongnu.org,
	arbel.moshe@oracle.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424101954.xUvxvDskxkyubEfwxhzWEtlolxwuS_VG9Ej-zg9qcvM@z>

On 2019-04-24 15:49, Sam Eiderman wrote:
> Commit b0651b8c246d ("vmdk: Move l1_size check into vmdk_add_extent")
> extended the l1_size check from VMDK4 to VMDK3 but did not update the
> default coverage in the moved comment.
> 
> The previous vmdk4 calculation:
> 
>     (512 * 1024 * 1024) * 512(l2 entries) * 65536(grain) = 16PB
> 
> The added vmdk3 calculation:
> 
>     (512 * 1024 * 1024) * 4096(l2 entries) * 512(grain) = 1PB
> 
> Adding the calculation of vmdk3 to the comment.
> 
> In any case, VMware does not offer virtual disks more than 2TB for
> vmdk4/vmdk3 or 64TB for the new undocumented seSparse format which is
> not implemented yet in qemu.
> 
> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
> Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
> ---
>  block/vmdk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index de8cb859f8..fc7378da78 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -426,10 +426,15 @@ static int vmdk_add_extent(BlockDriverState *bs,
>          return -EFBIG;
>      }
>      if (l1_size > 512 * 1024 * 1024) {
> -        /* Although with big capacity and small l1_entry_sectors, we 
> can get a
> +        /*
> +         * Although with big capacity and small l1_entry_sectors, we 
> can get a
>           * big l1_size, we don't want unbounded value to allocate the 
> table.
> -         * Limit it to 512M, which is 16PB for default cluster and L2 
> table
> -         * size */
> +         * Limit it to 512M, which is:
> +         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
> +         *            cluster size: 64KB, L2 table size: 512 entries
> +         *     1PB  - for default "ESXi Host Sparse Extent" 
> (VMDK3/vmfsSparse)
> +         *            cluster size: 512B, L2 table size: 4096 entries
> +         */
>          error_setg(errp, "L1 size too big");
>          return -EFBIG;
>      }

The calculation of VMDK3 can be verified in end of page No.9 of the spec 
(https://www.vmware.com/support/developer/vddk/vmdk_50_technote.pdf).

Also the VMDK4 can be checked in the section Grain Table and Grain in 
page No.8 of the spec.

Reviewed-by: yuchenlin <yuchenlin@synology.com>

