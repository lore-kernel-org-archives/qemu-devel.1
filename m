Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CCCC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F6F20821
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 08:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F6F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32893 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGJKW-00004u-9i
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 04:20:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJIG-0007PA-AQ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGJIF-0005Jx-79
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:18:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGJIE-0005JZ-VX
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:18:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 263BC308424E;
	Tue, 16 Apr 2019 08:18:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F5A919C71;
	Tue, 16 Apr 2019 08:18:07 +0000 (UTC)
Date: Tue, 16 Apr 2019 09:18:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190416081804.GC31311@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
	<20190415092500.GD5718@redhat.com>
	<aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <aa92336f-681e-30d9-2670-7d0093d9912a@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 16 Apr 2019 08:18:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
	"mst@redhat.com" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416081804.xGaZ9jewKY8V5d4u2TWpA86LtwBL35EZnKrFheQqn0g@z>

On Tue, Apr 16, 2019 at 02:56:12PM +0800, Pu Wen wrote:
> On 2019/4/15 17:25, Daniel P. Berrang=C3=A9 wrote:
> > On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> ...
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index f2c15bf..551bec9 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -128,6 +128,8 @@ GlobalProperty pc_compat_3_1[] =3D {
> > >       { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
> > >       { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
> > >       { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
> > > +    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
> > > +    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
> > >       { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
> > >       { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
> > >       { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
> > > @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] =3D {
> > >       { TYPE_X86_CPU, "topoext", "off" },
> > >       { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> > >       { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> > > +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> > >   };
> > >   const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
> >=20
> > You can drop the changes in this file. This CPU model didn't exist
> > in any older QEMU releases, so there's no machine type backcompat
> > required, at least from upstream QEMU POV.
>=20
> Then how about running QEMU with the parameter like "-M pc-i440fx-2.12"=
?
> Although the default machine is newer than that.

That doesnt matter.  This back-compat property table is about ensuring
that "-cpu Skylake-Client -M pc-i440fx-2.12" run on QEMU 4.0.0 release
works the same way as when run on QEMU 2.12.0 release.

Since there is no Dhyana CPU model in QEMU 2.12.0 release, there's no
back compat issue to fix.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

