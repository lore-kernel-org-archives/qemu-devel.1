Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC20C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 596AB20679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596AB20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htZig-0004LB-1c
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htZi0-0003Yj-5c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htZhy-0003ij-NH
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 11:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htZhv-0003gN-O6; Fri, 02 Aug 2019 11:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37048307D934;
 Fri,  2 Aug 2019 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-107.ams2.redhat.com
 [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C895C600D1;
 Fri,  2 Aug 2019 15:42:57 +0000 (UTC)
Date: Fri, 2 Aug 2019 17:42:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190802154256.GE6379@localhost.localdomain>
References: <20190725091900.30542-1-vsementsov@virtuozzo.com>
 <20190725091900.30542-2-vsementsov@virtuozzo.com>
 <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <2a105159-ab90-8f7c-bba9-4cec27e6144c@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 15:43:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/9] block: add
 .bdrv_need_rw_file_child_during_reopen_rw handler
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
Cc: fam@euphon.net, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 31.07.2019 um 14:09 hat Max Reitz geschrieben:
> On 25.07.19 11:18, Vladimir Sementsov-Ogievskiy wrote:
> > On reopen to rw parent may need rw access to child in .prepare, for
> > example qcow2 needs to write IN_USE flags into stored bitmaps
> > (currently it is done in a hacky way after commit and don't work).
> > So, let's introduce such logic.
> >=20
> > The drawback is that in worst case bdrv_reopen_set_read_only may finish
> > with error and in some intermediate state: some nodes reopened RW and
> > some are not. But this is a way to fix bug around reopening qcow2
> > bitmaps in the following commits.
>=20
> This commit message doesn=E2=80=99t really explain what this patch does.
>=20
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  include/block/block_int.h |   2 +
> >  block.c                   | 144 ++++++++++++++++++++++++++++++++++----
> >  2 files changed, 133 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 3aa1e832a8..7bd6fd68dd 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -531,6 +531,8 @@ struct BlockDriver {
> >                               uint64_t parent_perm, uint64_t parent_sha=
red,
> >                               uint64_t *nperm, uint64_t *nshared);
> > =20
> > +     bool (*bdrv_need_rw_file_child_during_reopen_rw)(BlockDriverState=
 *bs);
> > +
> >      /**
> >       * Bitmaps should be marked as 'IN_USE' in the image on reopening =
image
> >       * as rw. This handler should realize it. It also should unset rea=
donly
> > diff --git a/block.c b/block.c
> > index cbd8da5f3b..3c8e1c59b4 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1715,10 +1715,12 @@ static void bdrv_get_cumulative_perm(BlockDrive=
rState *bs, uint64_t *perm,
> >                                       uint64_t *shared_perm);
> > =20
> >  typedef struct BlockReopenQueueEntry {
> > -     bool prepared;
> > -     bool perms_checked;
> > -     BDRVReopenState state;
> > -     QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
> > +    bool reopened_file_child_rw;
> > +    bool changed_file_child_perm_rw;
> > +    bool prepared;
> > +    bool perms_checked;
> > +    BDRVReopenState state;
> > +    QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
> >  } BlockReopenQueueEntry;
> > =20
> >  /*
> > @@ -3421,6 +3423,105 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopen=
Queue *bs_queue,
> >                                     keep_old_opts);
> >  }
> > =20
> > +static int bdrv_reopen_set_read_only_drained(BlockDriverState *bs,
> > +                                             bool read_only,
> > +                                             Error **errp)
> > +{
> > +    BlockReopenQueue *queue;
> > +    QDict *opts =3D qdict_new();
> > +
> > +    qdict_put_bool(opts, BDRV_OPT_READ_ONLY, read_only);
> > +
> > +    queue =3D bdrv_reopen_queue(NULL, bs, opts, true);
> > +
> > +    return bdrv_reopen_multiple(queue, errp);
> > +}
> > +
> > +/*
> > + * handle_recursive_reopens
> > + *
> > + * On fail it needs rollback_recursive_reopens to be called.
>=20
> It would be nice if this description actually said anything about what
> the function is supposed to do.
>=20
> > + */
> > +static int handle_recursive_reopens(BlockReopenQueueEntry *current,
> > +                                    Error **errp)
> > +{
> > +    int ret;
> > +    BlockDriverState *bs =3D current->state.bs;
> > +
> > +    /*
> > +     * We use the fact that in reopen-queue children are always follow=
ing
> > +     * parents.
> > +     * TODO: Switch BlockReopenQueue to be QTAILQ and use
> > +     *       QTAILQ_FOREACH_REVERSE.
>=20
> Why don=E2=80=99t you do that first?  It would make the code more obvious=
 at
> least to me.
>=20
> > +     */
> > +    if (QSIMPLEQ_NEXT(current, entry)) {
> > +        ret =3D handle_recursive_reopens(QSIMPLEQ_NEXT(current, entry)=
, errp);
> > +        if (ret < 0) {
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    if ((current->state.flags & BDRV_O_RDWR) && bs->file && bs->drv &&
> > +        bs->drv->bdrv_need_rw_file_child_during_reopen_rw &&
> > +        bs->drv->bdrv_need_rw_file_child_during_reopen_rw(bs))
> > +    {
> > +        if (!bdrv_is_writable(bs->file->bs)) {
> > +            ret =3D bdrv_reopen_set_read_only_drained(bs->file->bs, fa=
lse, errp);
>=20
> Hm.  Sorry, I find this all a bit hard to understand.  (No comments and
> all.)
>=20
> I understand that this is for an RO -> RW transition?  Everything is
> still RO, but the parent will need an RW child before it transitions to
> RW itself.
>=20
>=20
> I=E2=80=99m going to be honest up front, I don=E2=80=99t like this very m=
uch.  But I
> think it may be a reasonable solution for now.
>=20
> As I remember, the problem was that when reopening a qcow2 node from RO
> to RW, we need to write something in .prepare() (because it can fail),
> but naturally no .prepare() is called after any .commit(), so no matter
> the order of nodes in the ReopenQueue, the child node will never be RW
> by this point.
>=20
> Hm.  To me that mostly means that making the whole reopen process a
> transaction was just a dream that turns out not to work.

This patch already looks somewhat complicated to me, and what you're
proposing below sounds another order of magnitude more complex.

But I think the important point is your last sentence above. Once we
acknowledge that we can't possibly maintain full transaction semantics,
I'll ask this naive question: What prevents us from just keeping the
additional write in .commit?

It is expected to work in the common case, so we're only talking about
the behaviour in error cases anyway. If something fails and we can't do
things in a transactionable way, we need to decide what the surprise
result will look like, because we can neither guarantee a rollback nor
successful completion.

If the write fails unexpectedly, and we end up with a qcow2 image that
is opened r/w, but has read-only bitmaps - wouldn't that be a reasonable
result? It seems much easier to explain than some dependency subchain
already being committed and the rest rolled back.

So, I guess my question is, what is the specifc scenario you're trying
to fix with this series (why isn't the final patch a test case that
would answer this question?), and are we sure that the cure isn't worse
than the disease?

Kevin

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdRFoAAAoJEH8JsnLIjy/WI8oQAK9+eLe5fcme0skj0WqjQuTf
RhnIFF77ypC1Ik7qk09SCNDmcgR6PYoijsvGswJLjQcQPNgZgfUngUgXaJ4N5TFr
waDzaDGDHaqX6bmG36t7nzPeEiwIg1wh2w+SOb6XuhVbTmIrynnjSsgXj3SiyJBb
MUxw7FIe6U8tD0epY9M69T1FVkTN+PvO9D077w0p6amP/74874JPpC2ig/atLwzr
1LC8HwVIYuCurygETvy4HKb2x9aYHB6bJ/0Y6dxaB96DBKM2Wtj9nWhlkXazVXr3
uZXa4GUSDHjhBXCqoIcLE5I7R8BJSkfFIsG8qltpmEkHnb5E3VDhtXneT+nQ2GRE
ab6FHIlPPXlpKCyiOUzDM2Ac3U13hKsu2qkpuNtcE7AKWOFLoA7mSWAXj7eezaNe
q1AXiFtSF025FkzEPp84ELiXvweBEIA6U0eK6NqgrqO4NMtBjRTXmdlZnWiO1ETW
xnTqFL6oxgNwVRhOfKOdfBOCgqCZJqmW9DGWZiQFtrkGdZjjY5Cx6ASe0ddj5uT0
NpI6vGKllsFKhlEQr7pF6Ju7uSOa5CZ98NFML3uWJYhQiJEpKudiciptPQlZwXj+
Ygsqt0NT2uc/XnQOfJUGGMJfBj5gbZcGe0Nxu3+YEzfxisXuUz7MfeaXjCqghAyM
3p3yQIwB8csqapBrF921
=knYR
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

