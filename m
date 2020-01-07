Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B75C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B37206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B37206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios95-0003EU-AP
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ios13-00075C-07
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ios11-0000iT-Jb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:47:36 -0500
Received: from 18.mo6.mail-out.ovh.net ([46.105.73.110]:42456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ios10-0000fa-Be
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:47:35 -0500
Received: from player772.ha.ovh.net (unknown [10.108.42.239])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id BA5D41F4AA4
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 17:47:31 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id C95FFE02459E;
 Tue,  7 Jan 2020 16:47:28 +0000 (UTC)
Date: Tue, 7 Jan 2020 17:47:26 +0100
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 1/1] 9p-local.c: always return -1 on error in
 local_unlinkat_common
Message-ID: <20200107174726.5640a059@bahia.lan>
In-Reply-To: <20200107144718.391550-1-danielhb413@gmail.com>
References: <20200107144718.391550-1-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13124333742538463494
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.110
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

I've changed "9p-local.c:" to "9p: local:" which is the usual prefix used for
fsdev backend specific changes.

On Tue,  7 Jan 2020 11:47:18 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> local_unlinkat_common() is supposed to always return -1 on error.
> This is being done by jumps to the 'err_out' label, which is
> a 'return ret' call, and 'ret' is initialized with -1.
> 
> Unfortunately there is a condition in which the function will
> return 0 on error: in a case where flags == AT_REMOVEDIR, 'ret'
> will be 0 when reaching
> 
> map_dirfd = openat_dir(...)
> 
> And, if map_dirfd == -1 and errno != ENOENT, the existing 'err_out'
> jump will execute 'return ret', when ret is still set to zero
> at that point.
> 
> This patch fixes it by changing all 'err_out' labels by
> 'return -1' calls, ensuring that the function will always
> return -1 on error conditions. 'ret' can be left unintialized
> since it's now being used just to store the result of 'unlinkat'
> calls.
> 
> CC: Greg Kurz <groug@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Applied to 9p-next.

Thanks Daniel and feliz ano novo :)

>  hw/9pfs/9p-local.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ca641390fb..de61aca216 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1076,7 +1076,7 @@ out:
>  static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>                                   int flags)
>  {
> -    int ret = -1;
> +    int ret;
>  
>      if (ctx->export_flags & V9FS_SM_MAPPED_FILE) {
>          int map_dirfd;
> @@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>  
>              fd = openat_dir(dirfd, name);
>              if (fd == -1) {
> -                goto err_out;
> +                return -1;
>              }
>              ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
>              close_preserve_errno(fd);
>              if (ret < 0 && errno != ENOENT) {
> -                goto err_out;
> +                return -1;
>              }
>          }
>          map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
> @@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>              ret = unlinkat(map_dirfd, name, 0);
>              close_preserve_errno(map_dirfd);
>              if (ret < 0 && errno != ENOENT) {
> -                goto err_out;
> +                return -1;
>              }
>          } else if (errno != ENOENT) {
> -            goto err_out;
> +            return -1;
>          }
>      }
>  
> -    ret = unlinkat(dirfd, name, flags);
> -err_out:
> -    return ret;
> +    return unlinkat(dirfd, name, flags);
>  }
>  
>  static int local_remove(FsContext *ctx, const char *path)


