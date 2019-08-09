Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972A8C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5432166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 09:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5432166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw0xO-00044F-Pt
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 05:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hw0wl-0003E4-Ga
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hw0wk-0006wD-Br
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:12:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hw0wk-0006uh-5k
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 05:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BF61D30A541A;
 Fri,  9 Aug 2019 09:12:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8A965D9D6;
 Fri,  9 Aug 2019 09:12:17 +0000 (UTC)
Date: Fri, 9 Aug 2019 10:12:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190809091214.GD13660@redhat.com>
References: <20190808020723.GB26938@richard> <20190808080229.GA2534@redhat.com>
 <20190808084653.GB32524@richard> <20190808092213.GB2534@redhat.com>
 <20190809000609.GA4201@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190809000609.GA4201@richard>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 09:12:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Fail] tests/test-util-filemonitor fails
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 09, 2019 at 08:06:09AM +0800, Wei Yang wrote:
> On Thu, Aug 08, 2019 at 10:22:13AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> >On Thu, Aug 08, 2019 at 04:46:53PM +0800, Wei Yang wrote:
> >> On Thu, Aug 08, 2019 at 09:02:29AM +0100, Daniel P. Berrang=C3=A9 wr=
ote:
> >> >On Thu, Aug 08, 2019 at 10:07:23AM +0800, Wei Yang wrote:
> >> >> Current qemu fails tests/test-util-filemonitor.
> >> >
> >> >You'll need to provide more info. The test works for me and passes =
in all
> >> >the QEMU CI environments.
> >> >
> >>=20
> >> The error message from my side is:
> >>=20
> >> /util/filemonitor: Expected watch id 200000000 but got 100000000
> >> **
> >> ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events: as=
sertion failed: (err =3D=3D 0)
> >>=20
> >> What else you'd prefer to have?
> >
> >Can you set the  "FILEMONITOR_DEBUG=3D1" env variable before running
> >the test - it will print out lots more info
> >
>=20
> Here is the output with more info.
>=20
>     $ FILEMONITOR_DEBUG=3D1 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-sys=
tem-x86_64 tests/test-util-filemonitor

>     Rmdir /tmp/test-util-filemonitor-151B6Z/fish
>     Event id=3D200000000 event=3D4 file=3D
>     Expected watch id 200000000 but got 100000000
>     **

Ok, so the kernel is sending the events in an unexpected order

>     ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events: a=
ssertion failed: (err =3D=3D 0)
>     Aborted (core dumped)
>=20
>=20
> >Also what operating system are you using, and what kernel version
> >
>=20
> OS: Ubuntu 18.04.2 LTS
> Kernel: I built the kernel whose last commit is bed38c3e2dca.

Does it work if you use the normal LTS kernel package instead.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

