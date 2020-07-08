Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A1CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED2320775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UleGMWHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED2320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI4u-00049x-I3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtHfk-0005Fo-28
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45966
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtHfh-0002gY-Tb
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KATNAMlZlZJpNmIOw7KWlt2YaqlSsqzegZzmWd+o8Vk=;
 b=UleGMWHgxMnuDVYVQr4PbHQPp3hqxA8nF7VjRaCxa5Qiz0vG8bE8nijopXW/gn1pZoImgl
 8A/+QWbluQkI7YmNgE5BbnMRaW7enJkOT7dtQI1tCMG8Snh370UnKlPpBaAEl987xiSvl3
 d+1PkFAod3p5TI6VrQoTJmUwc+WUuZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-X5svud8kO_CghB98iU3piQ-1; Wed, 08 Jul 2020 08:29:28 -0400
X-MC-Unique: X5svud8kO_CghB98iU3piQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DBAB88C79E;
 Wed,  8 Jul 2020 12:29:27 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E492919C4F;
 Wed,  8 Jul 2020 12:29:26 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:29:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Lin Ma <LMa@suse.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdg==?= =?utf-8?Q?2?= 3/3]
 scsi-disk: Add support for the GET LBA STATUS 16 command
Message-ID: <20200708122925.GF459887@stefanha-x1.localdomain>
References: <20200617103018.18026-1-lma@suse.com>
 <20200617103018.18026-4-lma@suse.com>
 <20200622121403.GB13543@stefanha-x1.localdomain>
 <AM6PR04MB57824A3955C649E2CEBCBFB7C56E0@AM6PR04MB5782.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB57824A3955C649E2CEBCBFB7C56E0@AM6PR04MB5782.eurprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "'fam@euphon.net'" <fam@euphon.net>,
 "'kwolf@redhat.com'" <kwolf@redhat.com>,
 "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
 "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>,
 "'mreitz@redhat.com'" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 09:18:59AM +0000, Lin Ma wrote:
>=20
>=20
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Stefan Hajnoczi <stefanha@redhat.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2020=E5=B9=B46=E6=9C=8822=E6=97=
=A5 20:14
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Lin Ma <LMa@suse.com>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org; fam@euphon.net; kwolf@redhat=
.com;
> > mreitz@redhat.com; pbonzini@redhat.com
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2 3/3] scsi-disk: Add support for the G=
ET LBA STATUS 16
> > command
> >=20
> > On Wed, Jun 17, 2020 at 06:30:18PM +0800, Lin Ma wrote:
> > > Signed-off-by: Lin Ma <lma@suse.com>
> > > ---
> > >  hw/scsi/scsi-disk.c        | 90
> > ++++++++++++++++++++++++++++++++++++++
> > >  include/block/accounting.h |  1 +
> > >  include/scsi/constants.h   |  1 +
> > >  3 files changed, 92 insertions(+)
> > >
> > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c index
> > > 387503e11b..9e3002ddaf 100644
> > > --- a/hw/scsi/scsi-disk.c
> > > +++ b/hw/scsi/scsi-disk.c
> > > @@ -1866,6 +1866,89 @@ static void
> > scsi_disk_emulate_write_data(SCSIRequest *req)
> > >      }
> > >  }
> > >
> > > +typedef struct GetLbaStatusCBData {
> > > +    uint32_t num_blocks;
> > > +    uint32_t is_deallocated;
> > > +    SCSIDiskReq *r;
> > > +} GetLbaStatusCBData;
> > > +
> > > +static void scsi_get_lba_status_complete(void *opaque, int ret);
> > > +
> > > +static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData
> > > +*data, int ret) {
> > > +    SCSIDiskReq *r =3D data->r;
> > > +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> > > +
> > > +    assert(r->req.aiocb =3D=3D NULL);
> > > +
> > > +    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
> > > +                     s->qdev.blocksize,
> > BLOCK_ACCT_GET_LBA_STATUS);
> > > +
> > > +    r->req.aiocb =3D blk_aio_get_lba_status(s->qdev.conf.blk,
> > > +                                          r->req.cmd.lba *
> > s->qdev.blocksize,
> > > +                                          s->qdev.blocksize,
> > > +
> > > +scsi_get_lba_status_complete, data); }
> > > +
> > > +static void scsi_get_lba_status_complete(void *opaque, int ret) {
> > > +    GetLbaStatusCBData *data =3D opaque;
> > > +    SCSIDiskReq *r =3D data->r;
> > > +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> > > +
> > > +    assert(r->req.aiocb !=3D NULL);
> > > +    r->req.aiocb =3D NULL;
> > > +
> > > +    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
> > > +    if (scsi_disk_req_check_error(r, ret, true)) {
> > > +        g_free(data);
> > > +        goto done;
> > > +    }
> > > +
> > > +    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
> > > +    scsi_req_unref(&r->req);
> > > +    g_free(data);
> > > +
> > > +done:
> > > +    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
> > > +}
> > > +
> > > +static void scsi_disk_emulate_get_lba_status(SCSIRequest *req,
> > > +uint8_t *outbuf) {
> > > +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> > > +    GetLbaStatusCBData *data;
> > > +    uint32_t *num_blocks;
> > > +    uint32_t *is_deallocated;
> > > +
> > > +    data =3D g_new0(GetLbaStatusCBData, 1);
> > > +    data->r =3D r;
> > > +    num_blocks =3D &(data->num_blocks);
> > > +    is_deallocated =3D &(data->is_deallocated);
> > > +
> > > +    scsi_req_ref(&r->req);
> > > +    scsi_get_lba_status_complete_noio(data, 0);
> >=20
> > scsi_get_lba_status_complete_noio() looks asynchronous. If the BlockDri=
ver
> > yields in .bdrv_co_block_status() then the operation has not completed =
yet
> > when scsi_get_lba_status_complete_noio() returns. It is not safe to acc=
ess the
> > GetLbaStatusCBData data until the async operation is complete.
> >=20
> > Also, scsi_get_lba_status_complete() calls g_free(data) so there is a
> > use-after-free when *num_blocks and *is_deallocated are accessed.
>=20
> Got it, I'll fill the outbuf[] in the completion function in V3.
>=20
> > These issues can be solved by making this code asynchronous (similar to
> > read/write/flush/discard_zeroes/ioctl). outbuf[] will be filled in in t=
he completion
> > function before g_free(data) is called.
>=20
> I looked into block/io.c, The 'bdrv_co_pdiscard()', the 'bdrv_co_block_st=
atus' and the
> 'bdrv_co_flush()', They look similiar, They called corresponding bs->drv-=
>bdrv_co_*()
> or the bs->drv->bdrv_aio_*() between pair of blk_inc/dec_in_flight():
> The 'bdrv_co_pdiscard()' calls bs->drv->bdrv_co_pdiscard() or bs->drv->bd=
rv_aio_pdiscard()
> The 'bdrv_co_flush()' calls bs->drv->bdrv_co_flush*() or bs->drv->bdrv_ai=
o_flush().
> The 'bdrv_co_block_status' calls bs->drv->bdrv_co_block_status(). qemu co=
ntains the
> coroutine version of block_status, no aio version of block_status.
>=20
> About "making this code asynchronous", Well, In fact I havn't realized ye=
t where the issue is.
> If what you mean is that make the 'bdrv_co_get_lba_status()' asynchronous=
, How about
> directly calling coroutine-based 'bdrv_co_block_status()' instead of 'bdr=
v_block_status()' in it?
> Or could you please suggest more detailed information?
> BTW, IMO the existing BlockDriver->bdrv_co_block_status() is enough, It's=
 not necessary to
> implement a drv->bdrv_aio_get_block_status() in BlockDrivers(say qcow2 or=
 raw), Am I right?

scsi_disk_emulate_get_lba_status() is called outside coroutine context.
It is expected to return without blocking so that other activity can
continue (e.g. the vCPU can continue execution).

scsi_disk_emulate_get_lba_status() cannot fill in outbuf because we may
not have fetched the LBA status yet when it needs to return.

Luckily there are other SCSI commands in scsi_disk_emulate_command()
that are asynchronous. You can follow their model:

  case SYNCHRONIZE_CACHE:
      /* The request is used as the AIO opaque value, so add a ref.  */
      scsi_req_ref(&r->req);
      block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
                       BLOCK_ACCT_FLUSH);
      r->req.aiocb =3D blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r=
);
      return 0;

