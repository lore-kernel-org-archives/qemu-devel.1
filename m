Received: from eggs.gnu.org ([2001:4830:134:3::10]:50551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFJOa-0000er-HV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eFJOW-0000eN-GD
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:35:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:60790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eFJOW-0000dj-6i
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 07:35:48 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eFJOT-00012U-Rf
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:35:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D04902E80D3
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 12:35:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Nov 2017 12:25:07 -0000
From: jean-christophe manciot <manciot.jeanchristophe@gmail.com>
Reply-To: Bug 1732679 <1732679@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151083510794.7964.2025182664045014218.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1732679] [NEW] Cisco NX-OSv 9k crashes during
 boot with qemu 2.10.1(Debian 1:2.10.0+dfsg-2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Ubuntu 17.04
qemu 2.10.1(Debian 1:2.10.0+dfsg-2)
gns3 2.0.3
NX-OSv 9k 7.0.3.I6.1

- No such issue with previous qemu 2.8.x
- the issue does not seem to come from the debian packaging
- the issue does not seem to come from GNS3 either, as confirmed by Jeremy =
Grossmann at https://github.com/GNS3/gns3-server/issues/1193#issuecomment-3=
44240460

Either some parameters usage have changed (for instance -bios) (which would=
 make qemu not backwards compatible) or there is an issue with qemu itself.
The configuration parameters are:
```
                "compute_id": "local",
                "console": 2010,
                "console_type": "telnet",
                "first_port_name": "mgmt0",
                "height": 48,
                "label": {
                    "rotation": 0,
                    "style": "font-family: TypeWriter;font-size: 10.0;font-=
weight: bold;fill: #000000;fill-opacity: 1.0;",
                    "text": "NX_OSv_9k_Spine_31",
                    "x": -54,
                    "y": -25
                },
                "name": "NX_OSv_9k_Spine_31",
                "node_id": "8d01119a-0adc-41bc-950b-c5639db7708c",
                "node_type": "qemu",
                "port_name_format": "Ethernet1/{port1}",
                "port_segment_size": 0,
                "properties": {
                    "acpi_shutdown": false,
                    "adapter_type": "e1000",
                    "adapters": 10,
                    "bios_image": "",
                    "bios_image_md5sum": null,
                    "boot_priority": "c",
                    "cdrom_image": "",
                    "cdrom_image_md5sum": null,
                    "cpu_throttling": 0,
                    "cpus": 2,
                    "hda_disk_image": "NX-OSv-9k-7.0.3.I6.1.free.qcow2",
                    "hda_disk_image_md5sum": "18bb991b814a508d1190575f99dee=
d99",
                    "hda_disk_interface": "ide",
                    "hdb_disk_image": "",
                    "hdb_disk_image_md5sum": null,
                    "hdb_disk_interface": "ide",
                    "hdc_disk_image": "",
                    "hdc_disk_image_md5sum": null,
                    "hdc_disk_interface": "ide",
                    "hdd_disk_image": "",
                    "hdd_disk_image_md5sum": null,
                    "hdd_disk_interface": "ide",
                    "initrd": "",
                    "initrd_md5sum": null,
                    "kernel_command_line": "",
                    "kernel_image": "",
                    "kernel_image_md5sum": null,
                    "legacy_networking": false,
                    "mac_address": "00:07:00:03:16:01",
                    "options": "-nographic -enable-kvm -cpu host -machine q=
35 -smp cpus=3D2 -bios /usr/share/ovmf/OVMF.fd",
                    "platform": "x86_64",
                    "process_priority": "normal",
                    "qemu_path": "/usr/bin/qemu-system-x86_64",
                    "ram": 6144,
                    "usage": ""
```

The logs are:
- [execution log](https://github.com/GNS3/gns3-server/files/1381651/qemu.lo=
g.txt)
- [terminal log](https://github.com/GNS3/gns3-server/files/1381660/terminal=
.log.txt)

With the latest qemu, I can boot:
- Cisco IOSv 15.6(2)T
- Cisco IOSv-L2 15.2(20170321:233949)
- Cisco CSR 1000v 16.5.1b
- Cisco ASAv 9.6(2)

The major difference with NX-OSv 9k is the bios parameter: ```-bios /usr/sh=
are/ovmf/OVMF.fd```: =

```
ll /usr/share/ovmf/OVMF.fd
-rw-r--r-- 1 root root 2097152 Dec  9  2016 /usr/share/ovmf/OVMF.fd
```
A normal boot log with qemu 2.8.1 is available [here](https://github.com/GN=
S3/gns3-server/files/1381729/terminal.log.2.8.txt)

Highlighting the differences: qemu 2.8.1 on the left, qemu 2.10.1 on the ri=
ght hand side with the same boot parameters
![qemu 2 8 vs qemu 2 10](https://user-images.githubusercontent.com/13176858=
/31534998-8429462e-aff9-11e7-9cf3-bf2b00c21e8a.jpg)

** Affects: qemu
     Importance: Undecided
         Status: New

** Summary changed:

- Cisco NX-OSv 9k crashes during boot with latest qemu
+ Cisco NX-OSv 9k crashes during boot with qemu 2.10.1(Debian 1:2.10.0+dfsg=
-2)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1732679

Title:
  Cisco NX-OSv 9k crashes during boot with qemu 2.10.1(Debian
  1:2.10.0+dfsg-2)

Status in QEMU:
  New

Bug description:
  Ubuntu 17.04
  qemu 2.10.1(Debian 1:2.10.0+dfsg-2)
  gns3 2.0.3
  NX-OSv 9k 7.0.3.I6.1

  - No such issue with previous qemu 2.8.x
  - the issue does not seem to come from the debian packaging
  - the issue does not seem to come from GNS3 either, as confirmed by Jerem=
y Grossmann at https://github.com/GNS3/gns3-server/issues/1193#issuecomment=
-344240460

  Either some parameters usage have changed (for instance -bios) (which wou=
ld make qemu not backwards compatible) or there is an issue with qemu itsel=
f.
  The configuration parameters are:
  ```
                  "compute_id": "local",
                  "console": 2010,
                  "console_type": "telnet",
                  "first_port_name": "mgmt0",
                  "height": 48,
                  "label": {
                      "rotation": 0,
                      "style": "font-family: TypeWriter;font-size: 10.0;fon=
t-weight: bold;fill: #000000;fill-opacity: 1.0;",
                      "text": "NX_OSv_9k_Spine_31",
                      "x": -54,
                      "y": -25
                  },
                  "name": "NX_OSv_9k_Spine_31",
                  "node_id": "8d01119a-0adc-41bc-950b-c5639db7708c",
                  "node_type": "qemu",
                  "port_name_format": "Ethernet1/{port1}",
                  "port_segment_size": 0,
                  "properties": {
                      "acpi_shutdown": false,
                      "adapter_type": "e1000",
                      "adapters": 10,
                      "bios_image": "",
                      "bios_image_md5sum": null,
                      "boot_priority": "c",
                      "cdrom_image": "",
                      "cdrom_image_md5sum": null,
                      "cpu_throttling": 0,
                      "cpus": 2,
                      "hda_disk_image": "NX-OSv-9k-7.0.3.I6.1.free.qcow2",
                      "hda_disk_image_md5sum": "18bb991b814a508d1190575f99d=
eed99",
                      "hda_disk_interface": "ide",
                      "hdb_disk_image": "",
                      "hdb_disk_image_md5sum": null,
                      "hdb_disk_interface": "ide",
                      "hdc_disk_image": "",
                      "hdc_disk_image_md5sum": null,
                      "hdc_disk_interface": "ide",
                      "hdd_disk_image": "",
                      "hdd_disk_image_md5sum": null,
                      "hdd_disk_interface": "ide",
                      "initrd": "",
                      "initrd_md5sum": null,
                      "kernel_command_line": "",
                      "kernel_image": "",
                      "kernel_image_md5sum": null,
                      "legacy_networking": false,
                      "mac_address": "00:07:00:03:16:01",
                      "options": "-nographic -enable-kvm -cpu host -machine=
 q35 -smp cpus=3D2 -bios /usr/share/ovmf/OVMF.fd",
                      "platform": "x86_64",
                      "process_priority": "normal",
                      "qemu_path": "/usr/bin/qemu-system-x86_64",
                      "ram": 6144,
                      "usage": ""
  ```

  The logs are:
  - [execution log](https://github.com/GNS3/gns3-server/files/1381651/qemu.=
log.txt)
  - [terminal log](https://github.com/GNS3/gns3-server/files/1381660/termin=
al.log.txt)

  With the latest qemu, I can boot:
  - Cisco IOSv 15.6(2)T
  - Cisco IOSv-L2 15.2(20170321:233949)
  - Cisco CSR 1000v 16.5.1b
  - Cisco ASAv 9.6(2)

  The major difference with NX-OSv 9k is the bios parameter: ```-bios /usr/=
share/ovmf/OVMF.fd```: =

  ```
  ll /usr/share/ovmf/OVMF.fd
  -rw-r--r-- 1 root root 2097152 Dec  9  2016 /usr/share/ovmf/OVMF.fd
  ```
  A normal boot log with qemu 2.8.1 is available [here](https://github.com/=
GNS3/gns3-server/files/1381729/terminal.log.2.8.txt)

  Highlighting the differences: qemu 2.8.1 on the left, qemu 2.10.1 on the =
right hand side with the same boot parameters
  ![qemu 2 8 vs qemu 2 10](https://user-images.githubusercontent.com/131768=
58/31534998-8429462e-aff9-11e7-9cf3-bf2b00c21e8a.jpg)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1732679/+subscriptions
