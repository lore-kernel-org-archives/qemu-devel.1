Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB2C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1930520856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1930520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ljm-00038Y-A6
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i8LSc-0000pO-UC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i8LSb-00076q-Df
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53122)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i8LSb-00076e-6C
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8174D308421A;
 Thu, 12 Sep 2019 09:32:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E2B60C05;
 Thu, 12 Sep 2019 09:32:12 +0000 (UTC)
Date: Thu, 12 Sep 2019 10:32:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190912093210.GD24576@redhat.com>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
 <87d0g6dnbc.fsf_-_@dusky.pond.sub.org> <87y2ytzy17.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2ytzy17.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 12 Sep 2019 09:32:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] TCG plugins and the GPL (was: [PATCH v4 00/54]
 plugins for TCG)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, bobby.prani@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 12, 2019 at 10:03:48AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
> >
> >> Markus Armbruster <armbru@redhat.com> writes:
> > [...]
> >>> Please advise why TCG plugins don't undermine the GPL.  Any proposa=
l to
> >>> add a plugin interface needs to do that.
> >>
> >> I'm not sure what we can say about this apart from "ask your lawyer"=
.
> >
> > I'm not asking for a legal argument, I'm asking for a pragmatic one.
> >
> >> I'm certainly not proposing we add any sort of language about what
> >> should and shouldn't be allowed to use the plugin interface. I find =
it
> >> hard to see how anyone could argue code written to interface with th=
e
> >> plugin API couldn't be considered a derived work.
> >
> > What makes that so?  Is writing a plugin without linking with QEMU co=
de
> > impractical?
>=20
> The way a plugin works is by linking. The plugin itself would be useles=
s
> unless combined with the QEMU code to do its thing. It is a more
> intimate binding than an IPC interface using some sort of protocol. The
> argument goes that pretty much any kernel module is derived code - but
> again it has never really been litigated in the courts which would be
> the people to set the precedent.

Part of the problem with the kernel is the historical precedent they
had set. The issue of GPL compliance only become prominent much later
after (closed source) loadable modules were already widely in use. They
tried to lock the door after the horse had already bolted by adding
EXPORT_SYMBOL_GPL.

We can avoid this trapped by clearly documenting our license expectations
from the very start. ie state that we consider any plugins to be derived
works and to be bound by the terms of the GPL. This doesn't mean the
plugins themselves have to be GPL, but they have to be under terms that
allow relicensing to the GPL, in order to be license compatible.=20

We could even go as far as having the plugin registration API require
that the plugin explicitly declare its license and we can log this
license at time of loading. If people use a non-GPL compatible license
it will be clearly visible as non-compatible, or if they lie and pretend
to be GPL then they would be willfully violating.

> >> There are two use cases I have in mind:
> >>
> >> The first is FLOSS developers writing interesting tools that can tak=
e
> >> advantage of QEMU's control of the system to do experiments that are
> >> tricky with other setups (Valgrind is limited to same-arch, Dynamo/P=
in
> >> are user-space only). I want these experiments to be easy to do with=
out
> >> having to keep hacking and re-hacking QEMU's core code. I would hope
> >> QEMU developers would up-stream theirs into the QEMU source tree but=
 I
> >> can imagine academics will have open source code that will only ever=
 sit
> >> in their paper's repository.
> >
> > GPL'ed code that's not for upstream is 100% legitimate.

Yep, the code only has to be provided to the people who receive the
plugin binary. Those people can't be prevented from redistributing
it further though.

> >> The other is users who currently maintain hacked up internal copies =
of
> >> QEMU as a test bed for whatever piece of silicon they are brewing be=
hind
> >> closed doors. This code would never be distributed (hence never be a=
 GPL
> >> issue)
> >
> > Correct.  We can't force anybody to distribute, and that's only prope=
r.
> >

> > Are there any technical difficulties that could make distributing a
> > plugins in binary form impractical?
>=20
> Well the first thing will be we are not intending to offer a guaranteed
> ABI. While we don't want to be changing it at a whim there shouldn't be
> an expectation that the plugin interface will maintain backwards
> compatibility (unlike the command line interface ;-). There should be a=
n
> expectation that plugins will likely need to be rebuilt against the
> current source tree from time to time.
>=20
> We could implement a more technical measure analogous to the kernels
> module signing that would require the plugin to be rebuilt with
> reference to the current QEMU source tree although that will be a pain
> even for internally distributed blobs. I'm loathed to implement such a
> system from v1 though given the problem of publicly distributed binary
> blobs is currently only a theoretical problem.

The problem with waiting for a problem to arise is that you have set a
precedent that its ok. We are in a stronger enforcement position if we
can set expectations accurately from day one, avoiding the trap the
kernel had which needed to try to enforce after the fact.

So from that POV, I'd be strongly in favour of technical measures that
force the plugin to be rebuilt against each new QEMU version.

This doesn't need to be module signing - it could be as simple as
requiring the plugin to export a symbol "module_version" which must
exactly match the QEMU version, or refuse to load it. If we want to
be even more strict we could generate a random hash in each QEMU
rebuild, which is the similar level of strictness to kernel signing

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

