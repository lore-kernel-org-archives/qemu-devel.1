Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD20C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6972B20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ysq4GRiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6972B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpKE-0001Ph-Lc
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1izpJZ-0000oS-VT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1izpJW-0004H6-A6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:08:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45440
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1izpJV-00047g-VA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 17:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581026876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k1E1+8pGlX6K6dcSitTYHD9pONPNqtoxh8e9eN9LTUk=;
 b=Ysq4GRiLDJi7LEg78GkkKgkeXmJxv9Xjdz+//MJN0HdyhNudeQJ8R8FC0oWl6GF4SOO8rQ
 XADLuHamKr8g0Qp8L8C01JNf5H2runMM8TimKQqZRVUhMo9EW6rCO5DGzuZ5lbgO/k/PL+
 /jCvq0cZ3FGrM0yfNPQSVixdVxH0lgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-24sAkbX1PsOd0-Qwo859GQ-1; Thu, 06 Feb 2020 17:07:54 -0500
X-MC-Unique: 24sAkbX1PsOd0-Qwo859GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95E4DB25
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 22:07:53 +0000 (UTC)
Received: from localhost (unused-10-15-17-6.yyz.redhat.com [10.15.17.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 664A58EA10;
 Thu,  6 Feb 2020 22:07:50 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:07:50 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PULL 00/46] Python queue 2020-02-06
Message-ID: <20200206220750.GF412524@habkost.net>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2020 at 10:18:50PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Hi Peter,
>=20
> I prepared this series on behalf of Eduardo and
> Cleber (one of them will ack this cover).

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

>=20
> Regards,
>=20
> Phil.
>=20
> The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d761=
1c:
>=20
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-040220-=
1' into staging (2020-02-04 18:55:06 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.com/philmd/qemu.git tags/python-next-20200206
>=20
> for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d308:
>=20
>   .readthedocs.yml: specify some minimum python requirements (2020-02-06 =
21:48:24 +0100)
>=20
> ----------------------------------------------------------------
>=20
> - Python 3 cleanups:
>   . Remove text about Python 2 in qemu-deprecated (Thomas)
>   . Remove shebang header (Paolo, Philippe)
>   . scripts/checkpatch.pl now allows Python 3 interpreter (Philippe)
>   . Explicit usage of Python 3 interpreter in scripts (Philippe)
>   . Fix Python scripts permissions (Paolo, Philippe)
>   . Drop 'from __future__ import print_function' (Paolo)
>   . Specify minimum python requirements in ReadTheDocs configuration (Ale=
x)
> - Test UNIX/EXEC transports with migration (Oksana)
> - Added extract_from_rpm helper, improved extract_from_deb (Liam)
> - Allow to use other serial consoles than default one (Philippe)
> - Various improvements in QEMUMonitorProtocol (Wainer)
> - Fix kvm_available() on ppc64le (Wainer)
>=20
> ----------------------------------------------------------------
>=20
> Alex Benn=C3=A9e (1):
>   .readthedocs.yml: specify some minimum python requirements
>=20
> Denis Plotnikov (1):
>   tests: rename virtio_seg_max_adjust to virtio_check_params
>=20
> Liam Merwick (4):
>   travis.yml: install rpm2cpio for acceptance tests
>   tests/boot_linux_console: add extract_from_rpm method
>   tests/boot_linux_console: use os.path for filesystem paths
>   tests/boot_linux_console: fix extract_from_deb() comment
>=20
> Luk=C3=A1=C5=A1 Doktor (1):
>   python: Treat None-return of greeting cmd
>=20
> Oksana Vohchana (4):
>   tests/acceptance/migration: Factor out assert_migration()
>   tests/acceptance/migration: Factor out do_migrate()
>   tests/acceptance/migration: Test UNIX transport when migrating
>   tests/acceptance/migration: Test EXEC transport when migrating
>=20
> Paolo Bonzini (3):
>   scripts/signrom: remove Python 2 support, add shebang
>   make all Python scripts executable
>   drop "from __future__ import print_function"
>=20
> Philippe Mathieu-Daud=C3=A9 (24):
>   python/qemu/machine: Allow to use other serial consoles than default
>   Acceptance tests: Extract _console_interaction()
>   Acceptance tests: Add interrupt_interactive_console_until_pattern()
>   tests/boot_linux_console: Tag Emcraft Smartfusion2 as running 'u-boot'
>   tests/acceptance/virtio_check_params: Improve exception logging
>   tests/acceptance/virtio_check_params: List machine being tested
>   tests/acceptance/virtio_check_params: Default to -nodefaults
>   tests/acceptance/virtio_check_params: Disable the test
>   tests/acceptance/boot_linux_console: Do not use VGA on Clipper machine
>   tests/acceptance/version: Default to -nodefaults
>   tests/acceptance/migration: Add the 'migration' tag
>   tests/acceptance/migration: Default to -nodefaults
>   scripts/checkpatch.pl: Only allow Python 3 interpreter
>   tests/qemu-iotests/check: Allow use of python3 interpreter
>   tests/qemu-iotests: Explicit usage of Python 3 (scripts with __main__)
>   tests: Explicit usage of Python 3
>   scripts: Explicit usage of Python 3 (scripts with __main__)
>   scripts/minikconf: Explicit usage of Python 3
>   scripts/tracetool: Remove shebang header
>   tests/acceptance: Remove shebang header
>   tests/vm: Remove shebang header
>   tests/qemu-iotests: Explicit usage of Python3 (scripts without
>     __main__)
>   scripts: Explicit usage of Python 3 (scripts without __main__)
>   tests/qemu-iotests/check: Only check for Python 3 interpreter
>=20
> Thomas Huth (2):
>   qemu-deprecated: Remove text about Python 2
>   tests/acceptance: Add boot tests for some of the QEMU advent calendar
>     images
>=20
> Wainer dos Santos Moschetta (6):
>   python/qemu: qmp: Replace socket.error with OSError
>   python/qemu: Delint the qmp module
>   python/qemu: qmp: Make accept()'s timeout configurable
>   python/qemu: qmp: Make QEMUMonitorProtocol a context manager
>   python/qemu: qmp: Remove unnused attributes
>   python/qemu: accel: Fix kvm_available() on ppc64le
>=20
>  qemu-deprecated.texi                          |   8 --
>  .readthedocs.yml                              |  20 +++
>  .travis.yml                                   |   3 +-
>  python/qemu/accel.py                          |   3 +-
>  python/qemu/machine.py                        |  10 +-
>  python/qemu/qmp.py                            |  99 ++++++++++----
>  scripts/analyse-9p-simpletrace.py             |   3 +-
>  scripts/analyse-locks-simpletrace.py          |   3 +-
>  scripts/checkpatch.pl                         |   6 +
>  scripts/decodetree.py                         |   2 +-
>  scripts/device-crash-test                     |   3 +-
>  scripts/dump-guest-memory.py                  |   1 -
>  scripts/kvm/kvm_flightrecorder                |   3 +-
>  scripts/kvm/vmxcap                            |   1 -
>  scripts/minikconf.py                          |   2 +-
>  scripts/modules/module_block.py               |   1 -
>  scripts/qapi-gen.py                           |   3 +-
>  scripts/qapi/doc.py                           |   1 -
>  scripts/qmp/qemu-ga-client                    |   3 +-
>  scripts/qmp/qmp                               |   3 +-
>  scripts/qmp/qmp-shell                         |   3 +-
>  scripts/qmp/qom-fuse                          |   2 +-
>  scripts/qmp/qom-get                           |   1 -
>  scripts/qmp/qom-list                          |   1 -
>  scripts/qmp/qom-set                           |   1 -
>  scripts/qmp/qom-tree                          |   1 -
>  scripts/render_block_graph.py                 |   2 +-
>  scripts/replay-dump.py                        |   3 +-
>  scripts/signrom.py                            |  11 +-
>  scripts/simpletrace.py                        |   3 +-
>  scripts/tracetool.py                          |   2 +-
>  scripts/tracetool/__init__.py                 |   1 -
>  scripts/tracetool/backend/__init__.py         |   1 -
>  scripts/tracetool/backend/dtrace.py           |   1 -
>  scripts/tracetool/backend/ftrace.py           |   1 -
>  scripts/tracetool/backend/log.py              |   1 -
>  scripts/tracetool/backend/simple.py           |   1 -
>  scripts/tracetool/backend/syslog.py           |   1 -
>  scripts/tracetool/backend/ust.py              |   1 -
>  scripts/tracetool/format/__init__.py          |   1 -
>  scripts/tracetool/format/c.py                 |   1 -
>  scripts/tracetool/format/d.py                 |   1 -
>  scripts/tracetool/format/h.py                 |   1 -
>  scripts/tracetool/format/log_stap.py          |   1 -
>  scripts/tracetool/format/simpletrace_stap.py  |   1 -
>  scripts/tracetool/format/stap.py              |   1 -
>  scripts/tracetool/format/tcg_h.py             |   1 -
>  scripts/tracetool/format/tcg_helper_c.py      |   1 -
>  scripts/tracetool/format/tcg_helper_h.py      |   1 -
>  .../tracetool/format/tcg_helper_wrapper_h.py  |   1 -
>  scripts/tracetool/format/ust_events_c.py      |   1 -
>  scripts/tracetool/format/ust_events_h.py      |   1 -
>  scripts/tracetool/transform.py                |   1 -
>  scripts/tracetool/vcpu.py                     |   1 -
>  scripts/vmstate-static-checker.py             |   3 +-
>  tests/acceptance/avocado_qemu/__init__.py     |  59 +++++++--
>  tests/acceptance/boot_linux_console.py        | 124 +++++++++++++++++-
>  tests/acceptance/migration.py                 |  57 +++++---
>  tests/acceptance/version.py                   |   1 +
>  ...g_max_adjust.py =3D> virtio_check_params.py} |  16 ++-
>  tests/acceptance/x86_cpu_model_versions.py    |   1 -
>  tests/docker/travis.py                        |   3 +-
>  tests/guest-debug/test-gdbstub.py             |   1 -
>  tests/migration/guestperf/engine.py           |   1 -
>  tests/migration/guestperf/plot.py             |   1 -
>  tests/migration/guestperf/shell.py            |   1 -
>  tests/qapi-schema/test-qapi.py                |   3 +-
>  tests/qemu-iotests/030                        |   2 +-
>  tests/qemu-iotests/040                        |   2 +-
>  tests/qemu-iotests/041                        |   2 +-
>  tests/qemu-iotests/044                        |   2 +-
>  tests/qemu-iotests/045                        |   2 +-
>  tests/qemu-iotests/055                        |   2 +-
>  tests/qemu-iotests/056                        |   2 +-
>  tests/qemu-iotests/057                        |   2 +-
>  tests/qemu-iotests/065                        |   2 +-
>  tests/qemu-iotests/093                        |   2 +-
>  tests/qemu-iotests/096                        |   2 +-
>  tests/qemu-iotests/118                        |   2 +-
>  tests/qemu-iotests/124                        |   2 +-
>  tests/qemu-iotests/129                        |   2 +-
>  tests/qemu-iotests/132                        |   2 +-
>  tests/qemu-iotests/136                        |   2 +-
>  tests/qemu-iotests/139                        |   2 +-
>  tests/qemu-iotests/147                        |   2 +-
>  tests/qemu-iotests/148                        |   2 +-
>  tests/qemu-iotests/149                        |   3 +-
>  tests/qemu-iotests/151                        |   2 +-
>  tests/qemu-iotests/152                        |   2 +-
>  tests/qemu-iotests/155                        |   2 +-
>  tests/qemu-iotests/163                        |   2 +-
>  tests/qemu-iotests/165                        |   3 +-
>  tests/qemu-iotests/169                        |   2 +-
>  tests/qemu-iotests/194                        |   2 +-
>  tests/qemu-iotests/196                        |   2 +-
>  tests/qemu-iotests/199                        |   2 +-
>  tests/qemu-iotests/202                        |   2 +-
>  tests/qemu-iotests/203                        |   2 +-
>  tests/qemu-iotests/205                        |   2 +-
>  tests/qemu-iotests/206                        |   2 +-
>  tests/qemu-iotests/207                        |   2 +-
>  tests/qemu-iotests/208                        |   2 +-
>  tests/qemu-iotests/209                        |   2 +-
>  tests/qemu-iotests/210                        |   2 +-
>  tests/qemu-iotests/211                        |   2 +-
>  tests/qemu-iotests/212                        |   2 +-
>  tests/qemu-iotests/213                        |   2 +-
>  tests/qemu-iotests/216                        |   2 +-
>  tests/qemu-iotests/218                        |   2 +-
>  tests/qemu-iotests/219                        |   2 +-
>  tests/qemu-iotests/222                        |   2 +-
>  tests/qemu-iotests/224                        |   2 +-
>  tests/qemu-iotests/228                        |   2 +-
>  tests/qemu-iotests/234                        |   2 +-
>  tests/qemu-iotests/235                        |   2 +-
>  tests/qemu-iotests/236                        |   2 +-
>  tests/qemu-iotests/237                        |   2 +-
>  tests/qemu-iotests/238                        |   2 +-
>  tests/qemu-iotests/242                        |   2 +-
>  tests/qemu-iotests/245                        |   2 +-
>  tests/qemu-iotests/246                        |   2 +-
>  tests/qemu-iotests/248                        |   2 +-
>  tests/qemu-iotests/254                        |   2 +-
>  tests/qemu-iotests/255                        |   2 +-
>  tests/qemu-iotests/256                        |   2 +-
>  tests/qemu-iotests/257                        |   2 +-
>  tests/qemu-iotests/258                        |   2 +-
>  tests/qemu-iotests/260                        |   2 +-
>  tests/qemu-iotests/262                        |   2 +-
>  tests/qemu-iotests/264                        |   2 +-
>  tests/qemu-iotests/266                        |   2 +-
>  tests/qemu-iotests/277                        |   2 +-
>  tests/qemu-iotests/280                        |   2 +-
>  tests/qemu-iotests/281                        |   2 +-
>  tests/qemu-iotests/check                      |   2 +-
>  tests/qemu-iotests/iotests.py                 |   1 -
>  tests/qemu-iotests/nbd-fault-injector.py      |   3 +-
>  tests/qemu-iotests/qcow2.py                   |   3 +-
>  tests/qemu-iotests/qed.py                     |   3 +-
>  tests/vm/basevm.py                            |   2 -
>  tests/vm/centos                               |   2 +-
>  tests/vm/fedora                               |   2 +-
>  tests/vm/freebsd                              |   2 +-
>  tests/vm/netbsd                               |   2 +-
>  tests/vm/openbsd                              |   2 +-
>  tests/vm/ubuntu.i386                          |   2 +-
>  146 files changed, 431 insertions(+), 233 deletions(-)
>  create mode 100644 .readthedocs.yml
>  mode change 100644 =3D> 100755 scripts/minikconf.py
>  mode change 100644 =3D> 100755 scripts/signrom.py
>  rename tests/acceptance/{virtio_seg_max_adjust.py =3D> virtio_check_para=
ms.py} (90%)
>  mode change 100755 =3D> 100644
>  mode change 100644 =3D> 100755 tests/qemu-iotests/222
>  mode change 100644 =3D> 100755 tests/qemu-iotests/245
>  mode change 100755 =3D> 100644 tests/vm/basevm.py
>=20
> --=20
> 2.21.1
>=20

