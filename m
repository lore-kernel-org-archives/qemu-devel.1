Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1B0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4993520781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiyYFvGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993520781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJ5k-0000IX-Ef
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jJJ4c-0007Oj-Ti
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jJJ4b-0005Cz-1U
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:45:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46166
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jJJ4a-0005C7-Ps
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585669503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHiBBFKN1+9Ah8JWzS7vq3zn0xuYV3qt7DLJoDjEr9M=;
 b=iiyYFvGuFQnsP7fcMr5sM9sDSU1tkYtWlJeSjMU9iw8nYlFusptLtGquPPhUWB3t9GE6Kd
 9D2cJheNQa+rK9p+Arn4Tdk8Hv5APf6edNdwlKokKX/2YkIL9E9w0tKCltAYklCNaDn/AT
 sIzE6pVKxPSzH80R3v/nb1nvG6Hl87E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-X-pxTg1tNJiJdhKTPdTLFg-1; Tue, 31 Mar 2020 11:45:01 -0400
X-MC-Unique: X-pxTg1tNJiJdhKTPdTLFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7A2D800D50;
 Tue, 31 Mar 2020 15:45:00 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-236.ams2.redhat.com [10.36.114.236])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 437D510002BB;
 Tue, 31 Mar 2020 15:44:59 +0000 (UTC)
Date: Tue, 31 Mar 2020 17:44:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200331154457.GJ7030@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com>
 <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <20200331120220.GA7030@linux.fritz.box>
 <d447cca0-44b2-392b-3be6-32f17c255dea@redhat.com>
 <alpine.BSF.2.22.395.2003311715110.73689@zero.eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2003311715110.73689@zero.eik.bme.hu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 31.03.2020 um 17:20 hat BALATON Zoltan geschrieben:
> On Tue, 31 Mar 2020, Eric Blake wrote:
> > On 3/31/20 7:02 AM, Kevin Wolf wrote:
> > > Am 31.03.2020 um 09:48 hat Paolo Bonzini geschrieben:
> > > > On 30/03/20 16:37, Kevin Wolf wrote:
> > > > > If manually dealing with separate build directories is inconvenie=
nt
> > > > > today, it will still be inconvenient with Meson, so this would me=
an
> > > > > introducing the automatic directly creation together with the oth=
er
> > > > > changes to enable Meson. Which is fine by me, as long as it is re=
ally
> > > > > done when the external directory becomes mandatory, so that peopl=
e won't
> > > > > have to switch back and forth between directories.
> > > >=20
> > > > Serious question: why is automatic directly creation more convenien=
t for
> > > > developers?  Even if "./configure" generates a "build" directory fo=
r
> > > > you, you would still have to invoke the QEMU binary as
> > > > "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient=
 than
> > > > doing "mkdir build" in the first place.
> > >=20
> > > Mainly because it allows me to start everything (most importantly: my
> > > editor, git and make) from the same directory.
> > >=20
> > > I guess the automatic directory creation is the less important part
> > > compared to a Makefile in the source tree that calls the Makefile in =
the
> > > build directory, because creation the directory is a one-time thing, =
but
> > > I call make all the time.
> >=20
> > If we make in-tree ./configure create a GNUmakefile shim that
> > auto-forwards to build/, it would also be possible to create symlinks t=
o
> > the various targets that will live in build.  I recently switched my
> > qemu playground to use VPATH builds, but with symlinks such as qemu-img
> > -> build/qemu-img, I can still use my muscle memory of an in-tree build
> > for normal development.

I like this idea. We could even make the emulator binaries available on
the top level then.

> > > Creating it automatically is nice especially for those who build QEMU
> > > for the first time and expect that the ./configure; make; make instal=
l
> > > sequence they are used to just works.
> > >=20
> > > Prefixing build/ when using the binaries is a change, too, but I gues=
s
> > > tab completion means that it's not much worse than prefixing ./
> >=20
> > With symlinks, it is possible to give much more than 'make' the illusio=
n
> > of working in-tree.  It then boils down to a question of how many
> > symlinks are worth creating.
>=20
> Also creating symlinks, while nice, is probably added maintainance
> burden because it's something that only needs to be done in in-tree
> runs so it will likely get broken by those using only out of tree.

To me this sounds like something that will be created once and then
never touched again except maybe for adding new binaries. If some binary
is missing, this is easily fixed by those who use pseudo-in-tree builds.

Kevin


