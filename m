Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B988C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C3820730
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 19:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwZ3HjDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C3820730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izQhQ-0005sc-H4
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 14:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37584)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izQgc-0005Kl-TJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izQgZ-0005g1-Jo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:50:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49549
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izQgZ-0005Tq-At
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 14:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580932205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DtRyeb82aUczV8smihJnJrn4lmylROlQCyKZlt53fY=;
 b=KwZ3HjDyg4cMOvhTIn/8o5+KEU1eXnePtSwzKxxAqkJLmfwMCYx7DQ8uybowsApRqO4PLk
 wQUjFodvOkt9a99D/+weC4gsaxiUImdVBdXIvi3ULuf75H1wWOiaW/GyGc9qLq++XV4ypC
 BLfeeUq3cbHHBK3i2SN5nghyAtloypE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-n6F7zIJ0MJWRGsvT9ywDyA-1; Wed, 05 Feb 2020 14:49:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 885BE63AD8;
 Wed,  5 Feb 2020 19:49:57 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D90B9859A9;
 Wed,  5 Feb 2020 19:49:47 +0000 (UTC)
Date: Wed, 5 Feb 2020 19:49:44 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy? (Was: Re: Making QEMU easier for
 management tools and applications)
Message-ID: <20200205194944.GP3210@work-vm>
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: n6F7zIJ0MJWRGsvT9ywDyA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* John Snow (jsnow@redhat.com) wrote:
> I'm forking the subject as I believe Markus wanted to focus on the
> machine interface aspect.
>=20
> I feel that a new human interface is *related* to that goal: the
> splitting of, and commitment to, separate human and machine interfaces
> powered by a single root schema.
>=20
> I am a big believer in making QEMU usable directly to human users as I
> feel the pipeline of "tinker to deployment" is important for a
> successful project, for many reasons:
>=20
> - QEMU should be easy to pick up and learn.
>=20
> - Supporting QEMU's use directly as an "end-user" program increases
> proficiency in the user population at large, which (can) lead to better
> answers and engagement on e.g. Reddit, StackOverflow, IRC
>=20
> - Evolving deployments from QEMU-only to libvirt+ or above (RHV, oVirt,
> kubevirt) should be a smooth and gradual process as additional
> complexity is desired.
>=20
> - Focusing on QEMU's usability allows our project to be consumed easier
> by new cloud-focused projects. If they are already familiar with (and
> happy with) our project, it is more likely to be used instead of seeking
> out alternatives. This is about reducing friction.
>=20
> So, for those reasons ... even though I feel that a machine-focused API
> is our #1 priority as it caters to our existing users, we should also
> focus on what it will take to grow mindshare for QEMU's value in the
> ecosystem.
>=20
> Slick interfaces and documentation go a long, long way to doing that.
>=20
> So: I feel that any new machine-only paradigm or overhaul needs to be
> accompanied with some new sugar to help the medicine go down, so-to-speak=
.
>=20
> On 2/5/20 8:09 AM, Kevin Wolf wrote:
> > Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
> >>>> The other part that it needs to solve is how to be available by defa=
ult
> >>>> without specifying anything on the command line. Basically, if I pre=
ss
> >>>> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
> >>>> implemented internally or by an external Python process, I don't min=
d.
> >>>
> >>> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
> >>> use HMP on stdin).
> >>
> >> I don't think it would be that hard, actually.
> >>
> >> If you have a -qmp-shell option that takes a chardev and defaults to v=
c,
> >> you've solved the part with both stdio and Ctrl-Alt-2. Now all you nee=
d
> >> to do is launch the Python child process, pass it a pair of pipes for
> >> communication and forward everything between the pipes and the chardev=
.
> >>
> >> (That's the theory anyway.)
> >=20
> > If someone is interested, I did a quick proof-of-concept hack:
> >=20
> >     https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-shell
> >=20
> > It doesn't clean up anything properly (including the qmp-shell processe=
s
> > it starts), but it spawns a usable qmp-shell on a user-specified
> > character device. stdio seems to work, though without readline
> > functionality (I suppose I still have line-buffering somewhere), vc
> > doesn't really work at all yet.
> >=20
> > Try it out like this:
> >=20
> >     $ ./qemu-storage-daemon --chardev stdio,id=3Dm --monitor m,mode=3Dq=
mp-shell
> >     monitor_qmp_event: 1
> >     Welcome to the QMP low-level shell!
> >     Connected to QEMU 4.2.50
> >=20
> >     (QEMU) query-version
> >     {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "package=
": "v4.2.0-1188-gd95a3885a9"}}
> >     (QEMU) quit
> >=20
> > (Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
> > refactorings in the storage daemon branch, so why not try both at once?=
)
> >=20
> > Polishing this to make it mergable would still require substantial work=
,
> > so at the moment I'm not planning to do this. But if someone wants to
> > pick it up, feel free (just let us know).
> >=20
> > Hm, in fact... A qmp-shell GSoC project?
> >=20
>=20
> That would be great. I worry that we should have a clear vision for the
> syntax before we give this project to an intern, though. With a clear
> vision and an outline for deliverables, it's an incredibly appropriate
> project.
>=20
> Some things I think we want to define before we start:
>=20
> 1. What are we trying to achieve with a standalone shell?
> 2. What syntax should it use?
>=20
> I think those are the hardest parts.
>=20
>=20
> Below, some musings:
>=20
> - An integrated QMP shell would be a great usability boost to users of
> bare QEMU.
>=20
> - It is undesirable in general to support two interfaces. Feature
> disparity is a problem, as is needing to document and test two separate
> interfaces. The quality disparity between the two is also an issue.
>=20
> - Offering HMP via the GTK interface but not QMP is a discoverability
> problem. Unfamiliar users might assume that HMP is our flagship
> interface. It is not.
>=20
> - We are unlikely to re-expand HMP to cover everything QMP does; writing
> a QMP shell that makes QMP easy to interface with is a better solution
> for removing redundancy and complexity.
>=20
> - I suspect that the target audience for users of naked QEMU are:
>   - QEMU developers
>   - Upper-layer developers (RHV, oVirt, KubeVirt, libvirt, kata, et al)
> researching, testing, and debugging integration.
>   - Devops professionals testing, implementing and debugging
>     configuration & infrastructure
>   - Security/infosec researchers
>   - Embedded platform developers
>   - Academic researchers
>=20
>=20
>=20
> So please correct me if I am off the mark;
>=20
> Design Goals:
>   - The removal of HMP
>   - An easy-to-use interface that remains reasonably "close" to the
> machine API such that it provides a smooth transition to scripting QEMU.
>   - Integration with our GTK interface for discoverability and convenienc=
e
>=20
> Syntax:
>   - TBD? Do we agree that the current syntax in qmp-shell is "bad" and
> should be replaced? If yes, what should it look like?

I believe it should be a python shell with added commands.

Simple things should be simple.
  e.g. adding a disk from a local file should be trivial.

Complex things can be complex - but it would be better if they were
simple.

  It's OK if the worst case of a blockdev is a bit hairy, but
  watch out for cases where the hairyness creeps in unnecessarily.

If the user screwsup, it should give an error that prompts the user
to the parameter they got wrong.

Output from commands should normally be pretty formatted (with an option
to display raw json for those needing it).
  e.g. that 'query-version' should give either just the package
  version (as info version currently does) or:
      4.2.50  Package: v4.2.0-1188-gd95a3885a9

We shouldn't lose any HMP commands that some people find useful
  Ditching HMP isn't an option until we've got almost all of it
  covered.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


