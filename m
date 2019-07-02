Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5F3C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FCF2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 10:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FCF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGPI-0002Rg-FJ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 06:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51023)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJw-0005pq-KU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJq-0007of-E8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJo-0007gm-3n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A55D0C0568FB;
 Tue,  2 Jul 2019 10:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDAF71001B0E;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E2FBF11328AA; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:11 +0200
Message-Id: <20190702104716.9140-14-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 02 Jul 2019 10:47:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 13/18] qapi: Split machine-target.json off
 target.json and misc.json
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move commands query-cpu-definitions, query-cpu-model-baseline,
query-cpu-model-comparison, and query-cpu-model-expansion with their
types from target.json to machine-target.json.  Also move types
CpuModelInfo, CpuModelExpansionType, and CpuModelCompareResult from
misc.json there.  Add machine-target.json to MAINTAINERS section
"Machine core".

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-13-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[Commit message typo fixed]
---
 MAINTAINERS                     |   1 +
 qapi/Makefile.objs              |   2 +-
 qapi/machine-target.json        | 318 ++++++++++++++++++++++++++++++++
 qapi/misc.json                  |  74 --------
 qapi/qapi-schema.json           |   1 +
 qapi/target.json                | 242 ------------------------
 target/arm/helper.c             |   2 +-
 target/i386/cpu.c               |   2 +-
 target/mips/helper.c            |   2 +-
 target/ppc/translate_init.inc.c |   2 +-
 target/s390x/cpu_models.c       |   2 +-
 11 files changed, 326 insertions(+), 322 deletions(-)
 create mode 100644 qapi/machine-target.json

diff --git a/MAINTAINERS b/MAINTAINERS
index bf6742d59f..2eb851cbdd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1270,6 +1270,7 @@ F: hw/core/null-machine.c
 F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
+F: qapi/machine-target.json
 F: qom/cpu.c
 F: include/hw/boards.h
 F: include/hw/cpu/cluster.h
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 01dced01aa..4e87bef6e1 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -9,7 +9,7 @@ QAPI_COMMON_MODULES =3D audio authz block-core block char=
 common crypto
 QAPI_COMMON_MODULES +=3D introspect job machine migration misc net
 QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
-QAPI_TARGET_MODULES =3D target
+QAPI_TARGET_MODULES =3D machine-target target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
 util-obj-y +=3D qapi-builtin-types.o
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
new file mode 100644
index 0000000000..5d7480f6ab
--- /dev/null
+++ b/qapi/machine-target.json
@@ -0,0 +1,318 @@
+# -*- Mode: Python -*-
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# @CpuModelInfo:
+#
+# Virtual CPU model.
+#
+# A CPU model consists of the name of a CPU definition, to which
+# delta changes are applied (e.g. features added/removed). Most magic va=
lues
+# that an architecture might require should be hidden behind the name.
+# However, if required, architectures can expose relevant properties.
+#
+# @name: the name of the CPU definition the model is based on
+# @props: a dictionary of QOM properties to be applied
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelInfo',
+  'data': { 'name': 'str',
+            '*props': 'any' } }
+
+##
+# @CpuModelExpansionType:
+#
+# An enumeration of CPU model expansion types.
+#
+# @static: Expand to a static CPU model, a combination of a static base
+#          model name and property delta changes. As the static base mod=
el will
+#          never change, the expanded CPU model will be the same, indepe=
ndent of
+#          QEMU version, machine type, machine options, and accelerator =
options.
+#          Therefore, the resulting model can be used by tooling without=
 having
+#          to specify a compatibility machine - e.g. when displaying the=
 "host"
+#          model. The @static CPU models are migration-safe.
+
+# @full: Expand all properties. The produced model is not guaranteed to =
be
+#        migration-safe, but allows tooling to get an insight and work w=
ith
+#        model details.
+#
+# Note: When a non-migration-safe CPU model is expanded in static mode, =
some
+# features enabled by the CPU model may be omitted, because they can't b=
e
+# implemented by a static CPU model definition (e.g. cache info passthro=
ugh and
+# PMU passthrough in x86). If you need an accurate representation of the
+# features enabled by a non-migration-safe CPU model, use @full. If you =
need a
+# static representation that will keep ABI compatibility even when chang=
ing QEMU
+# version or machine-type, use @static (but keep in mind that some featu=
res may
+# be omitted).
+#
+# Since: 2.8.0
+##
+{ 'enum': 'CpuModelExpansionType',
+  'data': [ 'static', 'full' ] }
+
+
+##
+# @CpuModelCompareResult:
+#
+# An enumeration of CPU model comparison results. The result is usually
+# calculated using e.g. CPU features or CPU generations.
+#
+# @incompatible: If model A is incompatible to model B, model A is not
+#                guaranteed to run where model B runs and the other way =
around.
+#
+# @identical: If model A is identical to model B, model A is guaranteed =
to run
+#             where model B runs and the other way around.
+#
+# @superset: If model A is a superset of model B, model B is guaranteed =
to run
+#            where model A runs. There are no guarantees about the other=
 way.
+#
+# @subset: If model A is a subset of model B, model A is guaranteed to r=
un
+#          where model B runs. There are no guarantees about the other w=
ay.
+#
+# Since: 2.8.0
+##
+{ 'enum': 'CpuModelCompareResult',
+  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
+
+##
+# @CpuModelBaselineInfo:
+#
+# The result of a CPU model baseline.
+#
+# @model: the baselined CpuModelInfo.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelBaselineInfo',
+  'data': { 'model': 'CpuModelInfo' },
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @CpuModelCompareInfo:
+#
+# The result of a CPU model comparison.
+#
+# @result: The result of the compare operation.
+# @responsible-properties: List of properties that led to the comparison=
 result
+#                          not being identical.
+#
+# @responsible-properties is a list of QOM property names that led to
+# both CPUs not being detected as identical. For identical models, this
+# list is empty.
+# If a QOM property is read-only, that means there's no known way to mak=
e the
+# CPU models identical. If the special property name "type" is included,=
 the
+# models are by definition not identical and cannot be made identical.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelCompareInfo',
+  'data': { 'result': 'CpuModelCompareResult',
+            'responsible-properties': ['str'] },
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @query-cpu-model-comparison:
+#
+# Compares two CPU models, returning how they compare in a specific
+# configuration. The results indicates how both models compare regarding
+# runnability. This result can be used by tooling to make decisions if a
+# certain CPU model will run in a certain configuration or if a compatib=
le
+# CPU model has to be created by baselining.
+#
+# Usually, a CPU model is compared against the maximum possible CPU mode=
l
+# of a certain configuration (e.g. the "host" model for KVM). If that CP=
U
+# model is identical or a subset, it will run in that configuration.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model may look different depending on the machine-=
type.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine options (including accelerator): in some architectures, CPU =
models
+#   may look different depending on machine and accelerator options. (Ex=
cept for
+#   CPU models reported as "static" in query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
+#   global properties may affect expansion of CPU models. Using
+#   query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support comparing CPU models. s390x support=
s
+# comparing CPU models.
+#
+# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mod=
els is
+#          not supported, if a model cannot be used, if a model contains
+#          an unknown cpu definition name, unknown properties or propert=
ies
+#          with wrong types.
+#
+# Note: this command isn't specific to s390x, but is only implemented
+# on this architecture currently.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-comparison',
+  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelCompareInfo',
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @query-cpu-model-baseline:
+#
+# Baseline two CPU models, creating a compatible third model. The create=
d
+# model will always be a static, migration-safe CPU model (see "static"
+# CPU model expansion for details).
+#
+# This interface can be used by tooling to create a compatible CPU model=
 out
+# two CPU models. The created CPU model will be identical to or a subset=
 of
+# both CPU models when comparing them. Therefore, the created CPU model =
is
+# guaranteed to run where the given CPU models run.
+#
+# The result returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model may look different depending on the machine-=
type.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine options (including accelerator): in some architectures, CPU =
models
+#   may look different depending on machine and accelerator options. (Ex=
cept for
+#   CPU models reported as "static" in query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
+#   global properties may affect expansion of CPU models. Using
+#   query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support baselining CPU models. s390x suppor=
ts
+# baselining CPU models.
+#
+# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU mo=
dels is
+#          not supported, if a model cannot be used, if a model contains
+#          an unknown cpu definition name, unknown properties or propert=
ies
+#          with wrong types.
+#
+# Note: this command isn't specific to s390x, but is only implemented
+# on this architecture currently.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-baseline',
+  'data': { 'modela': 'CpuModelInfo',
+            'modelb': 'CpuModelInfo' },
+  'returns': 'CpuModelBaselineInfo',
+  'if': 'defined(TARGET_S390X)' }
+
+##
+# @CpuModelExpansionInfo:
+#
+# The result of a cpu model expansion.
+#
+# @model: the expanded CpuModelInfo.
+#
+# Since: 2.8.0
+##
+{ 'struct': 'CpuModelExpansionInfo',
+  'data': { 'model': 'CpuModelInfo' },
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
+
+##
+# @query-cpu-model-expansion:
+#
+# Expands a given CPU model (or a combination of CPU model + additional =
options)
+# to different granularities, allowing tooling to get an understanding w=
hat a
+# specific CPU model looks like in QEMU under a certain configuration.
+#
+# This interface can be used to query the "host" CPU model.
+#
+# The data returned by this command may be affected by:
+#
+# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine-type: CPU model  may look different depending on the machine=
-type.
+#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
+# * machine options (including accelerator): in some architectures, CPU =
models
+#   may look different depending on machine and accelerator options. (Ex=
cept for
+#   CPU models reported as "static" in query-cpu-definitions.)
+# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
+#   global properties may affect expansion of CPU models. Using
+#   query-cpu-model-expansion while using these is not advised.
+#
+# Some architectures may not support all expansion types. s390x supports
+# "full" and "static".
+#
+# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU mo=
dels is
+#          not supported, if the model cannot be expanded, if the model =
contains
+#          an unknown CPU definition name, unknown properties or propert=
ies
+#          with a wrong type. Also returns an error if an expansion type=
 is
+#          not supported.
+#
+# Since: 2.8.0
+##
+{ 'command': 'query-cpu-model-expansion',
+  'data': { 'type': 'CpuModelExpansionType',
+            'model': 'CpuModelInfo' },
+  'returns': 'CpuModelExpansionInfo',
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
+
+##
+# @CpuDefinitionInfo:
+#
+# Virtual CPU definition.
+#
+# @name: the name of the CPU definition
+#
+# @migration-safe: whether a CPU definition can be safely used for
+#                  migration in combination with a QEMU compatibility ma=
chine
+#                  when migrating between different QEMU versions and be=
tween
+#                  hosts with different sets of (hardware or software)
+#                  capabilities. If not provided, information is not ava=
ilable
+#                  and callers should not assume the CPU definition to b=
e
+#                  migration-safe. (since 2.8)
+#
+# @static: whether a CPU definition is static and will not change depend=
ing on
+#          QEMU version, machine type, machine options and accelerator o=
ptions.
+#          A static model is always migration-safe. (since 2.8)
+#
+# @unavailable-features: List of properties that prevent
+#                        the CPU model from running in the current
+#                        host. (since 2.8)
+# @typename: Type name that can be used as argument to @device-list-prop=
erties,
+#            to introspect properties configurable using -cpu or -global=
.
+#            (since 2.9)
+#
+# @unavailable-features is a list of QOM property names that
+# represent CPU model attributes that prevent the CPU from running.
+# If the QOM property is read-only, that means there's no known
+# way to make the CPU model run in the current host. Implementations
+# that choose not to provide specific information return the
+# property name "type".
+# If the property is read-write, it means that it MAY be possible
+# to run the CPU model in the current host if that property is
+# changed. Management software can use it as hints to suggest or
+# choose an alternative for the user, or just to generate meaningful
+# error messages explaining why the CPU model can't be used.
+# If @unavailable-features is an empty list, the CPU model is
+# runnable using the current host and machine-type.
+# If @unavailable-features is not present, runnability
+# information for the CPU is not available.
+#
+# Since: 1.2.0
+##
+{ 'struct': 'CpuDefinitionInfo',
+  'data': { 'name': 'str',
+            '*migration-safe': 'bool',
+            'static': 'bool',
+            '*unavailable-features': [ 'str' ],
+            'typename': 'str' },
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
+
+##
+# @query-cpu-definitions:
+#
+# Return a list of supported virtual CPU definitions
+#
+# Returns: a list of CpuDefInfo
+#
+# Since: 1.2.0
+##
+{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
+  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
diff --git a/qapi/misc.json b/qapi/misc.json
index b4f8c658b7..d7db863c81 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1387,80 +1387,6 @@
 { 'command': 'query-memory-size-summary', 'returns': 'MemoryInfo' }
=20
=20
-##
-# @CpuModelInfo:
-#
-# Virtual CPU model.
-#
-# A CPU model consists of the name of a CPU definition, to which
-# delta changes are applied (e.g. features added/removed). Most magic va=
lues
-# that an architecture might require should be hidden behind the name.
-# However, if required, architectures can expose relevant properties.
-#
-# @name: the name of the CPU definition the model is based on
-# @props: a dictionary of QOM properties to be applied
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelInfo',
-  'data': { 'name': 'str',
-            '*props': 'any' } }
-
-##
-# @CpuModelExpansionType:
-#
-# An enumeration of CPU model expansion types.
-#
-# @static: Expand to a static CPU model, a combination of a static base
-#          model name and property delta changes. As the static base mod=
el will
-#          never change, the expanded CPU model will be the same, indepe=
ndent of
-#          QEMU version, machine type, machine options, and accelerator =
options.
-#          Therefore, the resulting model can be used by tooling without=
 having
-#          to specify a compatibility machine - e.g. when displaying the=
 "host"
-#          model. The @static CPU models are migration-safe.
-
-# @full: Expand all properties. The produced model is not guaranteed to =
be
-#        migration-safe, but allows tooling to get an insight and work w=
ith
-#        model details.
-#
-# Note: When a non-migration-safe CPU model is expanded in static mode, =
some
-# features enabled by the CPU model may be omitted, because they can't b=
e
-# implemented by a static CPU model definition (e.g. cache info passthro=
ugh and
-# PMU passthrough in x86). If you need an accurate representation of the
-# features enabled by a non-migration-safe CPU model, use @full. If you =
need a
-# static representation that will keep ABI compatibility even when chang=
ing QEMU
-# version or machine-type, use @static (but keep in mind that some featu=
res may
-# be omitted).
-#
-# Since: 2.8.0
-##
-{ 'enum': 'CpuModelExpansionType',
-  'data': [ 'static', 'full' ] }
-
-
-##
-# @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results. The result is usually
-# calculated using e.g. CPU features or CPU generations.
-#
-# @incompatible: If model A is incompatible to model B, model A is not
-#                guaranteed to run where model B runs and the other way =
around.
-#
-# @identical: If model A is identical to model B, model A is guaranteed =
to run
-#             where model B runs and the other way around.
-#
-# @superset: If model A is a superset of model B, model B is guaranteed =
to run
-#            where model A runs. There are no guarantees about the other=
 way.
-#
-# @subset: If model A is a subset of model B, model A is guaranteed to r=
un
-#          where model B runs. There are no guarantees about the other w=
ay.
-#
-# Since: 2.8.0
-##
-{ 'enum': 'CpuModelCompareResult',
-  'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
-
 ##
 # @AddfdInfo:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 31611191db..8dc82fde31 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -100,6 +100,7 @@
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
 { 'include': 'machine.json' }
+{ 'include': 'machine-target.json' }
 { 'include': 'misc.json' }
 { 'include': 'target.json' }
 { 'include': 'audio.json' }
diff --git a/qapi/target.json b/qapi/target.json
index 1d4d54b600..e0a73581d8 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -5,8 +5,6 @@
 # =3D Target-specific commands & events
 ##
=20
-{ 'include': 'misc.json' }
-
 ##
 # @RTC_CHANGE:
 #
@@ -228,130 +226,6 @@
   'data': { 'filename': 'str' },
   'if': 'defined(TARGET_S390X)' }
=20
-##
-# @CpuModelBaselineInfo:
-#
-# The result of a CPU model baseline.
-#
-# @model: the baselined CpuModelInfo.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelBaselineInfo',
-  'data': { 'model': 'CpuModelInfo' },
-  'if': 'defined(TARGET_S390X)' }
-
-##
-# @CpuModelCompareInfo:
-#
-# The result of a CPU model comparison.
-#
-# @result: The result of the compare operation.
-# @responsible-properties: List of properties that led to the comparison=
 result
-#                          not being identical.
-#
-# @responsible-properties is a list of QOM property names that led to
-# both CPUs not being detected as identical. For identical models, this
-# list is empty.
-# If a QOM property is read-only, that means there's no known way to mak=
e the
-# CPU models identical. If the special property name "type" is included,=
 the
-# models are by definition not identical and cannot be made identical.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelCompareInfo',
-  'data': { 'result': 'CpuModelCompareResult',
-            'responsible-properties': ['str'] },
-  'if': 'defined(TARGET_S390X)' }
-
-##
-# @query-cpu-model-comparison:
-#
-# Compares two CPU models, returning how they compare in a specific
-# configuration. The results indicates how both models compare regarding
-# runnability. This result can be used by tooling to make decisions if a
-# certain CPU model will run in a certain configuration or if a compatib=
le
-# CPU model has to be created by baselining.
-#
-# Usually, a CPU model is compared against the maximum possible CPU mode=
l
-# of a certain configuration (e.g. the "host" model for KVM). If that CP=
U
-# model is identical or a subset, it will run in that configuration.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model may look different depending on the machine-=
type.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine options (including accelerator): in some architectures, CPU =
models
-#   may look different depending on machine and accelerator options. (Ex=
cept for
-#   CPU models reported as "static" in query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
-#   global properties may affect expansion of CPU models. Using
-#   query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support comparing CPU models. s390x support=
s
-# comparing CPU models.
-#
-# Returns: a CpuModelBaselineInfo. Returns an error if comparing CPU mod=
els is
-#          not supported, if a model cannot be used, if a model contains
-#          an unknown cpu definition name, unknown properties or propert=
ies
-#          with wrong types.
-#
-# Note: this command isn't specific to s390x, but is only implemented
-# on this architecture currently.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-comparison',
-  'data': { 'modela': 'CpuModelInfo', 'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelCompareInfo',
-  'if': 'defined(TARGET_S390X)' }
-
-##
-# @query-cpu-model-baseline:
-#
-# Baseline two CPU models, creating a compatible third model. The create=
d
-# model will always be a static, migration-safe CPU model (see "static"
-# CPU model expansion for details).
-#
-# This interface can be used by tooling to create a compatible CPU model=
 out
-# two CPU models. The created CPU model will be identical to or a subset=
 of
-# both CPU models when comparing them. Therefore, the created CPU model =
is
-# guaranteed to run where the given CPU models run.
-#
-# The result returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model may look different depending on the machine-=
type.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine options (including accelerator): in some architectures, CPU =
models
-#   may look different depending on machine and accelerator options. (Ex=
cept for
-#   CPU models reported as "static" in query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
-#   global properties may affect expansion of CPU models. Using
-#   query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support baselining CPU models. s390x suppor=
ts
-# baselining CPU models.
-#
-# Returns: a CpuModelBaselineInfo. Returns an error if baselining CPU mo=
dels is
-#          not supported, if a model cannot be used, if a model contains
-#          an unknown cpu definition name, unknown properties or propert=
ies
-#          with wrong types.
-#
-# Note: this command isn't specific to s390x, but is only implemented
-# on this architecture currently.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-baseline',
-  'data': { 'modela': 'CpuModelInfo',
-            'modelb': 'CpuModelInfo' },
-  'returns': 'CpuModelBaselineInfo',
-  'if': 'defined(TARGET_S390X)' }
-
 ##
 # @GICCapability:
 #
@@ -396,119 +270,3 @@
 ##
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
   'if': 'defined(TARGET_ARM)' }
-
-##
-# @CpuModelExpansionInfo:
-#
-# The result of a cpu model expansion.
-#
-# @model: the expanded CpuModelInfo.
-#
-# Since: 2.8.0
-##
-{ 'struct': 'CpuModelExpansionInfo',
-  'data': { 'model': 'CpuModelInfo' },
-  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
-
-##
-# @query-cpu-model-expansion:
-#
-# Expands a given CPU model (or a combination of CPU model + additional =
options)
-# to different granularities, allowing tooling to get an understanding w=
hat a
-# specific CPU model looks like in QEMU under a certain configuration.
-#
-# This interface can be used to query the "host" CPU model.
-#
-# The data returned by this command may be affected by:
-#
-# * QEMU version: CPU models may look different depending on the QEMU ve=
rsion.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine-type: CPU model  may look different depending on the machine=
-type.
-#   (Except for CPU models reported as "static" in query-cpu-definitions=
.)
-# * machine options (including accelerator): in some architectures, CPU =
models
-#   may look different depending on machine and accelerator options. (Ex=
cept for
-#   CPU models reported as "static" in query-cpu-definitions.)
-# * "-cpu" arguments and global properties: arguments to the -cpu option=
 and
-#   global properties may affect expansion of CPU models. Using
-#   query-cpu-model-expansion while using these is not advised.
-#
-# Some architectures may not support all expansion types. s390x supports
-# "full" and "static".
-#
-# Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU mo=
dels is
-#          not supported, if the model cannot be expanded, if the model =
contains
-#          an unknown CPU definition name, unknown properties or propert=
ies
-#          with a wrong type. Also returns an error if an expansion type=
 is
