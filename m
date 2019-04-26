Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22123C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF5572077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RN7AcbB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5572077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK1S1-00052z-6e
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 10:03:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Q9-0003u7-25
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hK1Q8-0005j4-39
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:01:45 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:36697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hK1Q7-0005iU-Qb; Fri, 26 Apr 2019 10:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=Kroqf7g8FZDRgISRaqOcdBdSzeD4usGVVEaA/3VO5UU=; 
	b=RN7AcbB/lQLC65ClYX79ax++unCkTON3Alg6g8MB0iCzhGvI7EWfSu+Y1MWOLAJeLvtZdtyjFB7FjhGHD/m9yG4XKFD3dAlmksJMZHB3TFqBNJB7xBdM80pmJ5jt5toBTdAS38nbjGRzLfNk6Kd5KPAs6lryPpyUtKBexzHkrJwGkemPVU41CIHhAbbrIy7A4om+Jz1M9Vu44ac/FTSRIgcZzmMV7n0+QizMUnez477LWH28vMwPjLFhna/TSn/3UK8tO8+0/ZwH6bcUzFVdgwj4ps+UBtnmJl9f5YGah9lhhjx/x6dK8D7nqSHzqC41iBdonHdvu1TRUKzDIiJIWQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hK1Q6-0005jP-L1; Fri, 26 Apr 2019 16:01:42 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hK1Q6-0000Up-Hf; Fri, 26 Apr 2019 16:01:42 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
In-Reply-To: <20190404112953.4058-1-berto@igalia.com>
References: <20190404112953.4058-1-berto@igalia.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Fri, 26 Apr 2019 16:01:42 +0200
Message-ID: <w51y33wg915.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Assert that
 drv->bdrv_child_perm is set in bdrv_child_perm()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426140142.hqUXZxJQ413l7suPkl9iAKK717bjw0uCF5VCqL01sl4@z>

ping

On Thu 04 Apr 2019 01:29:53 PM CEST, Alberto Garcia wrote:
> There is no need to check for this because all block drivers that have
> children implement bdrv_child_perm and all callers already ensure that
> bs->drv is set.
>
> Furthermore, if this check would fail then the callers would end up
> with uninitialized values for nperm and nshared.
>
> This patch replaces the check with an assertion.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/block.c b/block.c
> index 3050854528..5f92565692 100644
> --- a/block.c
> +++ b/block.c
> @@ -1742,11 +1742,10 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
>                              uint64_t parent_perm, uint64_t parent_shared,
>                              uint64_t *nperm, uint64_t *nshared)
>  {
> -    if (bs->drv && bs->drv->bdrv_child_perm) {
> -        bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
> -                                 parent_perm, parent_shared,
> -                                 nperm, nshared);
> -    }
> +    assert(bs->drv && bs->drv->bdrv_child_perm);
> +    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
> +                             parent_perm, parent_shared,
> +                             nperm, nshared);
>      /* TODO Take force_share from reopen_queue */
>      if (child_bs && child_bs->force_share) {
>          *nshared = BLK_PERM_ALL;
> -- 
> 2.11.0

