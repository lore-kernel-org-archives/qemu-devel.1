Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF45AC11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA98520828
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUkWO/uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA98520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6F18-0004Bx-RF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6F0C-0003Ld-3J
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6F0A-00081o-C1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:46:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6F0A-00081f-8E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582555589;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6vGduk1A+w295XIUufIvOPd1A0vBCfHwQmIvBwHJqA4=;
 b=KUkWO/ukYU8SGmwfSTBwxzkMdiqGPwyaaeUFBYPtypyw6fKRN8ziZAhhhpYHDGgGKIEFy0
 QR9PIpZDF23PHithY9c+6MvEElw+ntlHiatRnJpxlekUcV14Nys1QCiZ7zfcKvMBWxdy++
 1KVX/QSybbAwZ6DNhs1knNBA5PIxCUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-yiuN4XLkOwydSyEGFm6UoQ-1; Mon, 24 Feb 2020 09:46:25 -0500
X-MC-Unique: yiuN4XLkOwydSyEGFm6UoQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797F68017DF;
 Mon, 24 Feb 2020 14:46:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 234EF91833;
 Mon, 24 Feb 2020 14:46:23 +0000 (UTC)
Date: Mon, 24 Feb 2020 14:46:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots (was: [PATCH
 02/13] qcrypto-luks: implement encryption key management)
Message-ID: <20200224144621.GT635661@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <20200217103700.GC6309@linux.fritz.box>
 <fd30b30b11772bd59ccf4573a35fc01d5bd51379.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fd30b30b11772bd59ccf4573a35fc01d5bd51379.camel@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 01:07:23PM +0200, Maxim Levitsky wrote:
