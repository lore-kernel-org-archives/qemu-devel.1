Return-Path: <SRS0=g5aJ=2O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87EC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 13:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A642206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2019 13:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VziQgUV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A642206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijjp3-0000hU-D9
	for qemu-devel@archiver.kernel.org; Tue, 24 Dec 2019 08:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1ijjo7-0008Pf-0L
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1ijjo3-0002Ca-AF
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:01:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ijjo3-0002CI-4y
 for qemu-devel@nongnu.org; Tue, 24 Dec 2019 08:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577192458;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ag4pHv8kmPnhtjwOhQqFO5IK4tdu2YClJ+pmEw+OQ/Y=;
 b=VziQgUV8H9RtpGmkt2Tz3Hl/rNpMNdclvW0M9JmROIFbw0Lh1WS4XL9HBCVB9FLjf2+ljS
 CczuY9n/Z1UduLfhTmVXXsh3ju2XvrEQGSNTeUO8xR4GnJekMeeeAoV+dLbXnBgNgmbQ9M
 MlnTgaV1JNhVcXdnhQFC6GShRzmvUJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-7e5f0ISkPlyAZgeUFK4I4g-1; Tue, 24 Dec 2019 08:00:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CECB477;
 Tue, 24 Dec 2019 13:00:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81AF781657;
 Tue, 24 Dec 2019 13:00:38 +0000 (UTC)
Date: Tue, 24 Dec 2019 13:00:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20191224130035.GC2710539@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7e5f0ISkPlyAZgeUFK4I4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 04:13:59PM +0000, Stefan Hajnoczi wrote:
> Hi,
> QEMU presents a command-line interface and QMP monitor for
> applications to interact with.  Applications actually need API
> bindings in their programming language.  Bindings avoid reimplementing
> code to spawn a QEMU process and interact with QMP.  QEMU is kind of
> lazy and de facto relies on libvirt for API bindings.
>=20
> Is it time for better QEMU APIs?
>=20
> 1. We have qapi-schema.json.  Let's render to HTML and publish
> versioned documentation online.

You have patches to publish this to the website already which is
good for git master. We still need to get this published for
stable releases, ideally we would have up to publish it for our
pre-existing stable releases back a year or two too.

At the same time though this is insufficient. It is *really* hard
to understand how QAPI schema maps to either JSON or CLI args for
either QMP or the CLI. Most docs examples just talk in terms of
-drive. I think the qapi schema docs could benefit from more
work to provide real world example usage inline.


> 2. scripts/qmp/ contains command-line tools for QMP communication.
> They could use some polish and then be shipped.

The qmp-shell in particular is interesting. Libvirt has a similar
need for a simpler way to deal with QMP and "virsh qemu-monitor-command"
has notable overlap with functionality of qmp-shell.

I wonder if there's a way to spin this off so that we have have a
standard QMP client shell that can either talk direct to a UNIX
socket, or indirect via libvirt's QMP command passthrough APIs.

> 3. python/qemu/ contains Python modules for managing a QEMU process
> and QMP communication.  This should be packaged in distros and
> available on PyPI.
>
> 4. Go and Rust bindings would also be useful.  There is
> https://github.com/intel/govmm but I think it makes sense to keep it
> in qemu.git and provide an interface similar to our Python modules.

Presumably you mean bindings for the QMP commands ?  This will
quickly expand to mean bindings for every aspect of QEMU configuration
that's currently QAPI-ified. It will quickly become a very big job
to design, develop & maintain, especially if you want to support
multiple languages in a natural way.

> 5. A jailer is needed to isolate the QEMU process and vhost-user
> device backends using seccomp, Linux namespaces, and maybe
> SELinux/AppArmor.  We used to be able to rely on libvirt for QEMU
> security, but it's becoming a common task for any device backend and
> IMO should be its own launcher tool.

Based on experiance in libvirt, this is an even larger job than (4),
as the feature set here is huge.  Much of it directly ties into the
config problem, as to deal with SELinux / namespace setup the code
needs to understand what resources to provide access to. This
requires a way to express 100% coverage of all QEMU configuration
in use & analyse it to determine what resources it implies. So this
ties strongly into QAPI-ification completion.


On the libvirt side, we've a strong long term desire to move our
codebase from C to either Go or Rust. In doing this refactoring
and rewriting, we would quite likely end up with self-contained
packages / modules / APIs that can be used independantly of the
main libvirt API. Thus there's probably scope here to collaborate
between libvirt & QEMU communities to develop new APIs.

Some of this code could be directly QEMU related, but other parts
of the code are likely to be generic & not tied to QEMU at all.
For example libvirt's SELinux, namespace, cgroup setup code is used
by LXC too. Thus from the libvirt POV, some libraries might be
deliverable by QEMU project, but others might be deliverable by
libvirt project. Or might be scope for a indepent new project to
deliver pieces.

