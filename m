Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A0C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD6B21882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD6B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hixuo-0007HR-QA
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34074)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hixtt-0006Xi-Cf
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hixtr-0007gv-IP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:19:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49770)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hixtr-0007g2-Cn
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:19:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E24673082B6D;
 Thu,  4 Jul 2019 09:19:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF1901001B3B;
 Thu,  4 Jul 2019 09:19:23 +0000 (UTC)
Date: Thu, 4 Jul 2019 10:19:21 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Message-ID: <20190704091921.GE20871@redhat.com>
References: <20190703135411.28436-1-berrange@redhat.com>
 <87k1cywznu.fsf@zen.linaroharston>
 <20190704085016.GC20871@redhat.com>
 <87h882w463.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h882w463.fsf@zen.linaroharston>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 04 Jul 2019 09:19:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 04, 2019 at 10:16:20AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Jul 03, 2019 at 10:56:05PM +0100, Alex Benn=C3=A9e wrote:
> >>
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> <snip>
> >> > The reality is that the monitor console (whether QMP or HMP) is
> >> > considered a privileged interface to QEMU and as such must only
> >> > be made available to trusted users. IOW, making it available with
> >> > no authentication over TCP is simply a, very serious, user
> >> > configuration error not a security flaw in QEMU itself.
> >>
> >> Is this the sort of thing we should emit warnings for? I guess this =
is a
> >> philosophical question as QEMU tends to err towards being taciturn o=
n
> >> the command line unless something is actually wrong (and not just
> >> stupid).
> >>
> >> I wouldn't expect a warning for -serial mon:stdio but maybe a
> >> non-localhost tcp chardev for o+rw socket might be worth a mention? =
Of
> >> course this sort of sanitising of the command line options does incu=
r
> >> cost and complexity in our option processing.
> >
> > The challenge with issuing warnings is ensuring that we don't give
> > false positives, and that's pretty much impossible IMHO.
> >
> > Even use of plain non-localhost TCP chardevs can be valid in some
> > circumstances. For example it would not be surprising to see it
> > used if QEMU was inside a Kubernetes container, as two containers
> > can communicate with each other over IP & rely on Kubernetes
> > networking layer to provide security
>=20
> That's certainly a valid setup - you're right this is really a policy
> question. Oh well I guess if your serious about security you read the
> documentation before going to production right ;-)
>=20
> I assume libvirt et all strive to use secure configurations by default?

Yes, libvirt exclusively uses a UNIX domain socket for the monitor, and
of course even if we used a TCP socket, the SELinux/AppArmour policy
will block any attempts at elevating privs via QMP commands that spawn
processes or try to access arbitrary files.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

