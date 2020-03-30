Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B1BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D7B20716
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHDSfEXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D7B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIuh3-00031z-Ud
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 09:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jIugR-0002Zt-Qd
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jIugP-0000Ye-BJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:42:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:57746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jIugP-0000VT-50
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585575748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LxShFbWooBAyWwMirj70RumSKUTjmqN1uFhPS6127xU=;
 b=NHDSfEXp9827VhAV0r4P/I1qzD4+clfjWCoZF1QcHEffWy8h2E7XeJICzHstSyIJd6ersu
 FUykKt2Afq2OQK4QwioDKtcAphBdm6yaR9PIgLy1TAhvyblk2FjRFjDVLKDOspXmZw+7ub
 GJ1YSvi4xdwkJ+cTLxd1bl0jzVQn3w4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-h09YFT6EMd-6k5FTMB7MNA-1; Mon, 30 Mar 2020 09:42:19 -0400
X-MC-Unique: h09YFT6EMd-6k5FTMB7MNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF196149C1;
 Mon, 30 Mar 2020 13:42:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE2519756;
 Mon, 30 Mar 2020 13:42:17 +0000 (UTC)
Date: Mon, 30 Mar 2020 14:42:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200330134212.GO236854@redhat.com>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 02:31:52PM +0100, Peter Maydell wrote:
> On Mon, 30 Mar 2020 at 14:26, Markus Armbruster <armbru@redhat.com> wrote=
:
> >
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> > > AIUI from Paolo, the intention is to deprecate and eventually
> > > stop supporting "in-tree" builds, so that the only option is
> > > building in a separate build directory. I thought we should
> > > probably mention that in the 5.0 changelog, so I wrote up some
> > > text:
> > >
> > > https://wiki.qemu.org/ChangeLog/5.0#Build_Information
> >
> > Overdue.  Thanks for doing this!
> >
> > > Suggestions for changes/comments etc welcome.
> >
> > Looks fine to me.
>=20
> Consensus in the thread seemed to lean towards having
> the 'configure/make' runes auto-create a build directory;
> if we want to do that we should probably not say anything in
> the release notes, because we'll cause people to change
> unnecessarily. Or at least have them say "We recommend
> out-of-tree builds. In future we might make the commands
> that currently do an in-tree build automatically create
> and use a build directory for you." rather than a blanket
> "we're going to drop this and you should change what you
> do now".
>=20
> Thoughts?

When the time comes to switch to Meson, we'll be forcing a
separate build directory & that will also potentially involve
a change in build instructions for users.

So if we expect Meson will arrive in QEMU soon (say before end
of this year), then I'd try to keep changes related to make to
the bare minimum, and have Meson switch as the "flag day" when
developers are forced to adapt their build process.=20

IOW, merely warn people that in-tree builds are deprecated and
not tested by the project and enourage switching to out of tree
builds. Dont try to magically create a separate build dir now.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


