Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0D426691
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 09:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0D426691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWdeU-0003HO-Nq
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 05:16:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWddU-0002gu-85
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWddS-0000fD-4J
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1hWddM-0000aI-OR
	for qemu-devel@nongnu.org; Fri, 31 May 2019 05:15:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D43C5C002965;
	Fri, 31 May 2019 09:15:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-126.ams2.redhat.com
	[10.36.117.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4545608CA;
	Fri, 31 May 2019 09:15:20 +0000 (UTC)
Date: Fri, 31 May 2019 11:15:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190531091514.GA9842@localhost.localdomain>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
	<87sgt7sxhy.fsf@dusky.pond.sub.org>
	<CAJ+F1CJ6hpQZf6199_-rAW98HwEssNT_kXBJF9he9NZFvWaGPA@mail.gmail.com>
	<87tvdlhakq.fsf@dusky.pond.sub.org>
	<CAJ+F1CJLuNVu_aWPjQtFwP_tLMqn=vd_gCtW7SWZWdhYMF6H7w@mail.gmail.com>
	<87blzo1fa5.fsf@dusky.pond.sub.org>
	<20190527090731.uohmamahlg53bu77@sirius.home.kraxel.org>
	<87pno46ngf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87pno46ngf.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 31 May 2019 09:15:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	=?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 27.05.2019 um 15:23 hat Markus Armbruster geschrieben:
> Gerd Hoffmann <kraxel@redhat.com> writes:
>=20
> > On Mon, May 27, 2019 at 10:18:42AM +0200, Markus Armbruster wrote:
> >> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> writes:
> >>=20
> >> > Hi
> >> >
> >> > On Thu, May 23, 2019 at 9:52 AM Markus Armbruster <armbru@redhat.c=
om> wrote:
> >> >> I'm not sure how asynchronous commands could support reconnect an=
d
> >> >> resume.
> >> >
> >> > The same way as current commands, including job commands.
> >>=20
> >> Consider the following scenario: a management application such as
> >> libvirt starts a long-running task with the intent to monitor it unt=
il
> >> it finishes.  Half-way through, the management application needs to
> >> disconnect and reconnect for some reason (systemctl restart, or cras=
h &
> >> recover, or whatever).
> >>=20
> >> If the long-running task is a job, the management application can re=
sume
> >> after reconnect: the job's ID is as valid as it was before, and the
> >> commands to query and control the job work as before.
> >>=20
> >> What if it's and asynchronous command?
> >
> > This is not meant for some long-running job which you have to manage.
> >
> > Allowing commands being asynchronous makes sense for things which (a)
> > typically don't take long, and (b) don't need any management.
> >
> > So, if the connection goes down the job is simply canceled, and after
> > reconnecting the management can simply send the same command again.
>=20
> Is this worth its own infrastructure?
>=20
> Would you hazard a guess on how many commands can take long enough to
> demand a conversion to asynchronous, yet not need any management?

Candidates are any commands that perform I/O. You don't want to hold the
BQL while doing I/O. Probably most block layer commands fall into this
category.

In fact, even the commands to start a block job could probably make use
of this infrastructure because they typically do some I/O before
returning success for starting the job.

> >> > Whenever we can solve things on qemu side, I would rather not
> >> > deprecate current API.
> >>=20
> >> Making a synchronous command asynchronous definitely changes API.
> >
> > Inside qemu yes, sure.  But for the QMP client nothing changes.
>=20
> Command replies can arrive out of order, can't they?

My understanding is that this is just an internal change and commands
still aren't processed in parallel.

Kevin

