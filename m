Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003A8C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B439620833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B439620833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48533 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRckl-0000V3-Lx
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:18:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRcjg-0008Vd-BG
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRcje-0007Q7-9A
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:17:20 -0400
Received: from 20.mo5.mail-out.ovh.net ([91.121.55.239]:57033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRcje-0007NH-28
	for qemu-devel@nongnu.org; Fri, 17 May 2019 09:17:18 -0400
Received: from player799.ha.ovh.net (unknown [10.109.159.139])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 359FE22FA5D
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:17:15 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player799.ha.ovh.net (Postfix) with ESMTPSA id 7AD355DC76B0;
	Fri, 17 May 2019 13:17:12 +0000 (UTC)
Date: Fri, 17 May 2019 15:17:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190517151711.7262e276@bahia.lan>
In-Reply-To: <155774365069.175576.5671141718062840805.stgit@bahia.lan>
References: <155774341935.175576.9256391991091401927.stgit@bahia.lan>
	<155774365069.175576.5671141718062840805.stgit@bahia.lan>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12995699678214265138
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgieefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.121.55.239
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtfs: Fix documentation of -fsdev
 and -virtfs
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 12:34:10 +0200
Greg Kurz <groug@kaod.org> wrote:

> This fixes several things:
> - add "id" description to -virtfs documentation
> - split the description into several lines in both usage and documentation
>   for accurateness and clarity
> - add documentation and usage of the synth fsdriver
> - add "throttling.*" description to -fsdev local
> - add some missing periods
> - add proper reference to the virtfs-proxy-helper(1) manual page
> - document that the virtio device may be either virtio-9p-pci, virtio-9p-ccw
>   or virtio-9p-device, depending on the machine type
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - mention virtfs-proxy-helper(1) change in the changelog
>     - mention virtio-9p-ccw and virtio-9p-device
> ---

Thomas,

Unless you (or anyone else) have some objections, I intend to apply this patch
and issue a pull request in a near future.

Cheers,

--
Greg

>  qemu-options.hx |   93 +++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 66 insertions(+), 27 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 03c50ba0f0b2..fa705b63b157 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1232,26 +1232,35 @@ the write back by pressing @key{C-a s} (@pxref{disk_images}).
>  ETEXI
>  
>  DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
> -    "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
> -    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n"
> +    "-fsdev local,id=id,path=path,security_model=mapped-xattr|mapped-file|passthrough|none\n"
> +    " [,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
>      " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
>      " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
>      " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
>      " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
> -    " [[,throttling.iops-size=is]]\n",
> +    " [[,throttling.iops-size=is]]\n"
> +    "-fsdev proxy,id=id,socket=socket[,writeout=immediate][,readonly]\n"
> +    "-fsdev proxy,id=id,sock_fd=sock_fd[,writeout=immediate][,readonly]\n"
> +    "-fsdev synth,id=id\n",
>      QEMU_ARCH_ALL)
>  
>  STEXI
>  
> -@item -fsdev @var{fsdriver},id=@var{id},path=@var{path},[security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
> +@item -fsdev local,id=@var{id},path=@var{path},security_model=@var{security_model} [,writeout=@var{writeout}][,readonly][,fmode=@var{fmode}][,dmode=@var{dmode}] [,throttling.@var{option}=@var{value}[,throttling.@var{option}=@var{value}[,...]]]
> +@itemx -fsdev proxy,id=@var{id},socket=@var{socket}[,writeout=@var{writeout}][,readonly]
> +@itemx -fsdev proxy,id=@var{id},sock_fd=@var{sock_fd}[,writeout=@var{writeout}][,readonly]
> +@itemx -fsdev synth,id=@var{id}[,readonly]
>  @findex -fsdev
>  Define a new file system device. Valid options are:
>  @table @option
> -@item @var{fsdriver}
> -This option specifies the fs driver backend to use.
> -Currently "local" and "proxy" file system drivers are supported.
> +@item local
> +Accesses to the filesystem are done by QEMU.
> +@item proxy
> +Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +@item synth
> +Synthetic filesystem, only used by QTests.
>  @item id=@var{id}
> -Specifies identifier for this device
> +Specifies identifier for this device.
>  @item path=@var{path}
>  Specifies the export path for the file system device. Files under
>  this path will be available to the 9p client on the guest.
> @@ -1279,48 +1288,76 @@ Enables exporting 9p share as a readonly mount for guests. By default
>  read-write access is given.
>  @item socket=@var{socket}
>  Enables proxy filesystem driver to use passed socket file for communicating
> -with virtfs-proxy-helper
> +with virtfs-proxy-helper(1).
>  @item sock_fd=@var{sock_fd}
>  Enables proxy filesystem driver to use passed socket descriptor for
> -communicating with virtfs-proxy-helper. Usually a helper like libvirt
> -will create socketpair and pass one of the fds as sock_fd
> +communicating with virtfs-proxy-helper(1). Usually a helper like libvirt
> +will create socketpair and pass one of the fds as sock_fd.
>  @item fmode=@var{fmode}
>  Specifies the default mode for newly created files on the host. Works only
>  with security models "mapped-xattr" and "mapped-file".
>  @item dmode=@var{dmode}
>  Specifies the default mode for newly created directories on the host. Works
>  only with security models "mapped-xattr" and "mapped-file".
> +@item throttling.bps-total=@var{b},throttling.bps-read=@var{r},throttling.bps-write=@var{w}
> +Specify bandwidth throttling limits in bytes per second, either for all request
> +types or for reads or writes only.
> +@item throttling.bps-total-max=@var{bm},bps-read-max=@var{rm},bps-write-max=@var{wm}
> +Specify bursts in bytes per second, either for all request types or for reads
> +or writes only.  Bursts allow the guest I/O to spike above the limit
> +temporarily.
> +@item throttling.iops-total=@var{i},throttling.iops-read=@var{r}, throttling.iops-write=@var{w}
> +Specify request rate limits in requests per second, either for all request
> +types or for reads or writes only.
> +@item throttling.iops-total-max=@var{im},throttling.iops-read-max=@var{irm}, throttling.iops-write-max=@var{iwm}
> +Specify bursts in requests per second, either for all request types or for reads
> +or writes only.  Bursts allow the guest I/O to spike above the limit temporarily.
> +@item throttling.iops-size=@var{is}
> +Let every @var{is} bytes of a request count as a new request for iops
> +throttling purposes.
>  @end table
>  
> --fsdev option is used along with -device driver "virtio-9p-pci".
> -@item -device virtio-9p-pci,fsdev=@var{id},mount_tag=@var{mount_tag}
> -Options for virtio-9p-pci driver are:
> +-fsdev option is used along with -device driver "virtio-9p-...".
> +@item -device virtio-9p-@var{type},fsdev=@var{id},mount_tag=@var{mount_tag}
> +Options for virtio-9p-... driver are:
>  @table @option
> +@item @var{type}
> +Specifies the variant to be used. Supported values are "pci", "ccw" or "device",
> +depending on the machine type.
>  @item fsdev=@var{id}
> -Specifies the id value specified along with -fsdev option
> +Specifies the id value specified along with -fsdev option.
>  @item mount_tag=@var{mount_tag}
> -Specifies the tag name to be used by the guest to mount this export point
> +Specifies the tag name to be used by the guest to mount this export point.
>  @end table
>  
>  ETEXI
>  
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
> -    "-virtfs local,path=path,mount_tag=tag,security_model=[mapped-xattr|mapped-file|passthrough|none]\n"
> -    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n",
> +    "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
> +    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
> +    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
> +    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
> +    "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
>      QEMU_ARCH_ALL)
>  
>  STEXI
>  
> -@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
> +@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
> +@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
> +@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
> +@itemx -virtfs synth,mount_tag=@var{mount_tag}
>  @findex -virtfs
>  
> -The general form of a Virtual File system pass-through options are:
> +Define a new filesystem device and expose it to the guest using a virtio-9p-device. The general form of a Virtual File system pass-through options are:
>  @table @option
> -@item @var{fsdriver}
> -This option specifies the fs driver backend to use.
> -Currently "local" and "proxy" file system drivers are supported.
> +@item local
> +Accesses to the filesystem are done by QEMU.
> +@item proxy
> +Accesses to the filesystem are done by virtfs-proxy-helper(1).
> +@item synth
> +Synthetic filesystem, only used by QTests.
>  @item id=@var{id}
> -Specifies identifier for this device
> +Specifies identifier for the filesystem device
>  @item path=@var{path}
>  Specifies the export path for the file system device. Files under
>  this path will be available to the 9p client on the guest.
> @@ -1348,17 +1385,19 @@ Enables exporting 9p share as a readonly mount for guests. By default
>  read-write access is given.
>  @item socket=@var{socket}
>  Enables proxy filesystem driver to use passed socket file for
> -communicating with virtfs-proxy-helper. Usually a helper like libvirt
> -will create socketpair and pass one of the fds as sock_fd
> +communicating with virtfs-proxy-helper(1). Usually a helper like libvirt
> +will create socketpair and pass one of the fds as sock_fd.
>  @item sock_fd
>  Enables proxy filesystem driver to use passed 'sock_fd' as the socket
> -descriptor for interfacing with virtfs-proxy-helper
> +descriptor for interfacing with virtfs-proxy-helper(1).
>  @item fmode=@var{fmode}
>  Specifies the default mode for newly created files on the host. Works only
>  with security models "mapped-xattr" and "mapped-file".
>  @item dmode=@var{dmode}
>  Specifies the default mode for newly created directories on the host. Works
>  only with security models "mapped-xattr" and "mapped-file".
> +@item mount_tag=@var{mount_tag}
> +Specifies the tag name to be used by the guest to mount this export point.
>  @end table
>  ETEXI
>  
> 


