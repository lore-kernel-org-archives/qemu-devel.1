Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3845C54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C2F20714
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 08:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uob3cSLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C2F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQjj-00061K-Po
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 04:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYQiZ-0004dT-Jz
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:56:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jYQiY-0004XK-H8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 04:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589273809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AfCIc9Aj5OctTTgd0HbsWUlIkGGmvD7poEz+cWiruY=;
 b=Uob3cSLpGDQE+kP5DDSfkBnuZGWx1PIPuvap9YFB2rI+ikwxZu3TqEEG3sLcTu/d1DDVcK
 Ai2zFcTxwY+X61naVdMAeHsO/PW2Z4gZ2VA5MzAp31WD0+bBgJ57Y9J84TAwkBZcjFrnYc
 dvmooiJgpWF3QrbmW4M6l6a6D//gCkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-GGCsg9-KM_m6cnQaCY49Pg-1; Tue, 12 May 2020 04:56:46 -0400
X-MC-Unique: GGCsg9-KM_m6cnQaCY49Pg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1DD460;
 Tue, 12 May 2020 08:56:44 +0000 (UTC)
Received: from localhost (ovpn-112-75.ams2.redhat.com [10.36.112.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60E176298D;
 Tue, 12 May 2020 08:56:37 +0000 (UTC)
Date: Tue, 12 May 2020 09:56:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
Message-ID: <20200512085636.GB300009@stefanha-x1.localdomain>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <8ffca5a79b71ebe0f183707db34f59562faee71f.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8ffca5a79b71ebe0f183707db34f59562faee71f.1587614626.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 09:13:46PM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> Defines mpqemu-link object which forms the communication link between
> QEMU & emulation program.
> Adds functions to configure members of mpqemu-link object instance.
> Adds functions to send and receive messages over the communication
> channel.
> Adds GMainLoop to handle events received on the communication channel.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

This will change a lot when integrated into the QEMU event loop so I've
skipped a lot of the code.

QIOChannel is probably the appropriate object to use instead of directly
accessing a file descriptor.

> +/**
> + * mpqemu_cmd_t:
> + *
> + * proc_cmd_t enum type to specify the command to be executed on the rem=
ote
> + * device.
> + */
> +typedef enum {
> +    INIT =3D 0,
> +    MAX,
> +} mpqemu_cmd_t;
> +
> +/**
> + * MPQemuMsg:
> + * @cmd: The remote command
> + * @bytestream: Indicates if the data to be shared is structured (data1)
> + *              or unstructured (data2)
> + * @size: Size of the data to be shared
> + * @data1: Structured data
> + * @fds: File descriptors to be shared with remote device
> + * @data2: Unstructured data
> + *
> + * MPQemuMsg Format of the message sent to the remote device from QEMU.
> + *
> + */
> +typedef struct {
> +    mpqemu_cmd_t cmd;

Please use an int field on the wire because the C standard says:

  Each enumerated type shall be compatible with char, a signed integer
  type, or an unsigned integer type. The choice of type is
  implementation-defined, but shall be capable of representing the
  values of all the members of the enumeration.

So the compiler may make this a char field (which would introduce
padding before the bytestream field) but if a new enum constant FOO =3D
0x100 is added then the compiler might change the size to 16-bit.

> +int mpqemu_msg_recv(MPQemuMsg *msg, MPQemuChannel *chan)
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
> +    int sock =3D chan->sock;
> +    QemuMutex *lock =3D &chan->recv_lock;
> +
> +    struct iovec iov =3D {
> +        .iov_base =3D (char *) msg,
> +        .iov_len =3D MPQEMU_MSG_HDR_SIZE,
> +    };
> +
> +    memset(&hdr, 0, sizeof(hdr));
> +    memset(&u, 0, sizeof(u));
> +
> +    hdr.msg_iov =3D &iov;
> +    hdr.msg_iovlen =3D 1;
> +    hdr.msg_control =3D &u;
> +    hdr.msg_controllen =3D sizeof(u);
> +
> +    WITH_QEMU_LOCK_GUARD(lock) {
> +        do {
> +            rc =3D recvmsg(sock, &hdr, 0);
> +        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
> +
> +        if (rc < 0) {

Missing rc !=3D MPQEMU_MSG_HDR_SIZE check. If this was a short read we
should not attempt to parse uninitialized bytes in msg.

This is more defensive than relying on catching bogus input values later
on and also protects against accidentally revealing uninitialized memory
contents by observing our error handling response.

> +            qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, "
> +                          "errno is %d, sock %d\n", __func__, rc, errno,=
 sock);
> +            return rc;
> +        }
> +
> +        msg->num_fds =3D 0;
> +        for (chdr =3D CMSG_FIRSTHDR(&hdr); chdr !=3D NULL;
> +             chdr =3D CMSG_NXTHDR(&hdr, chdr)) {
> +            if ((chdr->cmsg_level =3D=3D SOL_SOCKET) &&
> +                (chdr->cmsg_type =3D=3D SCM_RIGHTS)) {
> +                fdsize =3D chdr->cmsg_len - CMSG_LEN(0);
> +                msg->num_fds =3D fdsize / sizeof(int);
> +                if (msg->num_fds > REMOTE_MAX_FDS) {
> +                    qemu_log_mask(LOG_REMOTE_DEBUG,
> +                                  "%s: Max FDs exceeded\n", __func__);
> +                    return -ERANGE;
> +                }
> +
> +                memcpy(msg->fds, CMSG_DATA(chdr), fdsize);
> +                break;
> +            }
> +        }
> +
> +        if (msg->bytestream) {
> +            if (!msg->size) {
> +                qemu_mutex_unlock(lock);

Duplicate unlock, we're already inside WITH_QEMU_LOCK_GUARD().

> +                return -EINVAL;
> +            }
> +
> +            msg->data2 =3D calloc(1, msg->size);

What is the maximum message size? Please pick one and enforce it to
protect against huge allocations that cause us to run out of memory.

> +            data =3D msg->data2;
> +        } else {
> +            data =3D (uint8_t *)&msg->data1;

Adding a uint8_t member to the union eliminates the need for a cast:

  union {
      uint64_t u64;
      uint8_t u8;
  } data1;

  ...

  data =3D &msg->data1.u8;

> +        }
> +
> +        if (msg->size) {
> +            do {
> +                rc =3D read(sock, data, msg->size);
> +            } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAI=
N));
> +        }

Short reads are an error. Please check that the sum of rc values is
equal to msg->size.

> +    }
> +    return rc;
> +}
...
> +bool mpqemu_msg_valid(MPQemuMsg *msg)
> +{
> +    if (msg->cmd >=3D MAX) {
> +        return false;
> +    }

Checking msg->cmd < 0 is also useful here, especially when the field
type is changed to int.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl66ZMMACgkQnKSrs4Gr
c8jdCwf/dlMkEQINt0914ZHENLmfsUZSEK5pb5opZQeQrMqldSbO6ByTODaMzlPf
V/O9DgxqqWq0WCFBrRvbGyn08LidHx363XHchT1gRjgOwhRpYEhMuuoHZIpXhFJS
MlYaUGRVnYqBwP0ZllOETE3HvO5LRnTbPeyr/r5GGXS9/nw+WkNkG3xt8RxlD/kv
AaV1gjb+2E9wFrok6N6aSbZN9IJev+ioJvD5qcJudmZGqxWbzitpRpaSNM+4JbHC
501lWJNE4e5tbE2Tq9kGT51W55bMI7KbFtCqpVvoYFVoxWiA4UDTrZzizI2x/B9n
Yg4NJsneWsIuCn7/wNsTIqjzdeF8xw==
=BtYe
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--


