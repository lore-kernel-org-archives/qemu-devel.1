Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B1C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 22:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE54206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 22:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZqfD3js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE54206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYGdX-0003Ww-Gd
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 18:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYGcS-0002Oy-GG
 for qemu-devel@nongnu.org; Mon, 11 May 2020 18:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jYGcR-0004AM-Kn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 18:09:52 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 19E4E2070B;
 Mon, 11 May 2020 22:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589234990;
 bh=92PqnuJXJjKAj0ya7kaCm2zsMKqVqFDfdxaY0D+5CaA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=LZqfD3jsJW9IvmGI1qdOb3qYUu12NiKGlj1qgrqT1e+J3okovN4GF9k5FmAOlDH2s
 AO64JhR6gzcGP2Ri+ihhRvUIeyhJ5KCF/WCtTCnqG3DhoPZBifTWFH4PQb7BhrREp1
 12p1m8NpAnbT6lSFQjODTjw6+QvXJ3MLZf3MANV4=
Date: Mon, 11 May 2020 15:09:49 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/2] xen-9pfs: Fix log messages of reply errors
In-Reply-To: <ad0e5a9b6abde52502aa40b30661d29aebe1590a.1589132512.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.21.2005111450110.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589132512.git.qemu_oss@crudebyte.com>
 <ad0e5a9b6abde52502aa40b30661d29aebe1590a.1589132512.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 18:09:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 10 May 2020, Christian Schoenebeck wrote:
> If delivery of some 9pfs response fails for some reason, log the
> error message by mentioning the 9P protocol reply type, not by
> client's request type. The latter could be misleading that the
> error occurred already when handling the request input.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  hw/9pfs/xen-9p-backend.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 18fe5b7c92..f04caabfe5 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -137,7 +137,8 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
>      ret = v9fs_iov_vmarshal(in_sg, num, offset, 0, fmt, ap);
>      if (ret < 0) {
>          xen_pv_printf(&xen_9pfs->xendev, 0,
> -                      "Failed to encode VirtFS request type %d\n", pdu->id + 1);
> +                      "Failed to encode VirtFS reply type %d\n",
> +                      pdu->id + 1);
>          xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
>          xen_9pfs_disconnect(&xen_9pfs->xendev);
>      }
> @@ -201,9 +202,9 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>  
>      buf_size = iov_size(ring->sg, num);
>      if (buf_size  < P9_IOHDRSZ) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> -                "needs %zu bytes, buffer has %zu, less than minimum\n",
> -                pdu->id, *size, buf_size);
> +        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
> +                      "%zu bytes, buffer has %zu, less than minimum\n",
> +                      pdu->id + 1, *size, buf_size);
>          xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
>          xen_9pfs_disconnect(&xen_9pfs->xendev);
>      }
> -- 
> 2.20.1
> 

