Received: from eggs.gnu.org ([209.51.188.92]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glTtK-00053A-Ek
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glTtJ-0005PQ-N8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glTtJ-0005NM-7F
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AE2EC1F89
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:14:47 +0000 (UTC)
Date: Mon, 21 Jan 2019 08:14:37 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190121071437.yp22hr7hczlr23ww@sirius.home.kraxel.org>
References: <20190118173103.4903-1-berrange@redhat.com>
	<20190118173103.4903-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118173103.4903-2-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] display: ensure qxl log_buf is a
 nul terminated string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

>      case QXL_IO_LOG:
> -        trace_qxl_io_log(d->id, d->ram->log_buf);
> +        d->ram->log_buf[sizeof(d->ram->log_buf) - 1] = '\0';
> +        trace_qxl_io_log(d->id, (const char *)d->ram->log_buf);
>          if (d->guestdebug) {

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
