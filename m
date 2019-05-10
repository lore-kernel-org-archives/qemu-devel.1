Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A7BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8EA21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8EA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8ct-0004Ie-Bn
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:44:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP8Le-00065a-83
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP8LY-0001Zl-1W
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hP8LV-0001X3-Ov
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:26:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AC048308402A;
	Fri, 10 May 2019 16:26:03 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 288B45D6A9;
	Fri, 10 May 2019 16:25:56 +0000 (UTC)
Date: Fri, 10 May 2019 17:25:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190510162554.GQ7671@redhat.com>
References: <20190510134203.24012-1-lvivier@redhat.com>
	<20190510134203.24012-2-lvivier@redhat.com>
	<20190510121135-mutt-send-email-mst@kernel.org>
	<20190510161644.GP7671@redhat.com>
	<20190510121939-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510121939-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 16:26:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/3] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Cc: Laurent Vivier <lvivier@redhat.com>,
	Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 12:21:19PM -0400, Michael S. Tsirkin wrote:
> On Fri, May 10, 2019 at 05:16:44PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, May 10, 2019 at 12:12:41PM -0400, Michael S. Tsirkin wrote:
> > > On Fri, May 10, 2019 at 03:42:01PM +0200, Laurent Vivier wrote:
> > > > From: Kashyap Chamarthy <kchamart@redhat.com>
> > > >=20
> > > > When QEMU exposes a VirtIO-RNG device to the guest, that device n=
eeds a
> > > > source of entropy, and that source needs to be "non-blocking", li=
ke
> > > > `/dev/urandom`.  However, currently QEMU defaults to the problema=
tic
> > > > `/dev/random`, which is "blocking" (as in, it waits until suffici=
ent
> > > > entropy is available).
> > > >=20
> > > > Why prefer `/dev/urandom` over `/dev/random`?
> > > > ---------------------------------------------
> > > >=20
> > > > The man pages of urandom(4) and random(4) state:
> > > >=20
> > > >     "The /dev/random device is a legacy interface which dates bac=
k to a
> > > >     time where the cryptographic primitives used in the implement=
ation
> > > >     of /dev/urandom were not widely trusted.  It will return rand=
om
> > > >     bytes only within the estimated number of bits of fresh noise=
 in the
> > > >     entropy pool, blocking if necessary.  /dev/random is suitable=
 for
> > > >     applications that need high quality randomness, and can affor=
d
> > > >     indeterminate delays."
> > > >=20
> > > > Further, the "Usage" section of the said man pages state:
> > > >=20
> > > >     "The /dev/random interface is considered a legacy interface, =
and
> > > >     /dev/urandom is preferred and sufficient in all use cases, wi=
th the
> > > >     exception of applications which require randomness during ear=
ly boot
> > > >     time; for these applications, getrandom(2) must be used inste=
ad,
> > > >     because it will block until the entropy pool is initialized.
> > >=20
> > > So how about just using getrandom then?
> >=20
> > The 3rd patch in this series addresses that.
>=20
> It seems to use qemu_guest_getrandom which in turn
> with patch 1 calls /dev/urandom...
> Did I miss something?

qemu_guest_getrandom will preferentially use the crypto library random
APIs (gnutls, or gcrypt). If both are compiled out that it will use
getrandom() if supported by the C library and current kernel. If that
fails then it will try /dev/urandom if it exists, finally /dev/random.=20
On Windows it uses their native crypto API. See this dependant series:

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02237.html

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

