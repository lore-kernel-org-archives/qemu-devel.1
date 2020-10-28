Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293EDC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:48:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1EF247A4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/UkiiNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1EF247A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmkq-0007x0-GJ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXmif-0006Td-0o
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:46:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXmic-00024s-DN
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 10:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603896389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxdHhj2f8JDB/kxfZIik1TF40XP762Bfes/A3qOJc28=;
 b=g/UkiiNcUOtyeAb6vHOqFMPmIrSlJa5nF3c4HAcGq9GwRU0xsJ9qo7keg5yAQKI+m42Jfx
 l1vBjIOpyhjU+lSj5LCTKBkWxcEVJbMiqFcx2GtiG6K6ftHyB6W3lNXtKYyKCt4y/o/Uqw
 w1LsJdZ4T/EhIVNrZc/E4eJinTYtoXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-tgRINEISPLGkxD-yYEHEbg-1; Wed, 28 Oct 2020 10:46:24 -0400
X-MC-Unique: tgRINEISPLGkxD-yYEHEbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171D580365F;
 Wed, 28 Oct 2020 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 333735C1D7;
 Wed, 28 Oct 2020 14:46:18 +0000 (UTC)
Date: Wed, 28 Oct 2020 10:46:16 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 01/15] python: create qemu packages
Message-ID: <20201028144616.GB2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-2-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-2-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 03:35:41PM -0400, John Snow wrote:
> move python/qemu/*.py to python/qemu/[machine, qmp]/*.py and update impor=
t
> directives across the tree.
>=20
> This is done to create a PEP420 namespace package, in which we may
> create subpackages. To do this, the namespace directory ("qemu") should
> not have any modules in it. Those files will go into new 'machine' and 'q=
mp'
> subpackages instead.
>=20
> Implement machine/__init__.py making the top-level classes and functions
> from its various modules available directly inside the package. Change
> qmp.py to qmp/__init__.py similarly, such that all of the useful QMP
> library classes are available directly from "qemu.qmp" instead of
> "qemu.qmp.qmp".
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/{qemu =3D> }/.isort.cfg                |  0
>  python/qemu/__init__.py                     | 11 ------
>  python/qemu/{ =3D> machine}/.flake8           |  0
>  python/qemu/machine/__init__.py             | 41 +++++++++++++++++++++
>  python/qemu/{ =3D> machine}/accel.py          |  0
>  python/qemu/{ =3D> machine}/console_socket.py |  0
>  python/qemu/{ =3D> machine}/machine.py        | 16 +++++---
>  python/qemu/{ =3D> machine}/pylintrc          |  0
>  python/qemu/{ =3D> machine}/qtest.py          |  3 +-
>  python/qemu/{qmp.py =3D> qmp/__init__.py}     | 12 +++++-
>  tests/acceptance/boot_linux.py              |  3 +-
>  tests/qemu-iotests/297                      |  2 +-
>  tests/qemu-iotests/300                      |  4 +-
>  tests/qemu-iotests/iotests.py               |  2 +-
>  tests/vm/basevm.py                          |  3 +-
>  15 files changed, 71 insertions(+), 26 deletions(-)
>  rename python/{qemu =3D> }/.isort.cfg (100%)
>  delete mode 100644 python/qemu/__init__.py
>  rename python/qemu/{ =3D> machine}/.flake8 (100%)
>  create mode 100644 python/qemu/machine/__init__.py
>  rename python/qemu/{ =3D> machine}/accel.py (100%)
>  rename python/qemu/{ =3D> machine}/console_socket.py (100%)
>  rename python/qemu/{ =3D> machine}/machine.py (98%)
>  rename python/qemu/{ =3D> machine}/pylintrc (100%)
>  rename python/qemu/{ =3D> machine}/qtest.py (99%)
>  rename python/qemu/{qmp.py =3D> qmp/__init__.py} (96%)
>=20
> diff --git a/python/qemu/.isort.cfg b/python/.isort.cfg
> similarity index 100%
> rename from python/qemu/.isort.cfg
> rename to python/.isort.cfg
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> deleted file mode 100644
> index 4ca06c34a4..0000000000
> --- a/python/qemu/__init__.py
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -# QEMU library
> -#
> -# Copyright (C) 2015-2016 Red Hat Inc.
> -# Copyright (C) 2012 IBM Corp.
> -#
> -# Authors:
> -#  Fam Zheng <famz@redhat.com>
> -#
> -# This work is licensed under the terms of the GNU GPL, version 2.  See
> -# the COPYING file in the top-level directory.
> -#
> diff --git a/python/qemu/.flake8 b/python/qemu/machine/.flake8
> similarity index 100%
> rename from python/qemu/.flake8
> rename to python/qemu/machine/.flake8
> diff --git a/python/qemu/machine/__init__.py b/python/qemu/machine/__init=
__.py
> new file mode 100644
> index 0000000000..27b0b19abd
> --- /dev/null
> +++ b/python/qemu/machine/__init__.py
> @@ -0,0 +1,41 @@
> +"""
> +QEMU development and testing library.
> +
> +This library provides a few high-level classes for driving QEMU from a
> +test suite, not intended for production use.
> +
> +- QEMUMachine: Configure and Boot a QEMU VM
> + - QEMUQtestMachine: VM class, with a qtest socket.
> +
> +- QEMUQtestProtocol: Connect to, send/receive qtest messages.
> +
> +- list_accel: List available accelerators
> +- kvm_available: Probe for KVM support
> +- tcg_available: Probe for TCG support
> +"""
> +
> +# Copyright (C) 2020 John Snow for Red Hat Inc.
> +# Copyright (C) 2015-2016 Red Hat Inc.
> +# Copyright (C) 2012 IBM Corp.
> +#
> +# Authors:
> +#  John Snow <jsnow@redhat.com>
> +#  Fam Zheng <fam@euphon.net>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +from .accel import kvm_available, list_accel, tcg_available
> +from .machine import QEMUMachine
> +from .qtest import QEMUQtestMachine, QEMUQtestProtocol
> +
> +
> +__all__ =3D (
> +    'list_accel',
> +    'kvm_available',
> +    'tcg_available',
> +    'QEMUMachine',
> +    'QEMUQtestProtocol',
> +    'QEMUQtestMachine',
> +)

How far would this approach go?  I mean, should all future APIs be develope=
d
inside module under "qemu/machine", say "qemu/machine/foo.py" and their mai=
n
functionality imported here?  Or do you see this as a temporary state?

IMO, this is hard to maintain, and is a very easy path to future
inconsistencies.

> diff --git a/python/qemu/accel.py b/python/qemu/machine/accel.py
> similarity index 100%
> rename from python/qemu/accel.py
> rename to python/qemu/machine/accel.py
> diff --git a/python/qemu/console_socket.py b/python/qemu/machine/console_=
socket.py
> similarity index 100%
> rename from python/qemu/console_socket.py
> rename to python/qemu/machine/console_socket.py
> diff --git a/python/qemu/machine.py b/python/qemu/machine/machine.py
> similarity index 98%
> rename from python/qemu/machine.py
> rename to python/qemu/machine/machine.py
> index 6420f01bed..a5dc305539 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -38,8 +38,14 @@
>      Type,
>  )
> =20
> -from . import console_socket, qmp
> -from .qmp import QMPMessage, QMPReturnValue, SocketAddrT
> +from qemu.qmp import (
> +    QEMUMonitorProtocol,
> +    QMPMessage,
> +    QMPReturnValue,
> +    SocketAddrT,
> +)
> +
> +from . import console_socket
> =20
> =20
>  LOG =3D logging.getLogger(__name__)
> @@ -139,7 +145,7 @@ def __init__(self,
>          self._events: List[QMPMessage] =3D []
>          self._iolog: Optional[str] =3D None
>          self._qmp_set =3D True   # Enable QMP monitor by default.
> -        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] =3D None
> +        self._qmp_connection: Optional[QEMUMonitorProtocol] =3D None
>          self._qemu_full_args: Tuple[str, ...] =3D ()
>          self._temp_dir: Optional[str] =3D None
>          self._launched =3D False
> @@ -314,7 +320,7 @@ def _pre_launch(self) -> None:
>              if self._remove_monitor_sockfile:
>                  assert isinstance(self._monitor_address, str)
>                  self._remove_files.append(self._monitor_address)
> -            self._qmp_connection =3D qmp.QEMUMonitorProtocol(
> +            self._qmp_connection =3D QEMUMonitorProtocol(
>                  self._monitor_address,
>                  server=3DTrue,
>                  nickname=3Dself._name
> @@ -534,7 +540,7 @@ def set_qmp_monitor(self, enabled: bool =3D True) -> =
None:
>          self._qmp_set =3D enabled
> =20
>      @property
> -    def _qmp(self) -> qmp.QEMUMonitorProtocol:
> +    def _qmp(self) -> QEMUMonitorProtocol:
>          if self._qmp_connection is None:
>              raise QEMUMachineError("Attempt to access QMP with no connec=
tion")
>          return self._qmp_connection
> diff --git a/python/qemu/pylintrc b/python/qemu/machine/pylintrc
> similarity index 100%
> rename from python/qemu/pylintrc
> rename to python/qemu/machine/pylintrc
> diff --git a/python/qemu/qtest.py b/python/qemu/machine/qtest.py
> similarity index 99%
> rename from python/qemu/qtest.py
> rename to python/qemu/machine/qtest.py
> index 39a0cf62fe..53926e434a 100644
> --- a/python/qemu/qtest.py
> +++ b/python/qemu/machine/qtest.py
> @@ -26,8 +26,9 @@
>      TextIO,
>  )
> =20
> +from qemu.qmp import SocketAddrT
> +
>  from .machine import QEMUMachine
> -from .qmp import SocketAddrT
> =20
> =20
>  class QEMUQtestProtocol:
> diff --git a/python/qemu/qmp.py b/python/qemu/qmp/__init__.py
> similarity index 96%
> rename from python/qemu/qmp.py
> rename to python/qemu/qmp/__init__.py
> index 2cd4d43036..9606248a3d 100644
> --- a/python/qemu/qmp.py
> +++ b/python/qemu/qmp/__init__.py
> @@ -1,4 +1,14 @@
> -""" QEMU Monitor Protocol Python class """
> +"""
> +QEMU Monitor Protocol (QMP) development library & tooling.
> +
> +This package provides a fairly low-level class for communicating to QMP
> +protocol servers, as implemented by QEMU, the QEMU Guest Agent, and the
> +QEMU Storage Daemon. This library is not intended for production use.
> +
> +`QEMUMonitorProtocol` is the primary class of interest, and all errors
> +raised derive from `QMPError`.
> +"""
> +
>  # Copyright (C) 2009, 2010 Red Hat Inc.
>  #
>  # Authors:
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
> index 0055dc7cee..54f999e647 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -12,8 +12,7 @@
> =20
>  from avocado_qemu import Test, BUILD_DIR
> =20
> -from qemu.accel import kvm_available
> -from qemu.accel import tcg_available
> +from qemu.machine import kvm_available, tcg_available
>

I think this reveals a slight downgrade of the API caused by the usage
of the symbols from "qemu.machine" namespace.

My point is that there are valid use cases for using "kvm_available"
without using a "QEMUMachine".  This presuposes that "qemu.machine" is
named like that because "QEMUMachine" are the main actors of this
namespace.

Naming is hard, (so don't assume I believe "utils" below is the best
or even a good name), but I'd be more confortable using an API along
the lines:

   from qemu.utils.accel import kvm_available
   kvm_available()

OR

   from qemu.utils import accel
   accel.kvm_available()

This would also remove the need to keep importing symbols into the
current "qemu.machine" namespace.

>  from avocado.utils import cloudinit
>  from avocado.utils import network
> diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
> index 5c5420712b..8236875222 100755
> --- a/tests/qemu-iotests/297
> +++ b/tests/qemu-iotests/297
> @@ -36,7 +36,7 @@ MYPYPATH=3D../../python/ mypy --warn-unused-configs --d=
isallow-subclassing-any \
>      --disallow-any-generics --disallow-incomplete-defs \
>      --disallow-untyped-decorators --no-implicit-optional \
>      --warn-redundant-casts --warn-unused-ignores \
> -    --no-implicit-reexport iotests.py
> +    --no-implicit-reexport --namespace-packages iotests.py
> =20
>  # success, all done
>  echo "*** done"
> diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
> index 5b75121b84..a41fac4e1d 100755
> --- a/tests/qemu-iotests/300
> +++ b/tests/qemu-iotests/300
> @@ -23,7 +23,7 @@ import random
>  import re
>  from typing import Dict, List, Optional, Union
>  import iotests
> -import qemu
> +from qemu.machine import machine
>

I believe this gives my previous comment some extra strength.  I think
this shows that "qemu.machine" containing "machine" really means that
the first "machine" naming component doesn't really mean that.

"qemu.utils" is not perfect, but it's much more honest IMO.

Cheers,
- Cleber.

>  BlockBitmapMapping =3D List[Dict[str, Union[str, List[Dict[str, str]]]]]
> =20
> @@ -454,7 +454,7 @@ class TestBlockBitmapMappingErrors(TestDirtyBitmapMig=
ration):
>          # the failed migration
>          try:
>              self.vm_b.shutdown()
> -        except qemu.machine.AbnormalShutdown:
> +        except machine.AbnormalShutdown:
>              pass
> =20
>      def test_aliased_bitmap_name_too_long(self) -> None:
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 63d2ace93c..6574afd735 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -37,7 +37,7 @@
> =20
>  # pylint: disable=3Dimport-error, wrong-import-position
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
> -from qemu import qtest
> +from qemu.machine import qtest
>  from qemu.qmp import QMPMessage
> =20
>  # Use this logger for logging messages directly from the iotests module
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 3fac20e929..b38969f61f 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -19,8 +19,7 @@
>  import time
>  import datetime
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
> -from qemu.accel import kvm_available
> -from qemu.machine import QEMUMachine
> +from qemu.machine import kvm_available, QEMUMachine
>  import subprocess
>  import hashlib
>  import argparse
> --=20
> 2.26.2
>=20

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+ZhDYACgkQZX6NM6Xy
CfMNgQ//YKZE3otRQEevMwwKBGKZTisG6OVD3yaA51+cuCpVvvGxlxl/Ho6+44m1
KrF0QBojyy4u0O8trjPDcC8UL64LptY7uMh0k6gFVSMwUQHg+HbblJ7YUBUMXx5P
OhDaDuDBhDTkPky3Kd5OlTDC+KyMmDRTkWqYr2AwCzGpWHGyAttMOWgBPgGl97o/
UQi8Hp2yd2bf1YCSRQcXRL/pQe3lvhZQ3QQaUai8c93Vyg61pTXsPQMNUq8Fmcpu
OQyknr/0h07IrhdS8pgyXrc3C2ygk7xIHsPVO2nz8oj4N55OTKfWjEJzUKubi9bg
5wh2SUZZqgbErIMcZH7FM7Iw49q/yea2j2u5qYDfgBDHvNiAx2dBK0wrlCSAyMTD
QjtsxEyMfDtcNMa8aCfoi5JnbVF5yP9C/J0X0Scx4mBhofgajLf/yvoUZgmwamvB
ZBUvE8oF/BHDlE6khJxoRMR1IiCuVy8aTNae7OnLyd4o+1n8ll5cBsTWU2WJ7AwO
034xpP/UZ8VPex09FhhNCmXARM47nr3U6eyDRVDDTyR/I4uYdQU8/ZDX1UgHiWNt
M4XB6DgVw9IjCLQ9PzII1strnXNVqxaFR2BpibhKRY682/7Gm+EMFhguoLkzT8a9
ersy9wMLuepsgYpRc3dz0JsyR2Ack1YOa+1aa8J5lz06YtlbzBg=
=SZYO
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--


