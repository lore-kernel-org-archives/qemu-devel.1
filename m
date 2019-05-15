Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BAAC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D18205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 20:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D18205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR0L4-0006sT-8v
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 16:17:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hR0JG-0005uY-Rx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hR0JF-0007oB-JL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hR0JF-0007eE-CF
	for qemu-devel@nongnu.org; Wed, 15 May 2019 16:15:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEA07E3E00;
	Wed, 15 May 2019 20:15:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.112.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DC4B460BE5;
	Wed, 15 May 2019 20:15:17 +0000 (UTC)
Date: Wed, 15 May 2019 21:15:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190515201514.GA1417@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<20190515165328.GK4751@redhat.com>
	<314ae411-2d75-00e6-109a-2604a36973b7@linaro.org>
	<20190515174956.GL4751@redhat.com>
	<5f4af92c-4db4-dc72-74c2-cfe1dc4eb021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f4af92c-4db4-dc72-74c2-cfe1dc4eb021@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 15 May 2019 20:15:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v7 01/24] build: Link user-only with
 crypto-rng-obj-y
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 09:38:00PM +0200, Laurent Vivier wrote:
> On 15/05/2019 19:49, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, May 15, 2019 at 10:22:08AM -0700, Richard Henderson wrote:
> >> On 5/15/19 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> >>> On Tue, May 14, 2019 at 12:16:30PM -0700, Richard Henderson wrote:
> >>>> For user-only, we require only the random number bits of the
> >>>> crypto subsystem.
> >>>>
> >>>> We need to preserve --static linking, which for many recent Linux
> >>>> distributions precludes using GnuTLS or GCrypt.  Instead, use our
> >>>> random-platform module unconditionally.
> >>>
> >>> I don't think we need to special case in this way.
> >>>
> >>> Today if you do a default build with all targets & tools and want
> >>> to use --static, but don't have static libs available for some
> >>> things you can achieve that
> >>>
> >>>  ./configure --static --disable-gnutls --disable-gcrypt --disable-n=
ettle
> >>
> >> But we don't really want all of those --disable arguments by default=
.  It would
> >> be one thing if one explicitly used --enable-gnutls and got link err=
ors.  We
> >> must preserve --static working all by itself.
> >=20
> > That's already not working today unless you add extra args to disable
> > build of the system emulators and tools.=20
> >=20
>=20
> Perhaps it can help, I have a series queued by Paolo to cleanup the
> build dependencies for --{disable,enable}-{system,user,tools}:
>=20
>     [v3,0/5] build: cleanup in Makefile.objs
>     https://patchwork.kernel.org/cover/10880135/

I don't think it'll make a difference to use of --static when trying
to build a default config (ie all targets + tools)


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

