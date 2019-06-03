Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48C8C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC0428018
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC0428018
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjOO-0001sZ-3A
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:36:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hXjNW-0001Pr-H6
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:35:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hXjNQ-0001m0-T0
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:35:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hXjNM-0001VX-W9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:35:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4E0346288;
	Mon,  3 Jun 2019 09:35:26 +0000 (UTC)
Received: from gondolin (ovpn-204-96.brq.redhat.com [10.40.204.96])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF37F604FE;
	Mon,  3 Jun 2019 09:35:22 +0000 (UTC)
Date: Mon, 3 Jun 2019 11:35:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190603113518.4cce7e76.cohuck@redhat.com>
In-Reply-To: <87k1e3t6kw.fsf@dusky.pond.sub.org>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<CAL1e-=iM9VUkH+ao+pseJ+2jky2JM9L0hPQzjEF_-BJQjnzENw@mail.gmail.com>
	<87k1e3t6kw.fsf@dusky.pond.sub.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 03 Jun 2019 09:35:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 03 Jun 2019 10:29:35 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:
>=20
> > On May 29, 2019 5:09 PM, "Markus Armbruster" <armbru@redhat.com> wrote:=
 =20
> >>
> >> When scripts/get_maintainer.pl reports something like
> >>
> >>     John Doe <jdoe@example.org> (maintainer:Overall)
> >>
> >> the user is left to wonder *which* of our three "Overall" sections
> >> applies.  We have three, one each under "Guest CPU cores (TCG)",
> >> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
> >>
> >> Rename sections under
> >>
> >> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
> >>
> >> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
> >>
> >> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
> >> =20
> >
> > In its essence definitely not a bad idea, but I must admit I tend to ag=
ree
> > with Philippe the new titles sound confusing, odd, artificial. Perhaps =
the
> > better alternative could be:
> >
> > =E2=80=9CFOO TCG guest=E2=80=9D
> > =E2=80=9CFOO KVM guest=E2=80=9D
> > =E2=80=9CFOO Xen guest=E2=80=9D =20
>=20
> Other suggestions mentioned so far:
>=20
>   "FOO CPUs (TCG)"
>   "TCG FOO CPUs"
>=20
> and same for KVM and Xen.
>=20
> I guess mentioning target first, accelerator second, no parenthesis
> makes sense.  That leaves "guest" vs. "CPUs".  Which one's closer to the
> truth?

'CPUs' makes more sense to me; 'guest' would also include
(architecture-specific) emulated devices.

>=20
> >> * "Architecture support" from "FOO" to "FOO general architecture
> >>   support"
> >> =20
> >
> > Here we have a kind of strange situation with S390 architecture - it is=
 the
> > only one present in this way in MAINTAINERS. Othrr than that, your new
> > wording looks fine to me. =20
>=20
> Yes, it's odd.  But it's what works for the S390 maintainers.

Yes. I basically integrate all s390 stuff, including pull requests from
others. I'm more wondering why other architectures don't do that as
well :) Different setup, I guess.

