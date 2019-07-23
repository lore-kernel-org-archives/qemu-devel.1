Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C24BC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4885921901
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 11:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4885921901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpscq-0004rb-Hs
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 07:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hpscg-0004P4-BA
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:06:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hpscf-00086W-4y
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 07:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hpscc-00085H-Gy; Tue, 23 Jul 2019 07:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7FDBB30C1343;
 Tue, 23 Jul 2019 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-32.ams2.redhat.com
 [10.36.116.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 855B819C59;
 Tue, 23 Jul 2019 11:06:16 +0000 (UTC)
Date: Tue, 23 Jul 2019 13:06:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190723110615.GB11008@localhost.localdomain>
References: <20190722133054.21781-1-mreitz@redhat.com>
 <20190722133054.21781-3-mreitz@redhat.com>
 <20190723085236.GA5296@localhost.localdomain>
 <91179292-29aa-4d00-78ac-a8861fd5f308@redhat.com>
 <20190723100243.GA11008@localhost.localdomain>
 <083850e7-81ab-a9df-9fbd-1bb49adf1712@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Content-Disposition: inline
In-Reply-To: <083850e7-81ab-a9df-9fbd-1bb49adf1712@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 23 Jul 2019 11:06:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] block: Only the main loop can
 change AioContexts
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.07.2019 um 12:21 hat Max Reitz geschrieben:
> On 23.07.19 12:02, Kevin Wolf wrote:
> > Am 23.07.2019 um 11:41 hat Max Reitz geschrieben:
> >> On 23.07.19 10:52, Kevin Wolf wrote:
> >>> Am 22.07.2019 um 15:30 hat Max Reitz geschrieben:
> >>>> bdrv_set_aio_context_ignore() can only work in the main loop:
> >>>> bdrv_drained_begin() only works in the main loop and the node's (old)
> >>>> AioContext; and bdrv_drained_end() really only works in the main loop
> >>>> and the node's (new) AioContext (contrary to its current comment, wh=
ich
> >>>> is just wrong).
> >>>>
> >>>> Consequentially, bdrv_set_aio_context_ignore() must be called from t=
he
> >>>> main loop.  Luckily, assuming that we can make block graph changes o=
nly
> >>>> from the main loop as well, all its callers do that already.
> >>>>
> >>>> Note that changing a node's context in a sense is an operation that
> >>>> changes the block graph, so it actually makes sense to require this
> >>>> function to be called from the main loop.
> >>>>
> >>>> Also, fix bdrv_drained_end()'s description.  You can only use it from
> >>>> the main loop or the node's AioContext, and in the latter case, the
> >>>> whole subtree must be in the same context.
> >>>>
> >>>> Fixes: e037c09c78520cbdb6da7cfc6ad0256d5870b814
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> ---
> >>>>  include/block/block.h |  8 +++-----
> >>>>  block.c               | 13 ++++++++-----
> >>>>  2 files changed, 11 insertions(+), 10 deletions(-)
> >>>>
> >>>> diff --git a/include/block/block.h b/include/block/block.h
> >>>> index 60f00479e0..50a07c1c33 100644
> >>>> --- a/include/block/block.h
> >>>> +++ b/include/block/block.h
> >>>> @@ -667,11 +667,9 @@ void bdrv_subtree_drained_begin(BlockDriverStat=
e *bs);
> >>>>   *
> >>>>   * This polls @bs's AioContext until all scheduled sub-drained_ends
> >>>>   * have settled.  On one hand, that may result in graph changes.  On
> >>>> - * the other, this requires that all involved nodes (@bs and all of
> >>>> - * its parents) are in the same AioContext, and that the caller has
> >>>> - * acquired it.
> >>>> - * If there are any nodes that are in different contexts from @bs,
> >>>> - * these contexts must not be acquired.
> >>>> + * the other, this requires that the caller either runs in the main
> >>>> + * loop; or that all involved nodes (@bs and all of its parents) are
> >>>> + * in the caller's AioContext.
> >>>>   */
> >>>>  void bdrv_drained_end(BlockDriverState *bs);
> >>>
> >>> I think you are right about the requirement that bdrv_drained_end() is
> >>> only called from the main or the BDS AioContext, which is a requireme=
nt
> >>> that directly comes from AIO_WAIT_WHILE().
> >>>
> >>> However, I don't see why we have requirements on the AioContext of the
> >>> parent nodes (or any other nodes), except possibly not holding their
> >>> lock.  We don't poll their context, so it shouldn't matter in which
> >>> context they are?
> >>
> >> Hm.  I don=E2=80=99t know how I got confused there, you=E2=80=99re rig=
ht.
> >>
> >> I don=E2=80=99t think the (falsely given) restriction hurts, though, b=
ecause a
> >> subtree should be within a single context anyway (unless you=E2=80=99r=
e in
> >> bdrv_set_aio_context_ignore(), which needs to be in the main context).
> >>
> >> So, hm, yes, I messed up this comment a bit now.  But now it=E2=80=99s=
 just more
> >> restrictive than it needs to be and I don=E2=80=99t think callers are =
going to
> >> care, so...
> >=20
> > Nothing that should hold up your pull request, but I'd prefer to fix the
> > comment in a follow-up.
>=20
> On second thought, does aio_wait_kick() wake up any context but the main
> context?  I was under the impression that it doesn=E2=80=99t.  If it does=
n=E2=80=99t, I
> don=E2=80=99t know how bdrv_drained_end()=E2=80=99s AIO_WAIT_WHILE() will=
 be woken up if
> it doesn=E2=80=99t run in the main context and it has to wait for yet ano=
ther
> thread.

Hm, I think you're right.

And your comment actually says main loop _or_ everything in the same
context, so it's correct (but I misread it at first and thought the
condition would always apply).

Kevin

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdNuomAAoJEH8JsnLIjy/WufoP/jlGQArdJYr7T3Qj7L5Wrsdf
kL+IX9Pa14IHgJvUeldt52EiwH/1uhLsxUGSJkc0lxSODWf4XNvWUPzup6RMuJd/
tFIpQ24HRP/8UMFqXW9ZLu76XiGZlL9rZi5QwkuFROEMUoM4vq72JDvxh5NtXxvq
2bSY48F4YHW+dDoT3uaoSrpte84qYLQmd0RHPFdzK671Y5+XT0bvFDfpszV848Lk
tS/W6GEOwOJa18xcyNV1W2D7KUyaFZjRvz84B9nCCl8f+FbiHZo9DPLoN1jtiXmF
NSShjW0FV12TGCP7bMlX0sj+uhOgZTMq/+LX/SJVyFkvIOWlh6vgPiowIQo8R0rO
Qw5j+8i2Uj1cDX0HVEmdXDbMLvk0toNuYzDU/985BbiSKLjhOEfAFQwY2xuhLwad
TUgIK1hvsE3DZGoMeKDFSOfAOhWNoGETEJiwx56B4cTK6zh/ouFG0swVYc3gqLx7
ttVYgemV6QLgFET4kOGFahMAzgnkKEFs9VR81+jHjBTzQ/3waYLMjOZfOIsibb1+
XIxZziilamRhnVJrtTjzaPyepvlHPhUWNQqMzmKzxksnfxDTff8ulh+KoDKED9IL
cM1ltaF3oWNectyVnd6nZM+YGDubKGKziljrM8bNon9rFNlXi9XqJ10asa/GTNwT
mbFk3vNXUnwewBsXPZN3
=//lz
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--

