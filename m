Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0811BC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE27C208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 14:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE27C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqHr-0003zO-Qy
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 09:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iopIr-0001Y1-Qs
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iopIq-0002Yq-Lr
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:49 -0500
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:56301)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iopIq-0002Wg-FW
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:53:48 -0500
Received: from player789.ha.ovh.net (unknown [10.109.146.168])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 1987121C1DC
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 14:53:45 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 2CF13DF96870;
 Tue,  7 Jan 2020 13:53:43 +0000 (UTC)
Date: Tue, 7 Jan 2020 14:53:40 +0100
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 44/59] 9p-local.c: remove unneeded label in
 local_unlinkat_common()
Message-ID: <20200107145340.60698c46@bahia.lan>
In-Reply-To: <20200106182425.20312-45-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-45-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10189675636031199494
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehgedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.104.253
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  6 Jan 2020 15:24:10 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> 'err_out' can be replaced by 'return ret' in the error conditions
> the jump was being made.
> 
> CC: Greg Kurz <groug@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/9pfs/9p-local.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ca641390fb..f9bdd2ad7c 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1094,12 +1094,12 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>  
>              fd = openat_dir(dirfd, name);
>              if (fd == -1) {
> -                goto err_out;
> +                return ret;
>              }
>              ret = unlinkat(fd, VIRTFS_META_DIR, AT_REMOVEDIR);
>              close_preserve_errno(fd);
>              if (ret < 0 && errno != ENOENT) {
> -                goto err_out;
> +                return ret;
>              }
>          }
>          map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
> @@ -1107,16 +1107,14 @@ static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
>              ret = unlinkat(map_dirfd, name, 0);
>              close_preserve_errno(map_dirfd);
>              if (ret < 0 && errno != ENOENT) {
> -                goto err_out;
> +                return ret;
>              }
>          } else if (errno != ENOENT) {
> -            goto err_out;
> +            return ret;

Ouch... I now realize we can get there with ret == 0 when unlinking a
directory in mapped-file mode. The function will wrongly return success
despite the failure.... Since this function is supposed to return -1
on error, I suggest to do that instead of return ret, and to drop the
initialization of ret to -1, which wouldn't be needed anymore.

Since this would fix a bug it makes sense to post it separately from
this series. Rewrite the title/changelog accordingly and I'll merge
it via the 9p tree.

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


