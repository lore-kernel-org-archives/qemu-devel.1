Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74AC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7E92189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E92189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiyzi-0000Fw-TR
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hiyyu-0007y6-LN
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:28:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hiyyt-0001aW-Du
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hiyyt-0001aB-8Q
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86061368E3
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 10:28:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DC8860A9D;
 Thu,  4 Jul 2019 10:28:40 +0000 (UTC)
Date: Thu, 4 Jul 2019 11:28:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190704102837.GA24190@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190704102457.GE1609@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 04 Jul 2019 10:28:46 +0000 (UTC)
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 03, 2019 at 06:25:01PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > > @@ -306,6 +308,13 @@ bool trace_init_backends(void)
> > >      openlog(NULL, LOG_PID, LOG_DAEMON);
> > >  #endif
> > > =20
> > > +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
> > > +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
> > > +    trace_env =3D getenv("QEMU_TRACE_EVENTS");
> > > +    if (trace_env) {
> > > +        trace_enable_events(trace_env);
> > > +    }
> > > +
> >=20
> > I don't think it is a nice idea to add this via environment variables
> > to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handsh=
ake
> > to read the env vars and then pass a suitable -trace arg when spawnin=
g
> > QEMU ?
>=20
> What is the concern about adding these environment variables to QEMU?
>=20
> It is convenient to be able to use tracing even if QEMU is invoked by
> something you cannot modify/control.
>=20
> The main issues I see with environment variables are:
>=20
> 1. Security.  Is there a scenario where an attacker can use environment
>    variables to influence the behavior of a QEMU process running at a
>    different trust level?
>=20
> 2. Name collision.  What is the chance that existing users already
>    define environment variables with these names and that unexpected
>    behavior could result?

One of the biggest problems with QEMU in general has been poorly modelled
& defined interfaces for configuration. At runtime we've solved this with
QMP. At startup we're still fighting the horror of QemuOpts in general an=
d
haven't got startup modelling to be on a par with that offered by QEMU.
It was even worse when Audio didn't even use QemuOpts and instead used
an arbitrary set of poorly defined env variables. To me adding yet anothe=
r
way to configure QEMU via env vars is moving in the opposite direction to
what we want.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

