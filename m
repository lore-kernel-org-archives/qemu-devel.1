Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EB5C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E180206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9M2/5eN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E180206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j01DN-0005mJ-FC
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j01Cd-0005L2-JW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j01Cb-00021e-LI
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:49:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j01Cb-00021U-Go
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:49:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581072576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZRrNwBjHDxVNamOvTKLGU5+ZR4Ko2E8TnmCawZ1600=;
 b=U9M2/5eNHrKjr3CbJPe7tRtFbPzm66j2aVZ3nBXrewG2xR8u/fHa/NcE9h3jZfn4SXra3I
 nZEZ8EzaDld3YeVwBUib+QmyLVeh+6paNwn9pybEhk4GwpPBETTPufDRQo+aQERswmWukq
 WFAZvwcamgHX1omXW0qAhi+es8uo66E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-eLvAqG6GP4K58Xg1nWaBEA-1; Fri, 07 Feb 2020 05:49:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DD9061183;
 Fri,  7 Feb 2020 10:49:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A8D65C554;
 Fri,  7 Feb 2020 10:49:18 +0000 (UTC)
Date: Fri, 7 Feb 2020 11:49:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200207104917.GD6031@linux.fritz.box>
References: <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206142143.GA4926@linux.fritz.box>
 <20200206182639.GL3655@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200206182639.GL3655@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: eLvAqG6GP4K58Xg1nWaBEA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.02.2020 um 19:26 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 06.02.2020 um 10:40 hat Markus Armbruster geschrieben:
> > > >> On 2/5/20 8:09 AM, Kevin Wolf wrote:
> > > >> > Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
> > > >> >>>> The other part that it needs to solve is how to be available =
by default
> > > >> >>>> without specifying anything on the command line. Basically, i=
f I press
> > > >> >>>> Ctrl-Alt-2, I want to get to a monitor shell. If that shell i=
s
> > > >> >>>> implemented internally or by an external Python process, I do=
n't mind.
> > > >> >>>
> > > >> >>> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mo=
stly
> > > >> >>> use HMP on stdin).
> > > >> >>
> > > >> >> I don't think it would be that hard, actually.
> > > >> >>
> > > >> >> If you have a -qmp-shell option that takes a chardev and defaul=
ts to vc,
> > > >> >> you've solved the part with both stdio and Ctrl-Alt-2. Now all =
you need
> > > >> >> to do is launch the Python child process, pass it a pair of pip=
es for
> > > >> >> communication and forward everything between the pipes and the =
chardev.
> > > >> >>
> > > >> >> (That's the theory anyway.)
> > > >> >=20
> > > >> > If someone is interested, I did a quick proof-of-concept hack:
> > > >> >=20
> > > >> >     https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-sh=
ell
> > > >> >=20
> > > >> > It doesn't clean up anything properly (including the qmp-shell p=
rocesses
> > > >> > it starts), but it spawns a usable qmp-shell on a user-specified
> > > >> > character device. stdio seems to work, though without readline
> > > >> > functionality (I suppose I still have line-buffering somewhere),=
 vc
> > > >> > doesn't really work at all yet.
> > > >> >=20
> > > >> > Try it out like this:
> > > >> >=20
> > > >> >     $ ./qemu-storage-daemon --chardev stdio,id=3Dm --monitor m,m=
ode=3Dqmp-shell
> > > >> >     monitor_qmp_event: 1
> > > >> >     Welcome to the QMP low-level shell!
> > > >> >     Connected to QEMU 4.2.50
> > > >> >=20
> > > >> >     (QEMU) query-version
> > > >> >     {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "=
package": "v4.2.0-1188-gd95a3885a9"}}
> > > >> >     (QEMU) quit
> > > >> >=20
> > > >> > (Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
> > > >> > refactorings in the storage daemon branch, so why not try both a=
t once?)
> > > >> >=20
> > > >> > Polishing this to make it mergable would still require substanti=
al work,
> > > >> > so at the moment I'm not planning to do this. But if someone wan=
ts to
> > > >> > pick it up, feel free (just let us know).
> > > >> >=20
> > > >> > Hm, in fact... A qmp-shell GSoC project?
> > > >> >=20
> > > >>=20
> > > >> That would be great. I worry that we should have a clear vision fo=
r the
> > > >> syntax before we give this project to an intern, though. With a cl=
ear
> > > >> vision and an outline for deliverables, it's an incredibly appropr=
iate
> > > >> project.
> > > >>=20
> > > >> Some things I think we want to define before we start:
> > > >>=20
> > > >> 1. What are we trying to achieve with a standalone shell?
> > >=20
> > > Projects without a clear goal rarely succeed.  Success within three
> > > months is even rarer.
> > >
> > > >> 2. What syntax should it use?
> > >=20
> > > Leaving that to a GSoC student amounts to setting up for failure.
> >=20
> > I think this subthread shows that we actually have many separate
> > projects that people wish to have someone work on. Each of them is
> > probably a bit too small for a whole GSoC, but all of them together are
> > probably too much. So I'll guess the student would pick maybe two of
> > them, and if time is left at the end, more can be added as a bonus.
> >=20
> > 1. Something like --monitor mode=3Dqmp-shell that just spawns an extern=
al
> >    Python script and passes it a QMP socket. This is the fundamental
> >    building block for having any kind of external monitor script
> >    actually integrated in QEMU, so I think just running the existing
> >    qmp-shell this way (with proper support for at least stdio and vc
> >    chardevs) would make sense as a first milestone.
>=20
> I was originally going to suggest that should be sugar for a
> -chardev filter  that takes an in/out chardev - but I don't know how
> you'd handle tty stuff like formatting and tab completion etc.

Originally I thought the same, but it's actually not enough. The
external process needs not only stdio connected to the chardev, but also
another file descriptor for a QMP socket.

I guess tab completion should be possible if we can turn off line
buffering. Not sure what's the problem with formatting.

> > 2. Rewriting qmp-shell to use a better syntax for nested data
> >    structures. This would have to be defined before the project starts.
> >=20
> > 3. Improving qmp-shell UI-wise, e.g. by having better autocompletion,
> >    support for counting brackets, or whatever else was mentioned. We
> >    have a few ideas, and there's room for the student to add their own
> >    ideas, too.
> >=20
> > 4. Something HMP-like. This isn't QMP any more, so it could as well be =
a
> >    separate script (hmp-shell?). But it could also be integrated in
> >    qmp-shell in the form of additional commands that are implemented
> >    client-side. Or maybe have a single shell, but have a QMP mode and a=
n
> >    HMP mode and the user can switch between these modes.
> >=20
> >    The syntax for the HMP shell/mode could be the same or different fro=
m
> >    the QMP syntax. This would have to be defined beforehand, too.
>=20
> separate script sharing the qmp interface code?

I would certainly expect that any QMP/HMP shell code uses the existing
QEMUMonitorProtocol Python class. qmp-shell already does.

Maybe they could share a bit more (command parsing?) if we want to have
separate scripts for HMP and QMP. Though actually I think I like the
idea of a combined QMP/HMP shell better at the moment.

Kevin


