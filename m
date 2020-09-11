Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF3C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:22:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F215D21D91
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 11:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F215D21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGh8i-0005br-Nv
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 07:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGh8C-00055v-R9; Fri, 11 Sep 2020 07:22:16 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:53627)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kGh8A-0008AA-DM; Fri, 11 Sep 2020 07:22:16 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.235])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D0678607B4D2;
 Fri, 11 Sep 2020 13:21:58 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 11 Sep
 2020 13:21:54 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002985e5217-0349-435d-88f8-559121086d1a,
 864FBEA0465FE1F0C66A9C6AC37977A76827B8ED) smtp.auth=groug@kaod.org
Date: Fri, 11 Sep 2020 13:21:52 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 11/14] block/qcow2-bitmap: return startus from
 qcow2_store_persistent_dirty_bitmaps
Message-ID: <20200911132152.01855289@bahia.lan>
In-Reply-To: <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
References: <20200909185930.26524-1-vsementsov@virtuozzo.com>
 <20200909185930.26524-12-vsementsov@virtuozzo.com>
 <20200911113838.482b062e@bahia.lan>
 <2d8099d0-c04c-8b91-fd1e-f988cbba14ce@virtuozzo.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: df834903-b74f-474e-8ca8-15c9996f5f0e
X-Ovh-Tracer-Id: 6761591892413880763
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqheftdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeelueetheegheefteevveelvdfhueeuudegudegtedufeeutdekkeeugeejgfetvdenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehkfiholhhfsehrvgguhhgrthdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 04:34:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, berto@igalia.com, pavel.dovgaluk@ispras.ru,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com,
 ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 13:18:32 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 11.09.2020 12:38, Greg Kurz wrote:
> > s/startus/status
> >=20
> > On Wed,  9 Sep 2020 21:59:27 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> >=20
> >> It's better to return status together with setting errp. It makes
> >> possible to avoid error propagation.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   block/qcow2.h        |  2 +-
> >>   block/qcow2-bitmap.c | 13 ++++++-------
> >>   2 files changed, 7 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/block/qcow2.h b/block/qcow2.h
> >> index e7e662533b..49824be5c6 100644
> >> --- a/block/qcow2.h
> >> +++ b/block/qcow2.h
> >> @@ -972,7 +972,7 @@ bool qcow2_get_bitmap_info_list(BlockDriverState *=
bs,
> >>                                   Qcow2BitmapInfoList **info_list, Err=
or **errp);
> >>   int qcow2_reopen_bitmaps_rw(BlockDriverState *bs, Error **errp);
> >>   int qcow2_truncate_bitmaps_check(BlockDriverState *bs, Error **errp);
> >> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> >> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> >>                                             bool release_stored, Error=
 **errp);
> >>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp);
> >>   bool qcow2_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
> >> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> >> index f58923fce3..5eeff1cb1c 100644
> >> --- a/block/qcow2-bitmap.c
> >> +++ b/block/qcow2-bitmap.c
> >> @@ -1524,9 +1524,10 @@ out:
> >>    * readonly to begin with, and whether we opened directly or reopene=
d to that
> >>    * state shouldn't matter for the state we get afterward.
> >>    */
> >> -void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> >> +bool qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs,
> >>                                             bool release_stored, Error=
 **errp)
> >>   {
> >> +    ERRP_GUARD();
> >=20
> > Maybe worth mentioning in the changelog that this ERRP_GUARD() fixes
> > an error_prepend(errp, ...) not visible in the patch context.
>=20
> Ah yes. Actually this is occasional thing I didn't want to include into t=
his patch
> (and int this part I). So we can just drop it and leave for part II or pa=
rt III,
> or add a note into commit message
>=20
> >=20
> > Anyway,
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> Thanks a lot for reviewing :)
>=20

Don't mention it :)

> Hmm.. With this series I understand the following:
>=20
> 1. It's no sense in simple applying scripts/coccinelle/errp-guard.cocci t=
o the whole code-base, because:
>=20
>    - it produces a lot of "if (*errp)" in places where it is really simpl=
e to avoid error propagation at all, like in this series
>    - reviewing is the hardest part of the process
>=20
> So, if we have to review these changes anyway, it's better to invest a bi=
t more time into patch creation, and make code correspond to our modern err=
or API recommendations.
>=20
> 2. So, the process turns into following steps:
>=20
>    - apply scripts/coccinelle/errp-guard.cocci
>    - look through patches and do obvious refactorings (like this series)
>    - keep ERRP_GUARD where necessary (appending info to error, or where r=
efactoring of function return status is too invasive and not simple)
>=20

I've started to follow this process for the spapr code and, indeed, I
can come up with better changes by refactoring some code manually.
Some of these changes are not that obvious that they could be made
by someone who doesn't know the code, so I tend to agree with your
arguments in 1.

This is also the reason I didn't review patches 10, 13 and 14 because
they looked like I should understand the corresponding code a bit more.

> 3. Obviously, that's too much for me :) Of course, I will invest some tim=
e into making the series like this one, and reviewing them, but I can't do =
it for weeks and months. (My original =D1=81unning plan to simply push ~100=
 generated commits with my s-o-b and become the greatest contributor failed=
:)
>=20

Ha ha :D ... as a consolation prize, maybe we can reach a fair number
of r-b by reviewing each other's _simple_ cleanups ;-)

> The good thing is that now, with ERRP_GUARD finally merged, we can produc=
e parallel series like this, and they will be processed in parallel by diff=
erent maintainers (and Markus will have to merge series for subsystems with=
 unavailable maintainers).
>=20

This sounds nice. My only concern would be to end up fixing code nobody
uses or cares for, so I guess it would be better that active maintainers
or supporters give impetus on that.

> So, everybody is welcome to the process [2]. Probably we want to make a s=
eparate announcement in a list with short recommendations and instructions?=
 But who read announcements..
>=20

I don't :) but the very massive series that were posted on the topic
the last few months look like an announcement to me, at least for
active maintainers and supporters.

> >=20
> >>       BdrvDirtyBitmap *bitmap;
> >>       BDRVQcow2State *s =3D bs->opaque;
> >>       uint32_t new_nb_bitmaps =3D s->nb_bitmaps;
> >> @@ -1546,7 +1547,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockD=
riverState *bs,
> >>           bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> >>                                      s->bitmap_directory_size, errp);
> >>           if (bm_list =3D=3D NULL) {
> >> -            return;
> >> +            return false;
> >>           }
> >>       }
> >>  =20
> >> @@ -1661,7 +1662,7 @@ success:
> >>       }
> >>  =20
> >>       bitmap_list_free(bm_list);
> >> -    return;
> >> +    return true;
> >>  =20
> >>   fail:
> >>       QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> >> @@ -1679,16 +1680,14 @@ fail:
> >>       }
> >>  =20
> >>       bitmap_list_free(bm_list);
> >> +    return false;
> >>   }
> >>  =20
> >>   int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
> >>   {
> >>       BdrvDirtyBitmap *bitmap;
> >> -    Error *local_err =3D NULL;
> >>  =20
> >> -    qcow2_store_persistent_dirty_bitmaps(bs, false, &local_err);
> >> -    if (local_err !=3D NULL) {
> >> -        error_propagate(errp, local_err);
> >> +    if (!qcow2_store_persistent_dirty_bitmaps(bs, false, errp)) {
> >>           return -EINVAL;
> >>       }
> >>  =20
> >=20
>=20
>=20


