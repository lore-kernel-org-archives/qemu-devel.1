Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4E2C7619B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8798320725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtmhiaDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8798320725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bdX-0003bw-PH
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j3bct-00035x-JA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j3bcr-0006vt-17
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:19:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47637
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j3bcq-0006uy-Sc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581927572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUJDODn/jN1ijx1T9Hy5rhSjkw+jU8op56EfORrlbho=;
 b=GtmhiaDnHZCNm9HvuhTw7NL8eV+bMpJJrIfabSS07kc485ftoo+VxEuVJPCxoQ5LEMUBGR
 gBU+rGAz3glgsSQgz5fghxZeooqc6DVpya87Y7d/H/GPGyzHsvKXvl+9qHqn6X0KcxzdrO
 A893/99vDvTS+7O9lIzkLhTIMtnssts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-YKse9FXLMFedo-y6DJ8L_A-1; Mon, 17 Feb 2020 03:19:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0521005512;
 Mon, 17 Feb 2020 08:19:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4545C100;
 Mon, 17 Feb 2020 08:19:27 +0000 (UTC)
Message-ID: <806a87fca46483681cda0045c3f274312fec2503.camel@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 17 Feb 2020 10:19:26 +0200
In-Reply-To: <87lfp1ww41.fsf@dusky.pond.sub.org>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <59039903dba3c277ef9dbc2397a896c906f120d1.camel@redhat.com>
 <87lfp1ww41.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: YKse9FXLMFedo-y6DJ8L_A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-02-17 at 07:45 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Sat, 2020-02-15 at 15:51 +0100, Markus Armbruster wrote:
> > > Review of this patch led to a lengthy QAPI schema design discussion.
> > > Let me try to condense it into a concrete proposal.
> > > 
> > > This is about the QAPI schema, and therefore about QMP.  The
> > > human-friendly interface is out of scope.  Not because it's not
> > > important (it clearly is!), only because we need to *focus* to have a
> > > chance at success.
> > 
> > 100% agree.
> > > 
> > > I'm going to include a few design options.  I'll mark them "Option:".
> > > 
> > > The proposed "amend" interface takes a specification of desired state,
> > > and figures out how to get from here to there by itself.  LUKS keyslots
> > > are one part of desired state.
> > > 
> > > We commonly have eight LUKS keyslots.  Each keyslot is either active or
> > > inactive.  An active keyslot holds a secret.
> > > 
> > > Goal: a QAPI type for specifying desired state of LUKS keyslots.
> > > 
> > > Proposal:
> > > 
> > >     { 'enum': 'LUKSKeyslotState',
> > >       'data': [ 'active', 'inactive' ] }
> > > 
> > >     { 'struct': 'LUKSKeyslotActive',
> > >       'data': { 'secret': 'str',
> > >                 '*iter-time': 'int } }
> > > 
> > >     { 'struct': 'LUKSKeyslotInactive',
> > >       'data': { '*old-secret': 'str' } }
> > > 
> > >     { 'union': 'LUKSKeyslotAmend',
> > >       'base': { '*keyslot': 'int',
> > >                 'state': 'LUKSKeyslotState' }
> > >       'discriminator': 'state',
> > >       'data': { 'active': 'LUKSKeyslotActive',
> > >                 'inactive': 'LUKSKeyslotInactive' } }
> > > 
> > > LUKSKeyslotAmend specifies desired state for a set of keyslots.
> > > 
> > > Four cases:
> > > 
> > > * @state is "active"
> > > 
> > >   Desired state is active holding the secret given by @secret.  Optional
> > >   @iter-time tweaks key stretching.
> > > 
> > >   The keyslot is chosen either by the user or by the system, as follows:
> > > 
> > >   - @keyslot absent
> > > 
> > >     One inactive keyslot chosen by the system.  If none exists, error.
> > > 
> > >   - @keyslot present
> > > 
> > >     The keyslot given by @keyslot.
> > > 
> > >     If it's already active holding @secret, no-op.  Rationale: the
> > >     current state is the desired state.
> > > 
> > >     If it's already active holding another secret, error.  Rationale:
> > >     update in place is unsafe.
> > > 
> > >     Option: delete the "already active holding @secret" case.  Feels
> > >     inelegant to me.  Okay if it makes things substantially simpler.
> > 
> > I didn't really understand this, since in state=active we shouldn't
> > delete anything. Looks OK otherwise.
> 
> Let me try to clarify.
> 
> Option: make the "already active holding @secret" case an error like the
> "already active holding another secret" case.  In longhand:
> 
>      - @keyslot present
> 
>        The keyslot given by @keyslot.
> 
>        If it's already active, error.
> 
> It feels inelegant to me, because it deviates from "specify desired
> state" paradigm: the specified desired state is fine, the way to get
> there from current state is obvious (do nothing), yet it's still an
> error.
Yep, although in theory we also specify that iteration count, which might not
match (and it will never exactly match since it is benchmark based), thus
if user specified it, we might err out, and otherwise indeed ignore this.
This is of course very minor issue.

> 
> > > * @state is "inactive"
> > > 
> > >   Desired state is inactive.
> > > 
> > >   Error if the current state has active keyslots, but the desired state
> > >   has none.
> > > 
> > >   The user choses the keyslot by number and/or by the secret it holds,
> > >   as follows:
> > > 
> > >   - @keyslot absent, @old-secret present
> > > 
> > >     All active keyslots holding @old-secret.  If none exists, error.
> > > 
> > >   - @keyslot present, @old-secret absent
> > > 
> > >     The keyslot given by @keyslot.
> > > 
> > >     If it's already inactive, no-op.  Rationale: the current state is
> > >     the desired state.
> > > 
> > >   - both @keyslot and @old-secret present
> > > 
> > >     The keyslot given by keyslot.
> > > 
> > >     If it's inactive or holds a secret other than @old-secret, error.
> > 
> > Yea, that would be very nice to have.
> > > 
> > >     Option: error regardless of @old-secret, if that makes things
> > >     simpler.
> > > 
> > >   - neither @keyslot not @old-secret present
> > > 
> > >     All keyslots.  Note that this will error out due to "desired state
> > >     has no active keyslots" unless the current state has none, either.
> > > 
> > >     Option: error out unconditionally.
> > 
> > Yep, that the best IMHO.
> 
> It's a matter of taste.
> 
> If we interpret "both absent" as "all keyslots", then all cases flow out
> of the following simple spec:
> 
>     0. Start with the set of all keyslots
> 
>     1. If @old-secret is present, interset it with the set of slots
>        holding that secret.
> 
>     2. If @keyslots is present, intersect it with the set of slots with
>        that slot number.
> 
> The order of steps 1 and 2 doesn't matter.
> 
> To error out unconditionally, we have to make "both absent" a special
> case.
Yes but to be honest it is few lines of code, and gets you a better
error message in the process. I don't have a strong opinion on this though.

> 
> A good way to resolve such matters of taste is to try writing doc
> comments for all proposals.  If you find you hate one of them much less,
> you have a winner :)

I am already out of this game for some time, I myself won't argue
over this interface (in addition to that that current interface is very good IMHO),
and I am just waiting for others to accept it.


Best regards and thanks for help,
	Maxim Levitsky

> 
> [...]



