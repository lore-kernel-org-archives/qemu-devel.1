Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78439C0650E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:41:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 443782082F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443782082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk3fe-0001KO-Cu
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hk3ex-0000oj-SQ
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hk3ew-00044t-0m
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:40:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hk3es-000400-0g; Sun, 07 Jul 2019 05:40:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD53C85376;
 Sun,  7 Jul 2019 09:40:32 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAA7810018F9;
 Sun,  7 Jul 2019 09:40:28 +0000 (UTC)
Message-ID: <0ed73bd185691405471e94e0d316597df9a39c1c.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jul 2019 12:40:27 +0300
In-Reply-To: <456c2c44-6a67-08c4-c1c0-210ac9c50deb@redhat.com>
References: <20190703155944.9637-7-mlevitsk@redhat.com>
 <20190703160754.12361-1-mlevitsk@redhat.com>
 <456c2c44-6a67-08c4-c1c0-210ac9c50deb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sun, 07 Jul 2019 09:40:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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

On Fri, 2019-07-05 at 15:50 +0200, Max Reitz wrote:
> On 03.07.19 18:07, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c       | 81 ++++++++++++++++++++++++++++++++++++++++++++=
++
> >  block/trace-events |  2 ++
> >  2 files changed, 83 insertions(+)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 02e0846643..96a715dcc1 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
>=20
> [...]
>=20
> > @@ -460,6 +461,7 @@ static void nvme_identify(BlockDriverState *bs, i=
nt namespace, Error **errp)
> >                            s->page_size / sizeof(uint64_t) * s->page_=
size);
> > =20
> >      s->supports_write_zeros =3D (idctrl->oncs & NVME_ONCS_WRITE_ZERO=
S) !=3D 0;
> > +    s->supports_discard =3D (idctrl->oncs & NVME_ONCS_DSM) !=3D 0;
>=20
> Shouldn=E2=80=99t this be le16_to_cpu(idctrl->oncs)?  Same in the previ=
ous
> patch, now that I think about it.

This reminds me of how I basically scrubbed though nvme-mdev looking for =
endiannes bugs,=20
manually searching for every reference to hardware controlled structure.
Thank you very much!!


>=20
> > =20
> >      memset(resp, 0, 4096);
> > =20
> > @@ -1149,6 +1151,84 @@ static coroutine_fn int nvme_co_pwrite_zeroes(=
BlockDriverState *bs,
> >  }
> > =20
> > =20
> > +static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
> > +                                         int64_t offset,
> > +                                         int bytes)
> > +{
> > +    BDRVNVMeState *s =3D bs->opaque;
> > +    NVMeQueuePair *ioq =3D s->queues[1];
> > +    NVMeRequest *req;
> > +    NvmeDsmRange *buf;
> > +    QEMUIOVector local_qiov;
> > +    int r;
> > +
> > +    NvmeCmd cmd =3D {
> > +        .opcode =3D NVME_CMD_DSM,
> > +        .nsid =3D cpu_to_le32(s->nsid),
> > +        .cdw10 =3D 0, /*number of ranges - 0 based*/
>=20
> I=E2=80=99d make this cpu_to_le32(0).  Sure, there is no effect for 0, =
but in
> theory this is a variable value, so...
Let it be.

>=20
> > +        .cdw11 =3D cpu_to_le32(1 << 2), /*deallocate bit*/
> > +    };
> > +
> > +    NVMeCoData data =3D {
> > +        .ctx =3D bdrv_get_aio_context(bs),
> > +        .ret =3D -EINPROGRESS,
> > +    };
> > +
> > +    if (!s->supports_discard) {
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    assert(s->nr_queues > 1);
> > +
> > +    buf =3D qemu_try_blockalign0(bs, 4096);
>=20
> I=E2=80=99m not sure whether this needs to be 4096 or whether 16 would =
suffice,
>  but I suppose this gets us the least trouble.
Exactly. Even better would be now that I think about it to use 's->page_s=
ize', the device page size.
It is at least 4K (spec minimum).

Speaking of which, there is a theoretical bug there - the device in theor=
y can indicate that its minimal page size is larger that 4K.
The kernel currently rejects such devices, but here the driver just force=
s 4K page size in the CC register

>=20
> > +    if (!buf) {
> > +            return -ENOMEM;
>=20
> Indentation is off.
True!

>=20
> > +    }
> > +
> > +    buf->nlb =3D cpu_to_le32(bytes >> s->blkshift);
> > +    buf->slba =3D cpu_to_le64(offset >> s->blkshift);
> > +    buf->cattr =3D 0;
> > +
> > +    qemu_iovec_init(&local_qiov, 1);
> > +    qemu_iovec_add(&local_qiov, buf, 4096);
> > +
> > +    req =3D nvme_get_free_req(ioq);
> > +    assert(req);
> > +
> > +    qemu_co_mutex_lock(&s->dma_map_lock);
> > +    r =3D nvme_cmd_map_qiov(bs, &cmd, req, &local_qiov);
> > +    qemu_co_mutex_unlock(&s->dma_map_lock);
> > +
> > +    if (r) {
> > +        req->busy =3D false;
> > +        return r;
>=20
> Leaking buf and local_qiov here.
True, fixed.

>=20
> > +    }
> > +
> > +    trace_nvme_dsm(s, offset, bytes);
> > +
> > +    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
> > +
> > +    data.co =3D qemu_coroutine_self();
> > +    while (data.ret =3D=3D -EINPROGRESS) {
> > +        qemu_coroutine_yield();
> > +    }
> > +
> > +    qemu_co_mutex_lock(&s->dma_map_lock);
> > +    r =3D nvme_cmd_unmap_qiov(bs, &local_qiov);
> > +    qemu_co_mutex_unlock(&s->dma_map_lock);
> > +    if (r) {
> > +        return r;
>=20
> Leaking buf and local_qiov here, too.
True, fixed - next time will check error paths better.

>=20
> Max
>=20
> > +    }
> > +
> > +    trace_nvme_dsm_done(s, offset, bytes, data.ret);
> > +
> > +    qemu_iovec_destroy(&local_qiov);
> > +    qemu_vfree(buf);
> > +    return data.ret;
> > +
> > +}
> > +
> > +
> >  static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
> >                                 BlockReopenQueue *queue, Error **errp=
)
> >  {
>=20
>=20

Thanks for the review,
	Best regards,
		Maxim Levitsky



