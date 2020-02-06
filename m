Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7746C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C6920659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP3fYI+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C6920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlsp-0006gp-Qw
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izlru-0005RZ-Np
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izlrr-0002nd-EG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:27:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43179
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izlrr-0002me-2H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581013629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isNMXGOUs8sJtDIYt8gNacL6U10T80BtNVzuZugYYu0=;
 b=eP3fYI+D6pNqDk+EmLBWswhNxagNPYyf80T6/CnBJ/dJK2SFo4azj+gr7uSs3zetqexy+/
 bs5Y/aSbl8Nw0ajNAtC0OrSZEG2rDMobUXpQnjqQ6Ft19wrPRkHHwZfP2Yscu2bo8mYcTN
 WhMat3I4R/hk2dt2WeqV3EfuN9oTnoY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Gf49iPlgPAWVyJ7OeGim-A-1; Thu, 06 Feb 2020 13:27:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 161248F6D02;
 Thu,  6 Feb 2020 18:27:01 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30D7C60C63;
 Thu,  6 Feb 2020 18:26:41 +0000 (UTC)
Date: Thu, 6 Feb 2020 18:26:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200206182639.GL3655@work-vm>
References: <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
 <20200206142143.GA4926@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200206142143.GA4926@linux.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Gf49iPlgPAWVyJ7OeGim-A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

* Kevin Wolf (kwolf@redhat.com) wrote:
> Am 06.02.2020 um 10:40 hat Markus Armbruster geschrieben:
> > >> On 2/5/20 8:09 AM, Kevin Wolf wrote:
> > >> > Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
> > >> >>>> The other part that it needs to solve is how to be available by=
 default
> > >> >>>> without specifying anything on the command line. Basically, if =
I press
> > >> >>>> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> > >> >>>> implemented internally or by an external Python process, I don'=
t mind.
> > >> >>>
> > >> >>> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I most=
ly
> > >> >>> use HMP on stdin).
> > >> >>
> > >> >> I don't think it would be that hard, actually.
> > >> >>
> > >> >> If you have a -qmp-shell option that takes a chardev and defaults=
 to vc,
> > >> >> you've solved the part with both stdio and Ctrl-Alt-2. Now all yo=
u need
> > >> >> to do is launch the Python child process, pass it a pair of pipes=
 for
