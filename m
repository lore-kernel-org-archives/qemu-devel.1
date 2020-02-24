Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC3C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 208DD20714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKfXCk+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208DD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6F4r-0006ox-Bw
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1j6F40-0006En-3Z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1j6F3y-0001to-GF
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:50:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1j6F3y-0001sM-AK
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582555825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cq+l5x2Q4Y0VCMhvboK4Y97PT0P98v/1MVzByss3x8=;
 b=IKfXCk+eWeNlbSXHS/SaSEkDGCzxHZwpVpt1YmZsF68SKrUzM+svMIpwd63Th+Vr8255Ry
 3TxGoshVnoqwMUBHM0RINckwi+/L3IxJCF+BTfzeB/7EN+i7kKHtgMVdSikTLFqppEJFPm
 Y9ICUQEPr3AutgfIPWszy5uLc9Zqy6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-6GT6cxA_Pb2WRPYkfRZIhA-1; Mon, 24 Feb 2020 09:50:22 -0500
X-MC-Unique: 6GT6cxA_Pb2WRPYkfRZIhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C675802563;
 Mon, 24 Feb 2020 14:50:20 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A98F5D9E5;
 Mon, 24 Feb 2020 14:50:18 +0000 (UTC)
Message-ID: <0bc646700ef5cfc6a58e2c4efa107fab3817b7f7.camel@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots (was: [PATCH
 02/13] qcrypto-luks: implement encryption key management)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Mon, 24 Feb 2020 16:50:17 +0200
In-Reply-To: <20200224144621.GT635661@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <20200217103700.GC6309@linux.fritz.box>
 <fd30b30b11772bd59ccf4573a35fc01d5bd51379.camel@redhat.com>
 <20200224144621.GT635661@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-02-24 at 14:46 +0000, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Feb 17, 2020 at 01:07:23PM +0200, Maxim Levitsky wrote:
> > On Mon, 2020-02-17 at 11:37 +0100, Kevin Wolf wrote:
> > > Am 15.02.2020 um 15:51 hat Markus Armbruster geschrieben:
> > > > Review of this patch led to a lengthy QAPI schema design discussion=
.
> > > > Let me try to condense it into a concrete proposal.
> > > >=20
> > > > This is about the QAPI schema, and therefore about QMP.  The
> > > > human-friendly interface is out of scope.  Not because it's not
> > > > important (it clearly is!), only because we need to *focus* to have=
 a
