Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F9DC55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C1F247F3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGflQDmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C1F247F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXoYm-0001uj-EJ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXoUB-0004zE-2U
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:39:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXoU8-0000oS-9d
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jaNB8nEcHPxPCxVUnAXMNnPoSTNYzG/eGCxLMufzNsw=;
 b=XGflQDmI3ZAAc2fV6pBoRhoWOc9+kcaql5KXqvwgYY8AxaLOiJswHvD01g0q/tf9mqrxvh
 fAxTsTDp90zjvhk1DPFdsoRa+HmD3CykADSMBB0PmfSUCjtEEg/QlnOaQMlIGVO7f+136f
 WYdhmiL70ztxthrP66xv9lUGYka7KQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-sxLN3cXIMjqJYwkfNy-_Ow-1; Wed, 28 Oct 2020 12:39:35 -0400
X-MC-Unique: sxLN3cXIMjqJYwkfNy-_Ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 268E48EBA0E;
 Wed, 28 Oct 2020 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 77B7D5C1D7;
 Wed, 28 Oct 2020 16:39:29 +0000 (UTC)
Date: Wed, 28 Oct 2020 12:39:27 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 01/15] python: create qemu packages
Message-ID: <20201028163927.GD2201333@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-2-jsnow@redhat.com>
 <20201028144616.GB2201333@localhost.localdomain>
 <1a05a456-2739-f539-0072-01ac7074f53b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1a05a456-2739-f539-0072-01ac7074f53b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
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

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 11:21:19AM -0400, John Snow wrote:
> On 10/28/20 10:46 AM, Cleber Rosa wrote:
> > On Tue, Oct 20, 2020 at 03:35:41PM -0400, John Snow wrote:
> > > move python/qemu/*.py to python/qemu/[machine, qmp]/*.py and update i=
mport
> > > directives across the tree.
> > >=20
> > > This is done to create a PEP420 namespace package, in which we may
> > > create subpackages. To do this, the namespace directory ("qemu") shou=
ld
> > > not have any modules in it. Those files will go into new 'machine' an=
d 'qmp'
> > > subpackages instead.
> > >=20
> > > Implement machine/__init__.py making the top-level classes and functi=
ons
> > > from its various modules available directly inside the package. Chang=
e
> > > qmp.py to qmp/__init__.py similarly, such that all of the useful QMP
> > > library classes are available directly from "qemu.qmp" instead of
> > > "qemu.qmp.qmp".
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   python/{qemu =3D> }/.isort.cfg                |  0
> > >   python/qemu/__init__.py                     | 11 ------
> > >   python/qemu/{ =3D> machine}/.flake8           |  0
> > >   python/qemu/machine/__init__.py             | 41 ++++++++++++++++++=
+++
> > >   python/qemu/{ =3D> machine}/accel.py          |  0
> > >   python/qemu/{ =3D> machine}/console_socket.py |  0
> > >   python/qemu/{ =3D> machine}/machine.py        | 16 +++++---
> > >   python/qemu/{ =3D> machine}/pylintrc          |  0
> > >   python/qemu/{ =3D> machine}/qtest.py          |  3 +-
> > >   python/qemu/{qmp.py =3D> qmp/__init__.py}     | 12 +++++-
> > >   tests/acceptance/boot_linux.py              |  3 +-
> > >   tests/qemu-iotests/297                      |  2 +-
> > >   tests/qemu-iotests/300                      |  4 +-
> > >   tests/qemu-iotests/iotests.py               |  2 +-
> > >   tests/vm/basevm.py                          |  3 +-
> > >   15 files changed, 71 insertions(+), 26 deletions(-)
> > >   rename python/{qemu =3D> }/.isort.cfg (100%)
> > >   delete mode 100644 python/qemu/__init__.py
> > >   rename python/qemu/{ =3D> machine}/.flake8 (100%)
> > >   create mode 100644 python/qemu/machine/__init__.py
> > >   rename python/qemu/{ =3D> machine}/accel.py (100%)
> > >   rename python/qemu/{ =3D> machine}/console_socket.py (100%)
> > >   rename python/qemu/{ =3D> machine}/machine.py (98%)
> > >   rename python/qemu/{ =3D> machine}/pylintrc (100%)
> > >   rename python/qemu/{ =3D> machine}/qtest.py (99%)
> > >   rename python/qemu/{qmp.py =3D> qmp/__init__.py} (96%)
> > >=20
> > > diff --git a/python/qemu/.isort.cfg b/python/.isort.cfg
> > > similarity index 100%
> > > rename from python/qemu/.isort.cfg
> > > rename to python/.isort.cfg
> > > diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> > > deleted file mode 100644
> > > index 4ca06c34a4..0000000000
> > > --- a/python/qemu/__init__.py
> > > +++ /dev/null
> > > @@ -1,11 +0,0 @@
> > > -# QEMU library
> > > -#
> > > -# Copyright (C) 2015-2016 Red Hat Inc.
> > > -# Copyright (C) 2012 IBM Corp.
> > > -#
> > > -# Authors:
> > > -#  Fam Zheng <famz@redhat.com>
> > > -#
> > > -# This work is licensed under the terms of the GNU GPL, version 2.  =
See
> > > -# the COPYING file in the top-level directory.
> > > -#
> > > diff --git a/python/qemu/.flake8 b/python/qemu/machine/.flake8
> > > similarity index 100%
> > > rename from python/qemu/.flake8
> > > rename to python/qemu/machine/.flake8
> > > diff --git a/python/qemu/machine/__init__.py b/python/qemu/machine/__=
init__.py
> > > new file mode 100644
> > > index 0000000000..27b0b19abd
> > > --- /dev/null
> > > +++ b/python/qemu/machine/__init__.py
> > > @@ -0,0 +1,41 @@
> > > +"""
> > > +QEMU development and testing library.
> > > +
> > > +This library provides a few high-level classes for driving QEMU from=
 a
> > > +test suite, not intended for production use.
> > > +
> > > +- QEMUMachine: Configure and Boot a QEMU VM
> > > + - QEMUQtestMachine: VM class, with a qtest socket.
> > > +
> > > +- QEMUQtestProtocol: Connect to, send/receive qtest messages.
> > > +
> > > +- list_accel: List available accelerators
> > > +- kvm_available: Probe for KVM support
> > > +- tcg_available: Probe for TCG support
> > > +"""
> > > +
> > > +# Copyright (C) 2020 John Snow for Red Hat Inc.
> > > +# Copyright (C) 2015-2016 Red Hat Inc.
> > > +# Copyright (C) 2012 IBM Corp.
> > > +#
> > > +# Authors:
> > > +#  John Snow <jsnow@redhat.com>
> > > +#  Fam Zheng <fam@euphon.net>
> > > +#
> > > +# This work is licensed under the terms of the GNU GPL, version 2.  =
See
> > > +# the COPYING file in the top-level directory.
> > > +#
> > > +
> > > +from .accel import kvm_available, list_accel, tcg_available
> > > +from .machine import QEMUMachine
> > > +from .qtest import QEMUQtestMachine, QEMUQtestProtocol
> > > +
> > > +
> > > +__all__ =3D (
> > > +    'list_accel',
> > > +    'kvm_available',
> > > +    'tcg_available',
> > > +    'QEMUMachine',
> > > +    'QEMUQtestProtocol',
> > > +    'QEMUQtestMachine',
> > > +)
> >=20
> > How far would this approach go?  I mean, should all future APIs be deve=
loped
> > inside module under "qemu/machine", say "qemu/machine/foo.py" and their=
 main
> > functionality imported here?  Or do you see this as a temporary state?
> >=20
>=20
> I assume any new functionality can be directly imported. Having this here
> doesn't prevent using the fully qualified module names.
>=20
> i.e. you can still do "from qemu.machine.machine import QEMUMachine".
>=20
> Offering root-level aliases seems like a very prevalent paradigm in popul=
ar
> third-party packages like 'requests'. Not justification in and of itself,
> but there's precedent.
>

There's always someone doing something someway... I think the point
here is to try to deliver something that makes the most sense to most
users of the API.  Not an easy task, but it's our task.

> > IMO, this is hard to maintain, and is a very easy path to future
> > inconsistencies.
> >=20
>=20
> Maybe. The alternative is to do what I did to QMP and stick it back insid=
e
> of __init__.
>=20
> What I don't like is:
>=20
> from qemu.machine.machine import QEMUMachine
>=20
> I prefer:
>=20
> from qemu.machine import QEMUMachine
>=20
>=20
> Of course, I also like help(qemu.machine) to show something useful, which=
 is
> going to generally involve updating the docstring to explain what the maj=
or
> APIs here are anyway, so I think actually you cannot escape your fate of
> having to keep a list of APIs updated in a multi-module package.
>=20
> Maybe you could make an argument that keeping both the docstring and the
> __all__ attribute in sync is an undue maintenance burden, but I'd need so=
me
> more convincing.
>=20
> > > diff --git a/python/qemu/accel.py b/python/qemu/machine/accel.py
> > > similarity index 100%
> > > rename from python/qemu/accel.py
> > > rename to python/qemu/machine/accel.py
> > > diff --git a/python/qemu/console_socket.py b/python/qemu/machine/cons=
ole_socket.py
> > > similarity index 100%
> > > rename from python/qemu/console_socket.py
> > > rename to python/qemu/machine/console_socket.py
> > > diff --git a/python/qemu/machine.py b/python/qemu/machine/machine.py
> > > similarity index 98%
> > > rename from python/qemu/machine.py
> > > rename to python/qemu/machine/machine.py
> > > index 6420f01bed..a5dc305539 100644
> > > --- a/python/qemu/machine.py
> > > +++ b/python/qemu/machine/machine.py
> > > @@ -38,8 +38,14 @@
> > >       Type,
> > >   )
> > > -from . import console_socket, qmp
> > > -from .qmp import QMPMessage, QMPReturnValue, SocketAddrT
> > > +from qemu.qmp import (
> > > +    QEMUMonitorProtocol,
> > > +    QMPMessage,
> > > +    QMPReturnValue,
> > > +    SocketAddrT,
> > > +)
> > > +
> > > +from . import console_socket
> > >   LOG =3D logging.getLogger(__name__)
> > > @@ -139,7 +145,7 @@ def __init__(self,
> > >           self._events: List[QMPMessage] =3D []
> > >           self._iolog: Optional[str] =3D None
> > >           self._qmp_set =3D True   # Enable QMP monitor by default.
> > > -        self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] =3D =
None
> > > +        self._qmp_connection: Optional[QEMUMonitorProtocol] =3D None
> > >           self._qemu_full_args: Tuple[str, ...] =3D ()
> > >           self._temp_dir: Optional[str] =3D None
> > >           self._launched =3D False
> > > @@ -314,7 +320,7 @@ def _pre_launch(self) -> None:
> > >               if self._remove_monitor_sockfile:
> > >                   assert isinstance(self._monitor_address, str)
> > >                   self._remove_files.append(self._monitor_address)
> > > -            self._qmp_connection =3D qmp.QEMUMonitorProtocol(
> > > +            self._qmp_connection =3D QEMUMonitorProtocol(
> > >                   self._monitor_address,
> > >                   server=3DTrue,
> > >                   nickname=3Dself._name
> > > @@ -534,7 +540,7 @@ def set_qmp_monitor(self, enabled: bool =3D True)=
 -> None:
> > >           self._qmp_set =3D enabled
> > >       @property
> > > -    def _qmp(self) -> qmp.QEMUMonitorProtocol:
> > > +    def _qmp(self) -> QEMUMonitorProtocol:
> > >           if self._qmp_connection is None:
> > >               raise QEMUMachineError("Attempt to access QMP with no c=
onnection")
> > >           return self._qmp_connection
> > > diff --git a/python/qemu/pylintrc b/python/qemu/machine/pylintrc
> > > similarity index 100%
> > > rename from python/qemu/pylintrc
> > > rename to python/qemu/machine/pylintrc
> > > diff --git a/python/qemu/qtest.py b/python/qemu/machine/qtest.py
> > > similarity index 99%
> > > rename from python/qemu/qtest.py
> > > rename to python/qemu/machine/qtest.py
> > > index 39a0cf62fe..53926e434a 100644
> > > --- a/python/qemu/qtest.py
> > > +++ b/python/qemu/machine/qtest.py
> > > @@ -26,8 +26,9 @@
> > >       TextIO,
> > >   )
> > > +from qemu.qmp import SocketAddrT
> > > +
> > >   from .machine import QEMUMachine
> > > -from .qmp import SocketAddrT
> > >   class QEMUQtestProtocol:
> > > diff --git a/python/qemu/qmp.py b/python/qemu/qmp/__init__.py
> > > similarity index 96%
> > > rename from python/qemu/qmp.py
> > > rename to python/qemu/qmp/__init__.py
> > > index 2cd4d43036..9606248a3d 100644
> > > --- a/python/qemu/qmp.py
> > > +++ b/python/qemu/qmp/__init__.py
> > > @@ -1,4 +1,14 @@
> > > -""" QEMU Monitor Protocol Python class """
> > > +"""
> > > +QEMU Monitor Protocol (QMP) development library & tooling.
> > > +
> > > +This package provides a fairly low-level class for communicating to =
QMP
> > > +protocol servers, as implemented by QEMU, the QEMU Guest Agent, and =
the
> > > +QEMU Storage Daemon. This library is not intended for production use=
.
> > > +
> > > +`QEMUMonitorProtocol` is the primary class of interest, and all erro=
rs
> > > +raised derive from `QMPError`.
> > > +"""
> > > +
> > >   # Copyright (C) 2009, 2010 Red Hat Inc.
> > >   #
> > >   # Authors:
> > > diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_l=
inux.py
> > > index 0055dc7cee..54f999e647 100644
> > > --- a/tests/acceptance/boot_linux.py
> > > +++ b/tests/acceptance/boot_linux.py
> > > @@ -12,8 +12,7 @@
> > >   from avocado_qemu import Test, BUILD_DIR
> > > -from qemu.accel import kvm_available
> > > -from qemu.accel import tcg_available
> > > +from qemu.machine import kvm_available, tcg_available
> > >=20
> >=20
> > I think this reveals a slight downgrade of the API caused by the usage
> > of the symbols from "qemu.machine" namespace.
> >=20
> > My point is that there are valid use cases for using "kvm_available"
> > without using a "QEMUMachine".  This presuposes that "qemu.machine" is
> > named like that because "QEMUMachine" are the main actors of this
> > namespace.
> >=20
>=20
> No, the accel functions literally start a QEMU process and probe its outp=
ut
> to determine what they support. This belongs directly alongside the machi=
ne
> code in my opinion.
>

accel.kvm_available() may not even run QEMU at all... and when it
does, it runs it just like your most mundane command line application,
"grepping" its stdout.

> (I also don't know why'd you call these functions unless you intended to
> create a machine based on what you found.
>

*If* this is an API that you intend others to leverage, you should
reverse the question: "Is there any reason for not making this utility
available and as obvious and as easily available as possible to be
used by people whom I can't actually tell how they'd use it?".

For instance, I may want to write Python code that skips over a number
of tests if I detect that KVM is not available.  This code of mine,
may be completely separate from actual code creating the QEMUMachines,
or may even be compiled C code that I don't want to call because I
know that KVM is not available.

And that's not hypothetical.  I personally have a use case for that.

>=20
> I see your point that it is not a method of the Machine class itself nor =
an
> extension thereof; but I think for the purpose of three small helper
> functions it's not worth creating an entirely new package to contain.
>

Not only that, but it's not even used by QEMUMachine itself.

> Nor is it worth watering down the "machine" name to something less specif=
ic
> to accommodate three tiny helper functions.
>=20
> If I am considering "machine" the "package that knows how to start and
> interact with QEMU", then accel belongs here.
>

That's pretty broad and generic.  Do you mean that "machine" should
know how to interact with, say, "info qtree"?  Would a utility that
outputs and parse that deserve to live under "machine"?

Please understand that these are the awkward, speculative and hard
questions that we have to ask *if* the intention is to make an API
available for general use.

> > Naming is hard, (so don't assume I believe "utils" below is the best
> > or even a good name), but I'd be more confortable using an API along
> > the lines:
> >=20
> >     from qemu.utils.accel import kvm_available
> >     kvm_available()
> >=20
> > OR
> >=20
> >     from qemu.utils import accel
> >     accel.kvm_available()
> >=20
>=20
> utils/tools I am reserving as a package for various debugging scripts and
> tools in the future that I don't intend to upload to PyPI, e.g. many of t=
he
> "thematically loose" scripts in ./scripts.
>

The *actual* name, if already "taken in advance", is not the core issue.

> > This would also remove the need to keep importing symbols into the
> > current "qemu.machine" namespace.
> >=20
>=20
> It would, but it's three functions. It doesn't warrant an entire package =
for
> a single module with three standalone functions.
>=20
> That calculus may change in the future if we accumulate lots more
> miscellaneous thingies to make that more worthwhile!
>=20
> > >   from avocado.utils import cloudinit
> > >   from avocado.utils import network
> > > diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
> > > index 5c5420712b..8236875222 100755
> > > --- a/tests/qemu-iotests/297
> > > +++ b/tests/qemu-iotests/297
> > > @@ -36,7 +36,7 @@ MYPYPATH=3D../../python/ mypy --warn-unused-configs=
 --disallow-subclassing-any \
> > >       --disallow-any-generics --disallow-incomplete-defs \
> > >       --disallow-untyped-decorators --no-implicit-optional \
> > >       --warn-redundant-casts --warn-unused-ignores \
> > > -    --no-implicit-reexport iotests.py
> > > +    --no-implicit-reexport --namespace-packages iotests.py
> > >   # success, all done
> > >   echo "*** done"
> > > diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
> > > index 5b75121b84..a41fac4e1d 100755
> > > --- a/tests/qemu-iotests/300
> > > +++ b/tests/qemu-iotests/300
> > > @@ -23,7 +23,7 @@ import random
> > >   import re
> > >   from typing import Dict, List, Optional, Union
> > >   import iotests
> > > -import qemu
> > > +from qemu.machine import machine
> > >=20
> >=20
> > I believe this gives my previous comment some extra strength.  I think
> > this shows that "qemu.machine" containing "machine" really means that
> > the first "machine" naming component doesn't really mean that.
> >=20
>=20
> Yeah, I don't like the duplication of 'machine' here either. I believe th=
is
> test needs access to specific error classes which I didn't believe were
> important enough to receive an alias.
>=20
> Might be that the correct thing to do is to stick machine.py in
> machine/__init__.py to avoid that duplication, just like I did with qmp.p=
y.
>

I agree this is a better approach wrt *machine.py* itself, from the
API perspective.

In a broad sense (excluding qmp) you're proposing that current usage of:

 "from qemu import myutility"

Becomes:

 "from qemu.machine import myutility"

And "everything" (take it with a grain of salt), will live under
"qemu.machine".  I still think, as you put it, that the future will
show that other modules not connected to "machine", but generally
useful, will need a place to live.

This may be an opportunity to *keep* a place where contributors can
put generally useful bits.  But, if you want to recognize that current
"from qemu import myutility" was an unintended naming side effect, and
that namespace is really about *machine*, and broaden the meaning of
"machine", OK.

Cheers,
- Cleber.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Znr0ACgkQZX6NM6Xy
CfOZRhAAkQ6/Y4nVlN8ZzKKqpZb77oDCpjBWfWwFacasuvyBV0Ihtb1e5FKe+AOA
EIiBOFg0bt+samt4RvmS/VXLe89wAJjy7ITtzZ5j6tR2FoIqTiTADK5OTrJjSf1s
aXTacgaIssL/E/13Liag/FTaO0DcYXt/O76/oBCjTSsZ2rAbWzf5ITlxgdfdNF0C
lgntbO/WEUG11V6C1OkQtEawT9v1IOMSRM17CuZGXDNEu4ToYvuQZ+kcrdPikmBU
rttBUAQkgMMhx1iNADgvOL/P5/eXl51i7DR6Uylg0P1QPN6saUk0S/Sw+ocpzHAG
IRqO4yusKnDzsIgZdWSQJNaaEooJ25vhcT6WUEXxAzmbSKLlSxdlhIoDoA0zNcz+
aJG8adPQw7VjOK+adxF4I92Lg+9SAC/lGDUt1PFCxx6mhglIEGKRgeXpCB/VZ/Eb
acYGKFN8sMpAP6x0Y3RTZi2JcUOuslnAHBiu7C1bE9+KJam2gQdKtzrR/buQ9QHo
HlY/AjSGRpcwh4D5PuOWdvQS5rCD360nLsRxMvgOONueHGzECt5re1qqh/9DMA1q
30ack3a4RyapwGnnReTYnKJ2DcZAUCblDZhLRysJPL1wm0xwSq3AojcFgkY0ZOxf
V/Fl5ZFCfZ9xiLG/13HpB42/I5qsvPCkVbUErVhiwgGxH1sTcSE=
=rC5a
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


