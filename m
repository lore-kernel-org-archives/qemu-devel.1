Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9198C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:55:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B3C218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B3C218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjOgH-0007L4-NM
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42340)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjObh-0003RQ-63
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjOba-0007un-Es
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:50:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjObV-0006tB-CR; Fri, 05 Jul 2019 09:50:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB9C5882EF;
 Fri,  5 Jul 2019 13:50:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B01176AD2D;
 Fri,  5 Jul 2019 13:50:08 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-7-mlevitsk@redhat.com>
 <20190703160754.12361-1-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <456c2c44-6a67-08c4-c1c0-210ac9c50deb@redhat.com>
Date: Fri, 5 Jul 2019 15:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703160754.12361-1-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ywrmSUJVlhpUufmiXiPUwlr6Gvl3ytKDP"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Fri, 05 Jul 2019 13:50:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4] block/nvme: add support for discard
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ywrmSUJVlhpUufmiXiPUwlr6Gvl3ytKDP
Content-Type: multipart/mixed; boundary="PYzIvp4wRjlfLAxel2fTRWhqlv7UBxCzg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>
Message-ID: <456c2c44-6a67-08c4-c1c0-210ac9c50deb@redhat.com>
Subject: Re: [PATCH v4] block/nvme: add support for discard
References: <20190703155944.9637-7-mlevitsk@redhat.com>
 <20190703160754.12361-1-mlevitsk@redhat.com>
In-Reply-To: <20190703160754.12361-1-mlevitsk@redhat.com>

--PYzIvp4wRjlfLAxel2fTRWhqlv7UBxCzg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 18:07, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++++=

>  block/trace-events |  2 ++
>  2 files changed, 83 insertions(+)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 02e0846643..96a715dcc1 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c

[...]

> @@ -460,6 +461,7 @@ static void nvme_identify(BlockDriverState *bs, int=
 namespace, Error **errp)
>                            s->page_size / sizeof(uint64_t) * s->page_si=
ze);
> =20
>      s->supports_write_zeros =3D (idctrl->oncs & NVME_ONCS_WRITE_ZEROS)=
 !=3D 0;
> +    s->supports_discard =3D (idctrl->oncs & NVME_ONCS_DSM) !=3D 0;

Shouldn=E2=80=99t this be le16_to_cpu(idctrl->oncs)?  Same in the previou=
s
patch, now that I think about it.

> =20
>      memset(resp, 0, 4096);
> =20
> @@ -1149,6 +1151,84 @@ static coroutine_fn int nvme_co_pwrite_zeroes(Bl=
ockDriverState *bs,
>  }
> =20
> =20
> +static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
> +                                         int64_t offset,
> +                                         int bytes)
> +{
> +    BDRVNVMeState *s =3D bs->opaque;
> +    NVMeQueuePair *ioq =3D s->queues[1];
> +    NVMeRequest *req;
> +    NvmeDsmRange *buf;
> +    QEMUIOVector local_qiov;
> +    int r;
> +
> +    NvmeCmd cmd =3D {
> +        .opcode =3D NVME_CMD_DSM,
> +        .nsid =3D cpu_to_le32(s->nsid),
> +        .cdw10 =3D 0, /*number of ranges - 0 based*/

I=E2=80=99d make this cpu_to_le32(0).  Sure, there is no effect for 0, bu=
t in
theory this is a variable value, so...

> +        .cdw11 =3D cpu_to_le32(1 << 2), /*deallocate bit*/
> +    };
> +
> +    NVMeCoData data =3D {
> +        .ctx =3D bdrv_get_aio_context(bs),
> +        .ret =3D -EINPROGRESS,
> +    };
> +
> +    if (!s->supports_discard) {
> +        return -ENOTSUP;
> +    }
> +
> +    assert(s->nr_queues > 1);
> +
> +    buf =3D qemu_try_blockalign0(bs, 4096);

I=E2=80=99m not sure whether this needs to be 4096 or whether 16 would su=
ffice,
 but I suppose this gets us the least trouble.

> +    if (!buf) {
> +            return -ENOMEM;

Indentation is off.

> +    }
> +
> +    buf->nlb =3D cpu_to_le32(bytes >> s->blkshift);
> +    buf->slba =3D cpu_to_le64(offset >> s->blkshift);
> +    buf->cattr =3D 0;
> +
> +    qemu_iovec_init(&local_qiov, 1);
> +    qemu_iovec_add(&local_qiov, buf, 4096);
> +
> +    req =3D nvme_get_free_req(ioq);
> +    assert(req);
> +
> +    qemu_co_mutex_lock(&s->dma_map_lock);
> +    r =3D nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
> +    qemu_co_mutex_unlock(&s->dma_map_lock);
> +
> +    if (r) {
> +        req->busy =3D false;
> +        return r;

Leaking buf and local_qiov here.

> +    }
> +
> +    trace_nvme_dsm(s, offset, bytes);
> +
> +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> +
> +    data.co =3D qemu_coroutine_self();
> +    while (data.ret =3D=3D -EINPROGRESS) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    qemu_co_mutex_lock(&s->dma_map_lock);
> +    r =3D nvme_cmd_unmap_qiov(bs, &local_qiov);
> +    qemu_co_mutex_unlock(&s->dma_map_lock);
> +    if (r) {
> +        return r;

Leaking buf and local_qiov here, too.

Max

> +    }
> +
> +    trace_nvme_dsm_done(s, offset, bytes, data.ret);
> +
> +    qemu_iovec_destroy(&local_qiov);
> +    qemu_vfree(buf);
> +    return data.ret;
> +
> +}
> +
> +
>  static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
>                                 BlockReopenQueue *queue, Error **errp)
>  {


--PYzIvp4wRjlfLAxel2fTRWhqlv7UBxCzg--

--ywrmSUJVlhpUufmiXiPUwlr6Gvl3ytKDP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fVY8ACgkQ9AfbAGHV
z0DB5wf/UM9K8BJWH1YhNVP4VU/gitQWsF7bMHgowaTXB+JTbR5bqmrkcCnikhuq
fPvWBtSN5Zop+tlv8adIQ2ZqLzLgc9CtgsLtJCt17uhb1WEQfb0weTxGZs1IxqkR
X8ZZoBQTJzlgeRvqrKjYPGJLq38l6lwuvPDd3HDp8CQJUbLfHHY5M82dnkRsrRj+
iHiEcYt4zsxeJX282oCUbCGYT4Vd6r3A0viH3iQWzEYSwSL1ycHn6y5ljxiNw/eK
AnvwLnnsFBsyEflwMb03C0QCxgBjw2wscKF5AUkuqXvXfg3KIju/nqGhhLoxuIrh
8b//OpBnl+SeEGfHT8JiPyajZ987Aw==
=fx5e
-----END PGP SIGNATURE-----

--ywrmSUJVlhpUufmiXiPUwlr6Gvl3ytKDP--

