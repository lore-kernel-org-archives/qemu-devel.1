Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B4C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 18:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDAD2087F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 18:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDAD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44476 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNLwq-0003tW-9d
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 14:33:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNLvz-0003aa-Qf
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNLvy-0006oE-L7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:32:23 -0400
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:34499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNLvy-0006Ua-Fg
	for qemu-devel@nongnu.org; Sun, 05 May 2019 14:32:22 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.5])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id ECE591E62F4
	for <qemu-devel@nongnu.org>; Sun,  5 May 2019 20:32:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id 4A944550F33C;
	Sun,  5 May 2019 18:32:10 +0000 (UTC)
Date: Sun, 5 May 2019 20:32:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190505203208.684776c0@bahia.lan>
In-Reply-To: <20190505144527.27926-1-thuth@redhat.com>
References: <20190505144527.27926-1-thuth@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3182919040220830002
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrjeehgddufeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.98.131
Subject: Re: [Qemu-devel] [PATCH] virtfs: Add missing "id" parameter in
 documentation
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505183208.iah8EkBsNkbYXOafeSdaWH-oowWvPa1KvZ-E3vdmlXk@z>

Hi Thomas,

Thanks for the janitoring :)

On Sun,  5 May 2019 16:45:27 +0200
Thomas Huth <thuth@redhat.com> wrote:

> ... and remove the square brackets from "path" and "security_model",
> since these parameters are not optional.
> 

Well this is only true when fsdriver == local, but the other fs drivers,
ie. proxy and synth, don't need it at all. Each driver has its own set of
options actually. This should better be described with separate lines IMHO.

Also, it should be stated that "id" relates to the fs backend, ie. it
belongs to the -fsdev "id" space, not to the device that gets exposed
to the guest.

Cheers,

--
Greg

> Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 51802cbb26..9571ddd141 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1311,7 +1311,7 @@ DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>  
>  STEXI
>  
> -@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
> +@item -virtfs @var{fsdriver},path=@var{path},mount_tag=@var{mount_tag},security_model=@var{security_model}[,id=@var{id}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
>  @findex -virtfs
>  
>  The general form of a Virtual File system pass-through options are:


