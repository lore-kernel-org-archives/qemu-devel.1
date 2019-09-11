Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F5C49ED9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EF12171F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 02:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EF12171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7sVK-0002wA-4W
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 22:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1i7sUL-0001n3-PH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1i7sUK-0004nq-Et
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1i7sUK-0004ng-7Y
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 22:36:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96403300DA3A
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:36:07 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-171.rdu2.redhat.com
 [10.10.121.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0FC460852;
 Wed, 11 Sep 2019 02:36:06 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 22:35:58 -0400
Message-Id: <20190911023558.4880-3-crosa@redhat.com>
In-Reply-To: <20190911023558.4880-1-crosa@redhat.com>
References: <20190911023558.4880-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 02:36:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] Python libs: enable machine type auto
 selection
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
Cc: Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The arm and aarch64 targets are noteworthy because they don't have a
default machine type.  This introduces and opt-in option to users of
the qemu.machine.QEMUMachine Python class, in which a default machine
type will be set when a number of conditions are met.

The motivation for this feature is that a number of (acceptance) tests
are target agnostic, and should run with all tarets (in theory while
it's pending continuous test execution).  These tests can be listed
with:

  avocado list --filter-by-tags=3D'-arch' --filter-by-tags-include-empty =
\
               --filter-by-tags-include-empty-key tests/acceptance/

Combined with the "qemu_bin" parameter that acceptance tests take, one
can run those tests with arm and aarch64 targets without adding
specific logic in each test.  To execute those with a aarch64 QEMU
binary one can run:

  avocado run --filter-by-tags=3D'-arch' --filter-by-tags-include-empty \
              --filter-by-tags-include-empty-key \
              -p qemu_bin=3Daarch64-softmmu/qemu-system-aarch64 \
              tests/acceptance/

When this feature is activated, the default automatic selection of
a machine type will be logged (as it will also be done in the QEMU
command line that is already logged).

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/machine.py                    | 81 +++++++++++++++++++++++
 tests/acceptance/avocado_qemu/__init__.py |  1 +
 2 files changed, 82 insertions(+)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 4f533b7881..350052a30b 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -69,6 +69,15 @@ class QEMUMachine(object):
         # vm is guaranteed to be shut down here
     """
=20
+
+    #: The default machine model, used by :meth:`set_machine_auto_select=
ion` and
+    #: :meth:`get_machine_auto_selection`
+    DEFAULT_MACHINE_MODELS =3D {
+        'arm': 'virt',
+        'aarch64': 'virt',
+        }
+
+
     def __init__(self, binary, args=3DNone, wrapper=3DNone, name=3DNone,
                  test_dir=3D"/var/tmp", monitor_address=3DNone,
                  socket_scm_helper=3DNone):
@@ -108,6 +117,7 @@ class QEMUMachine(object):
         self._temp_dir =3D None
         self._launched =3D False
         self._machine =3D None
+        self._machine_auto_selection =3D False
         self._console_set =3D False
         self._console_device_type =3D None
         self._console_address =3D None
@@ -286,6 +296,7 @@ class QEMUMachine(object):
=20
         self._iolog =3D None
         self._qemu_full_args =3D None
+        self._perform_machine_auto_selection()
         try:
             self._launch()
             self._launched =3D True
@@ -533,3 +544,73 @@ class QEMUMachine(object):
                                                  socket.SOCK_STREAM)
             self._console_socket.connect(self._console_address)
         return self._console_socket
+
+    def set_machine_auto_selection(self, value):
+        """
+        Defines whether QEMUMachine will set a machine model when needed
+
+        The machine model will only be set automatically if:
+
+        1) No machine model was explicity set with :meth:`set_machine`
+        2) Target binary is known to not work properly when a machine
+           is not specified (usually producing "No machine specified,
+           and there's no default" on the command line)
+        3) A default machine model exists in :data:`DEFAULT_MACHINE_MODE=
LS`
+        4) :func:`get_target_from_qemu_binary` is capable of returning
+           the target for the binary set on this class
+
+        If machine auto selection is enabled, it will be done so by
+        calling :meth:`set_machine` during the machine launc, that is
+        on :meth:`launch` so that a manually set machine model is not
+        discarded.
+
+        @param value: wether to enable or disable the machine auto selec=
tion
+                      feature
+        @type value: bool
+        """
+        self._machine_auto_selection =3D value
+
+    def get_machine_auto_selection(self):
+        """
+        Returns whether QEMUMachine will set a machine model when needed
+
+        Please refer to :meth:`set_machine_auto_selection` for a more
+        complete explanation.
+        """
+        return self._machine_auto_selection
+
+    def _perform_machine_auto_selection(self):
+        if not (self.get_machine_auto_selection() and self._machine is N=
one):
+            return
+
+        target =3D self._get_target_from_qemu_binary()
+        if target is None:
+            LOG.warn('Machine auto selection was requested, but it was n=
ot '
+                     'applied as the binary "%s" could not be probed for=
 its '
+                     'target architecture', self._binary)
+            return
+
+        machine_model =3D self.DEFAULT_MACHINE_MODELS.get(target, None)
+        if machine_model is None:
+            LOG.warn('Machine auto selection was requested, but it was n=
ot '
+                     'applied as there is no default machine model defin=
ed '
+                     'for target architecture "%s"', target)
+            return
+
+        LOG.debug('Setting machine model to: %s', machine_model)
+        self.set_machine(machine_model)
+
+    def _get_target_from_qemu_binary(self):
+        """
+        Returns the target for this machine's QEMU binary
+        """
+        qemu_machine =3D QEMUMachine(self._binary)
+        qemu_machine.add_args('-S')
+        qemu_machine.set_machine('none')
+        try:
+            qemu_machine.launch()
+            target_resp =3D qemu_machine.command('query-target')
+            qemu_machine.shutdown()
+            return target_resp['arch']
+        except Exception:
+            return None
diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
index bd41e0443c..025bb6a725 100644
--- a/tests/acceptance/avocado_qemu/__init__.py
+++ b/tests/acceptance/avocado_qemu/__init__.py
@@ -70,6 +70,7 @@ class Test(avocado.Test):
=20
     def _new_vm(self, *args):
         vm =3D QEMUMachine(self.qemu_bin)
+        vm.set_machine_auto_selection(True)
         if args:
             vm.add_args(*args)
         return vm
--=20
2.21.0


