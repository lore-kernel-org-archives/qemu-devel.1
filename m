Received: from eggs.gnu.org ([2001:4830:134:3::10]:48625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwK-0000Tk-0d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dXKwG-0005ZT-Qw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59311
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dXKwG-0005ZF-LC
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 01:20:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6I5JMSw040840
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:52 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bs4ja04j7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:20:52 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 23:20:51 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 18 Jul 2017 00:20:10 -0500
In-Reply-To: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1500355216-23603-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1500355216-23603-3-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/8] qemu-ga: add missing libpcre to MSI build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Thomas Lamprecht <t.lamprecht@proxmox.com>, Stefan Weil <sw@weilnetz.de>

From: Thomas Lamprecht <t.lamprecht@proxmox.com>

glib depends on libpcre which was not shipped with the MSI, thus
starting of the qemu-ga.exe failed with the respective error message.

Tell WIXL to ship this library with the MSI to avoid this problem.

Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
CC: Stefan Weil <sw@weilnetz.de>
CC: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/installer/qemu-ga.wxs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index fa2260c..5af1162 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -125,6 +125,9 @@
           <Component Id=3D"libwinpthread" Guid=3D"{6C117C78-0F47-4B07-8F=
34-6BEE11643829}">
             <File Id=3D"libwinpthread_1.dll" Name=3D"libwinpthread-1.dll=
" Source=3D"$(var.Mingw_bin)/libwinpthread-1.dll" KeyPath=3D"yes" DiskId=3D=
"1"/>
           </Component>
+          <Component Id=3D"libpcre" Guid=3D"{7A86B45E-A009-489A-A849-CE3=
BACF03CD0}">
+            <File Id=3D"libpcre_1.dll" Name=3D"libpcre-1.dll" Source=3D"=
$(var.Mingw_bin)/libpcre-1.dll" KeyPath=3D"yes" DiskId=3D"1"/>
+          </Component>
           <Component Id=3D"registry_entries" Guid=3D"{D075D109-51CA-11E3=
-9F8B-000C29858960}">
             <RegistryKey Root=3D"HKLM"
                          Key=3D"Software\$(env.QEMU_GA_MANUFACTURER)\$(e=
nv.QEMU_GA_DISTRO)\Tools\QemuGA">
@@ -173,6 +176,7 @@
       <ComponentRef Id=3D"libssp" />
       <ComponentRef Id=3D"libwinpthread" />
       <ComponentRef Id=3D"registry_entries" />
+      <ComponentRef Id=3D"libpcre" />
     </Feature>
=20
     <InstallExecuteSequence>
--=20
2.7.4
