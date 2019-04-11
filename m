Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF4CC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09D32077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09D32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZ0E-0007sn-Aq
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:40:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYz9-00076X-7H
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hEYz8-0005NF-1n
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hEYz7-0005Mw-OW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FC3A85A03;
	Thu, 11 Apr 2019 12:39:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D0E660FB4;
	Thu, 11 Apr 2019 12:39:14 +0000 (UTC)
Date: Thu, 11 Apr 2019 13:39:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190411123911.GR3641@redhat.com>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190411120421.GP3641@redhat.com>
	<219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <219131554985898@iva6-8a76e93b6298.qloud-c.yandex.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 11 Apr 2019 12:39:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411123911.llAJQCUBTqKSR1gFmxrKL1nNQtqKpf9M1HcVTao3-kI@z>

On Thu, Apr 11, 2019 at 03:31:43PM +0300, Yury Kotov wrote:
> 11.04.2019, 15:04, "Daniel P. Berrang=C3=A9" <berrange@redhat.com>:
> > On Wed, Apr 10, 2019 at 12:26:52PM +0300, Yury Kotov wrote:
> >> =C2=A0Currently such case is possible for incoming:
> >> =C2=A0QMP: add-fd (fdset =3D 0, fd of some file):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adds fd to fdset 0 and returns QEMU's =
fd (e.g. 33)
> >> =C2=A0QMP: migrate-incoming (uri =3D "fd:33"): fd is stored in QIOCh=
annel *ioc
> >> =C2=A0...
> >> =C2=A0Incoming migration completes and unrefs ioc -> close(33)
> >> =C2=A0QMP: remove-fd (fdset =3D 0, fd =3D 33):
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0removes fd from fdset 0 and qemu_close=
() -> close(33) =3D> double close
> >
> > IMHO this is user error.
> >
> > You've given the FD to QEMU and told it to use it for migration.
> >
> > Once you've done that you should not be calling remove-fd.
> >
> > remove-fd should only be used in some error code path. ie if you
> > have called add-fd, and then some failure means you've decided you
> > can't invoke 'migrate-incoming'. Now you should call "remove-fd".
> >
> > AFAIK, we have never documented that 'add-fd' must be paired
> > with 'remove-fd'.
> >
> > IOW, I think this "fix" is in fact not a fix - it is instead
> > changing the semantics of when "remove-fd" should be used.
> >
>=20
> I think it might be user's error but fd is still in cur_mon->fds (in ge=
tfd case)
> or in mon_fdsets (in add-fd case). So if fd is still exists in the list=
s why
> user can't close/remove it?
>=20
> So, there are 2 valid options:
> 1) fd is still valid after migration (dup)

If we do this then existing mgmt apps using QEMU who don't expect to need
to call remove-fd are going to be leaking FDs forever.

> 2) fd is closed but also removed from the appropriate list

monitor_get_fd currently leaves the FD on the list.

if all current users of that API are closing the FD
themselves, then we could change that method to remove
it from the list.

Either way the requirements in this area are pooly documented
both from QEMU's internal POV and from mgmt app public QMP pov.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

