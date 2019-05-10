Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45063C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1953E2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 06:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1953E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOyu2-0007q3-Bt
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 02:21:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOysx-0007M8-Mq
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOysv-0003a0-Mo
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hOyst-0003Ys-NC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 02:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66E49308FBA6
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 06:19:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 093D55D704;
	Fri, 10 May 2019 06:19:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 33B901132B35; Fri, 10 May 2019 08:19:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<87imumj1jb.fsf@dusky.pond.sub.org>
	<20190507161845.GL28722@habkost.net>
	<87lfzh5mrh.fsf@dusky.pond.sub.org>
	<20190508202830.GF4189@habkost.net>
	<874l646nbh.fsf@dusky.pond.sub.org>
	<20190509091452.GF31299@redhat.com>
	<20190509155247.GJ4189@habkost.net>
Date: Fri, 10 May 2019 08:19:52 +0200
In-Reply-To: <20190509155247.GJ4189@habkost.net> (Eduardo Habkost's message of
	"Thu, 9 May 2019 12:52:47 -0300")
Message-ID: <87a7fux247.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 10 May 2019 06:19:54 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, mprivozn@redhat.com,
	Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Thu, May 09, 2019 at 10:14:52AM +0100, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, May 09, 2019 at 10:31:46AM +0200, Markus Armbruster wrote:
>> > We've wandered into the QAPI vs. QOM swamp.  Cc: Paolo.
>> >=20
>> > Eduardo Habkost <ehabkost@redhat.com> writes:
>> >=20
>> > > On Wed, May 08, 2019 at 11:16:50AM +0200, Markus Armbruster wrote:
[...]
>> > >> I agree we should point to a preferred replacement whenever we depr=
ecate
>> > >> something.
>> > >>=20
>> > >> We have to do it in documentation.  And we generally do, in
>> > >> qemu-deprecated.texi.
>> > >>=20
>> > >> How useful would doing it in QMP as well be?  Depends on what manag=
ement
>> > >> applications can do with the additional information.
>> > >
>> > > I expect it to be useful for things that have obvious
>> > > replacements, like old machine type or CPU model versions.
>> >=20
>> > I doubt a management application should apply suggested replacements
>> > automatically, and I doubt libvirt would.  Not even when QEMU develope=
rs
>> > deem them "obvious".
>>=20
>> We certainly won't apply the suggested replacement as in many cases
>> it is not going to be a functionally equivalent drop-in.
>
> Who's "we"?
>
>>=20
>> If QEMU logs it to stderr, it will end up in the per-VM log file
>> libvirt has under /var/log/libvirt/qemu/$GUESTNAME.log.  If QEMU
>> doesn't log it to stderr, then libvirt would just write it to
>> that same log file itself.
>>=20
>> If libvirt gains some API or event for notifying apps of deprecation
>> we might bubble it up to the mgmt app that way.
>>=20
>> I still feel it is useful to have the suggested replacement in the
>> logs, rather  than only leaving it in qemu-deprecated.texi.  This
>> way the info is immediately visible to both app developers and any
>> support person dealing with bugs.
>>=20
>> If the app dev see the suggested replacement upfront they're more
>> likely to make an immediate decision to update their code if the
>> suggestion is trivial. If they need to go find the QEMU docs to
>> lookup what action is required I feel they'll more likely just
>> put the item on their long todo list where it will languish.
>
> Agreed.  However, note that the audience for deprecation
> information is not just developers and support people.  End users
> need to know when they are relying on a deprecated feature, and
> applications should make it as easy as possible for them to
> update their configurations.
>
> I'm not suggesting the alternative would be applied
> automatically.  But having the alternative available in a
> machine-friendly way may be the difference between a unhelpful UI
> that just tells the user there's some problem but can't give a
> solution, and one that can really assist the user to fix the
> problem.

I'm skeptical.

For the management application to assist its users, it has to translate
both the deprecated QEMU interface and its replacement into its own
interfaces (because those are the ones the users actually use).
Management applications routinely translate in the other direction.  I
doubt anyone would build reverse translation capabilities just for
helping users update deprecated configurations.  So unless such
capabilities get built for other purposes, machine-friendliness will
remain unused.

If the management application's user is another machine, another
translation is needed.  And so forth until we reach the guy who's
supposed to update configuration.

Such a game of telephone is unlikely to produce anything but confusion,
except for specific cases we test across the whole stack.

