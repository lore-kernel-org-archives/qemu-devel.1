Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3A0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514EA2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 09:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514EA2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLOg5-0006Ns-8H
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 05:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iLOew-0005Qe-7Z
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iLOeu-00081m-SF
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iLOeu-00081Y-J7
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 05:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD336307D97F
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:34:55 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7F4F600C1;
 Fri, 18 Oct 2019 09:34:46 +0000 (UTC)
Date: Fri, 18 Oct 2019 10:34:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] trace: forbid use of %m in trace
 event format strings
Message-ID: <20191018093443.GB28271@redhat.com>
References: <20190118173103.4903-1-berrange@redhat.com>
 <20190118173103.4903-4-berrange@redhat.com>
 <c18e222d-ae68-968b-7738-edfa21c8ceef@redhat.com>
 <20190122143257.GR13143@redhat.com>
 <c06dd0a6-166f-a522-1f54-736519076432@redhat.com>
 <20190122172333.GA13143@redhat.com>
 <9d0997e0-9019-c7c2-56d6-26c70f0d5c7e@redhat.com>
 <8e9b4f93-234b-9ae0-0ffc-d96de3ce02cb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e9b4f93-234b-9ae0-0ffc-d96de3ce02cb@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 18 Oct 2019 09:34:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 18, 2019 at 11:31:15AM +0200, Thomas Huth wrote:
> On 22/01/2019 19.10, Eric Blake wrote:
> > On 1/22/19 11:23 AM, Daniel P. Berrang=C3=A9 wrote:
> >=20
> >>
> >>>> On this point though, does anyone know of any platforms we support=
[1],
> >>>> or are likely to support in future, where 'strerror' is *not* thre=
ad
> >>>> safe ?
> >>>
> >>> I'm not coming up with one, and I think the problem is independent =
of
> >>> this series (if we DO have a problem, it's a series all its own to
> >>> eradicate the use of strerror() in favor of something safer, either
> >>> picking strerror_l() or dealing with the glibc vs. BSD differences =
in
> >>> strerror_r()).
> >>
> >> Agree that its not really something for this series - this just
> >> made me think of it again.
> >=20
> > Shoot - FreeBSD strerror() is not threadsafe:
> > https://github.com/freebsd/freebsd/blob/master/lib/libc/string/strerr=
or.c#L119
> >=20
> > char *
> > strerror(int num)
> > {
> > 	static char ebuf[NL_TEXTMAX];
> >=20
> > 	if (strerror_r(num, ebuf, sizeof(ebuf)) !=3D 0)
> > 		errno =3D EINVAL;
> > 	return (ebuf);
> > }
> >=20
> >>
> >> We went through the scrubbing in libvirt to use the sane, but still
> >> tedious to call, variant of strerror_r() many years ago. With luck
> >> though it is a worry that can be confined the dustbin of ancient
> >> UNIX history....unless someone can point to evidence to the contrary=
 ?
> >=20
> > libvirt has it easy - they let gnulib do all the work of futzing arou=
nd
> > with getting a working strerror() despite platform bugs and despite
> > glibc's insistence on a non-POSIX signature if _GNU_SOURCE is defined=
.
> > We'll have to do a bit more legwork.
> >=20
> > That said, I've added it to:
> > https://wiki.qemu.org/Contribute/BiteSizedTasks#Error_checking
> >=20
> > if someone wants to do the grunt work.
>=20
> I think we should change that task to switch to g_strerror() from glib
> instead ... as far as I can see, this is a proper wrapper around
> strerror_r(), so we don't have to deal with the implementation oddities
> of strerror_r() in QEMU.

Yeah, I think using g_strerror() makes sense. We've just adopted that
in libvirt precisely to avoid these platform portability oddities and
the really unpleasant API calling convention of strerror_r().


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

