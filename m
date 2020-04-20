Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1802FC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:21:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8B5218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8B5218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQTYQ-0004uT-UO
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53830 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jQTXS-00046l-2M
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:20:30 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jQTXR-0004Q0-76
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:20:29 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:38894)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jQTXQ-0004If-Oq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:20:28 -0400
Received: from player693.ha.ovh.net (unknown [10.108.54.172])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 18BA11623AA
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 12:20:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id D53E81187BFE7;
 Mon, 20 Apr 2020 10:20:12 +0000 (UTC)
Date: Mon, 20 Apr 2020 12:20:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2] 9pfs: local: ignore O_NOATIME if we don't have
 permissions
Message-ID: <20200420122011.26ede955@bahia.lan>
In-Reply-To: <e9bee604e8df528584693a4ec474ded6295ce8ad.1587149256.git.osandov@fb.com>
References: <e9bee604e8df528584693a4ec474ded6295ce8ad.1587149256.git.osandov@fb.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8603845614196070657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrgeefgddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.78.111; envelope-from=groug@kaod.org;
 helo=9.mo68.mail-out.ovh.net
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 06:20:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 46.105.78.111
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Apr 2020 11:48:24 -0700
Omar Sandoval <osandov@osandov.com> wrote:

> From: Omar Sandoval <osandov@fb.com>
> 
> QEMU's local 9pfs server passes through O_NOATIME from the client. If
> the QEMU process doesn't have permissions to use O_NOATIME (namely, it
> does not own the file nor have the CAP_FOWNER capability), the open will
> fail. This causes issues when from the client's point of view, it
> believes it has permissions to use O_NOATIME (e.g., a process running as
> root in the virtual machine). Additionally, overlayfs on Linux opens
> files on the lower layer using O_NOATIME, so in this case a 9pfs mount
> can't be used as a lower layer for overlayfs (cf.
> https://github.com/osandov/drgn/blob/dabfe1971951701da13863dbe6d8a1d172ad9650/vmtest/onoatimehack.c
> and https://github.com/NixOS/nixpkgs/issues/54509).
> 
> Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
> network filesystems. open(2) notes that O_NOATIME "may not be effective
> on all filesystems. One example is NFS, where the server maintains the
> access time." This means that we can honor it when possible but fall
> back to ignoring it.
> 
> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---

Applied to 9p-next.

> Changes from v1:
> 
> * Add comment
> * Add Christian's acked-by
> 
>  hw/9pfs/9p-util.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 79ed6b233e..546f46dc7d 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -37,9 +37,22 @@ static inline int openat_file(int dirfd, const char *name, int flags,
>  {
>      int fd, serrno, ret;
>  
> +again:
>      fd = openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
>                  mode);
>      if (fd == -1) {
> +        if (errno == EPERM && (flags & O_NOATIME)) {
> +            /*
> +             * The client passed O_NOATIME but we lack permissions to honor it.
> +             * Rather than failing the open, fall back without O_NOATIME. This
> +             * doesn't break the semantics on the client side, as the Linux
> +             * open(2) man page notes that O_NOATIME "may not be effective on
> +             * all filesystems". In particular, NFS and other network
> +             * filesystems ignore it entirely.
> +             */
> +            flags &= ~O_NOATIME;
> +            goto again;
> +        }
>          return -1;
>      }
>  


