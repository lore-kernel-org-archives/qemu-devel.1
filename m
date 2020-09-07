Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF53AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C71C620C09
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C71C620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDvL-0000oB-RP
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFDuf-0000NK-97
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:58:13 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:51767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kFDud-0007XT-7u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:58:12 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.114])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 64F965EBAE2F;
 Mon,  7 Sep 2020 11:58:00 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 7 Sep 2020
 11:57:59 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002df401f21-bd7e-4546-9ca5-accde4dfa796,
 FB6B05930862AC66219C483F6F551C079519CC1C) smtp.auth=groug@kaod.org
Date: Mon, 7 Sep 2020 11:57:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [SPAM] [PATCH] 9pfs: disable msize warning for synth driver
Message-ID: <20200907115758.70366924@bahia.lan>
In-Reply-To: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
References: <E1kEyDy-0006nN-5A@lizzy.crudebyte.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 08ff76fb-3e7e-4b36-8778-5eb238c41c2c
X-Ovh-Tracer-Id: 299489376638572954
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgihesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptefgffffgffgkeegffetkefhhfeuleffvdehvdfgtdfhiedutedvudelgfevveetnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:58:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 6 Sep 2020 18:50:32 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Previous patch introduced a performance warning being logged on host
> side if client connected with an 'msize' <= 8192. Disable this
> performance warning for the synth driver to prevent that warning from
> being printed whenever the 9pfs (qtest) test cases are running.
> 
> Introduce a new export flag V9FS_NO_PERF_WARN for that purpose, which
> might also be used to disable such warnings from the CLI in future.
> 
> We could have also prevented the warning by simply raising P9_MAX_SIZE
> in virtio-9p-test.c to any value larger than 8192, however in the
> context of test cases it makes sense running for edge cases, which
> includes the lowest 'msize' value supported by the server which is
> 4096, hence we want to preserve an msize of 4096 for the test client.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Heh, yes I guess it makes sense :)

I guess you could maybe queue this patch before the other one.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  fsdev/file-op-9p.h | 4 ++++
>  hw/9pfs/9p-synth.c | 2 ++
>  hw/9pfs/9p.c       | 2 +-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index f2f7772c86..d51cec2f3b 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -64,6 +64,10 @@ typedef struct ExtendedOps {
>   */
>  #define V9FS_REMAP_INODES           0x00000200
>  #define V9FS_FORBID_MULTIDEVS       0x00000400
> +/*
> + * Disables certain performance warnings from being logged on host side.
> + */
> +#define V9FS_NO_PERF_WARN           0x00000800
>  
>  #define V9FS_SEC_MASK               0x0000003C
>  
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 7eb210ffa8..cec8c0eefc 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -541,6 +541,8 @@ static int synth_init(FsContext *ctx, Error **errp)
>      QLIST_INIT(&synth_root.child);
>      qemu_mutex_init(&synth_mutex);
>  
> +    ctx->export_flags |= V9FS_NO_PERF_WARN;
> +
>      /* Add "." and ".." entries for root */
>      v9fs_add_dir_node(&synth_root, synth_root.attr->mode,
>                        "..", synth_root.attr, synth_root.attr->inode);
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 99b6f24fd6..741d222c3f 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1354,7 +1354,7 @@ static void coroutine_fn v9fs_version(void *opaque)
>      }
>  
>      /* 8192 is the default msize of Linux clients */
> -    if (s->msize <= 8192) {
> +    if (s->msize <= 8192 && !(s->ctx.export_flags & V9FS_NO_PERF_WARN)) {
>          warn_report_once(
>              "9p: degraded performance: a reasonable high msize should be "
>              "chosen on client/guest side (chosen msize is <= 8192). See "