--=20
Eduardo

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEWjIv1avE09usz9GqKAeTb5hNxaYFAl48jjMACgkQKAeTb5hN
xaZeUg//TYdu3ReaRkPArKBCgCdNW/DRaSFej548Iawhy7zZ07nJfGHOSeRqqHtM
OR8wKiifoiaPz39NHGs2EljYwEAxHGWCRwMVQyXouGjmEiD6mEAuPcW0TK4C9GwE
zY9DhRa5RM8JClt+AkLajx8l9UnGi5cIpaH9ePwibMy4QHETbxYifO2t+1pnUxtC
14VvbXMh+M5IIfVXqs+E3yREGruAc7Ryc2lPQXT4j0NoSwRzQBrXRukBI9vlH2EC
K1xi6t7BJydQR7aFokFyBqpPnZU57g+7f7dxPmvYhoxqpSZTgqbV5+y3tg5qjOAw
AMiS3wGdmO3rtlD9kSBqpnLwS9pFZtpKvwxZXgZRJ4aJHlb1JPG6oAOTIv1NI3+Z
qPyEpD7eRIE9ZSx0V+q9q5bXxoZxrJa02qH91lS0yCNYegtrUnWl05dPco3j4NR0
09Rh19PkyMzb1hPeuZqiG8ECFelGGSzLKdKV12zXCWK4bXWLQ4DlqY/xQDPQtrLe
8iqAO2CSsOf3djdgHGT6eIREbOc4H9+OYAsqAq6JK8epFq1sQUcnybsURAbeHvjc
/SzOZTU0PypQloaZDiT3H6OApyDAKfVBBS9gPyCdPnW3OOKyZvh0nzLRRCBeYQ9M
pRV4z7OwYgha3zJam6OeTjw/u3qtbDUg/bai0b+Qp3sbVz5fbI4=
=nr2H
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


