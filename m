Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BB0C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D039A2070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D039A2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8uS-0004Ok-4j
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:02:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hP8tK-0003ZS-Hz
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hP8tF-00047y-4S
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:01:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hP8tE-000476-Pu
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:00:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0C3F30025F1
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 17:00:54 +0000 (UTC)
Received: from localhost (ovpn-116-40.gru2.redhat.com [10.97.116.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E9A117791;
	Fri, 10 May 2019 17:00:54 +0000 (UTC)
Date: Fri, 10 May 2019 14:00:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510170052.GQ4189@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509091452.GF31299@redhat.com>
	<20190509155247.GJ4189@habkost.net>
	<87a7fux247.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87a7fux247.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 17:00:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] Export machine type deprecation info
 through QMP
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
Cc: mprivozn@redhat.com,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 08:19:52AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Thu, May 09, 2019 at 10:14:52AM +0100, Daniel P. Berrang=E9 wrote:
> >> On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
> >> > We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
> >> >=20
> >> > Eduardo Habkost <ehabkost@redhat.com> writes:
> >> >=20
> >> > > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrot=
e:
> [...]
> >> > >> I agree we should point to a preferred replacement whenever we =
deprecate
> >> > >> something.
> >> > >>=20
> >> > >> We have to do it in documentation.  And we generally do, in
> >> > >> qemu-deprecated.texi.
> >> > >>=20
> >> > >> How useful would doing it in QMP as well be?  Depends on what m=
anagement
> >> > >> applications can do with the additional information.
> >> > >
> >> > > I expect it to be useful for things that have obvious
> >> > > replacements, like old machine type or CPU model versions.
> >> >=20
> >> > I doubt a management application should apply suggested replacemen=
ts
> >> > automatically, and I doubt libvirt would.  Not even when QEMU deve=
lopers
> >> > deem them "obvious".
> >>=20
> >> We certainly won't apply the suggested replacement as in many cases
> >> it is not going to be a functionally equivalent drop-in.
> >
> > Who's "we"?
> >
> >>=20
> >> If QEMU logs it to stderr, it will end up in the per-VM log file
> >> libvirt has under /var/log/libvirt/qemu/$GUESTNAME.log.  If QEMU
> >> doesn't log it to stderr, then libvirt would just write it to
> >> that same log file itself.
> >>=20
> >> If libvirt gains some API or event for notifying apps of deprecation
> >> we might bubble it up to the mgmt app that way.
> >>=20
> >> I still feel it is useful to have the suggested replacement in the
> >> logs, rather  than only leaving it in qemu-deprecated.texi.  This
> >> way the info is immediately visible to both app developers and any
> >> support person dealing with bugs.
> >>=20
> >> If the app dev see the suggested replacement upfront they're more
> >> likely to make an immediate decision to update their code if the
> >> suggestion is trivial. If they need to go find the QEMU docs to
> >> lookup what action is required I feel they'll more likely just
> >> put the item on their long todo list where it will languish.
> >
> > Agreed.  However, note that the audience for deprecation
> > information is not just developers and support people.  End users
> > need to know when they are relying on a deprecated feature, and
> > applications should make it as easy as possible for them to
> > update their configurations.
> >
> > I'm not suggesting the alternative would be applied
> > automatically.  But having the alternative available in a
> > machine-friendly way may be the difference between a unhelpful UI
> > that just tells the user there's some problem but can't give a
> > solution, and one that can really assist the user to fix the
> > problem.
>=20
> I'm skeptical.
>=20
> For the management application to assist its users, it has to translate
> both the deprecated QEMU interface and its replacement into its own
> interfaces (because those are the ones the users actually use).
> Management applications routinely translate in the other direction.  I
> doubt anyone would build reverse translation capabilities just for
> helping users update deprecated configurations.  So unless such
> capabilities get built for other purposes, machine-friendliness will
> remain unused.
>=20
> If the management application's user is another machine, another
> translation is needed.  And so forth until we reach the guy who's
> supposed to update configuration.
>=20
> Such a game of telephone is unlikely to produce anything but confusion,
> except for specific cases we test across the whole stack.

I don't see how that applies to machine type and CPU model names.
Machine type and CPU model names are often exposed directly to
the end user.

--=20
Eduardo