> > > > chance at success.
> > > >=20
> > > > I'm going to include a few design options.  I'll mark them "Option:=
".
> > > >=20
> > > > The proposed "amend" interface takes a specification of desired sta=
te,
> > > > and figures out how to get from here to there by itself.  LUKS keys=
lots
> > > > are one part of desired state.
> > > >=20
> > > > We commonly have eight LUKS keyslots.  Each keyslot is either activ=
e or
> > > > inactive.  An active keyslot holds a secret.
> > > >=20
> > > > Goal: a QAPI type for specifying desired state of LUKS keyslots.
> > > >=20
> > > > Proposal:
> > > >=20
> > > >     { 'enum': 'LUKSKeyslotState',
> > > >       'data': [ 'active', 'inactive' ] }
> > > >=20
> > > >     { 'struct': 'LUKSKeyslotActive',
> > > >       'data': { 'secret': 'str',
> > > >                 '*iter-time': 'int } }
> > > >=20
> > > >     { 'struct': 'LUKSKeyslotInactive',
> > > >       'data': { '*old-secret': 'str' } }
> > > >=20
> > > >     { 'union': 'LUKSKeyslotAmend',
> > > >       'base': { '*keyslot': 'int',
> > > >                 'state': 'LUKSKeyslotState' }
> > > >       'discriminator': 'state',
> > > >       'data': { 'active': 'LUKSKeyslotActive',
> > > >                 'inactive': 'LUKSKeyslotInactive' } }
> > > >=20
> > > > LUKSKeyslotAmend specifies desired state for a set of keyslots.
> > >=20
> > > Though not arbitrary sets of keyslots, it's only a single keyslot or
> > > multiple keyslots containing the same secret. Might be good enough in
> > > practice, though it means that you may have to issue multiple amend
> > > commands to get to the final state that you really want (even if doin=
g
> > > everything at once would be safe).
> > >=20
> > > > Four cases:
> > > >=20
> > > > * @state is "active"
> > > >=20
> > > >   Desired state is active holding the secret given by @secret.  Opt=
ional
> > > >   @iter-time tweaks key stretching.
> > > >=20
> > > >   The keyslot is chosen either by the user or by the system, as fol=
lows:
> > > >=20
> > > >   - @keyslot absent
> > > >=20
> > > >     One inactive keyslot chosen by the system.  If none exists, err=
or.
> > > >=20
> > > >   - @keyslot present
> > > >=20
> > > >     The keyslot given by @keyslot.
> > > >=20
> > > >     If it's already active holding @secret, no-op.  Rationale: the
> > > >     current state is the desired state.
> > > >=20
> > > >     If it's already active holding another secret, error.  Rational=
e:
> > > >     update in place is unsafe.
> > > >=20
> > > >     Option: delete the "already active holding @secret" case.  Feel=
s
> > > >     inelegant to me.  Okay if it makes things substantially simpler=
.
> > > >=20
> > > > * @state is "inactive"
> > > >=20
> > > >   Desired state is inactive.
> > > >=20
> > > >   Error if the current state has active keyslots, but the desired s=
tate
> > > >   has none.
> > > >=20
> > > >   The user choses the keyslot by number and/or by the secret it hol=
ds,
> > > >   as follows:
> > > >=20
> > > >   - @keyslot absent, @old-secret present
> > > >=20
> > > >     All active keyslots holding @old-secret.  If none exists, error=
.
> > > >=20
> > > >   - @keyslot present, @old-secret absent
> > > >=20
> > > >     The keyslot given by @keyslot.
> > > >=20
> > > >     If it's already inactive, no-op.  Rationale: the current state =
is
> > > >     the desired state.
> > > >=20
> > > >   - both @keyslot and @old-secret present
> > > >=20
> > > >     The keyslot given by keyslot.
> > > >=20
> > > >     If it's inactive or holds a secret other than @old-secret, erro=
r.
> > > >=20
> > > >     Option: error regardless of @old-secret, if that makes things
> > > >     simpler.
> > > >=20
> > > >   - neither @keyslot not @old-secret present
> > > >=20
> > > >     All keyslots.  Note that this will error out due to "desired st=
ate
> > > >     has no active keyslots" unless the current state has none, eith=
er.
> > > >=20
> > > >     Option: error out unconditionally.
> > > >=20
> > > > Note that LUKSKeyslotAmend can specify only one desired state for
> > > > commonly just one keyslot.  Rationale: this satisfies practical nee=
ds.
> > > > An array of LUKSKeyslotAmend could specify desired state for all
> > > > keyslots.  However, multiple array elements could then apply to the=
 same
> > > > slot.  We'd have to specify how to resolve such conflicts, and we'd=
 have
> > > > to code up conflict detection.  Not worth it.
> > > >=20
> > > > Examples:
> > > >=20
> > > > * Add a secret to some free keyslot:
> > > >=20
> > > >   { "state": "active", "secret": "CIA/GRU/MI6" }
> > > >=20
> > > > * Deactivate all keyslots holding a secret:
> > > >=20
> > > >   { "state": "inactive", "old-secret": "CIA/GRU/MI6" }
> > > >=20
> > > > * Add a secret to a specific keyslot:
> > > >=20
> > > >   { "state": "active", "secret": "CIA/GRU/MI6", "keyslot": 0 }
> > > >=20
> > > > * Deactivate a specific keyslot:
> > > >=20
> > > >   { "state": "inactive", "keyslot": 0 }
> > > >=20
> > > >   Possibly less dangerous:
> > > >=20
> > > >   { "state": "inactive", "keyslot": 0, "old-secret": "CIA/GRU/MI6" =
}
> > > >=20
> > > > Option: Make use of Max's patches to support optional union tag wit=
h
> > > > default value to let us default @state to "active".  I doubt this m=
akes
> > > > much of a difference in QMP.  A human-friendly interface should pro=
bably
> > > > be higher level anyway (Daniel pointed to cryptsetup).
> > > >=20
> > > > Option: LUKSKeyslotInactive member @old-secret could also be named
> > > > @secret.  I don't care.
> > > >=20
> > > > Option: delete @keyslot.  It provides low-level slot access.
> > > > Complicates the interface.  Fine if we need lov-level slot access. =
 Do
> > > > we?
> > > >=20
> > > > I apologize for the time it has taken me to write this.
> > > >=20
> > > > Comments?
> > >=20
> > > Works for me (without taking any of the options).
> > >=20
> > > The unclear part is what the human-friendly interface should look lik=
e
> > > and where it should live. I'm afraid doing only the QMP part and call=
ing
> > > the feature completed like we do so often won't work in this case.
> >=20
> > IMHO, I think that the best way to create human friendly part is to imp=
lement
> > luks specific commands for qemu-img and use interface very similar
> > to what cryptsetup does.
>=20
> I think we can have a generic 'qemu-img amend' for machine type, with the
> complex dotted syntax.
>=20
> And then have two human friendly commands 'qemu-img crypt-add-key' and
> 'qemu-img crypt-del-key' similarish to cryptsetup.

Yep, this is exactly what I was thinking about this as well!

Best regards,
=09Maxim Levitsky
>=20
> Regards,
> Daniel



