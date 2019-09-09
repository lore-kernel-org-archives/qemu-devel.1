Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2FBC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D7FD21920
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7FD21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7GVc-0006pU-79
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7GUe-0006MC-DG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7GUc-0000PZ-Uf
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:01:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36436)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7GUZ-0000NT-HQ; Mon, 09 Sep 2019 06:01:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9592F30821BF;
 Mon,  9 Sep 2019 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-198.ams2.redhat.com
 [10.36.117.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5678E60BE2;
 Mon,  9 Sep 2019 10:01:49 +0000 (UTC)
Date: Mon, 9 Sep 2019 12:01:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190909100147.GC17606@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-17-mreitz@redhat.com>
 <b2f43475-224e-5003-2c51-3949e9fb2d42@virtuozzo.com>
 <e18b1eed-6d7a-603b-f8ad-4c56795309c2@redhat.com>
 <20190905162407.GD4911@localhost.localdomain>
 <af64f1db-c35b-351f-d65f-179775010d00@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <af64f1db-c35b-351f-d65f-179775010d00@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 09 Sep 2019 10:01:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 16/42] block: Flush all children in
 generic code
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 09.09.2019 um 10:31 hat Max Reitz geschrieben:
> On 05.09.19 18:24, Kevin Wolf wrote:
> > Am 12.08.2019 um 14:58 hat Max Reitz geschrieben:
> >> On 10.08.19 17:36, Vladimir Sementsov-Ogievskiy wrote:
> >>> 09.08.2019 19:13, Max Reitz wrote:
> >>>> If the driver does not support .bdrv_co_flush() so bdrv_co_flush()
> >>>> itself has to flush the children of the given node, it should not fl=
ush
> >>>> just bs->file->bs, but in fact all children.
> >>>>
> >>>> In any case, the BLKDBG_EVENT() should be emitted on the primary chi=
ld,
> >>>> because that is where a blkdebug node would be if there is any.
> >>>>
> >>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>   block/io.c | 23 +++++++++++++++++------
> >>>>   1 file changed, 17 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/block/io.c b/block/io.c
> >>>> index c5a8e3e6a3..bcc770d336 100644
> >>>> --- a/block/io.c
> >>>> +++ b/block/io.c
> >>>> @@ -2572,6 +2572,8 @@ static void coroutine_fn bdrv_flush_co_entry(v=
oid *opaque)
> >>>>  =20
> >>>>   int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
> >>>>   {
> >>>> +    BdrvChild *primary_child =3D bdrv_primary_child(bs);
> >>>> +    BdrvChild *child;
> >>>>       int current_gen;
> >>>>       int ret =3D 0;
> >>>>  =20
> >>>> @@ -2601,7 +2603,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverStat=
e *bs)
> >>>>       }
> >>>>  =20
> >>>>       /* Write back cached data to the OS even with cache=3Dunsafe */
> >>>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
> >>>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
> >>>>       if (bs->drv->bdrv_co_flush_to_os) {
> >>>>           ret =3D bs->drv->bdrv_co_flush_to_os(bs);
> >>>>           if (ret < 0) {
> >>>> @@ -2611,15 +2613,15 @@ int coroutine_fn bdrv_co_flush(BlockDriverSt=
ate *bs)
> >>>>  =20
> >>>>       /* But don't actually force it to the disk with cache=3Dunsafe=
 */
> >>>>       if (bs->open_flags & BDRV_O_NO_FLUSH) {
> >>>> -        goto flush_parent;
> >>>> +        goto flush_children;
> >>>>       }
> >>>>  =20
> >>>>       /* Check if we really need to flush anything */
> >>>>       if (bs->flushed_gen =3D=3D current_gen) {
> >>>> -        goto flush_parent;
> >>>> +        goto flush_children;
> >>>>       }
> >>>>  =20
> >>>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
> >>>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
> >>>>       if (!bs->drv) {
> >>>>           /* bs->drv->bdrv_co_flush() might have ejected the BDS
> >>>>            * (even in case of apparent success) */
> >>>> @@ -2663,8 +2665,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverSta=
te *bs)
> >>>>       /* Now flush the underlying protocol.  It will also have BDRV_=
O_NO_FLUSH
> >>>>        * in the case of cache=3Dunsafe, so there are no useless flus=
hes.
> >>>>        */
> >>>> -flush_parent:
> >>>> -    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
> >>>> +flush_children:
> >>>> +    ret =3D 0; > +    QLIST_FOREACH(child, &bs->children, next) {
> >>>> +        int this_child_ret;
> >>>> +
> >>>> +        this_child_ret =3D bdrv_co_flush(child->bs);
> >>>> +        if (!ret) {
> >>>> +            ret =3D this_child_ret;
> >>>> +        }
> >>>> +    }
> >>>
> >>> Hmm, you said that we want to flush only children with write-access f=
rom parent..
> >>
> >> Good that you remember it, I must have overlooked it (when reading the
> >> replies to the previous version). :-)
> >>
> >>> Shouldn't we check it? Or we assume that it's always safe to call bdr=
v_co_flush on
> >>> a node?
> >>
> >> I think it=E2=80=99s always safe.  But checking it seems like a nice t=
ouch, yes.
> >=20
> > I'm not sure why we would unconditionally flush all children anyway. The
> > only drivers I can think of that really need to flush more than one
> > child are blkverify and quorum, and both of them already implement this.
> > blkverify implements .bdrv_co_flush, so it's not affected by the change
> > anyway, but quorum children will be flushed twice now.
> >=20
> > But more than this, I'm worried about the overhead of needlessly
> > recursing through the whole backing chain and calling flush on every
> > node there.  Maybe bs->write_gen saves us so that at least this doesn't
> > result in an fdatasync() call for each, but still... Without a use case,
> > I'd rather not do this.
> >=20
> > Oh, well, after having written all of this, I see that qcow2 with an
> > external data file is buggy... This could be fixed in the qcow2 driver,
> > but maybe restricting the recursion to read-only is actually good enough
> > then. Can you mention this case in the commit message and maybe build a
> > test for it?
>=20
> And I should thus probably drop vmdk=E2=80=99s .bdrv_co_flush_to_disk()
> implementation.
>=20
> I will indeed try to write a test, but to be completely honest, I feel
> like this series is long enough.

I guess I could already merge patch 1 to give you space for another test
patch. ;-)

