Received: from eggs.gnu.org ([2001:4830:134:3::10]:55140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsRX-0006ck-3t
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:10:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsRS-0002WP-7v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:10:03 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:34756 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1drsRR-0002Vl-TK
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 17:09:58 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 00:09:47 +0300
Message-Id: <150525058710.15988.551646038781937708.stgit@frigg.lan>
In-Reply-To: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 02/22] instrument: Add configure-time flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 configure |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configure b/configure
index fd7e3a5e81..a21d1bceb9 100755
--- a/configure
+++ b/configure
@@ -356,6 +356,7 @@ pie=3D""
 qom_cast_debug=3D"yes"
 trace_backends=3D"log"
 trace_file=3D"trace"
+instrument=3D"no"
 spice=3D""
 rbd=3D""
 smartcard=3D""
@@ -886,6 +887,8 @@ for opt do
   ;;
   --with-trace-file=3D*) trace_file=3D"$optarg"
   ;;
+  --enable-instrument) instrument=3D"yes"
+  ;;
   --enable-gprof) gprof=3D"yes"
   ;;
   --enable-gcov) gcov=3D"yes"
@@ -1436,6 +1439,7 @@ Advanced options (experts only):
                            Available backends: $trace_backend_list
   --with-trace-file=3DNAME   Full PATH,NAME of file to store traces
                            Default:trace-<pid>
+  --enable-instrument      enable event instrumentation
   --disable-slirp          disable SLIRP userspace network connectivity
   --enable-tcg-interpreter enable TCG with bytecode interpreter (TCI)
   --oss-lib                path to OSS library
@@ -5366,6 +5370,7 @@ echo "Trace backends    $trace_backends"
 if have_backend "simple"; then
 echo "Trace output file $trace_file-<pid>"
 fi
+echo "instrumentation   $instrument"
 echo "spice support     $spice $(echo_version $spice $spice_protocol_ver=
sion/$spice_server_version)"
 echo "rbd support       $rbd"
 echo "xfsctl support    $xfs"
@@ -6019,6 +6024,10 @@ if have_backend "syslog"; then
 fi
 echo "CONFIG_TRACE_FILE=3D$trace_file" >> $config_host_mak
=20
+if test "$instrument" =3D "yes"; then
+  echo "CONFIG_INSTRUMENT=3Dy" >> $config_host_mak
+fi
+
 if test "$rdma" =3D "yes" ; then
   echo "CONFIG_RDMA=3Dy" >> $config_host_mak
 fi
