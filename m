Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:12:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB7F21734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB7F21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGjs-00057u-QK
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iuGiw-0003ti-5I
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iuGiv-0000ie-2w
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:11:14 -0500
Received: from 1.mo6.mail-out.ovh.net ([46.105.56.136]:37299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iuGiu-0000h9-Sg
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:11:13 -0500
Received: from player738.ha.ovh.net (unknown [10.108.42.168])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id BDA231FAFC1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 15:11:10 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id D44F9E9F9F03;
 Wed, 22 Jan 2020 14:11:08 +0000 (UTC)
Date: Wed, 22 Jan 2020 15:11:07 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v4 03/11] 9pfs: validate count sent by client with
 T_readdir
Message-ID: <20200122151107.7b8e5b10@bahia.lan>
In-Reply-To: <3990d3891e8ae2074709b56449e96ab4b4b93b7d.1579567020.git.qemu_oss@crudebyte.com>
References: <cover.1579567019.git.qemu_oss@crudebyte.com>
 <3990d3891e8ae2074709b56449e96ab4b4b93b7d.1579567020.git.qemu_oss@crudebyte.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6340505326727108928
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgdehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.136
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jan 2020 00:50:33 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> A good 9p client sends T_readdir with "count" parameter that's sufficiently
> smaller than client's initially negotiated msize (maximum message size).
> We perform a check for that though to avoid the server to be interrupted
> with a "Failed to encode VirtFS reply type 41" transport error message by
> bad clients. This count value constraint uses msize - 11, because 11 is the
> header size of R_readdir.
> 

This would be worth a comment...

> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index a5fbe821d4..18370183c4 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2426,6 +2426,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
>      int32_t count;
>      uint32_t max_count;
>      V9fsPDU *pdu = opaque;
> +    V9fsState *s = pdu->s;
>  
>      retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
>                             &initial_offset, &max_count);
> @@ -2434,6 +2435,13 @@ static void coroutine_fn v9fs_readdir(void *opaque)
>      }
>      trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
>  

... here. Something like:

    /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */

I can fix this in my tree, and actually done so since I've
applied patches 1 to 3.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    if (max_count > s->msize - 11) {
> +        max_count = s->msize - 11;
> +        warn_report_once(
> +            "9p: bad client: T_readdir with count > msize - 11"
> +        );
> +    }
> +
>      fidp = get_fid(pdu, fid);
>      if (fidp == NULL) {
>          retval = -EINVAL;


