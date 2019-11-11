Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88268C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D5320674
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJAQrahv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D5320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCma-0004uf-D1
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iUCkk-0002v4-CI
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iUCkh-0006DW-HY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:41:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iUCkh-0006DJ-5f
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573490478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XdMFE+QgLIQ0uhLAHL3L6SozjI9pLRgAuzC+2n4JEXg=;
 b=XJAQrahvq+b8tMDThmYJtCnTYvKkhLISWSYptnTf/V9/Sk1NUma5njwLkPN3AhlMGaGfrM
 WNW8e/WL16I91nzTw4fpBVqRCkPSpLvWSBLAZfea2aTbWcn774WRXZmg6+VpiXFIzu6QxV
 cw/mGYaceu4BaEn/vSMZZMCgsnnNk2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-vRDWi5hIOyi1C3ehQJnZqg-1; Mon, 11 Nov 2019 11:41:15 -0500
X-MC-Unique: vRDWi5hIOyi1C3ehQJnZqg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B3B100551B;
 Mon, 11 Nov 2019 16:41:13 +0000 (UTC)
Received: from localhost (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DAE3B60156;
 Mon, 11 Nov 2019 16:41:06 +0000 (UTC)
Date: Mon, 11 Nov 2019 16:41:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 07/49] multi-process: define mpqemu-link object
Message-ID: <20191111164105.GK402228@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b0bc2a517b0a41eb138ed4127aebe8a3952daec6.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rex5+51txc1ort/q"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, ross.lagerwall@citrix.com,
 kanth.ghatraju@oracle.com, kraxel@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, liran.alon@oracle.com, marcandre.lureau@gmail.com,
 mreitz@redhat.com, dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Rex5+51txc1ort/q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:08:48AM -0400, Jagannathan Raman wrote:
> +int mpqemu_msg_recv(MPQemuLinkState *s, MPQemuMsg *msg, MPQemuChannel *chan)
> +{
> +    int rc;
> +    uint8_t *data;
> +    union {
> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
> +        struct cmsghdr align;
> +    } u;
> +    struct msghdr hdr;
> +    struct cmsghdr *chdr;
> +    size_t fdsize;
> +    int sock = chan->sock;
> +    QemuMutex *lock = &chan->recv_lock;
> +
> +    struct iovec iov = {
> +        .iov_base = (char *) msg,
> +        .iov_len = MPQEMU_MSG_HDR_SIZE,
> +    };
> +
> +    memset(&hdr, 0, sizeof(hdr));
> +    memset(&u, 0, sizeof(u));
> +
> +    hdr.msg_iov = &iov;
> +    hdr.msg_iovlen = 1;
> +    hdr.msg_control = &u;
> +    hdr.msg_controllen = sizeof(u);
> +
> +    qemu_mutex_lock(lock);
> +
> +    do {
> +        rc = recvmsg(sock, &hdr, 0);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    if (rc < 0) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
> +                      " sock %d\n", __func__, rc, errno, sock);
> +        qemu_mutex_unlock(lock);
> +        return rc;
> +    }
> +
> +    msg->num_fds = 0;
> +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
> +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
> +        if ((chdr->cmsg_level == SOL_SOCKET) &&
> +            (chdr->cmsg_type == SCM_RIGHTS)) {
> +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
> +            msg->num_fds = fdsize / sizeof(int);
> +            if (msg->num_fds > REMOTE_MAX_FDS) {
> +                /*
> +                 * TODO: Security issue detected. Sender never sends more
> +                 * than REMOTE_MAX_FDS. This condition should be signaled to
> +                 * the admin
> +                 */
> +                qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
> +                return -ERANGE;
> +            }
> +
> +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
> +            break;
> +        }
> +    }
> +
> +    if (msg->size && msg->bytestream) {
> +        msg->data2 = calloc(1, msg->size);
> +        data = msg->data2;
> +    } else {
> +        data = (uint8_t *)&msg->data1;
> +    }
> +
> +    if (msg->size) {
> +        do {
> +            rc = read(sock, data, msg->size);
> +        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +    }
> +
> +    qemu_mutex_unlock(lock);
> +
> +    return rc;
> +}

This code is still insecure.  Until the communication between processes
is made secure this series does not meet its goal of providing process
isolation.

1. An attacker can overflow msg->data1 easily by setting msg->size but
   not msg->bytestream.
2. An attacker can allocate data2, all mpqemu_msg_recv() callers
   need to free it to prevent memory leaks.
3. mpqemu_msg_recv() callers generally do not validate untrusted msg
   fields.  All the code needs to be audited.

Stefan

--Rex5+51txc1ort/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3JjyEACgkQnKSrs4Gr
c8g+qgf/dMOSi4N9PQLrsAN0C1/9EvLCJ+Fy21aS96Q7t0cyavoSSrnOEsWnB5Ey
rCt7XAHIZfE49RrFsZYI3taDMOy+cNDjQzT2sujgVvAKlUuSnsqbPkE/YHFHxOzc
xRIo3Y1eZx6n7ediHGDmtOgboxrs6DOWHyus+VbzIDjyAmNUqkk2LGQTtjZa+v/k
JC5LFTeitesPz2I6Y7IWA7DpX0uQTG5Th2exNz2UvpunvE2Rkps53FWlFbkeiKe+
RnAq/ycVDpBE7SPiNxr9EuhZnMCF6cb0D9LaRO1bm7cU30lCT+VEkFUdH5SxDZT1
JD2Jl2bC5u+44hZdRKAyDulSfrYTPg==
=RKF2
-----END PGP SIGNATURE-----

--Rex5+51txc1ort/q--