Essentially we can consider a stack

     +--------------+
     |  Libvirt API |
     +--------------+
           |
=09   V
     +--------------+
     | Helper APIs  |
     +--------------+
           |
=09   V
     +--------------+
     |  QEMU        |
     +--------------+

Right now, everything in "Helper APIs" is hidden inside libvirt.
Some of that conceptually ought to be deliverable by QEMU. Some
of that ought to be spun out as separate deliverables by libvirt
or another independant project.

> 6. A configuration file format is sorely needed so that guest
> configuration can be persisted and easily launched.  Today you have to
> create a shell script that executes a QEMU command-line, but this is
> suboptimal because sharing executable scripts is dangerous from a
> security perspective and is hard to parse or modify programmatically.

A configuration file is just one aspect of our broader configuration
problem.

Our CLI in particular suffers from trying to be "all things to all people"
and IMHO is a direct cause of the perception of QEMU as being overly
complex, hard to understand & burdened by legacy support. Of course we
didn't set out intentionally on this path, things just grew organically
we were not succesfully enough at tackling technical debt over time.

To pick on blockdev, as it has had the most growth, IIUC we have

  $QEMU FILENAME
  $QEMU -hda FILENAME
  $QEMU -drive if=3Dide,file=3DFILENAME
  $QEMU -drive if=3Dnone,file=3DFILENAME,id=3Ddisk0 -device virtio-blk,driv=
e=3Ddisk0
  $QEMU -blockdev driver=3Draw,file.filename=3DFILENAME,id=3Ddisk0 -device =
virtio-blk,drive=3Ddisk0

IIUC, in (all/most) cases "FILENAME" can be either a plain filename,
or a "json:{....}" string, so that's giving us possibly as many as
10 ways to configure disks, with increasing generality.

If you were designing QEMU from a clean slate it is unlikely we'd
plan to have 10 syntaxes. A clean slate would probably provide
2 different syntaxes at most - one simple but convenient, and one
complex but fully expressive.

For every one there's going to be some set of users who think
their chosen syntax is ideal, and will thus be unhappy if we
cull one choice.  For the health of QEMU long term though, I
think we're going to have to accept the need to make some people
temporarily unhappy in order to become sustaininable over the
long term.


This ultimately all stems from the fact that the CLI design has
aimed to provide 100% coverage of all QEMU features for mgmt apps,
while at the same time as providing convenient syntax for humans.
Except it has actually failed in the former, because there's some
stuff you can only configured after launching QEMU via QMP commands.

We can reduce some of the maint burden by mapping "convenient syntax"
onto the more expressive (usually QAPI modelled) syntax internally,
but I think that alone is insufficient.

We should step back & consider the bigger question of what we want
QEMU's approach to configuration to be.

With my libvirt hat on, we have to support JSON for a large portion
of config because we need to use QMP hotplug. Thus if we could eliminate
the need to use the CLI syntax entirely, it would remove / simplify
libvirt's code base to work exclusively in terms of JSON.

With this in mind, I think we could reasonably declare a high level
goal that

 - CLI arg syntax is *exclusively* for human targetted convenient syntax
 - CLI arg syntax will *not* aim for 100% feature coverage
 - CLI arg syntax will not guarantee strict back compat but will not
   gratituitously break human usage
 - JSON syntax will provide 100% feature coverage for mmgmt apps and humans
 - JSON syntax will not be exposed via ARGV
 - JSON syntax will be usable via a config file
 - JSON syntax will be usable via QMP
 - JSON syntax will provide strict back compat, but with deprecations
   policy followed

This is more or less what our long term goal with QAPI has always
been. The sticking point has always been the tension with CLI arg
syntax back-compat. We need to decide how to cut the knot so that
we can complete the QAPI-ification in a forseeable amount of time.

> In many of these areas we already have a partial solution.  It just
> needs more work.  I think it would be worth the effort and the mental
> shift to really providing APIs that are easy to use by applications.
>=20
> What do you think?

Personally I think QEMU configuration is the single biggest pain point
for dealing with QEMU that we're not investing enough resources in.

> Have I missed things that are needed?
>=20
> Have I included things that are unnecessary?

Many of the things you list above are conceptually nice, but imply a
lot of extra work for maintainers, as they are expanding the scope of
the QEMU project. There's a risk this could divert resources away from
tackling technical debt in things we're already maintaining. The flip
side of course is that some of the things might attract new contributors
to the project, because new concepts are inevitably more interesting to
some people than tackling technical debt. IOW both are important and
we need to find a balance between them.

One of the serious long term issues we've had in QEMU is our inability
to finish jobs that we start. The configuration problem is the biggest
example or something we started JSON-ifying 10 years ago, but are still
an unknowable amount of time away from finishing.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