> > >> >> communication and forward everything between the pipes and the ch=
ardev.
> > >> >>
> > >> >> (That's the theory anyway.)
> > >> >=20
> > >> > If someone is interested, I did a quick proof-of-concept hack:
> > >> >=20
> > >> >     https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-shel=
l
> > >> >=20
> > >> > It doesn't clean up anything properly (including the qmp-shell pro=
cesses
> > >> > it starts), but it spawns a usable qmp-shell on a user-specified
> > >> > character device. stdio seems to work, though without readline
> > >> > functionality (I suppose I still have line-buffering somewhere), v=
c
> > >> > doesn't really work at all yet.
> > >> >=20
> > >> > Try it out like this:
> > >> >=20
> > >> >     $ ./qemu-storage-daemon --chardev stdio,id=3Dm --monitor m,mod=
e=3Dqmp-shell
> > >> >     monitor_qmp_event: 1
> > >> >     Welcome to the QMP low-level shell!
> > >> >     Connected to QEMU 4.2.50
> > >> >=20
> > >> >     (QEMU) query-version
> > >> >     {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "pa=
ckage": "v4.2.0-1188-gd95a3885a9"}}
> > >> >     (QEMU) quit
> > >> >=20
> > >> > (Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
> > >> > refactorings in the storage daemon branch, so why not try both at =
once?)
> > >> >=20
> > >> > Polishing this to make it mergable would still require substantial=
 work,
> > >> > so at the moment I'm not planning to do this. But if someone wants=
 to
> > >> > pick it up, feel free (just let us know).
> > >> >=20
> > >> > Hm, in fact... A qmp-shell GSoC project?
> > >> >=20
> > >>=20
> > >> That would be great. I worry that we should have a clear vision for =
the
> > >> syntax before we give this project to an intern, though. With a clea=
r
> > >> vision and an outline for deliverables, it's an incredibly appropria=
te
> > >> project.
> > >>=20
> > >> Some things I think we want to define before we start:
> > >>=20
> > >> 1. What are we trying to achieve with a standalone shell?
> >=20
> > Projects without a clear goal rarely succeed.  Success within three
> > months is even rarer.
> >
> > >> 2. What syntax should it use?
> >=20
> > Leaving that to a GSoC student amounts to setting up for failure.
>=20
> I think this subthread shows that we actually have many separate
> projects that people wish to have someone work on. Each of them is
> probably a bit too small for a whole GSoC, but all of them together are
> probably too much. So I'll guess the student would pick maybe two of
> them, and if time is left at the end, more can be added as a bonus.
>=20
> 1. Something like --monitor mode=3Dqmp-shell that just spawns an external
>    Python script and passes it a QMP socket. This is the fundamental
>    building block for having any kind of external monitor script
>    actually integrated in QEMU, so I think just running the existing
>    qmp-shell this way (with proper support for at least stdio and vc
>    chardevs) would make sense as a first milestone.

I was originally going to suggest that should be sugar for a
-chardev filter  that takes an in/out chardev - but I don't know how
you'd handle tty stuff like formatting and tab completion etc.

> 2. Rewriting qmp-shell to use a better syntax for nested data
>    structures. This would have to be defined before the project starts.
>=20
> 3. Improving qmp-shell UI-wise, e.g. by having better autocompletion,
>    support for counting brackets, or whatever else was mentioned. We
>    have a few ideas, and there's room for the student to add their own
>    ideas, too.
>=20
> 4. Something HMP-like. This isn't QMP any more, so it could as well be a
>    separate script (hmp-shell?). But it could also be integrated in
>    qmp-shell in the form of additional commands that are implemented
>    client-side. Or maybe have a single shell, but have a QMP mode and an
>    HMP mode and the user can switch between these modes.
>=20
>    The syntax for the HMP shell/mode could be the same or different from
>    the QMP syntax. This would have to be defined beforehand, too.

separate script sharing the qmp interface code?

Dave

> 5. Probably more that I just forgot now.
>=20
> Suggesting the exact goals is part of the student application process,
> but for fundamental things like the syntax we should probably already
> know what we want.
>=20
> > >> I think those are the hardest parts.
> > >>
> > >> Below, some musings:
> > >>=20
> > >> - An integrated QMP shell would be a great usability boost to users =
of
> > >> bare QEMU.
> > >>=20
> > >> - It is undesirable in general to support two interfaces. Feature
> > >> disparity is a problem, as is needing to document and test two separ=
ate
> > >> interfaces. The quality disparity between the two is also an issue.
> > >>=20
> > >> - Offering HMP via the GTK interface but not QMP is a discoverabilit=
y
> > >> problem. Unfamiliar users might assume that HMP is our flagship
> > >> interface. It is not.
> > >>=20
> > >> - We are unlikely to re-expand HMP to cover everything QMP does; wri=
ting
> > >> a QMP shell that makes QMP easy to interface with is a better soluti=
on
> > >> for removing redundancy and complexity.
>=20
> I'm not entirely convinced of this because QMP is often too low-level to
> actually address the practical high-level needs of users.
>=20
> But these HMP-ish things are probably easier to maintain as scripts
> outside of the QEMU binary, so I think some kind of "QMP with
> extensions" for human could be the solution.
>=20
> Once it's an external script, it will also be easy to exchange the shell
> for another one depending on user preference, or to hack in whatever
> functionality they are missing.
>=20
> > >> - I suspect that the target audience for users of naked QEMU are:
> > >>   - QEMU developers
> > >>   - Upper-layer developers (RHV, oVirt, KubeVirt, libvirt, kata, et =
al)
> > >> researching, testing, and debugging integration.
> > >>   - Devops professionals testing, implementing and debugging
> > >>     configuration & infrastructure
> > >>   - Security/infosec researchers
> > >>   - Embedded platform developers
> > >>   - Academic researchers
>=20
> Maybe kernel developers should be mentioned separately, but yes, this
> list looks plausible to me.
>=20
> > >> So please correct me if I am off the mark;
> > >>=20
> > >> Design Goals:
> > >>   - The removal of HMP
> > >>   - An easy-to-use interface that remains reasonably "close" to the
> > >> machine API such that it provides a smooth transition to scripting Q=
EMU.
> > >>   - Integration with our GTK interface for discoverability and conve=
nience
>=20
> As I listed above, I think these are actually three separate projects,
> rather than goals for a single big projects.
>=20
> > >> Syntax:
> > >>   - TBD? Do we agree that the current syntax in qmp-shell is "bad" a=
nd
> > >> should be replaced? If yes, what should it look like?
> > >
> > > I believe it should be a python shell with added commands.
> > >
> > > Simple things should be simple.
> > >   e.g. adding a disk from a local file should be trivial.
> > >
> > > Complex things can be complex - but it would be better if they were
> > > simple.
> > >
> > >   It's OK if the worst case of a blockdev is a bit hairy, but
> > >   watch out for cases where the hairyness creeps in unnecessarily.
> >=20
> > Designing interfaces to complex machinery is hard.  Experience tells
> > that we do okay when we focus on the building blocks first.  That's
> > -blockdev.  When we start with trying to make simple things simple, we
> > end in swamps.  That's -drive.
> >=20
> > Focus on building blocks is of course no excuse for unnecessary
> > hairiness.
> >=20
> > It's also no reason not to build more convenient things on top of the
> > building blocks.  I doubt they should go into QMP, though.
>=20
> Right, they should be implemented in that external script, which would
> use the lower-level QMP building blocks to provide the functionality. I
> also think it's a good idea to keep QMP accessible for more exotic use
> cases when the simple thing just doesn't cut it any more.
>=20
> > > If the user screwsup, it should give an error that prompts the user
> > > to the parameter they got wrong.
> > >
> > > Output from commands should normally be pretty formatted (with an opt=
ion
> > > to display raw json for those needing it).
> > >   e.g. that 'query-version' should give either just the package
> > >   version (as info version currently does) or:
> > >       4.2.50  Package: v4.2.0-1188-gd95a3885a9
> > >
> > > We shouldn't lose any HMP commands that some people find useful
> > >   Ditching HMP isn't an option until we've got almost all of it
> > >   covered.
> >=20
> > In particular, we currently use HMP for debugging and monitoring
> > purposes, where we don't need or want QMP's rigor, neither its rigorous
> > interface stability, nor its structured I/O.  We want the "whipuptitude=
"
> > we get from monitor_printf().  This is actually a point David has made
> > several times.
> >=20
> > To have a qmp-shell replace HMP, I think it needs to be able to
> >=20
> > * Go beyond 1:1
> >=20
> >   We tried a 1:1 mapping between HMP and QMP commands, and it didn't
> >   work out.  HMP's replacement should let us build convenient commands
> >   from QMP building blocks.
> >=20
> >   We tried a 1:1 mapping between HMP and QMP command arguments, guided
> >   by @args_type.  Worked out for simple cases, but was too constricting=
.
>=20
> We need to go beyond 1:1, but we probably want to be able to offer 1:1
> as a subset of commands accepted in that shell.
>=20
> Offering only 1:1 in a good way might already be a step forward.
>=20
> > * Preserve "whipuptitude" [David]
> >=20
> >   I figure that means allowing some in QMP.  Without compromising its
> >   core mission, of course.
>=20
> As long as we confine it to x- commands, I think this is okay.
>=20
> > * As discoverable as HMP is now [Kevin]
> >=20
> > * Help, completion and such at least on par with what HMP provides now
>=20
> Will we want to add new annotations in the schema for this?
>=20
> For example, HMP has completion support for block device names. In the
> QAPI schema, these are simply 'str'. We could bake the knowledge that
> in command 'foo' the parameter 'bar' is a block device name, but that
> would be a hack and would probably rarely be consistent with what QEMU
> actually does. It's really something that schema introspection should be
> able to tell us.
>=20
> Kevin
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


