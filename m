Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96DCC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F6B227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tzkklehg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F6B227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyxL-0004Wa-Lc
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ihywf-00041T-8Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ihywc-0001Xg-EV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:46:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33163
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ihywb-0001QR-Qy
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:46:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576773992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2CMYJbrpnjCCIxn1xrlQdTGITYJG5ziAf0+MSWSwCEg=;
 b=Tzkklehg/XvJL8q2yqBm1pW2tAQPEFD6RWZ4tuouik+FnMJK+zDNmj8lTsa4IKL2+jsidx
 GaKNTeSx06ydrVxXlVcggAvX75CaEX+7xbOa92N7hNEtPJl0G8nNUjGZQHlgYT1XnmPsbx
 or7Mpvlz8F22D00gSm1ZOTI/kTS+gI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Mj45HiboM7OudSDV1HChhA-1; Thu, 19 Dec 2019 11:46:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7083010AE7EE;
 Thu, 19 Dec 2019 16:46:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D080460BEC;
 Thu, 19 Dec 2019 16:46:13 +0000 (UTC)
Date: Thu, 19 Dec 2019 16:46:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191219164611.GA1698075@redhat.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219125021.GH1190276@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219125021.GH1190276@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Mj45HiboM7OudSDV1HChhA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 19, 2019 at 12:50:21PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> >=20
> >=20
> > > On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> > >=20
> > > On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> > >>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.c=
om> wrote:
> > >>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi =
wrote:
> > >>>> Is there a work-in-progress muser patch series you can post to sta=
rt the
> > >>>> discussion early?  That way we can avoid reviewers like myself ask=
ing
> > >>>> you to make changes after you have invested a lot of time.
> > >>>>=20
> > >>>=20
> > >>> Absolutely, that is our plan. At the moment we do not have the patc=
hes
> > >>> ready for the review. We have setup internally a milestone and will=
 be
> > >>> sending that early version as a tarball after we have it completed.
> > >>> Would be also a meeting something that could help us to stay on the=
 same
> > >>> page?
> > >>=20
> > >> Please loop us in if you so set up a meeting.
> > >=20
> > > There is a bi-weekly KVM Community Call that we can use for phone
> > > discussions:
> > >=20
> > >  https://calendar.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZ=
wNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> > >=20
> > > Or we can schedule a one-off call at any time :).
> >=20
> > Sounds good either way, whenever it's needed.
> >=20
> > >=20
> > > Questions I've seen when discussing muser with people have been:
> > >=20
> > > 1. Can unprivileged containers create muser devices?  If not, this is=
 a
> > >   blocker for use cases that want to avoid root privileges entirely.
> >=20
> > Yes you can. Muser device creation follows the same process as general
> > mdev device creation (ie. you write to a sysfs path). That creates an
> > entry in /dev/vfio and the control plane can further drop privileges
> > there (set selinux contexts, &c.)
>=20
> This isn't what I'd describe / consider as unprivileged, as AFAICT
> although QEMU can use it unprivileged, this still requires a privileged
> management process to do the setup in sysfs.
>=20
> I think it is desirable to be able support a fully unprivileged
> model where there is nothing requiring elevated privileges, neither
> libvirtd or QEMU.
>=20
> I think this basically ends up at the same requirement as support
> for non-Linux hosts. We have to assume that some desirable deployment
> scenarios will not be able to use Linux kernel features, either because
> they lack privileges, or are simply non-Linux hosts.
>=20
> > > 2. Does muser need to be in the kernel (e.g. slower to develop/ship,
> > >   security reasons)?  A similar library could be implemented in
> > >   userspace along the lines of the vhost-user protocol.  Although VMM=
s
> > >   would then need to use a new libmuser-client library instead of
> > >   reusing their VFIO code to access the device.
> >=20
> > Doing it in userspace was the flow we proposed back in last year's KVM
> > Forum (Edinburgh), but it got turned down. That's why we procured the
> > kernel approach, which turned out to have some advantages:
> > - No changes needed to Qemu
> > - No Qemu needed at all for userspace drivers
> > - Device emulation process restart is trivial
> >   (it therefore makes device code upgrades much easier)
> >=20
> > Having said that, nothing stops us from enhancing libmuser to talk
> > directly to Qemu (for the Qemu case). I envision at least two ways of
> > doing that:
> > - Hooking up libmuser with Qemu directly (eg. over a unix socket)
>=20
> A UNIX socket, or localhost TCP socket, sounds most appealing from a
> a portability POV.

Felipe reminded me on IRC that muser needs FD passing, so a TCP
localhost socket is not an option.  So UNIX socket would give us
portability to any platform, except for Windows. It is not the
end of the world to lack Windows support.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


