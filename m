Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB117C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B321D2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B321D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55550 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6ey-0006LZ-1v
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:26:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT6eC-0005Ws-Eo
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT6eA-00006l-NY
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT6eA-00006S-IF
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:25:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8EFE99DD9;
	Tue, 21 May 2019 15:25:43 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 120BB51C8A;
	Tue, 21 May 2019 15:25:33 +0000 (UTC)
Date: Tue, 21 May 2019 16:25:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190521152530.GR25835@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnobrg37.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 21 May 2019 15:25:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 05:18:36PM +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
> > On 21/05/19 10:53, Daniel P. Berrang=C3=A9 wrote:
> [...]
> >> QEMU should pick a tool which is well established / widely used & th=
us
> >> stands a good chance of being maintained for the long term, as we do=
n't
> >> want to end up relying on abandonware in 5 years time.  The kernel-d=
oc
> >> project is not widely used, but its main user is significant enough =
that
> >> it isn't likely to die through lack of maintainers.
> >
> > A couple years ago I didn't have problems modifying kerneldoc for QEM=
U's
> > syntax, it was a 10 lines patch.  Unfortunately I cannot find it anym=
ore.
>=20
> "QEMU's syntax" --- excuse me while I guffaw.
>=20
> What you (quite charitably) call "syntax", I call a habit of imitating
> examples.
>=20
> Anyway.  What's so special about QEMU that justifies coming up with our
> own doc syntax?  Other than "we made a hash of it, and cleaning it up
> would be work".

There's really no such thing as "QEMU syntax" for docs comments right
now AFAICT. We have used at least 4 different syntaxes across the various
parts of the codebase and none seems a clear winner in terms of usage. So
I assume that whatever tool we pick, the majority of work will be updatin=
g
existing docs comments to follow whatever syntax is picked.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

