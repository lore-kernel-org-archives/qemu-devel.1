Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE9C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:05:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF4E21479
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF4E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i863U-00015y-Ng
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 13:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i862f-0000XD-CE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i862e-0003TF-6j
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i862d-0003Su-VS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 13:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F72B308624A
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 17:04:27 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37D3219C6A;
 Wed, 11 Sep 2019 17:04:26 +0000 (UTC)
Date: Wed, 11 Sep 2019 18:04:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190911170423.GH2894@work-vm>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <20190911165627.GG24295@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190911165627.GG24295@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Wed, 11 Sep 2019 17:04:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Sep 11, 2019 at 05:42:00PM +0100, Dr. David Alan Gilbert (git) =
wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > RCU_READ_LOCK_AUTO takes the rcu_read_lock  and then uses glib's
> > g_auto infrastrcture (and thus whatever the compilers hooks are) to
> > release it on all exits of the block.
> >=20
> > Note this macro has a variable declaration in, and hence is not in
> > a while loop.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/qemu/rcu.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > index 22876d1428..6a25b27d28 100644
> > --- a/include/qemu/rcu.h
> > +++ b/include/qemu/rcu.h
> > @@ -154,6 +154,18 @@ extern void call_rcu1(struct rcu_head *head, RCU=
CBFunc *func);
> >        }),                                                           =
     \
> >        (RCUCBFunc *)g_free);
> > =20
> > +typedef char rcu_read_auto_t;
> > +static inline void rcu_read_auto_unlock(rcu_read_auto_t *r)
> > +{
> > +  rcu_read_unlock();
> > +}
> > +
> > +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(rcu_read_auto_t, rcu_read_auto_unlo=
ck)
> >
> > +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
> > +    _rcu_read_auto =3D 'x'; \
> > +    rcu_read_lock();
> > +
>=20
> Functionally this works, but my gut feeling would be to follow
> the design of GMutexLocker as-is:
>=20
>   https://developer.gnome.org/glib/stable/glib-Threads.html#g-mutex-loc=
ker-new
>=20
> so you get a use pattern of
>=20
>   g_autoptr(rcu_read_locker) locker =3D rcu_read_locker_new();
>=20
> This makes it explicit that the code is creating a variable here, which
> in turns means it is clear to force unlock early with
>=20
>   g_clear_pointer(&locker, rcu_read_locker_free)

The difference compared to the g-mutex-locker is that I don't have
another object to use as my pointer; that uses the address of the GMutex
as the dummy pointer value.  I did try an experiment with g_autoptr
and found that it did need to return a non-NULL value for it to work,
which then lead me to think what value to use - while it seems to work
if I return (void *)1 it makes me nervous.

Dave

>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

