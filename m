Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3CCC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:52:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E47208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E47208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAyje-0004O0-W3
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iAyiN-0003Zc-V4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iAyiM-0007A6-Jz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iAyiG-00073A-8A; Thu, 19 Sep 2019 11:51:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 373CA308FBA0;
 Thu, 19 Sep 2019 15:51:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A6AE608A5;
 Thu, 19 Sep 2019 15:50:48 +0000 (UTC)
Date: Thu, 19 Sep 2019 16:50:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [RFC] error: auto propagated local_err
Message-ID: <20190919155045.GS20217@redhat.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
 <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
 <35c972e1-bdb5-cbcb-ed45-6a51f19af98c@virtuozzo.com>
 <696673be-95c8-3f75-551c-26fccd230eb1@virtuozzo.com>
 <152afb5b-8efb-d968-d595-94f58ad02a04@redhat.com>
 <20190919144948.GR20217@redhat.com>
 <b5128e58-8b90-233d-6bb1-cc9009852d8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5128e58-8b90-233d-6bb1-cc9009852d8d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 19 Sep 2019 15:51:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "groug@kaod.org" <groug@kaod.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 10:24:20AM -0500, Eric Blake wrote:
> On 9/19/19 9:49 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> >> ALWAYS using MAKE_ERRP_SAFE() on entry to any function that has an E=
rror
> >> **errp parameter is dirt-simple to explain.  It has no performance
> >> penalty if the user passed in a normal error or error_abort (the cos=
t of
> >> an 'if' hidden in the macro is probably negligible compared to
> >> everything else we do), and has no semantic penalty if the user pass=
ed
> >> in NULL or error_fatal (we now get the behavior we want with less
> >> boilerplate).
> >>
> >> Having to think 'does this method require me to use MAKE_ERRP_SAFE, =
or
> >> can I omit it?' does not provide the same simplicity.
> >=20
> > The flipside is that MAKE_ERRP_SAFE hides a bunch of logic, so you do=
n't
> > really know what its doing without looking at it, and this is QEMU
> > custom concept so one more thing to learn for new contributors.
> >=20
> > While I think it is a nice trick, personally I think we would be bett=
er
> > off if we simply used a code pattern which does not require de-refere=
ncing
> > 'errp' at all, aside from exceptional cases. IOW, no added macro in 9=
5%
> > of all our methods using Error **errp.
>=20
> If 100% of our callsites use the macro, then new contributors will
> quickly learn by observation alone that the macro usage must be
> important on any new function taking Error **errp, whether or not they
> actually read the macro to see what it does.  If only 5% of our
> callsites use the macro, it's harder to argue that a new user will pick
> up on the nuances by observation alone (presumably, our docs would also
> spell it out, but we know that not everyone reads those...).

To get some slightly less made-up stats, I did some searching:

  - 4408  methods with an 'errp' parameter declared

     git grep 'Error \*\*errp'|  wc -l

  - 696 methods with an 'Error *local' declared (what other names
    do we use for this?)

     git grep 'Error \*local' | wc -l

  - 1243 methods with an 'errp' parameter which have void
    return value (fuzzy number - my matching is quite crude)

     git grep 'Error \*\*errp'|  grep -E '(^| )void' | wc -l

  - 11 methods using error_append_hint with a local_err

     git grep append_hint | grep local | wc -l


This suggests to me, that if we used the 'return 0 / return -1' conventio=
n
to indicate failure for the methods which currently return void, we could
potentially only have 11 cases where a local error object is genuinely
needed.=20

If my numbers are at all accurate, I still believe we're better off
changing the return type and eliminating essentially all use of local
error variables, as void funcs/local error objects appear to be the
minority coding pattern.


> > There are lots of neat things we could do with auto-cleanup functions=
 we
> > I think we need to be wary of hiding too much cleverness behind macro=
s
> > when doing so overall.
>=20
> The benefit of getting rid of the 'Error *local_err =3D NULL; ...
> error_propagate()' boilerplate is worth the cleverness, in my opinion,
> but especially if also accompanied by CI coverage that we abide by our
> new rules.

At least we're both wanting to eliminate the local error + propagation.
The difference is whether we're genuinely eliminating it, or just hiding
it from view via auto-cleanup & macro magic

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

