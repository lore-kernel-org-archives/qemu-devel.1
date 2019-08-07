Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EDFC19759
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8572199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8572199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGCV-0000Au-NF
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAf-0006yM-AF
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAd-0001YF-UY
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvGAd-0001XX-Mt
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x777E9j7097030
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 03:15:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7s71hx57-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:36 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 08:15:34 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 08:15:32 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x777FVRF40370374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 07:15:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7557BA4069;
 Wed,  7 Aug 2019 07:15:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EE18A407C;
 Wed,  7 Aug 2019 07:15:30 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.109.247.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 07:15:29 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:44:40 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080707-4275-0000-0000-000003562A26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080707-4276-0000-0000-000038682B17
Message-Id: <20190807071445.4109-2-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC PATCH 1/6] utils/python_api: add scripting
 interface for Qemu with python lib
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
Cc: maddy@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds scripting interface with python library to call functions in
python modules from Qemu that can be used to feed input externally
and without recompiling Qemu that can be used for early development,
testing and can be extended to abstract some of Qemu code out to a
python script to ease maintenance.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 configure                   |  10 +++++
 include/sysemu/python_api.h |  30 +++++++++++++
 util/Makefile.objs          |   1 +
 util/python_api.c           | 100 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)
 create mode 100644 include/sysemu/python_api.h
 create mode 100644 util/python_api.c

diff --git a/configure b/configure
index 714e7fb6a1..fddddcc879 100755
--- a/configure
+++ b/configure
@@ -1866,6 +1866,11 @@ fi
 # Preserve python version since some functionality is dependent on it
 python_version=$($python -V 2>&1 | sed -e 's/Python\ //')
 
+# Python config to be used for CFLAGS and LDFLAGS
+if ! [ -z "$python" ]; then
+    python_config="$python-config"
+fi
+
 # Suppress writing compiled files
 python="$python -B"
 
@@ -6304,6 +6309,11 @@ echo_version() {
     fi
 }
 
+if ! [ -z "$python_config" ]; then
+    QEMU_CFLAGS="$QEMU_CFLAGS $($python_config --includes)"
+    QEMU_LDFLAGS="$QEMU_LDFLAGS $($python_config --ldflags)"
+fi
+
 # prepend pixman and ftd flags after all config tests are done
 QEMU_CFLAGS="$pixman_cflags $fdt_cflags $QEMU_CFLAGS"
 QEMU_LDFLAGS="$fdt_ldflags $QEMU_LDFLAGS"
diff --git a/include/sysemu/python_api.h b/include/sysemu/python_api.h
new file mode 100644
index 0000000000..ff02d58377
--- /dev/null
+++ b/include/sysemu/python_api.h
@@ -0,0 +1,30 @@
+#ifndef _PPC_PNV_PYTHON_H
+#define _PPC_PNV_PYTHON_H
+
+#include <stdbool.h>
+#include <Python.h>
+
+extern PyObject *python_callback(const char *abs_module_path, const char *mod,
+                                 const char *func, char *args[],
+                                 const int nargs);
+
+extern uint64_t python_callback_int(const char *abs_module_path,
+                                    const char *mod,
+                                    const char *func, char *args[],
+                                    const int nargs);
+
+extern char *python_callback_str(const char *abs_module_path, const char *mod,
+                                 const char *func, char *args[],
+                                 const int nargs);
+
+extern bool python_callback_bool(const char *abs_module_path, const char *mod,
+                                 const char *func, char *args[],
+                                 const int nargs);
+
+extern void python_args_init_cast_int(char *args[], int arg, int pos);
+
+extern void python_args_init_cast_long(char *args[], uint64_t arg, int pos);
+
+extern void python_args_clean(char *args[], int nargs);
+
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..05851c94a7 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -50,6 +50,7 @@ util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
 util-obj-y += iova-tree.o
+util-obj-y += python_api.o
 util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_POSIX) += drm.o
diff --git a/util/python_api.c b/util/python_api.c
new file mode 100644
index 0000000000..854187e00f
--- /dev/null
+++ b/util/python_api.c
@@ -0,0 +1,100 @@
+#include "sysemu/python_api.h"
+#include "qemu/osdep.h"
+
+PyObject *python_callback(const char *abs_module_path, const char *mod,
+                          const char *func, char *args[], const int nargs)
+{
+    PyObject *mod_name, *module, *mod_ref, *function, *arguments;
+    PyObject *result = 0;
+    PyObject *value = NULL;
+
+    /* Set PYTHONPATH to absolute module path directory */
+    if (!abs_module_path)
+        abs_module_path = ".";
+    setenv("PYTHONPATH", abs_module_path, 1);
+
+    /* Initialize the Python Interpreter */
+    Py_Initialize();
+    mod_name = PyUnicode_FromString(mod);
+    /* Import module object */
+    module = PyImport_Import(mod_name);
+    if (!module) {
+        PyErr_Print();
+        fprintf(stderr, "Failed to load \"%s\"\n", mod);
+        exit(EXIT_FAILURE);
+    }
+    mod_ref = PyModule_GetDict(module);
+    function = PyDict_GetItemString(mod_ref, func);
+    if (function && PyCallable_Check(function)) {
+        arguments = PyTuple_New(nargs);
+        for (int i = 0; i < nargs; i++) {
+            value = PyUnicode_FromString(args[i]);
+            if (!value) {
+                Py_DECREF(arguments);
+                Py_DECREF(module);
+                fprintf(stderr, "Cannot convert argument\n");
+                exit(EXIT_FAILURE);
+            }
+            PyTuple_SetItem(arguments, i, value);
+        }
+        PyErr_Print();
+        result = PyObject_CallObject(function, arguments);
+        PyErr_Print();
+    }
+    else {
+        if (PyErr_Occurred())
+            PyErr_Print();
+        fprintf(stderr, "Cannot find function \"%s\"\n", func);
+        exit(EXIT_FAILURE);
+    }
+    /* Clean up */
+    Py_DECREF(value);
+    Py_DECREF(module);
+    Py_DECREF(mod_name);
+    /* Finish the Python Interpreter */
+    Py_Finalize();
+    return result;
+}
+
+uint64_t python_callback_int(const char *abs_module_path, const char *mod,
+                             const char *func, char *args[], const int nargs)
+{
+    PyObject *result;
+    result = python_callback(abs_module_path, mod, func, args, nargs);
+    return PyLong_AsLong(result);
+}
+
+char *python_callback_str(const char *abs_module_path, const char *mod,
+                          const char *func, char *args[], const int nargs)
+{
+    PyObject *result;
+    result = python_callback(abs_module_path, mod, func, args, nargs);
+    return PyUnicode_AsUTF8(result);
+}
+
+bool python_callback_bool(const char *abs_module_path, const char *mod,
+                          const char *func, char *args[], const int nargs)
+{
+    PyObject *result;
+    result = python_callback(abs_module_path, mod, func, args, nargs);
+    return (result == Py_True);
+}
+
+void python_args_init_cast_int(char *args[], int arg, int pos)
+{
+    args[pos]= malloc(sizeof(int));
+    sprintf(args[pos], "%d", arg);
+}
+
+void python_args_init_cast_long(char *args[], uint64_t arg, int pos)
+{
+    args[pos]= g_malloc(sizeof(uint64_t) * 2);
+    sprintf(args[pos], "%lx", arg);
+}
+
+void python_args_clean(char *args[], int nargs)
+{
+    for (int i = 0; i < nargs; i++) {
+        g_free(args[i]);
+    }
+}
-- 
2.14.5


