Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408E9C606AA
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF392053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF392053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkR3E-00017A-31
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hkR2H-0000fM-IP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hkR2F-0000DG-Vy
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:38:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hkR2F-0000Ca-OT
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:38:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D8F7281DFC
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 10:38:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAE5D5C46B;
 Mon,  8 Jul 2019 10:38:06 +0000 (UTC)
Date: Mon, 8 Jul 2019 11:38:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190708103804.GG3082@redhat.com>
References: <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
 <87d0iok4ai.fsf@dusky.pond.sub.org>
 <c4997dee-932c-eb57-23b9-4b51e8856f91@redhat.com>
 <874l3zhktx.fsf@dusky.pond.sub.org>
 <20190708093400.GB3082@redhat.com>
 <e396d430-1e6e-2e0b-454b-5c4208756742@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e396d430-1e6e-2e0b-454b-5c4208756742@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 08 Jul 2019 10:38:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 08, 2019 at 12:27:12PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 7/8/19 11:34 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Sat, Jul 06, 2019 at 06:02:18AM +0200, Markus Armbruster wrote:
> >> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>
> >>> On 7/5/19 3:19 PM, Markus Armbruster wrote:
> >>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> >>>>> On 7/5/19 10:07 AM, Stefan Hajnoczi wrote:
> >>>>>> On Thu, Jul 04, 2019 at 11:28:37AM +0100, Daniel P. Berrang=C3=A9=
 wrote:
> >>>>>>> On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote=
:
> >> [...]
> >>>>>>>> What is the concern about adding these environment variables t=
o QEMU?
> >>>>>>>>
> >>>>>>>> It is convenient to be able to use tracing even if QEMU is inv=
oked by
> >>>>>>>> something you cannot modify/control.
> >>>>>>>>
> >>>>>>>> The main issues I see with environment variables are:
> >>>>>>>>
> >>>>>>>> 1. Security.  Is there a scenario where an attacker can use en=
vironment
> >>>>>>>>    variables to influence the behavior of a QEMU process runni=
ng at a
> >>>>>>>>    different trust level?
> >>>>
> >>>> The common (and sad) solution for this is to require whatever runs=
 $PROG
> >>>> at a different trust level to scrub the environment.
> >>>
> >>> I hope people concerned by security build QEMU with the NOP trace b=
ackend.
> >>
> >> I sure hope at least one of our tracing backends (other than nop) ca=
n be
> >> used safely in production.
>=20
> I'm not saying production and security are orthogonal, but recent trend
> in security seems to reduce code exposure by disabling component, so I'=
d
> not be surprise if people who primary concern is strong security to use
> the NOP trace backend as default.
>=20
> > AFAIK, *all* of the trace backends are safe for use in production. Th=
e
> > only questions are around performance in production.  If anyone knows=
 of
> > any security problems with specific backends we should either address=
 them,
> > or document the backend is unsafe.
>=20
> I hope the tracing backend/frontends are safe. Now the trace events log
> a bunch of interesting information, so I'd not be surprise if some
> security researcher open a "QEMU information leak" CVE because we log
> various guest pointers i.e.

There would only be an information leak if the information was made
available to users/apps which are running at a lower privilege level
than QEMU. If you are root, or running as the QEMU user/group, then
all the information is already available by ptrace'ing QEMU or other
means. The tracing framework merely makes it available in an easier
to access way.

> Anyway, to stop bikeshedding this thread, can you add few lines about
> why not use getenv() in the HACKING?

I don't actually think the getenv thing is a security issue in any case.
If there was a security problem exploitable via getenv, then the bug woul=
d
lie in the application invoking QEMU for not ensuring the ENV contents
were safe before exec'ing QEMU. Libvirt is paranoid by default and scrubs
QEMU's env only keeping a specific sanitized whitelist for exactly these
reasons.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

