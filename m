Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06882C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D4220714
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 14:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVb5V8rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D4220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ezg-0002Hw-VJ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 09:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1j6ExT-0000Sq-Ax
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1j6ExS-0007Xk-17
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:43:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1j6ExR-0007Xe-Sj
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 09:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582555421;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELIRJW++q5+xz3dY5jYArDty86u8tOgUfi/0jnLdeyA=;
 b=SVb5V8rkv2YmgfLwi6R5LfC/cf+hQ3wI4qWWDnLbpeVECS4EjefY2oOPXzWuZ8/vhFYGDV
 dfCeHA7fLiuihRU5VA5BE6a049n19jIg7S7Tj2IvH1E2ZM4ow2JIagnCwIgZ/POPNVZMl7
 zU+C1kSzAzr3IL+tqwkj90purv51zbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-oOQjATuhPt2dG-uvj_xCbg-1; Mon, 24 Feb 2020 09:43:35 -0500
X-MC-Unique: oOQjATuhPt2dG-uvj_xCbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 552F68017CC;
 Mon, 24 Feb 2020 14:43:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F9919C7F;
 Mon, 24 Feb 2020 14:43:33 +0000 (UTC)
Date: Mon, 24 Feb 2020 14:43:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: QAPI schema for desired state of LUKS keyslots
Message-ID: <20200224144330.GR635661@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <20200217103700.GC6309@linux.fritz.box>
 <87ftf9s8ho.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87ftf9s8ho.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 01:28:51PM +0100, Markus Armbruster wrote:
> Kevin Wolf <kwolf@redhat.com> writes:
>=20
> > Am 15.02.2020 um 15:51 hat Markus Armbruster geschrieben:
> >> Review of this patch led to a lengthy QAPI schema design discussion.
> >> Let me try to condense it into a concrete proposal.
> >>=20
> >> This is about the QAPI schema, and therefore about QMP.  The
> >> human-friendly interface is out of scope.  Not because it's not
> >> important (it clearly is!), only because we need to *focus* to have a
> >> chance at success.
> >>=20
> >> I'm going to include a few design options.  I'll mark them "Option:".
> >>=20
> >> The proposed "amend" interface takes a specification of desired state,
> >> and figures out how to get from here to there by itself.  LUKS keyslot=
s
> >> are one part of desired state.
> >>=20
> >> We commonly have eight LUKS keyslots.  Each keyslot is either active o=
r
> >> inactive.  An active keyslot holds a secret.
> >>=20
> >> Goal: a QAPI type for specifying desired state of LUKS keyslots.
> >>=20
> >> Proposal:
> >>=20
> >>     { 'enum': 'LUKSKeyslotState',
> >>       'data': [ 'active', 'inactive' ] }
> >>=20
> >>     { 'struct': 'LUKSKeyslotActive',
> >>       'data': { 'secret': 'str',
> >>                 '*iter-time': 'int } }
> >>=20
> >>     { 'struct': 'LUKSKeyslotInactive',
> >>       'data': { '*old-secret': 'str' } }
> >>=20
> >>     { 'union': 'LUKSKeyslotAmend',
> >>       'base': { '*keyslot': 'int',
> >>                 'state': 'LUKSKeyslotState' }
> >>       'discriminator': 'state',
> >>       'data': { 'active': 'LUKSKeyslotActive',
> >>                 'inactive': 'LUKSKeyslotInactive' } }
> >>=20
> >> LUKSKeyslotAmend specifies desired state for a set of keyslots.
> >
> > Though not arbitrary sets of keyslots, it's only a single keyslot or
> > multiple keyslots containing the same secret. Might be good enough in
> > practice, though it means that you may have to issue multiple amend
> > commands to get to the final state that you really want (even if doing
> > everything at once would be safe).
>=20
> True.  I traded expressiveness for simplicity.
>=20
> Here's the only practical case I can think of where the lack of
> expressiveness may hurt: replace secrets.
>=20
> With this interface, you need two operations: activate a free slot with
> the new secret, deactivate the slot(s) with the old secret.  There is an
> intermediate state with both secrets active.
>=20
> A more expressive interface could let you do both in one step.  Relevant
> only if the implementation actually provides atomicity.  Can it?

This restriction is already present in the the long standing
cryptsetup command, so I don't think it is a big deal. Or to
put it another way I don't see a compelling justification for
why QEMU needs to be special and do it in op.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


