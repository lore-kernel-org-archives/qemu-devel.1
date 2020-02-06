Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB168C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0E1214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOqXk+AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0E1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlkw-00007t-M4
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1izljz-0007Os-FH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1izljx-0001Pc-ST
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:19:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1izljx-0001N0-O8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581013141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASPjptcycQvfYD9VSyp5SVH2V6vSXO+5fG95WXM7lBI=;
 b=TOqXk+AUKzfKQfUp6NaQ0N0uvakRQ/EuXHgklpV4yEvw2QJes5r/T1uTZUqUQjnn84Lp8w
 mYUdacVeju0zwuhTuNossnRw/5r4pa8I28rJE8rpn/wgHZD6eJweS1QMuucLAs+ZQmJtnl
 0t2/XcnX+FIEYvfj9lBbCI7BTbAYIrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-9Gt6LXvlNUeAhdjTknvcPw-1; Thu, 06 Feb 2020 13:18:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4BA189F768;
 Thu,  6 Feb 2020 18:18:48 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD5785DA7C;
 Thu,  6 Feb 2020 18:18:38 +0000 (UTC)
Date: Thu, 6 Feb 2020 18:18:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: qmp-shell for GSoC/Outreachy?
Message-ID: <20200206181836.GK3655@work-vm>
References: <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com>
 <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm>
 <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877e10xdd6.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9Gt6LXvlNUeAhdjTknvcPw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Markus Armbruster (armbru@redhat.com) wrote:
  That I wrote:
> >
> > I believe it should be a python shell with added commands.
> >
> > Simple things should be simple.
> >   e.g. adding a disk from a local file should be trivial.
> >
> > Complex things can be complex - but it would be better if they were
> > simple.
> >
> >   It's OK if the worst case of a blockdev is a bit hairy, but
> >   watch out for cases where the hairyness creeps in unnecessarily.
>=20
> Designing interfaces to complex machinery is hard.  Experience tells
> that we do okay when we focus on the building blocks first.  That's
> -blockdev.  When we start with trying to make simple things simple, we
> end in swamps.  That's -drive.
>=20
> Focus on building blocks is of course no excuse for unnecessary
> hairiness.
>=20
> It's also no reason not to build more convenient things on top of the
> building blocks.  I doubt they should go into QMP, though.

I see where you're coming from, but I like -drive - it's simple for
simple things; maybe it's a nightmare for some others, but if I just
want a VM with a disk on virtio, it's easy.

But I agree if you have good building blocks and they're easy to
understand and easy to represent, it's not a bad start.

> > If the user screwsup, it should give an error that prompts the user
> > to the parameter they got wrong.
> >
> > Output from commands should normally be pretty formatted (with an optio=
n
> > to display raw json for those needing it).
> >   e.g. that 'query-version' should give either just the package
> >   version (as info version currently does) or:
> >       4.2.50  Package: v4.2.0-1188-gd95a3885a9
> >
> > We shouldn't lose any HMP commands that some people find useful
> >   Ditching HMP isn't an option until we've got almost all of it
> >   covered.
>=20
> In particular, we currently use HMP for debugging and monitoring
> purposes, where we don't need or want QMP's rigor, neither its rigorous
> interface stability, nor its structured I/O.  We want the "whipuptitude"
> we get from monitor_printf().  This is actually a point David has made
> several times.
>=20
> To have a qmp-shell replace HMP, I think it needs to be able to
>=20
> * Go beyond 1:1
>=20
>   We tried a 1:1 mapping between HMP and QMP commands, and it didn't
>   work out.  HMP's replacement should let us build convenient commands
>   from QMP building blocks.
>=20
>   We tried a 1:1 mapping between HMP and QMP command arguments, guided
>   by @args_type.  Worked out for simple cases, but was too constricting.

Yes, it works for some things.

> * Preserve "whipuptitude" [David]
>=20
>   I figure that means allowing some in QMP.  Without compromising its
>   core mission, of course.
>=20
> * As discoverable as HMP is now [Kevin]
>=20
> * Help, completion and such at least on par with what HMP provides now
>=20
> Highly desirable:
>=20
> * Support transitioning to the machine interface [John]
>=20
>   Let humans start playing with the human interface, and when they feel
>   the need to automate, help them transition to QMP.
>=20
> Back to John's question on qmp-shell syntax, which hasn't been answered
> so far.
>=20
> JSON is a data-interchange format.  It doesn't try to be a configuration
> format or programming language syntax for human use.  It gets pressed
> into these roles with entirely predictable poor results.
>=20
> Pain points of JSON include having to count parenthesises and having to
> quote so bloody much.  Additional QMP pain points include long names and
> excessive nesting.

Some other pet hates:
  a) Number formats are awful for our uses
  b) Lack of room for comments

> For the configuration format role, more usable alternatives exist.  YAML
> is a popular one.
>=20
> qmp-shell is a REPL.  It needs a REPL-friendly syntax.  I doubt YAML is
> or even tries to be REPL-friendly.  I'd love to be wrong; the first rule
> of language design is "don't".
>=20
> Other language suggestions?

While I hate XML, there's a certain niceness in using the same thing as
libvirt for places that mean the same thing; but that would have the bad
requirement that things meant *exactly* the same thing.

But, for machine representations, I'm not sure moving away from JSON is
a requirement.

Dave

> On making JSON suck less in this role:
>=20
> LISP REPLs demonstrate that computers can assist effectively with
> counting parenthesises, and with completing long names.
>=20
> We could make quoting optional for sufficiently nice object member
> names.  QAPI naming rules ensure niceness, actually.
>=20
> We could make quoting optional for certain string literals.  Simple
> enough for literals that can only be a string, like abc.  For literals
> that could be something else like 123 or true, omitting quotes creates
> ambiguity.  When the schema accepts only one of the possible types, the
> ambiguity goes away.  Complexity stays, however.
>=20
> Excessive nesting should ideally be attacked in QMP itself, but backward
> compatibility makes that hard.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


