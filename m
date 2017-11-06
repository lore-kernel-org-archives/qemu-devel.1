Received: from eggs.gnu.org ([2001:4830:134:3::10]:48027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhhl-0001sO-Hb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhhg-0004bl-Kb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:44:45 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:53441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBhhg-0004b1-E6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:44:40 -0500
Received: from player737.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id AE73697CE3
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 14:44:36 +0100 (CET)
Date: Mon, 6 Nov 2017 14:44:22 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106144422.4bda119f@bahia>
In-Reply-To: <20170929111323.6308-4-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-4-michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/18] Disable the proxy fsdev under
 Windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Fri, 29 Sep 2017 13:13:08 +0200
Michael Fritscher <michael@fritscher.net> wrote:
> Signed-off-by: Michael Fritscher <michael@fritscher.net>

What's the justification for this patch ?

> ---
>  fsdev/qemu-fsdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 266e442b87..9f6d33365d 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -26,7 +26,9 @@ static FsDriverTable FsDrivers[] = {
>      { .name = "handle", .ops = &handle_ops},
>  #endif
>      { .name = "synth", .ops = &synth_ops},
> +#ifndef WIN32
>      { .name = "proxy", .ops = &proxy_ops},
> +#endif
>  };
> 
>  int qemu_fsdev_add(QemuOpts *opts)
