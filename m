Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB1C0650E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 08:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EAC20989
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 08:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EAC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk2mN-00074a-N1
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 04:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hk2lu-0006Ux-08
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 04:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hk2ls-0000o9-VC
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 04:43:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49364)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hk2lq-0000lO-JV; Sun, 07 Jul 2019 04:43:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3436D883BA;
 Sun,  7 Jul 2019 08:43:40 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD03618234;
 Sun,  7 Jul 2019 08:43:34 +0000 (UTC)
Message-ID: <d009ad68b237aae51d327955367dc2356f33bba0.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Sun, 07 Jul 2019 11:43:33 +0300
In-Reply-To: <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
 <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Sun, 07 Jul 2019 08:43:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] block/nvme: don't touch the
 completion entries
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

On Fri, 2019-07-05 at 13:03 +0200, Max Reitz wrote:
> On 03.07.19 17:59, Maxim Levitsky wrote:
> > Completion entries are meant to be only read by the host and written =
by the device.
> > The driver is supposed to scan the completions from the last point wh=
ere it left,
> > and until it sees a completion with non flipped phase bit.
>=20
> (Disclaimer: This is the first time I read the nvme driver, or really
> something in the nvme spec.)
>=20
> Well, no, completion entries are also meant to be initialized by the
> host.  To me it looks like this is the place where that happens:
> Everything that has been processed by the device is immediately being
> re-initialized.
>=20
> Maybe we shouldn=E2=80=99t do that here but in nvme_submit_command().  =
But
> currently we don=E2=80=99t, and I don=E2=80=99t see any other place whe=
re we currently
> initialize the CQ entries.

Hi!
I couldn't find any place in the spec that says that completion entries s=
hould be initialized.
It is probably wise to initialize that area to 0 on driver initialization=
, but nothing beyond that.
In particular that is what the kernel nvme driver does.=20
Other that allocating a zeroed memory (and even that I am not sure it doe=
s),=20
it doesn't write to the completion entries.

Thanks for the very very good review btw. I will go over all patches now =
and fix things.

Best regards,
	Maxim Levitsky

>=20
> Max
>=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/nvme.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 73ed5fa75f..6d4e7f3d83 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -315,7 +315,7 @@ static bool nvme_process_completion(BDRVNVMeState=
 *s, NVMeQueuePair *q)
> >      while (q->inflight) {
> >          int16_t cid;
> >          c =3D (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYT=
ES];
> > -        if (!c->cid || (le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_p=
hase) {
> > +        if ((le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase) {
> >              break;
> >          }
> >          q->cq.head =3D (q->cq.head + 1) % NVME_QUEUE_SIZE;
> > @@ -339,10 +339,7 @@ static bool nvme_process_completion(BDRVNVMeStat=
e *s, NVMeQueuePair *q)
> >          qemu_mutex_unlock(&q->lock);
> >          req.cb(req.opaque, nvme_translate_error(c));
> >          qemu_mutex_lock(&q->lock);
> > -        c->cid =3D cpu_to_le16(0);
> >          q->inflight--;
> > -        /* Flip Phase Tag bit. */
> > -        c->status =3D cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
> >          progress =3D true;
> >      }
> >      if (progress) {
> >=20
>=20
>=20



