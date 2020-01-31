Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEE7C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462F8206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABGVqXJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462F8206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSxa-0004om-HC
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1ixSwi-0003zv-Bq
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1ixSwh-0007SC-2X
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:50:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ixSwf-0007Nj-8S
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580464236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJRbZSnGgMpMjyGCPpCU1a7QxDRPSRHuwSY/lQCwQYc=;
 b=ABGVqXJF8CfwuKAdZ+cc/MyMo8RxVG+Fq5SMqCj7oescVZI4OgS4aRIUbR83Re2dGa6vWY
 C+nkBrz1IsjtnxPbM1GYClbwmsCjWI1vY+07erc1ItgGmk/5aKlYCgZbFkT6YAi93sHvUC
 PIS+tvbVb4iL3idpVMOe8goVoWWtWj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-6mPNMvBJMVe_VDi-7_v85w-1; Fri, 31 Jan 2020 04:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A78DE800D5A;
 Fri, 31 Jan 2020 09:50:32 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-252.ams2.redhat.com
 [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCA685C290;
 Fri, 31 Jan 2020 09:50:24 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 695CB3E04B8; Fri, 31 Jan 2020 10:50:23 +0100 (CET)
Date: Fri, 31 Jan 2020 10:50:23 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
Message-ID: <20200131095023.GA9328@paraplu>
References: <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org>
 <20200130210902.GA25927@paraplu>
 <87y2toi29o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87y2toi29o.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 6mPNMvBJMVe_VDi-7_v85w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>, John Snow <jsnow@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 07:11:15AM +0100, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:

[...]

> > What can be done to improve QOM documentation (or lack thereof)?
>=20
> Are you trying to push us from idle grousing to actually improve things?
> No fair!

I first wrote it as a semi-complaint, and then I caught myself: "you're
not helping"; so I rephrased it to be more constructive. :-)

> > From a couple of hurried `grep` queries in the QEMU tree, there seems t=
o
> > be no explicit qom.rst|txt, or qemu-object-model.txt|rst or some such.
> > (I hope I haven't missed any other files.)
>=20
> As far as I know, all we have is the lovingly[*] written comments in
> include/qom/object.h.  Sadly, we've let them rot in places.  In
> particular, many newer functions are undocumented.
>=20
> This is *reference* documentation.  What we lack (sorely!) is an
> overview / friendly introduction, and a design document with rationale.
> Reconstructing rationale now would involve guesswork.

Me nods; that (guesswork in retroactive rationale construction) makes
matters slightly more difficult.

[...]

> >     Opening qom/object.h[2], indeed there is copious amounts of docs,
> >     expressed as commented-out text.  Two questions:
> >
> >     - How much of this is still accurate?  (Sorry, if that's a loaded
> >       question.)
>=20
> May I present you Armbru's Comment Trust Levels:
>
> ACTL2: The comment may be overly terse or incomplete, but the
> probability for it to be outright wrong is low.
>=20
> ACTL1: Treat as helpful guidance (with gratitude), but trust only the
> code.
>=20
> ACTL0: It is a tale Told by an idiot[**], full of sound and fury,
> Signifying nothing.
>=20
> Most comments in decently maintained code are at ACTL1.

Noted.  (And thanks for the useful reference scale :-))

> Around the time initial QOM development solidified, object.h's comments
> were ACTL2.  The neglect that is now clearly visible there makes me
> downgrade to ACTL1.
>=20
> Paolo will have a more informed and possibly different opinion.
>=20
> >     - If at least 60% is still accurate, is it valuable to extract and
> >       publish it as rendered rST, as part of the on-going QEMU Docs
> >       improvement?
>=20
> Beware, personal opinion.
>=20
> When you put documentation next to the code it documents (which you
> absolutely should, because it's your only realistic chance to keep the
> two in sync), then extracting API comments is useful, because it
> collects them in one place.
>=20
> It's of next to no use to me when the comments are all in the same place
> already, namely the header.

Yeah, reasonable point.

> > (b) The other clue is also from the same post, where Eduardo provides
> >     pointers to past KVM Forum presentations by MarkusA, PaoloB,
> >     AndreasF on QOM, Qdev et al.
> >
> >     Is it worth slapping all these references (with a clear intro and
> >     outro) into a qom.rst file in QEMU tree, even if only for
> >     reference/context?  Or are these references, in-tree docs in
> >     object.h out-of-date beyond repair? =20
>=20
> Uff.
>=20
> My qdev talks predate the rebase onto QOM.  They may well confuse /
> mislead as much as inform now.

Good to know.  (We don't want to add additional sources of confusion.)

> > If it is useful, I'm happy to get the initial doc going, secure in the
> > knowledge that more clueful people than me will chip in during the
> > review :-)
>=20
> Ha, nerd sniping!

:-)

Thanks for the response; it was useful.

[...]

--=20
/kashyap