-#          not supported.
-#
-# Since: 2.8.0
-##
-{ 'command': 'query-cpu-model-expansion',
-  'data': { 'type': 'CpuModelExpansionType',
-            'model': 'CpuModelInfo' },
-  'returns': 'CpuModelExpansionInfo',
-  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
-
-##
-# @CpuDefinitionInfo:
-#
-# Virtual CPU definition.
-#
-# @name: the name of the CPU definition
-#
-# @migration-safe: whether a CPU definition can be safely used for
-#                  migration in combination with a QEMU compatibility ma=
chine
-#                  when migrating between different QEMU versions and be=
tween
-#                  hosts with different sets of (hardware or software)
-#                  capabilities. If not provided, information is not ava=
ilable
-#                  and callers should not assume the CPU definition to b=
e
-#                  migration-safe. (since 2.8)
-#
-# @static: whether a CPU definition is static and will not change depend=
ing on
-#          QEMU version, machine type, machine options and accelerator o=
ptions.
-#          A static model is always migration-safe. (since 2.8)
-#
-# @unavailable-features: List of properties that prevent
-#                        the CPU model from running in the current
-#                        host. (since 2.8)
-# @typename: Type name that can be used as argument to @device-list-prop=
erties,
-#            to introspect properties configurable using -cpu or -global=
.
-#            (since 2.9)
-#
-# @unavailable-features is a list of QOM property names that
-# represent CPU model attributes that prevent the CPU from running.
-# If the QOM property is read-only, that means there's no known
-# way to make the CPU model run in the current host. Implementations
-# that choose not to provide specific information return the
-# property name "type".
-# If the property is read-write, it means that it MAY be possible
-# to run the CPU model in the current host if that property is
-# changed. Management software can use it as hints to suggest or
-# choose an alternative for the user, or just to generate meaningful
-# error messages explaining why the CPU model can't be used.
-# If @unavailable-features is an empty list, the CPU model is
-# runnable using the current host and machine-type.
-# If @unavailable-features is not present, runnability
-# information for the CPU is not available.
-#
-# Since: 1.2.0
-##
-{ 'struct': 'CpuDefinitionInfo',
-  'data': { 'name': 'str',
-            '*migration-safe': 'bool',
-            'static': 'bool',
-            '*unavailable-features': [ 'str' ],
-            'typename': 'str' },
-  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
-
-##
-# @query-cpu-definitions:
-#
-# Return a list of supported virtual CPU definitions
-#
-# Returns: a list of CpuDefInfo
-#
-# Since: 1.2.0
-##
-{ 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
-  'if': 'defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I3=
86) || defined(TARGET_S390X) || defined(TARGET_MIPS)' }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index df4276f5f6..7caea52561 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -21,7 +21,7 @@
 #include "sysemu/kvm.h"
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-machine-target.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 147ff981ed..2a9f4e2d12 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -43,7 +43,7 @@
 #include "qapi/visitor.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/arch_init.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-machine-target.h"
=20
 #include "standard-headers/asm-x86/kvm_para.h"
=20
diff --git a/target/mips/helper.c b/target/mips/helper.c
index 6e6a44292f..a2b6459b05 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -24,7 +24,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "hw/mips/cpudevs.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-machine-target.h"
=20
 enum {
     TLBRET_XI =3D -6,
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 03cb6d0521..86fc8f2e31 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -41,7 +41,7 @@
 #include "qemu/cutils.h"
 #include "disas/capstone.h"
 #include "fpu/softfloat.h"
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-machine-target.h"
=20
 /* #define PPC_DUMP_CPU */
 /* #define PPC_DEBUG_SPR */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 19ebde14db..2cb09c0780 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -28,7 +28,7 @@
 #include "sysemu/arch_init.h"
 #include "hw/pci/pci.h"
 #endif
-#include "qapi/qapi-commands-target.h"
+#include "qapi/qapi-commands-machine-target.h"
=20
 #define CPUDEF_INIT(_type, _gen, _ec_ga, _mha_pow, _hmfai, _name, _desc)=
 \
     {                                                                   =
 \
--=20
2.21.0


