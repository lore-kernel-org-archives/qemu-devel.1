Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9AC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74A52084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74A52084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQy4J-0002JF-T2
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:51:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQy2V-0001FX-6F
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:50:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQy2T-0008WR-Um
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQy2T-0008Ui-My
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:50:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD2733083045;
	Wed, 15 May 2019 17:50:00 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 27689608A6;
	Wed, 15 May 2019 17:49:58 +0000 (UTC)
Date: Wed, 15 May 2019 18:49:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190515174956.GL4751@redhat.com>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
	<20190514191653.31488-2-richard.henderson@linaro.org>
	<20190515165328.GK4751@redhat.com>
	<314ae411-2d75-00e6-109a-2604a36973b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <314ae411-2d75-00e6-109a-2604a36973b7@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 17:50:00 +0000 (UTC)
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 10:22:08AM -0700, Richard Henderson wrote:
> On 5/15/19 9:53 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 14, 2019 at 12:16:30PM -0700, Richard Henderson wrote:
> >> For user-only, we require only the random number bits of the
> >> crypto subsystem.
> >>
> >> We need to preserve --static linking, which for many recent Linux
> >> distributions precludes using GnuTLS or GCrypt.  Instead, use our
> >> random-platform module unconditionally.
> >=20
> > I don't think we need to special case in this way.
> >=20
> > Today if you do a default build with all targets & tools and want
> > to use --static, but don't have static libs available for some
> > things you can achieve that
> >=20
> >  ./configure --static --disable-gnutls --disable-gcrypt --disable-net=
tle
>=20
> But we don't really want all of those --disable arguments by default.  =
It would
> be one thing if one explicitly used --enable-gnutls and got link errors=
.  We
> must preserve --static working all by itself.

That's already not working today unless you add extra args to disable
build of the system emulators and tools.=20

> > Previously if you took care to disable system emulators & tools
> > you could avoid the need to pass the --disable-* args, but I
> > think that's fairly minor.
>=20
> Well, no, you get link errors.
>=20
> (As an aside, IMO pkg-config is stupid in being only able to ask "is ve=
rsion X
> installed" without also being about to ask "is a static version of X
> installed".  pkg-config has a --static option, it just doesn't use it.)

Yeah it is very frustrating that it isn't actually useful in the way
you'd expect.

> But suppose we add back the patch for --static sanity check from v6.  W=
hat are
> we left with?  No crypto libraries remain on Fedora 30.  It appears tha=
t Ubuntu
> Bionic ships a static version of nettle, but nothing else.  Is that use=
ful on
> its own?

nettle isn't useful from POV of RNG.

> > So I think we should just use $(crypto-obj-y) unconditionally in
> > the user emulators, and get rid of crypto-aes-obj-y too.
> >=20
> > This will give a consistent crypto story across all the things we
> > build with no special cases.
>=20
> Well, maybe.  But what are we trying to accomplish?

With this v7, if building dynamically we get some parts of QEMU using
the full crypto/ impl and thus GNUTLS for RNG, and some parts of QEMU
using just the rng-platform.o.  I'd like it all to use the full crypto
impl when building dynamically.

Similarly if building statically, it should again result in the same
fallback choices. If a static gnutls is available it should use that,
but if none is present everything, it will get build with rng-platform.o

IOW, either we just document need to pass

   --disable-gnutls --disable-gcrypt --disable-nettle

if the distro lacks static versions of those libs - we already need
thus documented as we already suffer from that problem when building
statically.

Or we need to make configure more clever and check if static linking
actually works for these libs.

> What use is crypto to the host side of linux-user?  In general, all the=
 crypto
> that the application will do is on the guest side, within guest version=
s of
> gnutls etc.  All crypto that the guest expects of its kernel is done pa=
ssing
> off the syscall to the host kernel.
>=20
> That's why, here in v7, I began to think that perhaps all the faffing a=
bout
> with pkg-config vs --static was just a waste of time.
>=20
> Have I missed something?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

