Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD92C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10A22075C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C10A22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i87hN-000658-Q6
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 14:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i87gj-0005Yf-G7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i87gg-0005Bb-Oo
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i87gg-0005BM-Im
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:49:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF437307D945
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 18:49:53 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC235D9E2;
 Wed, 11 Sep 2019 18:49:52 +0000 (UTC)
Date: Wed, 11 Sep 2019 19:49:50 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190911184950.GN2894@work-vm>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <20190911165627.GG24295@redhat.com>
 <a16529f1-a5e3-ec80-7586-07d5b1c9ca87@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <a16529f1-a5e3-ec80-7586-07d5b1c9ca87@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 18:49:53 +0000 (UTC)
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
Cc: pbonzini@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 9/11/19 11:56 AM, Daniel P. Berrang=E9 wrote:
> > On Wed, Sep 11, 2019 at 05:42:00PM +0100, Dr. David Alan Gilbert (git=
) wrote:
> >> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >>
> >> RCU_READ_LOCK_AUTO takes the rcu_read_lock  and then uses glib's
>=20
> spurious double space
>=20
> >> g_auto infrastrcture (and thus whatever the compilers hooks are) to
>=20
> infrastructure
> compiler's

Thanks.

Dave

> >> release it on all exits of the block.
> >>
> >> Note this macro has a variable declaration in, and hence is not in
> >> a while loop.
> >>
>=20
> >> +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
> >> +    _rcu_read_auto =3D 'x'; \
> >> +    rcu_read_lock();
> >> +
> >=20
> > Functionally this works, but my gut feeling would be to follow
> > the design of GMutexLocker as-is:
> >=20
> >   https://developer.gnome.org/glib/stable/glib-Threads.html#g-mutex-l=
ocker-new
> >=20
> > so you get a use pattern of
> >=20
> >   g_autoptr(rcu_read_locker) locker =3D rcu_read_locker_new();
>=20
> Another pattern to consider: nbdkit uses:
>=20
> #define ACQUIRE_LOCK_FOR_CURRENT_SCOPE(mutex) \
>   CLEANUP_UNLOCK pthread_mutex_t *_lock =3D mutex; \
>   do { \
>     int _r =3D pthread_mutex_lock (_lock); \
>     assert (!_r); \
>   } while (0)
>=20
> with later code calling:
>=20
>   ACQUIRE_LOCK_FOR_CURRENT_SCOPE (&lock);
>=20
> >=20
> > This makes it explicit that the code is creating a variable here, whi=
ch
> > in turns means it is clear to force unlock early with
> >=20
> >   g_clear_pointer(&locker, rcu_read_locker_free)
>=20
> Yes, this aspect of glib is nicer than the corresponding nbdkit usage
> pattern.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

