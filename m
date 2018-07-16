Received: from eggs.gnu.org ([2001:4830:134:3::10]:34034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47u-0001sh-GY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff47o-0007wI-ST
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ff47o-0007va-Lx
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:05:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38A0F4067F19
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-125.ams2.redhat.com
	[10.36.116.125])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C49F02026D76
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 14:05:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 16 Jul 2018 16:05:12 +0200
Message-Id: <20180716140514.1490-4-armbru@redhat.com>
In-Reply-To: <20180716140514.1490-1-armbru@redhat.com>
References: <20180716140514.1490-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/5] qemu-doc: Move appendix "Deprecated
 features" to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Consumers of QEMU need to track feature deprecation.  Keeping
deprecation documentation in its own file helps in two small ways:

* You can track changes the easy and obvious way, with git-log.
  Before, you had to resort to more complex gittery like "git-log
  --oneline -L '/@node Deprecated features/,/@node Supported build
  platforms/:qemu-doc.texi'"

* It lets us use MAINTAINERS to copy interested parties on deprecation
  patches, so they can advise or object before they're a done deal.
  The next commit will do that for libvirt.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180716073226.21127-2-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu-deprecated.texi | 234 ++++++++++++++++++++++++++++++++++++++++++
 qemu-doc.texi        | 235 +------------------------------------------
 2 files changed, 235 insertions(+), 234 deletions(-)
 create mode 100644 qemu-deprecated.texi

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
new file mode 100644
index 0000000000..9920a85adc
--- /dev/null
+++ b/qemu-deprecated.texi
@@ -0,0 +1,234 @@
+@node Deprecated features
+@appendix Deprecated features
+
+In general features are intended to be supported indefinitely once
+introduced into QEMU. In the event that a feature needs to be removed,
+it will be listed in this appendix. The feature will remain functional
+for 2 releases prior to actual removal. Deprecated features may also
+generate warnings on the console when QEMU starts up, or if activated
+via a monitor command, however, this is not a mandatory requirement.
+
+Prior to the 2.10.0 release there was no official policy on how
+long features would be deprecated prior to their removal, nor
+any documented list of which features were deprecated. Thus
+any features deprecated prior to 2.10.0 will be treated as if
+they were first deprecated in the 2.10.0 release.
+
+What follows is a list of all features currently marked as
+deprecated.
+
+@section Build options
+
+@subsection GTK 2.x
+
+Previously QEMU has supported building against both GTK 2.x
+and 3.x series APIs. Support for the GTK 2.x builds will be
+discontinued, so maintainers should switch to using GTK 3.x,
+which is the default.
+
+@subsection SDL 1.2
+
+Previously QEMU has supported building against both SDL 1.2
+and 2.0 series APIs. Support for the SDL 1.2 builds will be
+discontinued, so maintainers should switch to using SDL 2.0,
+which is the default.
+
+@section System emulator command line arguments
+
+@subsection -no-kvm (since 1.3.0)
+
+The ``-no-kvm'' argument is now a synonym for setting
+``-machine accel=3Dtcg''.
+
+@subsection -vnc tls (since 2.5.0)
+
+The ``-vnc tls'' argument is now a synonym for setting
+``-object tls-creds-anon,id=3Dtls0'' combined with
+``-vnc tls-creds=3Dtls0'
+
+@subsection -vnc x509 (since 2.5.0)
+
+The ``-vnc x509=3D/path/to/certs'' argument is now a
+synonym for setting
+``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dno=
''
+combined with ``-vnc tls-creds=3Dtls0'
+
+@subsection -vnc x509verify (since 2.5.0)
+
+The ``-vnc x509verify=3D/path/to/certs'' argument is now a
+synonym for setting
+``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dye=
s''
+combined with ``-vnc tls-creds=3Dtls0'
+
+@subsection -tftp (since 2.6.0)
+
+The ``-tftp /some/dir'' argument is replaced by either
+``-netdev user,id=3Dx,tftp=3D/some/dir '' (for pluggable NICs, accompani=
ed
+with ``-device ...,netdev=3Dx''), or ``-nic user,tftp=3D/some/dir''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
+
+@subsection -bootp (since 2.6.0)
+
+The ``-bootp /some/file'' argument is replaced by either
+``-netdev user,id=3Dx,bootp=3D/some/file '' (for pluggable NICs, accompa=
nied
+with ``-device ...,netdev=3Dx''), or ``-nic user,bootp=3D/some/file''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
+
+@subsection -redir (since 2.6.0)
+
+The ``-redir [tcp|udp]:hostport:[guestaddr]:guestport'' argument is
+replaced by either
+``-netdev user,id=3Dx,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr=
]:guestport''
+(for pluggable NICs, accompanied with ``-device ...,netdev=3Dx'') or
+``-nic user,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestpor=
t''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
+
+@subsection -smb (since 2.6.0)
+
+The ``-smb /some/dir'' argument is replaced by either
+``-netdev user,id=3Dx,smb=3D/some/dir '' (for pluggable NICs, accompanie=
d
+with ``-device ...,netdev=3Dx''), or ``-nic user,smb=3D/some/dir''
+(for embedded NICs). The new syntax allows different settings to be
+provided per NIC.
+
+@subsection -drive cyls=3D...,heads=3D...,secs=3D...,trans=3D... (since =
2.10.0)
+
+The drive geometry arguments are replaced by the the geometry arguments
+that can be specified with the ``-device'' parameter.
+
+@subsection -drive serial=3D... (since 2.10.0)
+
+The drive serial argument is replaced by the the serial argument
+that can be specified with the ``-device'' parameter.
+
+@subsection -drive addr=3D... (since 2.10.0)
+
+The drive addr argument is replaced by the the addr argument
+that can be specified with the ``-device'' parameter.
+
+@subsection -usbdevice (since 2.10.0)
+
+The ``-usbdevice DEV'' argument is now a synonym for setting
+the ``-device usb-DEV'' argument instead. The deprecated syntax
+would automatically enable USB support on the machine type.
+If using the new syntax, USB support must be explicitly
+enabled via the ``-machine usb=3Don'' argument.
+
+@subsection -nodefconfig (since 2.11.0)
+
+The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
+
+@subsection -balloon (since 2.12.0)
+
+The @option{--balloon virtio} argument has been superseded by
+@option{--device virtio-balloon}.
+
+@subsection -machine s390-squash-mcss=3Don|off (since 2.12.0)
+
+The ``s390-squash-mcss=3Don`` property has been obsoleted by allowing th=
e
+cssid to be chosen freely. Instead of squashing subchannels into the
+default channel subsystem image for guests that do not support multiple
+channel subsystems, all devices can be put into the default channel
+subsystem image.
+
+@subsection -fsdev handle (since 2.12.0)
+
+The ``handle'' fsdev backend does not support symlinks and causes the 9p
+filesystem in the guest to fail a fair amount of tests from the PJD POSI=
X
+filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capabili=
ty,
+which is not the recommended way to run QEMU. This backend should not be
+used and it will be removed with no replacement.
+
+@subsection -no-frame (since 2.12.0)
+
+The @code{--no-frame} argument works with SDL 1.2 only. The other user
+interfaces never implemented this in the first place. So this will be
+removed together with SDL 1.2 support.
+
+@subsection -rtc-td-hack (since 2.12.0)
+
+The @code{-rtc-td-hack} option has been replaced by
+@code{-rtc driftfix=3Dslew}.
+
+@subsection -localtime (since 2.12.0)
+
+The @code{-localtime} option has been replaced by @code{-rtc base=3Dloca=
ltime}.
+
+@subsection -startdate (since 2.12.0)
+
+The @code{-startdate} option has been replaced by @code{-rtc base=3D@var=
{date}}.
+
+@subsection -virtioconsole (since 3.0.0)
+
+Option @option{-virtioconsole} has been replaced by
+@option{-device virtconsole}.
+
+@subsection -clock (since 3.0.0)
+
+The @code{-clock} option is ignored since QEMU version 1.7.0. There is n=
o
+replacement since it is not needed anymore.
+
+@subsection -enable-hax (since 3.0.0)
+
+The @option{-enable-hax} option has been replaced by @option{-accel hax}=
.
+Both options have been introduced in QEMU version 2.9.0.
+
+@subsection -drive file=3Djson:@{...@{'driver':'file'@}@} (since 3.0)
+
+The 'file' driver for drives is no longer appropriate for character or h=
ost
+devices and will only accept regular files (S_IFREG). The correct driver
+for these file types is 'host_cdrom' or 'host_device' as appropriate.
+
+@section QEMU Machine Protocol (QMP) commands
+
+@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
+
+"autoload" parameter is now ignored. All bitmaps are automatically loade=
d
+from qcow2 images.
+
+@subsection query-cpus (since 2.12.0)
+
+The ``query-cpus'' command is replaced by the ``query-cpus-fast'' comman=
d.
+
+@subsection query-cpus-fast "arch" output member (since 3.0.0)
+
+The ``arch'' output member of the ``query-cpus-fast'' command is
+replaced by the ``target'' output member.
+
+@section System emulator devices
+
+@subsection ivshmem (since 2.6.0)
+
+The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
+or ``ivshmem-doorbell`` device types.
+
+@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12=
.0)
+
+qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc6=
4)
+should be used instead. That means that embedded 4xx PowerPC CPUs will n=
ot
+support page sizes < 4096 any longer.
+
+@section System emulator machines
+
+@subsection pc-0.10 and pc-0.11 (since 3.0)
+
+These machine types are very old and likely can not be used for live mig=
ration
+from old QEMU versions anymore. A newer machine type should be used inst=
ead.
+
+@section Device options
+
+@subsection Block device options
+
+@subsubsection "backing": "" (since 2.12.0)
+
+In order to prevent QEMU from automatically opening an image's backing
+chain, use ``"backing": null'' instead.
+
+@subsection vio-spapr-device device options
+
+@subsubsection "irq": "" (since 3.0.0)
+
+The ``irq'' property is obsoleted.
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 1047c407e7..abfd2db546 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2791,240 +2791,7 @@ Run the emulation in single step mode.
=20
 @include qemu-tech.texi
