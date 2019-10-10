Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E076C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E452067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 13:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E452067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIYgv-0003ys-NI
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 09:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iIYWE-0000yZ-M5
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iIYW8-0000r5-8l
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:30:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iIYW6-0000pF-AQ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 09:30:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D346211A03;
 Thu, 10 Oct 2019 13:30:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 68BB45C686;
 Thu, 10 Oct 2019 13:29:49 +0000 (UTC)
Date: Thu, 10 Oct 2019 14:29:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/5] travis.yml: Compile on arm64, too
Message-ID: <20191010132947.GJ28562@redhat.com>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-6-thuth@redhat.com>
 <20191010105808.GH28562@redhat.com>
 <11a2be24-f177-8c55-b0fc-3945d023b877@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11a2be24-f177-8c55-b0fc-3945d023b877@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 10 Oct 2019 13:30:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 10, 2019 at 01:57:11PM +0200, Thomas Huth wrote:
> On 10/10/2019 12.58, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Oct 09, 2019 at 07:07:01PM +0200, Thomas Huth wrote:
> >> Travis now features an arm64 build host, so let's check compilation
> >> there, too.
> >>
> >> Unfortunately, there are some quirks:
> >> - block/ssh.c does not compile properly in this environment, so we h=
ave
> >>   to use --disable-libssh until that problem is fixed.
> >> - test-util-filemonitor fails, so we can not run the unit tests ther=
e
> >=20
> > Do you have any more info on this failure ?
> >=20
> > Running tests with FILEMONITOR_DEBUG=3D1 env variable set will make
> > it print more info
>=20
> Here you go:
>=20
> https://travis-ci.com/huth/qemu/jobs/244168910#L5775
>=20
> Quoting:
>=20
> "
> Add watch /tmp/test-util-filemonitor-PH0B9Z (null)
> Watch ID 100000000
> Add watch /tmp/test-util-filemonitor-PH0B9Z one.txt
> Watch ID 100000001
> Add watch /tmp/test-util-filemonitor-PH0B9Z two.txt
> Watch ID 100000002
> Create /tmp/test-util-filemonitor-PH0B9Z/one.txt
> Event id=3D100000000 event=3D0 file=3Done.txt
> Queue event id 100000000 event 0 file one.txt
> Queue event id 100000001 event 0 file one.txt
> Event id=3D100000001 event=3D0 file=3Done.txt
> Create /tmp/test-util-filemonitor-PH0B9Z/two.txt
> Queue event id 100000000 event 0 file two.txt
> Queue event id 100000002 event 0 file two.txt
> Event id=3D100000000 event=3D0 file=3Dtwo.txt
> Event id=3D100000002 event=3D0 file=3Dtwo.txt
> Create /tmp/test-util-filemonitor-PH0B9Z/three.txt
> Queue event id 100000000 event 0 file three.txt
> Event id=3D100000000 event=3D0 file=3Dthree.txt
> Unlink /tmp/test-util-filemonitor-PH0B9Z/three.txt
> Queue event id 100000000 event 2 file three.txt
> Event id=3D100000000 event=3D2 file=3Dthree.txt
> Rename /tmp/test-util-filemonitor-PH0B9Z/one.txt ->
> /tmp/test-util-filemonitor-PH0B9Z/two.txt
> Queue event id 100000000 event 2 file one.txt
> Queue event id 100000001 event 2 file one.txt
> Queue event id 100000000 event 0 file two.txt
> Queue event id 100000002 event 0 file two.txt
> Event id=3D100000000 event=3D2 file=3Done.txt
> Event id=3D100000001 event=3D2 file=3Done.txt
> Event id=3D100000000 event=3D0 file=3Dtwo.txt
> Event id=3D100000002 event=3D0 file=3Dtwo.txt
> Append /tmp/test-util-filemonitor-PH0B9Z/two.txt
> Queue event id 100000000 event 1 file two.txt
> Queue event id 100000002 event 1 file two.txt
> Event id=3D100000000 event=3D1 file=3Dtwo.txt
> Event id=3D100000002 event=3D1 file=3Dtwo.txt
> Touch /tmp/test-util-filemonitor-PH0B9Z/two.txt
> Event id=3D100000000 event=3D3 file=3Dtwo.txt
> Queue event id 100000000 event 3 file two.txt
> Queue event id 100000002 event 3 file two.txt
> Event id=3D100000002 event=3D3 file=3Dtwo.txt
> Del watch /tmp/test-util-filemonitor-PH0B9Z 100000001
> Add watch /tmp/test-util-filemonitor-PH0B9Z one.txt
> Watch ID 100000003
> Create /tmp/test-util-filemonitor-PH0B9Z/one.txt
> Queue event id 100000000 event 0 file one.txt
> Event id=3D100000000 event=3D0 file=3Done.txt
> Queue event id 100000003 event 0 file one.txt
> Event id=3D100000003 event=3D0 file=3Done.txt
> Del watch /tmp/test-util-filemonitor-PH0B9Z 100000003
> Unlink /tmp/test-util-filemonitor-PH0B9Z/one.txt
> Queue event id 100000000 event 2 file one.txt
> Event id=3D100000000 event=3D2 file=3Done.txt
> Mkdir /tmp/test-util-filemonitor-PH0B9Z/fish
> Queue event id 100000000 event 0 file fish
> Event id=3D100000000 event=3D0 file=3Dfish
> Add watch /tmp/test-util-filemonitor-PH0B9Z fish/
> Watch ID 200000000
> Add watch /tmp/test-util-filemonitor-PH0B9Z fish/one.txt
> Watch ID 200000001
> Create /tmp/test-util-filemonitor-PH0B9Z/fish/one.txt
> Queue event id 200000000 event 0 file one.txt
> Queue event id 200000001 event 0 file one.txt
> Event id=3D200000000 event=3D0 file=3Done.txt
> Event id=3D200000001 event=3D0 file=3Done.txt
> Del watch /tmp/test-util-filemonitor-PH0B9Z 200000001
> Rename /tmp/test-util-filemonitor-PH0B9Z/fish/one.txt ->
> /tmp/test-util-filemonitor-PH0B9Z/two.txt
> Queue event id 200000000 event 2 file one.txt
> Event id=3D200000000 event=3D2 file=3Done.txt
> Queue event id 100000000 event 0 file two.txt
> Event id=3D100000000 event=3D0 file=3Dtwo.txt
> Event id=3D100000002 event=3D0 file=3Dtwo.txt
> Queue event id 100000002 event 0 file two.txt
> Rmdir /tmp/test-util-filemonitor-PH0B9Z/fish
> Queue event id 100000000 event 2 file fish
> Event id=3D200000000 event=3D4 file=3D
> Missing event watch id 200000000 event 4 file
> **

This is really strange behaviour.  I've done some further test builds
on travis with various extra debug info & AFAICT, inotify is not
working correctly on the host - it is never emitting one of the events
that it should. Could be some wierd bug related to the filesystem
overlay setup used for the container env in travis I guess.

I'm not sure what todo here. I can't see an obvious trait that I can
use to identify a broken setup, in order to auto-skip the test. Might
just need to build without the inotify support somehow.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

