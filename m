Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D82020637
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slS0v0HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D82020637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPc9-0006UV-Lo
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGPZS-0002YC-Hh
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGPZR-0007Mp-13
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:04:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jGPZQ-0007Mh-Pj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:04:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id d5so5425106wrn.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9+KcASz58kIU9KENFl3u0ZOrQBEivXyyrG0O6FfO3eM=;
 b=slS0v0HXLJERc45wk177IDlVHjmhODumYptvd4+RRxTTjXLgM0lNsSzuR5tzlZCHCq
 LVd34Xt3Px7wePS7u+3roh4/o3PsO3RdISymVqES5U1DNpK4+oGrjoUsQ9HnPHMFiGob
 McjXOwIq4cEkp6huB3AoTFylde4ibc9o06m2nbLWIfQ3POt+Jhl76MhLfCjd1QJaDH0d
 KZjGXnXyvFp6wqpI48B/HOGkLp6pyGmUU3wnP+7j388RUIYq+wAFkW7wpKHA+GDb6ouZ
 B3SvO3DgBWhclklV37ds/M+dnSe6pMGe/Nt//AxQguTCs6/5DgezB8p/E8Vd566z2Jkh
 zc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9+KcASz58kIU9KENFl3u0ZOrQBEivXyyrG0O6FfO3eM=;
 b=rdJ6lyJJWLROQ8APaQ0xTZHBEFyNV9Dg1zMea5nju2xpJ9w98ZteoCPd4F+4PZ89so
 CuBDWVPb32tfDfPrwl7zQHP3B6S1WXZGc1x/LQzP7M6KqIGphPZlYhi5g42AzlYz5dEO
 IgLBDPB9IsAPHK24UdFy578uHL1+MA9pXw4CsVfy8PaSIhWLw6beanHvYWmSRVgv5Lgq
 RNDR4nL4GoERPmtMVPbM6GHcjJWK9vsBt0Lcik/XXC+yPLGfcVEf5o+o1FdjdQ4Hm4ul
 N65xOe2brEnoE33Crk/SZjE6MnZ0apeIQj9Fz/4n2v+b+1Agr1GXzBKFkBz8gEcuxG5y
 dJ2g==
X-Gm-Message-State: ANhLgQ1FR22G81PVABaxSsuKYdHQ9j9ZeOmO6VrmD68aA14RldArN7bg
 RfDRIRXBXzh2zYj7KFe8WhI=
X-Google-Smtp-Source: ADFU+vvOfF8leK8HwtGI0RTqgJiGvAaEmg4wNWwIwXbDFcNl6FfrWYADJiw5Dxz++RTKl3NojGCJ7Q==
X-Received: by 2002:adf:e98b:: with SMTP id h11mr11301168wrm.409.1584979495128; 
 Mon, 23 Mar 2020 09:04:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o4sm23938578wrp.84.2020.03.23.09.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:04:53 -0700 (PDT)
Date: Mon, 23 Mar 2020 16:04:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v5 2/5] generic vhost user server
Message-ID: <20200323160451.GB313555@stefanha-x1.localdomain>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
 <20200309100342.14921-3-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20200309100342.14921-3-coiby.xu@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 06:03:39PM +0800, Coiby Xu wrote:
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 6b38b67cf1..d207b5f981 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -37,6 +37,9 @@ util-obj-y += readline.o
>  util-obj-y += rcu.o
>  util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
>  util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
> +ifdef CONFIG_LINUX
> +util-obj-y += vhost-user-server.o
> +endif

Please use the more common form (which is also more concise):

util-obj-$(CONFIG_LINUX) += vhost-user-server.o