> On Mon, 2020-02-17 at 11:37 +0100, Kevin Wolf wrote:
> > Am 15.02.2020 um 15:51 hat Markus Armbruster geschrieben:
> > > Review of this patch led to a lengthy QAPI schema design discussion.
> > > Let me try to condense it into a concrete proposal.
> > >=20
> > > This is about the QAPI schema, and therefore about QMP.  The
> > > human-friendly interface is out of scope.  Not because it's not
> > > important (it clearly is!), only because we need to *focus* to have a
> > > chance at success.
> > >=20
> > > I'm going to include a few design options.  I'll mark them "Option:".
> > >=20
> > > The proposed "amend" interface takes a specification of desired state=
,
> > > and figures out how to get from here to there by itself.  LUKS keyslo=
ts
> > > are one part of desired state.
> > >=20
> > > We commonly have eight LUKS keyslots.  Each keyslot is either active =
or
> > > inactive.  An active keyslot holds a secret.
> > >=20
> > > Goal: a QAPI type for specifying desired state of LUKS keyslots.
> > >=20
> > > Proposal:
> > >=20
> > >     { 'enum': 'LUKSKeyslotState',
> > >       'data': [ 'active', 'inactive' ] }
> > >=20
> > >     { 'struct': 'LUKSKeyslotActive',
> > >       'data': { 'secret': 'str',
> > >                 '*iter-time': 'int } }
> > >=20
> > >     { 'struct': 'LUKSKeyslotInactive',
> > >       'data': { '*old-secret': 'str' } }
> > >=20
> > >     { 'union': 'LUKSKeyslotAmend',
> > >       'base': { '*keyslot': 'int',
> > >                 'state': 'LUKSKeyslotState' }
> > >       'discriminator': 'state',
> > >       'data': { 'active': 'LUKSKeyslotActive',
> > >                 'inactive': 'LUKSKeyslotInactive' } }
> > >=20
> > > LUKSKeyslotAmend specifies desired state for a set of keyslots.
> >=20
> > Though not arbitrary sets of keyslots, it's only a single keyslot or
> > multiple keyslots containing the same secret. Might be good enough in
> > practice, though it means that you may have to issue multiple amend
> > commands to get to the final state that you really want (even if doing
> > everything at once would be safe).
> >=20
> > > Four cases:
> > >=20
> > > * @state is "active"
> > >=20
> > >   Desired state is active holding the secret given by @secret.  Optio=
nal
> > >   @iter-time tweaks key stretching.
> > >=20
> > >   The keyslot is chosen either by the user or by the system, as follo=
ws:
> > >=20
> > >   - @keyslot absent
> > >=20
> > >     One inactive keyslot chosen by the system.  If none exists, error=
.
> > >=20
> > >   - @keyslot present
> > >=20
> > >     The keyslot given by @keyslot.
> > >=20
> > >     If it's already active holding @secret, no-op.  Rationale: the
> > >     current state is the desired state.
> > >=20
> > >     If it's already active holding another secret, error.  Rationale:
> > >     update in place is unsafe.
> > >=20
> > >     Option: delete the "already active holding @secret" case.  Feels
> > >     inelegant to me.  Okay if it makes things substantially simpler.
> > >=20
> > > * @state is "inactive"
> > >=20
> > >   Desired state is inactive.
> > >=20
> > >   Error if the current state has active keyslots, but the desired sta=
te
> > >   has none.
> > >=20
> > >   The user choses the keyslot by number and/or by the secret it holds=
,
> > >   as follows:
> > >=20
> > >   - @keyslot absent, @old-secret present
> > >=20
> > >     All active keyslots holding @old-secret.  If none exists, error.
> > >=20
> > >   - @keyslot present, @old-secret absent
> > >=20
> > >     The keyslot given by @keyslot.
> > >=20
> > >     If it's already inactive, no-op.  Rationale: the current state is
> > >     the desired state.
> > >=20
> > >   - both @keyslot and @old-secret present
> > >=20
> > >     The keyslot given by keyslot.
> > >=20
> > >     If it's inactive or holds a secret other than @old-secret, error.
> > >=20
> > >     Option: error regardless of @old-secret, if that makes things
> > >     simpler.
> > >=20
> > >   - neither @keyslot not @old-secret present
> > >=20
> > >     All keyslots.  Note that this will error out due to "desired stat=
e
> > >     has no active keyslots" unless the current state has none, either=
.
> > >=20
> > >     Option: error out unconditionally.
> > >=20
> > > Note that LUKSKeyslotAmend can specify only one desired state for
> > > commonly just one keyslot.  Rationale: this satisfies practical needs=
.
> > > An array of LUKSKeyslotAmend could specify desired state for all
> > > keyslots.  However, multiple array elements could then apply to the s=
ame
> > > slot.  We'd have to specify how to resolve such conflicts, and we'd h=
ave
> > > to code up conflict detection.  Not worth it.
> > >=20
> > > Examples:
> > >=20
> > > * Add a secret to some free keyslot:
> > >=20
> > >   { "state": "active", "secret": "CIA/GRU/MI6" }
> > >=20
> > > * Deactivate all keyslots holding a secret:
> > >=20
> > >   { "state": "inactive", "old-secret": "CIA/GRU/MI6" }
> > >=20
> > > * Add a secret to a specific keyslot:
> > >=20
> > >   { "state": "active", "secret": "CIA/GRU/MI6", "keyslot": 0 }
> > >=20
> > > * Deactivate a specific keyslot:
> > >=20
> > >   { "state": "inactive", "keyslot": 0 }
> > >=20
> > >   Possibly less dangerous:
> > >=20
> > >   { "state": "inactive", "keyslot": 0, "old-secret": "CIA/GRU/MI6" }
> > >=20
> > > Option: Make use of Max's patches to support optional union tag with
> > > default value to let us default @state to "active".  I doubt this mak=
es
> > > much of a difference in QMP.  A human-friendly interface should proba=
bly
> > > be higher level anyway (Daniel pointed to cryptsetup).
> > >=20
> > > Option: LUKSKeyslotInactive member @old-secret could also be named
> > > @secret.  I don't care.
> > >=20
> > > Option: delete @keyslot.  It provides low-level slot access.
> > > Complicates the interface.  Fine if we need lov-level slot access.  D=
o
> > > we?
> > >=20
> > > I apologize for the time it has taken me to write this.
> > >=20
> > > Comments?
> >=20
> > Works for me (without taking any of the options).
> >=20
> > The unclear part is what the human-friendly interface should look like
> > and where it should live. I'm afraid doing only the QMP part and callin=
g
> > the feature completed like we do so often won't work in this case.
>=20
> IMHO, I think that the best way to create human friendly part is to imple=
ment
> luks specific commands for qemu-img and use interface very similar
> to what cryptsetup does.

I think we can have a generic 'qemu-img amend' for machine type, with the
complex dotted syntax.

And then have two human friendly commands 'qemu-img crypt-add-key' and
'qemu-img crypt-del-key' similarish to cryptsetup.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


