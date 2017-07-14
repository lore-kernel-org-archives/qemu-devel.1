Received: from eggs.gnu.org ([2001:4830:134:3::10]:44276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVxdo-0005bu-DF
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dVxdm-0007NZ-QQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dVxdm-0007NL-Gd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:16:06 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 14 Jul 2017 11:15:49 +0100
Message-Id: <20170714101549.28665-3-berrange@redhat.com>
In-Reply-To: <20170714101549.28665-1-berrange@redhat.com>
References: <20170714101549.28665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] docs: document deprecated features in
 appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The deprecation of features in QEMU is totally adhoc currently,
with no way for the user to get a list of what is deprecated
in each release. This adds an appendix to the doc that records
when each deprecation was made and provides text explaining
what to use instead, if anything.

Since there has been no formal policy around removal of deprecated
features in the past, any deprecations prior to 2.10.0 are to be
treated as if they had been made at the 2.10.0 release. Thus the
earliest that existing deprecations will be deleted is the start
of the 2.12.0 cycle.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-doc.texi | 168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index f067015d4b..c06cab26b7 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -39,6 +39,7 @@
 * QEMU User space emulator::
 * Implementation notes::
 * Support lifetime::
+* Deprecated features::
 * License::
 * Index::
 @end menu
@@ -3165,6 +3166,173 @@ support machine types from many previous versions.
 The supported lifetime for versioned machine types is 12 releases,
 which is equivalent to 4 years worth of previous QEMU releases.
 
