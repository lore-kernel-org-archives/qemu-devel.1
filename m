Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62329C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:59:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2916720869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPyVDcUk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2916720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS43L-0000tD-9f
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iS428-00008H-L6
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iS41j-0001tB-CR
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:58:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iS41j-0001sz-8E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572980283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GVqNJQn+sLBTmtj5fKdnJMPW+NBUpq5Wszc2IgCo54=;
 b=OPyVDcUk7F8ozUwBtnrzCGJlS04k2n+OENMqhtAKmLeVTVLR6xcu97v+Y+O8t8KcjjLNW9
 uK/rr/56D9dB0N3v35GvTZ9iBIRD30QcNtZ+D+53foHCvri57cCh6EbzlP+FzPK6yDn4XJ
 JGnLj6O22kMXhnq8QLEtzChUo2pyqdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-s0RUTdedNluJpZCank5jmg-1; Tue, 05 Nov 2019 13:58:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6E0F1005500;
 Tue,  5 Nov 2019 18:57:58 +0000 (UTC)
Received: from work-vm (ovpn-117-86.ams2.redhat.com [10.36.117.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D1F775D9CD;
 Tue,  5 Nov 2019 18:57:49 +0000 (UTC)
Date: Tue, 5 Nov 2019 18:57:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] global: Squash 'the the'
Message-ID: <20191105185747.GE2781@work-vm>
References: <20191104185202.102504-1-dgilbert@redhat.com>
 <157290359988.27285.16497763825853147226@37313f22b938>
 <87ftj2kabe.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ftj2kabe.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: s0RUTdedNluJpZCank5jmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, qemu-devel@nongnu.org, laurent@vivier.eu,
 marcandre.lureau@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Benn=E9e (alex.bennee@linaro.org) wrote:
>=20
> no-reply@patchew.org writes:
>=20
> > Patchew URL: https://patchew.org/QEMU/20191104185202.102504-1-dgilbert@=
redhat.com/
> >
> >
> >
> > Hi,
> >
> > This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > make docker-image-centos7 V=3D1 NETWORK=3D1
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> >   TEST    iotest-qcow2: 009
> >   TEST    iotest-qcow2: 010
> > **
> > ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:wait_for_migration_=
fail: assertion failed: (!strcmp(status, "setup") || !strcmp(status, "faile=
d") || (allow_active && !strcmp(status, "active")))
> > ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:903:w=
ait_for_migration_fail: assertion failed: (!strcmp(status, "setup") || !str=
cmp(status, "failed") || (allow_active && !strcmp(status, "active")))
> > make: *** [check-qtest-aarch64] Error 1
> > make: *** Waiting for unfinished jobs....
>=20
> That's one I've been seeing intermittently on Travis since the
> softfreeze started. It was masked by the other regressions which are now
> fixed.

If anyone hits this I'd be greatful for a backtrace and/or the value of
'status' at the point it fails.

Dave

>=20
> >   TEST    check-unit: tests/test-bdrv-drain
> >   TEST    iotest-qcow2: 011
> > ---
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run',=
 '--label', 'com.qemu.instance.uuid=3Dacf3f0f780e741e6a5c367dda157d023', '-=
u', '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET=
_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '=
-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache'=
, '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v',=
 '/var/tmp/patchew-tester-tmp-_ad8j8yg/src/docker-src.2019-11-04-16.29.40.7=
445:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']=
' returned non-zero exit status 2.
> > filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dacf3f0f780e741e6a5=
c367dda157d023
> > make[1]: *** [docker-run] Error 1
> > make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-_ad8j8yg/src'
> > make: *** [docker-run-test-quick@centos7] Error 2
> >
> > real    10m19.416s
> > user    0m7.957s
> >
> >
> > The full log is available at
> > http://patchew.org/logs/20191104185202.102504-1-dgilbert@redhat.com/tes=
ting.docker-quick@centos7/?type=3Dmessage.
> > ---
> > Email generated automatically by Patchew [https://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
>=20
>=20
> --
> Alex Benn=E9e
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