=20
-@node Deprecated features
-@appendix Deprecated features
-
-In general features are intended to be supported indefinitely once
-introduced into QEMU. In the event that a feature needs to be removed,
-it will be listed in this appendix. The feature will remain functional
-for 2 releases prior to actual removal. Deprecated features may also
-generate warnings on the console when QEMU starts up, or if activated
-via a monitor command, however, this is not a mandatory requirement.
-
-Prior to the 2.10.0 release there was no official policy on how
-long features would be deprecated prior to their removal, nor
-any documented list of which features were deprecated. Thus
-any features deprecated prior to 2.10.0 will be treated as if
-they were first deprecated in the 2.10.0 release.
-
-What follows is a list of all features currently marked as
-deprecated.
-
-@section Build options
-
-@subsection GTK 2.x
-
-Previously QEMU has supported building against both GTK 2.x
-and 3.x series APIs. Support for the GTK 2.x builds will be
-discontinued, so maintainers should switch to using GTK 3.x,
-which is the default.
-
-@subsection SDL 1.2
-
-Previously QEMU has supported building against both SDL 1.2
-and 2.0 series APIs. Support for the SDL 1.2 builds will be
-discontinued, so maintainers should switch to using SDL 2.0,
-which is the default.
-
-@section System emulator command line arguments
-
-@subsection -no-kvm (since 1.3.0)
-
-The ``-no-kvm'' argument is now a synonym for setting
-``-machine accel=3Dtcg''.
-
-@subsection -vnc tls (since 2.5.0)
-
-The ``-vnc tls'' argument is now a synonym for setting
-``-object tls-creds-anon,id=3Dtls0'' combined with
-``-vnc tls-creds=3Dtls0'
-
-@subsection -vnc x509 (since 2.5.0)
-
-The ``-vnc x509=3D/path/to/certs'' argument is now a
-synonym for setting
-``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dno=
''
-combined with ``-vnc tls-creds=3Dtls0'
-
-@subsection -vnc x509verify (since 2.5.0)
-
-The ``-vnc x509verify=3D/path/to/certs'' argument is now a
-synonym for setting
-``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dye=
s''
-combined with ``-vnc tls-creds=3Dtls0'
-
-@subsection -tftp (since 2.6.0)
-
-The ``-tftp /some/dir'' argument is replaced by either
-``-netdev user,id=3Dx,tftp=3D/some/dir '' (for pluggable NICs, accompani=
ed
-with ``-device ...,netdev=3Dx''), or ``-nic user,tftp=3D/some/dir''
-(for embedded NICs). The new syntax allows different settings to be
-provided per NIC.
-
-@subsection -bootp (since 2.6.0)
-
-The ``-bootp /some/file'' argument is replaced by either
-``-netdev user,id=3Dx,bootp=3D/some/file '' (for pluggable NICs, accompa=
nied
-with ``-device ...,netdev=3Dx''), or ``-nic user,bootp=3D/some/file''
-(for embedded NICs). The new syntax allows different settings to be
-provided per NIC.
-
-@subsection -redir (since 2.6.0)
-
-The ``-redir [tcp|udp]:hostport:[guestaddr]:guestport'' argument is
-replaced by either
-``-netdev user,id=3Dx,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr=
]:guestport''
-(for pluggable NICs, accompanied with ``-device ...,netdev=3Dx'') or
-``-nic user,hostfwd=3D[tcp|udp]:[hostaddr]:hostport-[guestaddr]:guestpor=
t''
-(for embedded NICs). The new syntax allows different settings to be
-provided per NIC.
-
-@subsection -smb (since 2.6.0)
-
-The ``-smb /some/dir'' argument is replaced by either
-``-netdev user,id=3Dx,smb=3D/some/dir '' (for pluggable NICs, accompanie=
d
-with ``-device ...,netdev=3Dx''), or ``-nic user,smb=3D/some/dir''
-(for embedded NICs). The new syntax allows different settings to be
-provided per NIC.
-
-@subsection -drive cyls=3D...,heads=3D...,secs=3D...,trans=3D... (since =
2.10.0)
-
-The drive geometry arguments are replaced by the the geometry arguments
-that can be specified with the ``-device'' parameter.
-
-@subsection -drive serial=3D... (since 2.10.0)
-
-The drive serial argument is replaced by the the serial argument
-that can be specified with the ``-device'' parameter.
-
-@subsection -drive addr=3D... (since 2.10.0)
-
-The drive addr argument is replaced by the the addr argument
-that can be specified with the ``-device'' parameter.
-
-@subsection -usbdevice (since 2.10.0)
-
-The ``-usbdevice DEV'' argument is now a synonym for setting
-the ``-device usb-DEV'' argument instead. The deprecated syntax
-would automatically enable USB support on the machine type.
-If using the new syntax, USB support must be explicitly
-enabled via the ``-machine usb=3Don'' argument.
-
-@subsection -nodefconfig (since 2.11.0)
-
-The ``-nodefconfig`` argument is a synonym for ``-no-user-config``.
-
-@subsection -balloon (since 2.12.0)
-
-The @option{--balloon virtio} argument has been superseded by
-@option{--device virtio-balloon}.
-
-@subsection -machine s390-squash-mcss=3Don|off (since 2.12.0)
-
-The ``s390-squash-mcss=3Don`` property has been obsoleted by allowing th=
e
-cssid to be chosen freely. Instead of squashing subchannels into the
-default channel subsystem image for guests that do not support multiple
-channel subsystems, all devices can be put into the default channel
-subsystem image.
-
-@subsection -fsdev handle (since 2.12.0)
-
-The ``handle'' fsdev backend does not support symlinks and causes the 9p
-filesystem in the guest to fail a fair amount of tests from the PJD POSI=
X
-filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capabili=
ty,
-which is not the recommended way to run QEMU. This backend should not be
-used and it will be removed with no replacement.
-
-@subsection -no-frame (since 2.12.0)
-
-The @code{--no-frame} argument works with SDL 1.2 only. The other user
-interfaces never implemented this in the first place. So this will be
-removed together with SDL 1.2 support.
-
-@subsection -rtc-td-hack (since 2.12.0)
-
-The @code{-rtc-td-hack} option has been replaced by
-@code{-rtc driftfix=3Dslew}.
-
-@subsection -localtime (since 2.12.0)
-
-The @code{-localtime} option has been replaced by @code{-rtc base=3Dloca=
ltime}.
-
-@subsection -startdate (since 2.12.0)
-
-The @code{-startdate} option has been replaced by @code{-rtc base=3D@var=
{date}}.
-
-@subsection -virtioconsole (since 3.0.0)
-
-Option @option{-virtioconsole} has been replaced by
-@option{-device virtconsole}.
-
-@subsection -clock (since 3.0.0)
-
-The @code{-clock} option is ignored since QEMU version 1.7.0. There is n=
o
-replacement since it is not needed anymore.
-
-@subsection -enable-hax (since 3.0.0)
-
-The @option{-enable-hax} option has been replaced by @option{-accel hax}=
.
-Both options have been introduced in QEMU version 2.9.0.
-
-@subsection -drive file=3Djson:@{...@{'driver':'file'@}@} (since 3.0)
-
-The 'file' driver for drives is no longer appropriate for character or h=
ost
-devices and will only accept regular files (S_IFREG). The correct driver
-for these file types is 'host_cdrom' or 'host_device' as appropriate.
-
-@section QEMU Machine Protocol (QMP) commands
-
-@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-
-"autoload" parameter is now ignored. All bitmaps are automatically loade=
d
-from qcow2 images.
-
-@subsection query-cpus (since 2.12.0)
-
-The ``query-cpus'' command is replaced by the ``query-cpus-fast'' comman=
d.
-
-@subsection query-cpus-fast "arch" output member (since 3.0.0)
-
-The ``arch'' output member of the ``query-cpus-fast'' command is
-replaced by the ``target'' output member.
-
-@section System emulator devices
-
-@subsection ivshmem (since 2.6.0)
-
-The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
-or ``ivshmem-doorbell`` device types.
-
-@subsection Page size support < 4k for embedded PowerPC CPUs (since 2.12=
.0)
-
-qemu-system-ppcemb will be removed. qemu-system-ppc (or qemu-system-ppc6=
4)
-should be used instead. That means that embedded 4xx PowerPC CPUs will n=
ot
-support page sizes < 4096 any longer.
-
-@section System emulator machines
-
-@subsection pc-0.10 and pc-0.11 (since 3.0)
-
-These machine types are very old and likely can not be used for live mig=
ration
-from old QEMU versions anymore. A newer machine type should be used inst=
ead.
-
-@section Device options
-
-@subsection Block device options
-
-@subsubsection "backing": "" (since 2.12.0)
-
-In order to prevent QEMU from automatically opening an image's backing
-chain, use ``"backing": null'' instead.
-
-@subsection vio-spapr-device device options
-
-@subsubsection "irq": "" (since 3.0.0)
-
-The ``irq'' property is obsoleted.
+@include qemu-deprecated.texi
=20
 @node Supported build platforms
 @appendix Supported build platforms
--=20
2.17.1