+@node Deprecated features
+@appendix Deprecated features
+
+The following sections provide a list of all features currently
+marked as deprecated.
+
+Prior to the 2.10.0 release there was no official policy on how
+long features would be deprecated prior to their removal, nor
+any documented list of which features were deprecated. Thus
+any features deprecated prior to 2.10.0 will be treated as if
+they were first deprecated in the 2.10.0 release.
+
+@section System emulator command line arguments
+
+@subsection -drive boot=on|off (since 1.3.0)
+
+The ``boot=on|off'' option to the ``-drive'' argument is
+ignored. Applications should use the ``bootindex=N'' parameter
+to set an absolute ordering between devices instead.
+
+@subsection -tdf (since 1.3.0)
+
+The ``-tdf'' argument is ignored. The behaviour implemented
+by this argument is now the default when using the KVM PIT,
+but can be requested explicitly using
+``-global kvm-pit.lost_tick_policy=slew''.
+
+@subsection -no-kvm-pit-reinjection (since 1.3.0)
+
+The ``-no-kvm-pit-reinjection'' argument is now a
+synonym for setting ``-global kvm-pit.lost_tick_policy=discard''.
+
+@subsection -no-kvm-irqchip (since 1.3.0)
+
+The ``-no-kvm-irqchip'' argument is now a synonym for
+setting ``-machine kernel_irqchip=off''.
+
+@subsection -no-kvm-pit (since 1.3.0)
+
+The ``-no-kvm-pit'' argument is ignored. It is no longer
+possible to disable the KVM PIT directly.
+
+@subsection -no-kvm (since 1.3.0)
+
+The ``-no-kvm'' argument is now a synonym for setting
+``-machine accel=tcg''.
+
+@subsection -monitor default=on (since 2.4.0)
+
+The ``default'' option to the ``-monitor'' argument is
+now ignored. When multiple monitors were enabled, it
+indicated which monitor would receive log messages
+from the various subsystems. This feature is no longer
+required as messages are now only sent to the monitor
+in response to explicitly monitor commands.
+
+@subsection -vnc tls (since 2.5.0)
+
+The ``-vnc tls'' argument is now a synonym for setting
+``-object tls-creds-anon,id=tls0'' combined with
+``-vnc tls-creds=tls0'
+
+@subsection -vnc x509 (since 2.5.0)
+
+The ``-vnc x509=/path/to/certs'' argument is now a
+synonym for setting
+``-object tls-creds-x509,dir=/path/to/certs,id=tls0,verify-peer=no''
+combined with ``-vnc tls-creds=tls0'
+
+@subsection -vnc x509verify (since 2.5.0)
+
+The ``-vnc x509verify=/path/to/certs'' argument is now a
+synonym for setting
+``-object tls-creds-x509,dir=/path/to/certs,id=tls0,verify-peer=yes''
+combined with ``-vnc tls-creds=tls0'
+
+@subsection -tftp (since 2.6.0)
+
+The ``-tftp /some/dir'' argument is now a synonym for setting
+the ``-netdev user,tftp=/some/dir' argument. The new syntax
+allows different settings to be provided per NIC.
+
+@subsection -bootp (since 2.6.0)
+
+The ``-bootp /some/file'' argument is now a synonym for setting
+the ``-netdev user,bootp=/some/file' argument. The new syntax
+allows different settings to be provided per NIC.
+
+@subsection -redir (since 2.6.0)
+
+The ``-redir ARGS'' argument is now a synonym for setting
+the ``-netdev user,hostfwd=ARGS'' argument instead. The new
+syntax allows different settings to be provided per NIC.
+
+@subsection -smb (since 2.6.0)
+
+The ``-smb /some/dir'' argument is now a synonym for setting
+the ``-netdev user,smb=/some/dir'' argument instead. The new
+syntax allows different settings to be provided per NIC.
+
+@subsection -net channel (since 2.6.0)
+
+The ``--net channel,ARGS'' argument is now a synonym for setting
+the ``-netdev user,guestfwd=ARGS'' argument instead.
+
+@subsection -net vlan (since 2.9.0)
+
+The ``-net van=NN'' argument is partially replaced with the
+new ``-netdev'' argument. The remaining use cases will no
+longer be directly supported in QEMU.
+
+@subsection -drive if=scsi (since 2.9.0)
+
+The ``-drive if=scsi'' argument is replaced by the the
+``-device BUS-TYPE'' argument combined with ``-drive if=none''.
+
+@subsection -net dump (since 2.10.0)
+
+The ``--net dump'' argument is now replaced with the
+``-object filter-dump'' argument which works in combination
+with the modern ``-netdev`` backends instead.
+
+@subsection -hdachs (since 2.10.0)
+
+The ``-hdachs'' argument is now a synonym for setting
+the ``cyls'', ``heads'', ``secs'', and ``trans'' properties
+on the ``ide-hd'' device using the ``-device'' argument.
+The new syntax allows different settings to be provided
+per disk.
+
+@subsection -usbdevice (since 2.10.0)
+
+The ``-usbdevice DEV'' argument is now a synonym for setting
+the ``-device usb-DEV'' argument instead. The deprecated syntax
+would automatically enable USB support on the machine type.
+If using the new syntax, USB support must be explicitly
+enabled via the ``-machine usb=on'' argument.
+
+@section qemu-img command line arguments
+
+@subsection convert -s (since 2.0.0)
+
+The ``convert -s snapshot_id_or_name'' argument is obsoleted
+by the ``convert -l snapshot_param'' argument instead.
+
+@section System emulator human monitor commands
+
+@subsection usb_add (since 2.10.0)
+
+The ``usb_add'' command is replaced by the ``device_add'' command.
+
+@subsection usb_del (since 2.10.0)
+
+The ``usb_del'' command is replaced by the ``device_del'' command.
+
+@section System emulator devices
+
+@subsection ivshmem (since 2.6.0)
+
+The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
+or ``ivshmem-doorbell`` device types.
+
+@subsection spapr-pci-vfio-host-bridge (since 2.6.0)
+
+The ``spapr-pci-vfio-host-bridge'' device type is replaced by
+the ``spapr-pci-host-bridge'' device type.
+
 @node License
 @appendix License
 
-- 
2.13.0
