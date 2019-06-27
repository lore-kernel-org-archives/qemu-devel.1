Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3EC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAAC20828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAAC20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50297 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTU4-0004Er-G9
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47737)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgTRa-0001Y7-AM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgTRY-0004Pc-To
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hgTRY-0004Of-M6
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:24:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9B99630811C7
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 12:23:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C96760856;
 Thu, 27 Jun 2019 12:23:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF8B211386A0; Thu, 27 Jun 2019 14:23:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
 <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
Date: Thu, 27 Jun 2019 14:23:52 +0200
In-Reply-To: <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com> (Paolo
 Bonzini's message of "Thu, 27 Jun 2019 12:16:05 +0200")
Message-ID: <87blyjfc87.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 12:23:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/06/19 11:03, Daniel P. Berrang=C3=A9 wrote:
>> On Mon, Jun 10, 2019 at 01:14:57PM +0200, Paolo Bonzini wrote:
>>> The Meson build system is integrated in the existing configure/make ste=
ps
>>> by invoking Meson from the configure script and converting Meson's buil=
d.ninja
>>> rules to an included Makefile.
>>=20
>> Why did you take the route of converting ninja rules into makefile
>> rules, as opposed to just having some stub makefile rules which
>> directly invoke ninja where needed ?
>
> There are two parts of this.  One is practical and has to do with
> supporting a step-by-step transition.  Using ninja2make makes it trivial
> to have make build products that depend on meson build products, and
> this way bottom up is a natural direction to do the conversion, which is
> bottom up.  You'd start from libqemuutil.a and code generators (tracing
> + QAPI), then go to the tools and the emulators.

*If* the conversion is too big a task to permit doing it all at once,
then the step by step strategy you describe makes sense to me.

The trouble with step by step is running out of steam before the final
step.  That would leave us worse off.  Even an overly protracted
conversion would be bad.

Thus, my standard question on any proposed step-by-step conversion:
commitment to finishing it?  I'd be quite happy to take your word for
it.

> The second is a design decision that simplifying the Make/meson
> integration is *not* a goal.  Rather the goals are: 1) making the
> transition easier on developers; 2) avoiding magic in meson.build at all
> costs.  More specifically:
>
> - it should remain trivial to do things that used to be trivial, and
> most "make" invocations should be kept the same at least until
> everything is converted and we can perhaps declare a flag day.  People
> are used to "make check" or "make subdir-x86_64-softmmu", those should
> continue to work while the transition is in progress.
>
> - it should be possible to modify meson.build without knowing QEMU
> specific details, and that should be _already_ possible now at the
> beginning of the transition (to avoid creating technical debt).  This
> means keeping the magic confined in Makefile rules and external scripts,
> while having a pretty plain meson.build.

I wholeheartedly agree with (2).  Reducing magic is the whole point.

Your plan confines new magic to "Makefile rules and external scripts".
We'll get actual reduction only if we can retire or at least radically
simplify them at some point.

I'm more ambivalent on (1).  Yes, making the transition easier for
developers is worth hiding a certain amount of magic out of their way.
But not any amount.  We should try to preserve the targets printed by
"make help".

> I expect testing might also require some hand-holding, because "meson
> test" does not integrate with "make -j" and to keep supporting our "make
> check-*" targets.  However, until the make->ninja flag day we could
> generate tap-driver Makefile rules from "meson introspect --tests"
> output.  Basically I'm dropping Makefile magic in favor of build rule
> generators are written in high-level languages.

A PoC for selected tests would be nice.

>> Obviously this series is just some initial integration, but eventually
>> when we get a complete conversion, I think it will look pretty wierd
>> if we're still converting ninja to make.
>
> I agree; once all the build rules are converted the Makefile could be as
> simple as
>
> 	all:
> 	include config.mak
> 	include tests/docker/Makefile.include
> 	include tests/vm/Makefile.include
> 	.NOTPARALLEL:
> 	%:
> 		ninja $@
>
> 	subdir-%-softmmu:
> 		ninja qemu-system-$*
>
> 	subdir-%-linux-user:
> 		ninja qemu-$*
>
> 	check:
> 		$(MESON) test
>
> 	check-%:
> 		$(MESON) test --suite $*
>
> etc. (and likewise the configure script could just translate the command
> line options before invoking meson).

I wouldn't bother keeping around such an empty shell of a Makefile.

Keeping configure as a wrapper could be marginally more useful, mostly
for people trying to build QEMU for the first time.

>                                       But for now, since rules are
> written half in meson and half in make, ninja2make seems the most
> transparent way to integrate the two.
>
>> Part of the downside of our current build system is that although it
>> uses make, the usage is wierd and QEMU specific structure. It would
>> be a shame to pick meson and then again use it is a way that is wierd
>> and QEMU specific.
>
> I agree, this is why it's important to have at least a standard meson.bui=
ld.
>
> Some knowledge of config-host.mak is needed, because meson.build uses
> declare_dependency() instead of dependency() to link with libraries that
> were already found by configure, but that's it.

Ignorant question: could the switch to Meson enable doing less in
configure?  It's big and sloooow.