The request is not completed by scsi_disk_emulate_command(). Instead
blk_aio_flush() launches a flush operation and the SCSI request is
passed along as the argument to the scsi_aio_complete() completion
function.

Something similar is needed for GET_LBA_STATUS. Since there is no
bdrv_aio_block_status() you can create a coroutine instead of an aiocb:

  static void coroutine_fn scsi_co_block_status(void *opaque)
  {
      int ret;

      aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));

      ret =3D bdrv_co_block_status(...);

      ...fill in outbuf...

      scsi_req_complete(&r->req, GOOD);

      aio_context_release(blk_get_aio_context(s->qdev.conf.blk));

      scsi_req_unref(&r->req);
  }

  ...in scsi_disk_emulate_command()...
  scsi_req_ref(&r->req);
  co =3D qemu_coroutine_create(scsi_co_block_status, r);
  aio_co_schedule(blk_get_aio_context(s->qdev.conf.blk), co);
  return 0;

This is just a sketch, I haven't checked the details. The trickiest
issue is probably how to deal with r->req.aiocb, which is normally set
for async requests. It will be necessary to study the code to figure out
a solution because there is no BlockAIOCB in this case (we're using a
coroutine instead).

Stefan

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8FvCUACgkQnKSrs4Gr
c8gjiwf/Uir81NvfMCI4bfMjc8Xcy9QkBBqoNwwPqv0LozdunihtL7T3IZ8CVSiu
w8nWWOTBrVmkJL/6eGV5jjWdTIaJvZFXu/mgEs/kx/67fRoTGf5p/UmwBUY6TjgU
JdXFQz+UuExuVMcBfX7cX+eWtw1OgxAPYCW7dnbDGLdviYIto5Lwo97pkp1Ggc6F
T4tNm73kJD1C/OmvCoxMkq99rhlNs3jpw+XIUYPQ9dO15FPirXbE/hkXXQ1aj/ur
b2Fc8bTZGTaK2u41/WIs+vm/qMjs7j1BBF6HTvJr2qEnUCTasi8uDeG4wJQOEN8q
d+JVtBC0KqRCn6ikSf1SnLG26MwUfg==
=d7AW
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--


