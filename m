Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A5EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB9920873
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 16:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtyOEBL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB9920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBhSt-0002xI-It
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 12:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jBhSG-0002PP-8T
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jBhSE-00023e-5t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jBhSD-00020H-Pm
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 12:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583856601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lWLreIi1AqdTqsZXt7/f4jKx1vCmLHqB9EOtftNCPkw=;
 b=AtyOEBL1imEcCTM4LMWxgqHKVWDYlm6+z58GDRwyqpYZXOY0tlPgiXJO6N2q3vrPEPlQ8E
 XLD1S5yiV5tsvBaCa9l2ZyTbKIT/Hh8p4b21HF7pw7KRPIwY67xg+eAsr9GTIB736dD9Di
 2PS6evG4OjOo/AVrdUr/XrAZdHKHjKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-_lBN8-4_NXeg6jzM9SJvQA-1; Tue, 10 Mar 2020 12:09:57 -0400
X-MC-Unique: _lBN8-4_NXeg6jzM9SJvQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15A3C8C3164;
 Tue, 10 Mar 2020 16:09:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BECAB91D9B;
 Tue, 10 Mar 2020 16:09:42 +0000 (UTC)
Date: Tue, 10 Mar 2020 16:09:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 07/50] multi-process: define mpqemu-link object
Message-ID: <20200310160941.GK140737@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <20ec6f6666cc8adb211642156f5230e478143b81.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20ec6f6666cc8adb211642156f5230e478143b81.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9RxwyT9MtfFuvYYZ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9RxwyT9MtfFuvYYZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2020 at 03:54:58PM -0500, Jagannathan Raman wrote:
> +/*
> + * TODO: Dont use mpqemu link object since it is
> + * not needed to be created via -object.
> + */

Please investigate and resolve this TODO.

> +struct conf_data_msg {
> +    uint32_t addr;
> +    uint32_t val;
> +    int l;

Please use a self-explanatory field name.  I'm not sure what 'l' is.

conf_data_msg is not used in this patch.  Please introduce things when
they are needed to make the patch series easier to review in a linear
fashion.

> +/*
> + * TODO: make all communications asynchronous and run in the main
> + * loop or existing IOThread.
> + */

Please investigate and decide how to resolve this TODO.

> +void mpqemu_msg_send(MPQemuMsg *msg, MPQemuChannel *chan)
> +{
> +    int rc;
> +    uint8_t *data;
> +    union {
> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
> +        struct cmsghdr align;
> +    } u;
> +    struct msghdr hdr;
> +    struct cmsghdr *chdr;
> +    int sock = chan->sock;
> +    QemuMutex *lock = &chan->send_lock;
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
> +
> +    if (msg->num_fds > REMOTE_MAX_FDS) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
> +        return;
> +    }
> +
> +    if (msg->num_fds > 0) {
> +        size_t fdsize = msg->num_fds * sizeof(int);
> +
> +        hdr.msg_control = &u;
> +        hdr.msg_controllen = sizeof(u);
> +
> +        chdr = CMSG_FIRSTHDR(&hdr);
> +        chdr->cmsg_len = CMSG_LEN(fdsize);
> +        chdr->cmsg_level = SOL_SOCKET;
> +        chdr->cmsg_type = SCM_RIGHTS;
> +        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
> +        hdr.msg_controllen = CMSG_SPACE(fdsize);
> +    }
> +
> +    qemu_mutex_lock(lock);
> +
> +    do {
> +        rc = sendmsg(sock, &hdr, 0);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    if (rc < 0) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
> +                      " sock %d\n", __func__, rc, errno, sock);
> +        qemu_mutex_unlock(lock);
> +        return;
> +    }
> +
> +    if (msg->bytestream) {
> +        data = msg->data2;
> +    } else {
> +        data = (uint8_t *)msg + MPQEMU_MSG_HDR_SIZE;
> +    }
> +
> +    do {
> +        rc = write(sock, data, msg->size);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    qemu_mutex_unlock(lock);

Can this lock be avoided by using a single sendmsg(2) syscall instead of
sendmsg() + write()?  I feel deja vu here, like I maybe have raised this
in a previous revision of this patch series.

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

This TODO doesn't seem actionable.  The error is already handled.

> +                qemu_log_mask(LOG_REMOTE_DEBUG,
> +                              "%s: Max FDs exceeded\n", __func__);
> +                return -ERANGE;

The mutex must be released.

--9RxwyT9MtfFuvYYZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5nu8UACgkQnKSrs4Gr
c8hSFAgAtfOfgZfUaSjOvOG4MINCGVUklubwZJOhGBtEtcBEHuMpfwR5zsKG+pBF
NtXBD/Hau0Bd8aSMG9PNgq47bPxuLttNzTqh9fh+n2DoBMXlvyhSLA+47G29QAhv
tbabuRjhQSn/TdLx7t/00vbypHnBHXZAgOUKuchGuNrDKmwMChmK2J9dC5xtayCE
rYxt6QWAbFkJGnc+iQTnp5Fu0sszy0PGOyoLe8fHD0pQOMOdTW3ZKi+7TqcEZ2tE
6exkqzDaYVfVBTdC2/q22ifEnZsbcjy5mXVeLgE2dHStAV3VHYKZ7UY3LkxqouqV
+RJfU+6CnEy1l/UJv/zDH6nR4BChiQ==
=is06
-----END PGP SIGNATURE-----

--9RxwyT9MtfFuvYYZ--