Kevin

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJddiMLAAoJEH8JsnLIjy/W2XwP/jMc8hm8obS7wT7YlPlmK627
EvADYO6+8QP8bJRRgmkT4qRKvx+NXmempa9idcGeDfI9Gc12zrPxGdtAZ+nrEDem
JYZ5/4gL7Wi+AtMQyzmY77cp2i8wn90FGYdcmvEsuBnsTgDoenDwW2L+eTb9b4sS
0OTgmm1EI2MrFbu5hKqVOuvOEvxGK5TyLfJ4iUB+5pkcaHqKK4w0TyHMmhlhC0sU
hYGyorSbHYCjnmH/83ExIktFcvKmdZw9ZMZDwpEhRIVVKc6CNNdMrsiVWQb5XJ3g
VsVhsurZ80xo3b+cwG/XlcqkWouReEfiTm2BqHZMWru7/5WrNFHqoe7KlSfTsjog
LjIMW1H5JtvC47/GAFP0NzuXBUfXcnq/T5FgPjAsN4QnPRjsn9T9GO85O3eHRtPL
BIQCEq8qDDgHfISHMBTHu3090yFem05iC6Nc5il0MciHe7JbvCXChFaAPyiBE2vT
HtqkqRsxms9LvU+FB+9TxoAfjzE5TJix3JkcYY0OfndkyxFKZP/p+V/6AJseIXQi
pKSTbqEyJ6OjauSjpLo6R7++y0YTHpm0MM4t9dMRcQXU41igyjxRCrV4fOAC5aYq
9Cp6k2qDOgN816JTJy9HxMwbPTLW7TO0ZyX6laYOXtzI/Q8yVv+6M9JWOx4Jdw2e
8mkOS8yxXh5dpVibXeVB
=FaE4
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--

