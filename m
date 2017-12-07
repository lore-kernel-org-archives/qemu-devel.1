Received: from eggs.gnu.org ([2001:4830:134:3::10]:32961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eMs7N-0001X8-Pp
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fziglio@redhat.com>) id 1eMs7I-0003HN-Rh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:05:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fziglio@redhat.com>) id 1eMs7I-0003G1-Hn
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 04:05:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1782BC05972A
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 09:05:15 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0277118221
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 09:05:15 +0000 (UTC)
Date: Thu, 7 Dec 2017 04:05:14 -0500 (EST)
From: Frediano Ziglio <fziglio@redhat.com>
Message-ID: <2083994092.34289761.1512637514012.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171122135625.16625-1-fziglio@redhat.com>
References: <20171122135625.16625-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] spice: remove QXLWorker interface field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com
Cc: qemu-devel@nongnu.org

ping the series

> 
> This fields points to an old interface that is no more
> used in the current code.
> 
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  hw/display/qxl.c           | 1 -
>  include/ui/spice-display.h | 1 -
>  ui/spice-display.c         | 2 --
>  3 files changed, 4 deletions(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 99365c3e8f..b9fa067f6e 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -518,7 +518,6 @@ static void interface_attach_worker(QXLInstance *sin,
> QXLWorker *qxl_worker)
>      PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
>  
>      trace_qxl_interface_attach_worker(qxl->id);
> -    qxl->ssd.worker = qxl_worker;
>  }
>  
>  static void interface_set_compression_level(QXLInstance *sin, int level)
> diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
> index aaf2019889..6b5c73b21c 100644
> --- a/include/ui/spice-display.h
> +++ b/include/ui/spice-display.h
> @@ -86,7 +86,6 @@ struct SimpleSpiceDisplay {
>      DisplayChangeListener dcl;
>      void *buf;
>      int bufsize;
> -    QXLWorker *worker;
>      QXLInstance qxl;
>      uint32_t unique;
>      pixman_image_t *surface;
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index ad1ceafb3f..85a72fe76a 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -519,7 +519,6 @@ static void interface_attach_worker(QXLInstance *sin,
> QXLWorker *qxl_worker)
>      SimpleSpiceDisplay *ssd = container_of(sin, SimpleSpiceDisplay, qxl);
>  
>      dprint(1, "%s/%d:\n", __func__, ssd->qxl.id);
> -    ssd->worker = qxl_worker;
>  }
>  
>  static void interface_set_compression_level(QXLInstance *sin, int level)
> @@ -1028,7 +1027,6 @@ static void qemu_spice_display_init_one(QemuConsole
> *con)
>  
>      ssd->qxl.base.sif = &dpy_interface.base;
>      qemu_spice_add_display_interface(&ssd->qxl, con);
> -    assert(ssd->worker);
>      qemu_spice_create_host_memslot(ssd);
>  
>      register_displaychangelistener(&ssd->dcl);