> +static bool coroutine_fn
> +vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
> +{
> +    struct iovec iov = {
> +        .iov_base = (char *)vmsg,
> +        .iov_len = VHOST_USER_HDR_SIZE,
> +    };
> +    int rc, read_bytes = 0;
> +    /*
> +     * Store fds/nfds returned from qio_channel_readv_full into
> +     * temporary variables.
> +     *
> +     * VhostUserMsg is a packed structure, gcc will complain about passing
> +     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
> +     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
> +     * thus two temporary variables nfds and fds are used here.
> +     */
> +    size_t nfds = 0, nfds_t = 0;
> +    int *fds = NULL, *fds_t = NULL;
> +    VuClientInfo *client = container_of(vu_dev, VuClientInfo, vu_dev);
> +    QIOChannel *ioc = client->ioc;
> +
> +    Error *local_err = NULL;
> +    assert(qemu_in_coroutine());
> +    do {
> +        /*
> +         * qio_channel_readv_full may have short reads, keeping calling it
> +         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
> +         */
> +        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &local_err);
> +        if (rc < 0) {
> +            if (rc == QIO_CHANNEL_ERR_BLOCK) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +                continue;
> +            } else {
> +                error_report_err(local_err);
> +                return false;
> +            }
> +        }
> +        read_bytes += rc;
> +        fds = g_renew(int, fds_t, nfds + nfds_t);
> +        memcpy(fds + nfds, fds_t, nfds_t);
> +        nfds += nfds_t;
> +        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
> +            break;
> +        }

Does this loop work?  I can't see where iov_base and iov_len are
updated, so I guess the beginning of vmsg would be overwritten instead
of concatenating each readv iteration.

> +    } while (true);
> +    assert(nfds <= VHOST_MEMORY_MAX_NREGIONS);

The client is untrusted.  Please handle errors explicitly and do not
use assertion failures that can be triggered by the client.

> diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
> new file mode 100644
> index 0000000000..1a6b5e4ea9
> --- /dev/null
> +++ b/util/vhost-user-server.h
> @@ -0,0 +1,57 @@

Missing license header and #ifndef VHOST_USER_SERVER_H.

> +#include "contrib/libvhost-user/libvhost-user.h"
> +#include "io/channel-socket.h"
> +#include "io/channel-file.h"
> +#include "io/net-listener.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "standard-headers/linux/virtio_blk.h"
> +
> +typedef struct VuClientInfo VuClientInfo;
> +
> +typedef struct VuServer {
> +    QIONetListener *listener;
> +    AioContext *ctx;
> +    QTAILQ_HEAD(, VuClientInfo) clients;

The convention is that only one client can be connected to a vhost-user
UNIX domain at any given time.

Multiple devices can be exported by creating multiple vhost-user UNIX
domain sockets.

Therefore it seems unnecessary to have a list of connected clients.
Have I misunderstood something?

> +    void (*device_panic_notifier)(struct VuClientInfo *client) ;
> +    int max_queues;
> +    const VuDevIface *vu_iface;
> +    /*
> +     * @ptr_in_device: VuServer pointer memory location in vhost-user device
> +     * struct, so later container_of can be used to get device destruct
> +     */
> +    void *ptr_in_device;

Is this an opaque pointer that the device implementation will use?  If
so, please call it "opaque" and remove the comment.  "opaque" is the
standard name that is used and there is no need to explain it.

> +    bool close;

This field is unused.  Please drop it and introduce it in the patch that
needs it.

> +} VuServer;
> +
> +typedef struct KickInfo {
> +    VuDev *vu_dev;
> +    int fd; /*kick fd*/
> +    long index; /*queue index*/
> +    vu_watch_cb cb;
> +} KickInfo;
> +
> +struct VuClientInfo {

This could be inlined into VuServer since there should only be one
client connected to a vhost-user UNIX domain socket at any given time.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl543iMACgkQnKSrs4Gr
c8j4zgf+KN8kcGD1raiDROeevktjeDIR+sb4pFJnDpi/U1WXk3TvCxpWx5iDPh3D
9rtiQ4w7NRMvcY5/OWYIpHXzwA/DDodY0TTIvD51KrnhQItlOL58SZr2bzj5HZox
tHnvA4FC9pG+P5GR3/aWiFGFdngiErVqk5ko4oK7gqiFcWb04BbItLiklaGQV2BX
B23p6ovNtGSISJx9jpkkMDRI6J2NBi+P6Ec39i446XZ4vOEiHYLAJY96TuChzZ/Z
bMtZkborSxlXtwxUiwvV1tSYecXM7PSRCzLN+MCpzJ8IWPFfwx+NfPoLmahAzy09
p7QJ3AAQeIOg6g6PmrLeEdy+Ziohpw==
=rjAy
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--

