Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE93C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E24212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E24212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCll-0007ZW-S9
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hZBf6-0007zE-2R
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hZBf4-0005kg-0W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58826)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hZBf3-0005Yd-PO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:59:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3336D6EB9A;
 Fri,  7 Jun 2019 09:59:38 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F8D7FCE2;
 Fri,  7 Jun 2019 09:59:33 +0000 (UTC)
Date: Fri, 7 Jun 2019 10:59:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190607095930.GA28838@redhat.com>
References: <87woihi1wl.fsf@dusky.pond.sub.org>
 <20190524185344.GJ10764@habkost.net>
 <87r28k1g4q.fsf@dusky.pond.sub.org>
 <e5372760-7599-3155-44f7-dc704c9cbaa5@redhat.com>
 <875zphg9t8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875zphg9t8.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 07 Jun 2019 09:59:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] qapi/misc.json is too big,
 let's bite off a few chunks
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 08:59:31AM +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 27/05/19 10:00, Markus Armbruster wrote:
> >> As long as we don't have an active QOM maintainer[*], the benefit is
> >> low.
> >>=20
> >>=20
> >> [*] We need one.  I'm not volunteering.
> >
> > I think Daniel, Eduardo and I could count as de facto maintainer.  I
> > guess I could maintain it if I get two partners in crime as reviewers=
.
>=20
> Alright, we need two volunteers for the reviewer role, and one patch to
> MAINTAINERS.
>=20
> A mention in MAINTAINERS is the traditional punishment for good work, s=
o
> let's see who's been doing the work.  Aha:
>=20
>     Eduardo Habkost
>     Marc-Andr=C3=A9 Lureau
>     Markus Armbruster
>     Eric Blake
>     Philippe Mathieu-Daud=C3=A9
>=20
> Details appended.
>=20
> QOM is not a particularly active subsystem now: 51 commits in two years=
.
>=20
> We obviously need maintainers to review and merge patches.  The nominal
> maintainer hasn't been doing that since 2015.  Git shows the following
> top committers taking on / getting sucked into QOM:
>=20
>     Markus Armbruster <armbru@redhat.com>
>     Eduardo Habkost <ehabkost@redhat.com>
>     Paolo Bonzini <pbonzini@redhat.com>
>     Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Eric Blake <eblake@redhat.com>
>=20
> We really need nominal maintainer(s) again.
>=20
> Of course, *active* maintainers would be even better: I consider QOM
> stuck in an unhappy place where much of its potential is still
> potential.
>=20
> But let's start small.  Volunteers for the reviewer role, please step
> forward :)

I'm happy to be a reviewer since I understand the code fairly well.
I don't want to volunteer to be maintainer as I can't promise to
be timely at dealing with yet another patch queue.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

