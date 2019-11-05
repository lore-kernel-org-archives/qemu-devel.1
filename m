Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B296C49EAD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C7820869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hmc5a12q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C7820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvaA-00024G-CW
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iRvYV-000083-OE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iRvYS-0005Or-UM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:55:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iRvYS-0005Lo-HE
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572947715;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2WN+VRs+u/UP11Q55TNPNCCWcMLJguDgIUELZXAjdg=;
 b=Hmc5a12qAI9YUqctmu+XmAhzC+wQXdiyL4p5r0W9qnVuW7vS3mgQPeQOu2B6fIJ8qnhQdR
 ulca9Y1dhJR8LPENGULEuBw4K+7z1wnKrBAFCL8UDlEHN821HKExT8f3/R5rYZkSZM7OyU
 jRc6x97I0O19rXIn2SuCvlOoHYTkk+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Z6MPyYZsPgGiXzzhcN5k1Q-1; Tue, 05 Nov 2019 04:55:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C8FB107ACC2;
 Tue,  5 Nov 2019 09:55:11 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FC92608B5;
 Tue,  5 Nov 2019 09:55:02 +0000 (UTC)
Date: Tue, 5 Nov 2019 09:54:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Miguel Arruga Vivas <rosen644835@gmail.com>
Subject: Re: [Qemu-devel] [Fail] tests/test-util-filemonitor fails
Message-ID: <20191105095459.GC41709@redhat.com>
References: <20190808020723.GB26938@richard> <20190808080229.GA2534@redhat.com>
 <20190808084653.GB32524@richard> <20190808092213.GB2534@redhat.com>
 <20190809000609.GA4201@richard> <20190809091214.GD13660@redhat.com>
 <20191104171624.6e62c112@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191104171624.6e62c112@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Z6MPyYZsPgGiXzzhcN5k1Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 04, 2019 at 08:35:23PM +0100, Miguel Arruga Vivas wrote:
> Hi Daniel,
>=20
> I've been trying to open a bug in launchpad about exactly this, but it
> always raises an error when trying to log in.  Then I found this
> thread diving into the archives, so I'll try to kindly ask here about
> it.
>=20
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > On Fri, Aug 09, 2019 at 08:06:09AM +0800, Wei Yang wrote:
> > > On Thu, Aug 08, 2019 at 10:22:13AM +0100, Daniel P. Berrang=C3=A9
> > > wrote: =20
> > > >On Thu, Aug 08, 2019 at 04:46:53PM +0800, Wei Yang wrote: =20
> > > >> On Thu, Aug 08, 2019 at 09:02:29AM +0100, Daniel P. Berrang=C3=A9
> > > >> wrote: =20
> > > >> >On Thu, Aug 08, 2019 at 10:07:23AM +0800, Wei Yang wrote: =20
> > > >> >> Current qemu fails tests/test-util-filemonitor. =20
> > > >> >
> > > >> >You'll need to provide more info. The test works for me and
> > > >> >passes in all the QEMU CI environments.
> > > >> > =20
> > > >>=20
> > > >> The error message from my side is:
> > > >>=20
> > > >> /util/filemonitor: Expected watch id 200000000 but got 100000000
> > > >> **
> > > >> ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events:
> > > >> assertion failed: (err =3D=3D 0)
> > > >>=20
> > > >> What else you'd prefer to have? =20
> > > >
> > > >Can you set the  "FILEMONITOR_DEBUG=3D1" env variable before running
> > > >the test - it will print out lots more info
> > > > =20
> > >=20
> > > Here is the output with more info.
> > >=20
> > >     $ FILEMONITOR_DEBUG=3D1
> > > QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64
> > > tests/test-util-filemonitor =20
> >=20
> > >     Rmdir /tmp/test-util-filemonitor-151B6Z/fish
> > >     Event id=3D200000000 event=3D4 file=3D
> > >     Expected watch id 200000000 but got 100000000
> > >     ** =20
> >=20
> > Ok, so the kernel is sending the events in an unexpected order
>=20
> I've been reading about the issue and as far as I understand the inotify
> man-page[http://man7.org/linux/man-pages/man7/inotify.7.html], section
> "Dealing with rename() events", points out that the order nor the
> atomicity of the concurrent events is something that should be relied
> on.
> =20
> > >     ERROR:tests/test-util-filemonitor.c:665:test_file_monitor_events:
> > > assertion failed: (err =3D=3D 0) Aborted (core dumped)
> > >=20
> > >  =20
> > > >Also what operating system are you using, and what kernel version
>=20
> We have hit this error on GNU Guix master
> [http://issues.guix.gnu.org/issue/37860]. I'm using linux-libre 5.3.4
> on x86_64.  It does not seem to be something deterministic, but I just
> commented out the test the fifth time I've hit the same error.
>=20
> Is there any way to change the test to not rely on the ordering of the
> events from different views of the same fs action?

This reported bug was already fixed in git master with

  commit bf9e0313c27d8e6ecd7f7de3d63e1cb25d8f6311
  Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Date:   Wed Aug 21 16:14:27 2019 +0100

    tests: make filemonitor test more robust to event ordering
   =20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


