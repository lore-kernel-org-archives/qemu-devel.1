Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C1C0650E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4C120830
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 09:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4C120830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk3Lq-0006Wo-Cf
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 05:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hk3Ke-0005ty-KW
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hk3Kd-0000D5-EH
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 05:19:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43290)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hk3Ka-0000AT-Nx; Sun, 07 Jul 2019 05:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C71F43086258;
 Sun,  7 Jul 2019 09:19:35 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9D7C18948;
 Sun,  7 Jul 2019 09:19:31 +0000 (UTC)
Message-ID: <bddee5ccfbe7f4cf7fce97d037d7e24bed4a61cb.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jul 2019 12:19:30 +0300
In-Reply-To: <eb7d7240-ec4e-f0d8-2910-261ffe0a1092@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-6-mlevitsk@redhat.com>
 <eb7d7240-ec4e-f0d8-2910-261ffe0a1092@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Sun, 07 Jul 2019 09:19:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] block/nvme: add support for write
 zeros
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-05 at 15:33 +0200, Max Reitz wrote:
> On 03.07.19 17:59, Maxim Levitsky wrote:
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c         | 69 ++++++++++++++++++++++++++++++++++++++++++=
+-
> >  block/trace-events   |  1 +
> >  include/block/nvme.h | 19 +++++++++++-
> >  3 files changed, 87 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 152d27b07f..02e0846643 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
>=20
> [...]
>=20
> > @@ -469,6 +473,11 @@ static void nvme_identify(BlockDriverState *bs, =
int namespace, Error **errp)
> >      s->nsze =3D le64_to_cpu(idns->nsze);
> >      lbaf =3D &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
> > =20
> > +    if (NVME_ID_NS_DLFEAT_WRITE_ZEROS(idns->dlfeat) &&
> > +            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) =3D=3D
> > +                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS)
> > +        bs->supported_write_flags |=3D BDRV_REQ_MAY_UNMAP;
> > +
>=20
> This violates the coding style, there should be curly brackets here.
100% agree + I need to see if we can update the checkpatch.pl to catch th=
is.


>=20
> >      if (lbaf->ms) {
> >          error_setg(errp, "Namespaces with metadata are not yet suppo=
rted");
> >          goto out;
> > @@ -763,6 +772,8 @@ static int nvme_file_open(BlockDriverState *bs, Q=
Dict *options, int flags,
> >      int ret;
> >      BDRVNVMeState *s =3D bs->opaque;
> > =20
> > +    bs->supported_write_flags =3D BDRV_REQ_FUA;
> > +
> >      opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
> >      qemu_opts_absorb_qdict(opts, options, &error_abort);
> >      device =3D qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
> > @@ -791,7 +802,6 @@ static int nvme_file_open(BlockDriverState *bs, Q=
Dict *options, int flags,
> >              goto fail;
> >          }
> >      }
> > -    bs->supported_write_flags =3D BDRV_REQ_FUA;
>=20
> Any reason for this movement?

This is because the nvme_identify checks if the underlying namespace
supports 'discarded data reads back as zeros', and in which case it sets =
the
BDRV_REQ_MAY_UNMAP in bs->supported_write_flags which later allow me to s=
et
'deallocate' bit in the write zeros command which hints the controller
to discard the area.

This was moved to avoid overwriting the value. I could have instead just =
ored the value,
but this way I think is cleaner a bit.



>=20
> >      return 0;
> >  fail:
> >      nvme_close(bs);
> > @@ -1085,6 +1095,60 @@ static coroutine_fn int nvme_co_flush(BlockDri=
verState *bs)
> >  }
> > =20
> > =20
> > +static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
> > +                                              int64_t offset,
> > +                                              int bytes,
> > +                                              BdrvRequestFlags flags=
)
> > +{
> > +    BDRVNVMeState *s =3D bs->opaque;
> > +    NVMeQueuePair *ioq =3D s->queues[1];
> > +    NVMeRequest *req;
> > +
> > +    if (!s->supports_write_zeros) {
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    uint32_t cdw12 =3D ((bytes >> s->blkshift) - 1) & 0xFFFF;
>=20
> Another coding style violation: Variable declarations and other code ma=
y
> not be mixed.
Another bug in checkpatch.pl :-)

>=20
> > +
> > +    NvmeCmd cmd =3D {
> > +        .opcode =3D NVME_CMD_WRITE_ZEROS,
> > +        .nsid =3D cpu_to_le32(s->nsid),
> > +        .cdw10 =3D cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF)=
,
> > +        .cdw11 =3D cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xF=
FFFFFFF),
> > +    };
> > +
> > +    NVMeCoData data =3D {
> > +        .ctx =3D bdrv_get_aio_context(bs),
> > +        .ret =3D -EINPROGRESS,
> > +    };
>=20
> [...]
>=20
> > diff --git a/include/block/nvme.h b/include/block/nvme.h
> > index 3ec8efcc43..65eb65c740 100644
> > --- a/include/block/nvme.h
> > +++ b/include/block/nvme.h
> > @@ -653,12 +653,29 @@ typedef struct NvmeIdNs {
> >      uint8_t     mc;
> >      uint8_t     dpc;
> >      uint8_t     dps;
> > -    uint8_t     res30[98];
> > +
> > +    uint8_t     nmic;
> > +    uint8_t     rescap;
> > +    uint8_t     fpi;
> > +    uint8_t     dlfeat;
> > +
> > +    uint8_t     res30[94];
> >      NvmeLBAF    lbaf[16];
> >      uint8_t     res192[192];
> >      uint8_t     vs[3712];
> >  } NvmeIdNs;
> > =20
> > +
> > +/*Deallocate Logical Block Features*/
> > +#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
> > +#define NVME_ID_NS_DLFEAT_WRITE_ZEROS(dlfeat)     ((dlfeat) & 0x04)
>=20
> Isn=E2=80=99t it bit 3, i.e. 0x08?
Oops, I haven't noticed that 'read behavier' field is 3 bits and not 2!
Thank you very much. I haven't caught this since my device I tested on do=
esn't support this anyway (dlfeat =3D=3D 0)

>=20
> Max
>=20
> > +
> > +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x3)
> > +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
> > +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROS       1
> > +#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
> > +
> > +
> >  #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
> >  #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
> >  #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
> >=20
>=20


Thank you very very much for the review,
	Best regards,
		Maxim Levitsky


