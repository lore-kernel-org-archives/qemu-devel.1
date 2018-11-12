Received: from eggs.gnu.org ([2001:4830:134:3::10]:47724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMGR1-0002xO-Ur
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gMGQY-00083v-M8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:55:25 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gMGQY-0007wL-9D
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:55:10 -0500
Received: from player778.ha.ovh.net (unknown [10.109.143.3])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 459F81BFD82
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 18:55:07 +0100 (CET)
Date: Mon, 12 Nov 2018 18:54:59 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181112185459.55d27dc9@bahia.lan>
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC96A40@DGGEML532-MBX.china.huawei.com>
References: <A02D6AA901860840B46E751C5E9E38B42AFDB15F@DGGEML532-MBX.china.huawei.com>
	<A02D6AA901860840B46E751C5E9E38B43CC96A40@DGGEML532-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-9p:  fix coding style issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "berto@igalia.com" <berto@igalia.com>, "armbru@redhat.com" <armbru@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>

On Mon, 12 Nov 2018 01:12:33 +0000
xiezhide <xiezhide@huawei.com> wrote:

> fix two coding style issue
> 

These coding style issues seem to come from patch 1... It is weird to
introduce coding style nits and to fix them afterwards. Just avoid
them in the first place (./scripts/checkpatch.pl is your friend).

> Signed-off-by: x00390961 <xiezhide@huawei.com<mailto:xiezhide@huawei.com>>
> ---
>  fsdev/qemu-fsdev-throttle.c      | 2 +-
>  include/qemu/throttle-options.h   | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 7d313f2..fa2b0c8 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -116,7 +116,7 @@ void fsdev_get_io_throttle(FsThrottle *fst, FsdevIOThrottle **fs9pcfg,
>      ThrottleLimits *tlimits;
>      FsdevIOThrottle *fscfg = g_malloc(sizeof(*fscfg));
>      tlimits = qapi_FsdevIOThrottle_base(fscfg);
> -     fscfg->has_id = true;
> +    fscfg->has_id = true;
>      fscfg->id = g_strdup(fsdevice);
>      throttle_config_to_limits(&cfg, tlimits);
>      *fs9pcfg = fscfg;
> diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
> index 7134690..3eb1825 100644
> --- a/include/qemu/throttle-options.h
> +++ b/include/qemu/throttle-options.h
> @@ -111,6 +111,5 @@
>              .type = QEMU_OPT_NUMBER,\
>              .help = "when limiting by iops max size of an I/O in bytes",\
>          }
> -

I'd rather keep this blank line for better readability.

>      void throttle_parse_options(ThrottleConfig *, QemuOpts *);
>  #endif
> --
> 1.8.3.1
> 
