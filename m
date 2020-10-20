Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60CAC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C5A20757
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 15:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T97dyBfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C5A20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUtQh-0005PR-0r
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 11:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUtQ1-0004c9-Tx
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUtPz-0007GY-WA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603207159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIkwEexk2bVsl+cICWtaZ8IxE30/bxVM7iYp8Kk+yoM=;
 b=T97dyBfzbaQajaIULzErobNW/SQsS0RQJ/O0OtAb6yTUbtZftmIAZFbGNMxK4encTEhF5Z
 V2qrPJlHs+nQT/lf/tjwSaddCuHWr7vsh3/yyO2mc+dLYMytKrVknKpRjkeAznWB6zTH87
 nzpAJUMImUXm505qdpKwPwqyXhzP8hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-nN7ozVRTN4iimbFF-AEoRw-1; Tue, 20 Oct 2020 11:19:13 -0400
X-MC-Unique: nN7ozVRTN4iimbFF-AEoRw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 356B318BE169;
 Tue, 20 Oct 2020 15:19:12 +0000 (UTC)
Received: from localhost (ovpn-115-118.ams2.redhat.com [10.36.115.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4097100238E;
 Tue, 20 Oct 2020 15:19:11 +0000 (UTC)
Date: Tue, 20 Oct 2020 16:19:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/30] Block patches
Message-ID: <20201020151910.GA279266@stefanha-x1.localdomain>
References: <20201012182800.157697-1-stefanha@redhat.com>
 <CAFEAcA8Th3Bf8gN1eDcHMKP4FpvSHaxhV6kjYP92vLwbSwL=3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Th3Bf8gN1eDcHMKP4FpvSHaxhV6kjYP92vLwbSwL=3A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 10:48:17PM +0100, Peter Maydell wrote:
> On Mon, 12 Oct 2020 at 19:28, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2=
ef54:
> >
> >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-1=
0' into staging (2020-10-12 11:29:42 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> >
> > for you to fetch changes up to 3664ec6bbe236126b79d251d4037889e7181ab55=
:
> >
> >   iotests: add commit top->base cases to 274 (2020-10-12 16:47:58 +0100=
)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > v2:
> >  * Rebase and resolve conflict with commit 029a88c9a7e3 ("qemu-nbd: Hon=
or
> >    SIGINT and SIGHUP") [Peter]
> >
>=20
> Build failures, OSX and the BSDs:
>=20
> Compiling C object
> contrib/libvhost-user/libvhost-user.a.p/libvhost-user-glib.c.o
> ../../contrib/libvhost-user/libvhost-user.c:27:10: fatal error:
> 'sys/eventfd.h' file not found
> #include <sys/eventfd.h>
>          ^~~~~~~~~~~~~~~
> In file included from ../../contrib/libvhost-user/libvhost-user-glib.c:17=
:
> In file included from ../../contrib/libvhost-user/libvhost-user-glib.h:19=
:
> ../../contrib/libvhost-user/libvhost-user.h:21:10: fatal error:
> 'linux/vhost.h' file not found
> #include <linux/vhost.h>
>          ^~~~~~~~~~~~~~~
> 1 error generated.
>=20
>=20
> Build failure, 32-bit:
>=20
> ../../util/vhost-user-server.c: In function 'vu_message_read':
> ../../util/vhost-user-server.c:119:30: error: format '%lu' expects
> argument of type 'long unsigned int', but argument 3 has type 'size_t
> {aka unsigned int}' [-Werror=3Dformat=3D]
>                  error_report("A maximum of %zu fds are allowed, "
>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../../util/vhost-user-server.c:121:39:
>                               max_fds, vmsg->fd_num + nfds);
>                                        ~~~~~~~~~~~~~~~~~~~
> ../../util/vhost-user-server.c:120:45: note: format string is defined her=
e
>                               "however got %lu fds now",
>                                            ~~^
>                                            %u
>=20
> (you might also want to wordsmith the English in that error message)
>=20
> Build failure, Windows:
>=20
> ../../qemu-nbd.c:158:5: error: "CONFIG_POSIX" is not defined [-Werror=3Du=
ndef]
>  #if CONFIG_POSIX
>      ^
>=20
> 'make check' failure, s390x and ppc64 (ie big-endian host):
>=20
> ERROR:../../tests/qtest/vhost-user-blk-test.c:448:idx: assertion
> failed (capacity =3D=3D TEST_IMAGE_SIZE / 512): (2199023255552 =3D=3D 131=
072)
> ERROR qtest-i386: qos-test - Bail out!
> ERROR:../../tests/qtest/vhost-user-blk-test.c:448:idx: assertion
> failed (capacity =3D=3D TEST_IMAGE_SIZE / 512): (2199023255552 =3D=3D 131=
072)
>=20
> I also got this on aarch64 host:
>=20
> ERROR:../../tests/qtest/boot-sector.c:161:boot_sector_test: assertion
> failed (signature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000dead)
> ERROR qtest-s390x: cdrom-test - Bail out!
> ERROR:../../tests/qtest/boot-sector.c:161:boot_sector_test: assertion
> failed (signature =3D=3D SIGNATURE): (0x00000000 =3D=3D 0x0000dead)
>=20
> but it might be an unrelated intermittent.
>=20
> Also a hang on x86-64 host running qtest-ppc64 qos-test, ditto.

Thanks for the info. I will send a v2.

Stefan

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+O/+4ACgkQnKSrs4Gr
c8j6cwgAiSWT3PYkUJ7Te9pHCgt2zEGOg1B3Kyqx2x5VcqxIx5iC/mR+d2ZV3oKu
PtYk/JTOKI5h1SmgxyMmAT7cLQmrkLv5tXSnd1qBQhw61cv9afU6byXtmG10rh1w
1Ze6Ro6+/BOAR9fNjT7+tcedFDOA1EBH1Lxybw3qySzxVfOQgQ8Bubb5sQSs7qCG
v7nUaEUkxEdZptdoeKfBfD5Jr+JtJs2WctzyzSAyJ9sRYyIcXT8OrJ8J0KlCHGyG
iFrrmGlhLtbbHBbcgpB47EvGdOsNIfX0iOlC95fzIHajExSeuURs0oPY1Sy5rsl1
PVynY5EyqzXUTcuF4DsZdVOqbjUUvg==
=FWuy
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--


