Received: from eggs.gnu.org ([209.51.188.92]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1gzAhm-000628-8i
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhines@scalecomputing.com>) id 1gzAhk-0004lQ-79
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:41:46 -0500
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:53149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mhines@scalecomputing.com>)
	id 1gzAhj-0004ZU-EC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 20:41:44 -0500
Received: by mail-it1-x143.google.com with SMTP id g17so4351641ita.2
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 17:41:23 -0800 (PST)
Message-ID: <5c773c41.1c69fb81.68974.a5a0@mx.google.com>
MIME-Version: 1.0
From: Matt Hines <mhines@scalecomputing.com>
Date: Wed, 27 Feb 2019 17:41:19 -0800
In-Reply-To: <154895722053.23946.2175068699085740175@ebba9967afc0>
References: <20190128223056.19452-1-mhines@scalecomputing.com>
	<154895722053.23946.2175068699085740175@ebba9967afc0>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] QGA: Fix guest-get-fsinfo PCI
 addresscollection in Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>

ping



From: no-reply@patchew.org
Sent: Thursday, January 31, 2019 9:53
To: mhines@scalecomputing.com
Cc: fam@euphon.net; qemu-devel@nongnu.org; mhines@scalecomputing.com; mdrot=
h@linux.vnet.ibm.com
Subject: Re: [Qemu-devel] [PATCH v3] QGA: Fix guest-get-fsinfo PCI addressc=
ollection in Windows

Patchew URL: https://patchew.org/QEMU/20190128223056.19452-1-mhines@scaleco=
mputing.com/



Hi,

This series seems to have some coding style problems. See output below for
more information:

Subject: [Qemu-devel] [PATCH v3] QGA: Fix guest-get-fsinfo PCI address coll=
ection in Windows
Type: series
Message-id: 20190128223056.19452-1-mhines@scalecomputing.com

=3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
#!/bin/bash
git config --local diff.renamelimit 0
git config --local diff.renames True
git config --local diff.algorithm histogram
./scripts/checkpatch.pl --mailback base..
=3D=3D=3D TEST SCRIPT END =3D=3D=3D

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
Switched to a new branch 'test'
6805362916 QGA: Fix guest-get-fsinfo PCI address collection in Windows

=3D=3D=3D OUTPUT BEGIN =3D=3D=3D
WARNING: Block comments should align the * on each line
#198: FILE: qga/commands-win32.c:592:
+            /*
+            * CM API used here as opposed to

WARNING: line over 80 characters
#302: FILE: qga/commands-win32.c:661:
+            /* There is no need to allocate buffer in the next functions. =
The size

WARNING: Block comments use a leading /* on a separate line
#302: FILE: qga/commands-win32.c:661:
+            /* There is no need to allocate buffer in the next functions. =
The size

WARNING: Block comments should align the * on each line
#303: FILE: qga/commands-win32.c:662:
+            /* There is no need to allocate buffer in the next functions. =
The size
+            * is known and ULONG according to

ERROR: spaces required around that '&' (ctx:VxV)
#308: FILE: qga/commands-win32.c:667:
+                  &type, (PBYTE)&bus, size, NULL)) {
                                 ^

WARNING: Block comments use a leading /* on a separate line
#326: FILE: qga/commands-win32.c:673:
+            /* The function retrieves the device's address. This value wil=
l be

WARNING: Block comments use a trailing */ on a separate line
#327: FILE: qga/commands-win32.c:674:
+            * transformed into device function and number */

WARNING: Block comments should align the * on each line
#327: FILE: qga/commands-win32.c:674:
+            /* The function retrieves the device's address. This value wil=
l be
+            * transformed into device function and number */

ERROR: spaces required around that '&' (ctx:VxV)
#330: FILE: qga/commands-win32.c:677:
+                    &type, (PBYTE)&addr, size, NULL)) {
                                   ^

WARNING: Block comments use a leading /* on a separate line
#336: FILE: qga/commands-win32.c:683:
+            /* This call returns UINumber of DEVICE_CAPABILITIES structure=
.

WARNING: Block comments use a trailing */ on a separate line
#337: FILE: qga/commands-win32.c:684:
+            * This number is typically a user-perceived slot number. */

WARNING: Block comments should align the * on each line
#337: FILE: qga/commands-win32.c:684:
+            /* This call returns UINumber of DEVICE_CAPABILITIES structure=
.
+            * This number is typically a user-perceived slot number. */

ERROR: spaces required around that '&' (ctx:VxV)
#340: FILE: qga/commands-win32.c:687:
+                    &type, (PBYTE)&slot, size, NULL)) {
                                   ^

WARNING: Block comments use a leading /* on a separate line
#346: FILE: qga/commands-win32.c:693:
+            /* SetupApi gives us the same information as driver with

WARNING: Block comments should align the * on each line
#347: FILE: qga/commands-win32.c:694:
+            /* SetupApi gives us the same information as driver with
+            * IoGetDeviceProperty. According to Microsoft

WARNING: Block comments use a trailing */ on a separate line
#351: FILE: qga/commands-win32.c:698:
+            * SPDRP_ADDRESS is propertyAddress, so we do the same.*/

total: 3 errors, 13 warnings, 407 lines checked

Commit 680536291660 (QGA: Fix guest-get-fsinfo PCI address collection in Wi=
ndows) has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.
=3D=3D=3D OUTPUT END =3D=3D=3D

Test command exited with code: 1


The full log is available at
http://patchew.org/logs/20190128223056.19452-1-mhines@scalecomputing.com/te=
sting.checkpatch/?type=3Dmessage.
---
Email generated automatically by Patchew [http://patchew.org/].
Please send your feedback to patchew-devel@redhat.com
