Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718FC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7FD20675
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 16:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7FD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQaeP-0006pI-A3
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 12:51:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQadY-0006U8-BG
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQadV-0001Uv-Ec
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:50:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQadV-0001Sn-7C
	for qemu-devel@nongnu.org; Tue, 14 May 2019 12:50:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CCD330089B5;
	Tue, 14 May 2019 16:50:40 +0000 (UTC)
Received: from redhat.com (ovpn-112-20.ams2.redhat.com [10.36.112.20])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2106A608A6;
	Tue, 14 May 2019 16:50:38 +0000 (UTC)
Date: Tue, 14 May 2019 17:50:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190514165036.GA7680@redhat.com>
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<877eatdq3w.fsf@dusky.pond.sub.org>
	<20190514152331.GJ25916@redhat.com>
	<d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d050fa9d-8e4b-7b87-31e5-05a7fa78feb9@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Tue, 14 May 2019 16:50:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Add qemu_getrandom and
 ARMv8.5-RNG etc
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 09:14:57AM -0700, Richard Henderson wrote:
> On 5/14/19 8:23 AM, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, May 14, 2019 at 05:15:31PM +0200, Markus Armbruster wrote:
> >> "make check-unit" fails for me:
> >>
> >>   TEST    check-unit: tests/test-crypto-tlscredsx509
> >> Unexpected error in object_new_with_propv() at /work/armbru/qemu/qom=
/object.c:674:
> >> invalid object type: tls-creds-x509
> >>
> >> and
> >>
> >>   TEST    check-unit: tests/test-io-channel-tls
> >> Unexpected error in object_new_with_propv() at /work/armbru/qemu/qom=
/object.c:674:
> >> invalid object type: tls-creds-x509
> >>
> >> I haven't looked further.
> >=20
> > I have a nasty feeling it is caused by
> >=20
> >   Subject: [PATCH v6 02/25] crypto: Merge crypto-obj-y into libqemuut=
il.a
> >=20
> > The QOM objects are not directly used by most of the code. We rely on
> > the constructor registering the QOM object and then we request an
> > instance of it via the type name. So there's no direct function calls
> > from any code into the crypto object impls.
> >=20
> > When we put the crypto objects into libqemuutil.a the linker is not
> > intelligent enough to see the constructor and so thinks all these
> > QOM object impls are unused and discards them when linking the final
> > binary.
>=20
> Yes, that would do it.  We would need something in the test that forces=
 the
> objects into the link.  Without having yet looked at the test cases, an=
y ideas?

I don't think this is only the test suite. I think it will affect all the
binaries we build

The only way you can force it is to use -Wl,--whole-archive arg to tell l=
d
to include everything from libqemuutil.la, but that will break the way
the stubs work, as we want make of the stubs to be discarded.

The only other option is to not build $(crypto-obj-y) into libqemuutil.la=
,
but list that variable explicitly everywhere that we list libqemuutil.la

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

