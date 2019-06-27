Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA101C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08B22085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08B22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTx0-0004Dj-1M
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55421)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hgTvp-0003kB-3u
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hgTvn-0001jZ-PO
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:55:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hgTvn-0001iv-HJ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D8E3091740
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 12:55:09 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7C40608CA;
 Thu, 27 Jun 2019 12:55:08 +0000 (UTC)
Date: Thu, 27 Jun 2019 13:55:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190627125505.GH12358@redhat.com>
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <20190627090353.GA24929@redhat.com>
 <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8ae5bd6-2b52-99e0-993c-fe8f65d40da3@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 27 Jun 2019 12:55:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 12:16:05PM +0200, Paolo Bonzini wrote:
> On 27/06/19 11:03, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Jun 10, 2019 at 01:14:57PM +0200, Paolo Bonzini wrote:
> >> The Meson build system is integrated in the existing configure/make =
steps
> >> by invoking Meson from the configure script and converting Meson's b=
uild.ninja
> >> rules to an included Makefile.
> >=20
> > Why did you take the route of converting ninja rules into makefile
> > rules, as opposed to just having some stub makefile rules which
> > directly invoke ninja where needed ?
>=20
> There are two parts of this.  One is practical and has to do with
> supporting a step-by-step transition.  Using ninja2make makes it trivia=
l
> to have make build products that depend on meson build products, and
> this way bottom up is a natural direction to do the conversion, which i=
s
> bottom up.  You'd start from libqemuutil.a and code generators (tracing
> + QAPI), then go to the tools and the emulators.

Ok, I can understand that. I've been thinking about how we can switch
libvirt to use meson too, and trying to decide between meson being the
owner, calling out to make  vs keeping make as the owner and calling
out to meson. Ultimately to entirely banish make, autoconf, automake,
libtool, m4 & shell from our build system :-)

Despite thinking about an incremental conversion though, I was still
hoping libvirt would just have a single (largish) patch series to
do a complete conversion at a specific point in time.

> > Obviously this series is just some initial integration, but eventuall=
y
> > when we get a complete conversion, I think it will look pretty wierd
> > if we're still converting ninja to make.
>=20
> I agree; once all the build rules are converted the Makefile could be a=
s
> simple as
>=20
> 	all:
> 	include config.mak
> 	include tests/docker/Makefile.include
> 	include tests/vm/Makefile.include
> 	.NOTPARALLEL:
> 	%:
> 		ninja $@
>=20
> 	subdir-%-softmmu:
> 		ninja qemu-system-$*
>=20
> 	subdir-%-linux-user:
> 		ninja qemu-$*
>=20
> 	check:
> 		$(MESON) test
>=20
> 	check-%:
> 		$(MESON) test --suite $*
>=20
> etc. (and likewise the configure script could just translate the comman=
d
> line options before invoking meson).  But for now, since rules are
> written half in meson and half in make, ninja2make seems the most
> transparent way to integrate the two.

Ok, I think it understand the motiviation better now that its obviously
just a short term expedient step to convert ninja to make.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

