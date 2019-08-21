Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD01C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D66822D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 14:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D66822D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0RRT-00086A-41
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1i0ROS-00068v-8D
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1i0ROH-0002D5-Io
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 10:15:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>)
 id 1i0RNu-00021K-SP; Wed, 21 Aug 2019 10:14:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDE452A09D4;
 Wed, 21 Aug 2019 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-35.brq.redhat.com
 [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF12960925;
 Wed, 21 Aug 2019 14:14:40 +0000 (UTC)
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 Andrew Jones <drjones@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVUEEwEC
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AlqVjq0FCQdCCrIACgkQJrNi5H/PIsFF1Qf+K23kB5iOvsbe/swQda9nJZSgKkbXLCF3KCdw
 jCY3qdneHzro696qosRhWn+tpLQ6Mp8sgnXuJk96qaptXtx0R1Ci2oHFo01WfcSLZ1f99/0q
 dWGWJhTt2TPNP6A5rrw//FZlQOYNTYG9vn7euLE0el32ZQp/0HCO7XpLiujEX48fWdlaPmDO
 nalJEpzzJJNu8WnHIG2eLS8lGrNdnPbkxHyeERxPuWDAmHmWyZSaDMtMd40XVKfLfkyY83jz
 +uq8uMxPMzq116YvFygsXqJPgWGYX39BdasEssr/GABHqgKY54dtTdMnFZZFVowkoCSh2Al/
 X/OSk5wpyYZrEYeKNLkBDQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABiQE8BBgBAgAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlqV
 j3sFCQdCC4AACgkQJrNi5H/PIsG+JAf/emslPCAW4gmn3Ep1ON0V0xPGxFOUbH2m+f079pVP
 Jo3dGT6ZFF8q00GEsqxjpxO/c0opsTFrAN3qyTS3Kr4435ua66J5eP+TBkjN+vljmRi3T9Xg
 h/dHp0JkZQCtcnmNsm/9F0/GzMvc7CnsptDp4aT0KGMfpvv7XrQOkprSr2wgWeAdNVhCP2ZQ
 y+yAzLmHe5OGPW1qPmIBBvEnU2C8av0ONGKIxIAUCF8UCm+YJzPwIwJLhkzrhANiqNwQXwfn
 j8HaEsOCIX26S4GYYmIaY1+GBeHkeh0R/GzERRPh6jfhg2JiCE6ftgZ+DKRjsK3o1uw40aYe
 s/q9jwLlkaqraQ==
Message-ID: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
Date: Wed, 21 Aug 2019 16:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IJ2W3dmtyzEfBaGNxTZlSEq492BFIAr2j"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 21 Aug 2019 14:14:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Broken aarch64 by qcow2: skip writing zero buffers to
 empty COW areas [v2]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IJ2W3dmtyzEfBaGNxTZlSEq492BFIAr2j
Content-Type: multipart/mixed; boundary="EYEE16o1OBUdy1wDEU3gIqP3xUcys3GRw";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 Andrew Jones <drjones@redhat.com>
Message-ID: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
Subject: Broken aarch64 by qcow2: skip writing zero buffers to empty COW areas
 [v2]

--EYEE16o1OBUdy1wDEU3gIqP3xUcys3GRw
Content-Type: multipart/mixed;
 boundary="------------6FF53884564E090C45E246C8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6FF53884564E090C45E246C8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello guys,

First attempt was rejected due to zip attachment, let's try it again with=
 just Avocado-vt debug.log and serial console log files attached.

I bisected a regression on aarch64 all the way to this commit: "qcow2: sk=
ip writing zero buffers to empty COW areas" c8bb23cbdbe32f5c326365e0a82e1=
b0e68cdcd8a. Would you please have a look at it?

My reproducer is running kickstart installation of RHEL-8 from DVD on aar=
ch64 gicv3 machine, which never finishes since this commit, where anacond=
a complains about package installation, occasionally there are also XFS m=
etadata corruption messages on serial console:


2019-08-18 19:36:11: =1B[22;1HInstalling check.aarch64 (359/1180)=1B[1;24=
r=1B[23;1H[  439.335155] XFS (dm-3): Metadata corruption detected at xfs_=
inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 xfs_inode_bu=
f_verify
2019-08-18 19:36:11: [  439.345295] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:36:11: [  439.349167] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:36:11: =1B[1;23r=1B[23;80H
2019-08-18 19:36:11: =1B[22;1HInstalling libidn.aarch64 (360/1180)=1B[1;2=
4r=1B[23;1H[  439.354063] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00  ................
2019-08-18 19:36:11: [  439.365513] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.371929] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.378175] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.384242] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.390603] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.396784] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.402838] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.409314] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:36:11: [  439.416866] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:36:12: [  440.341560] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[23;80H=1B[1;23r=1B[23;80H
2019-08-18 19:36:12:=20
2019-08-18 19:36:12: =1B[22;1H=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[23;1HError=1B[1;24r=1B[2=
3;6H[  440.371152] systemd-journald[1550]: Journal effective settings sea=
l=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.381579] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: =1B[1;23r=1B[23;80H
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12: =1B[18;1H   The following error occurred while insta=
lling.  This is a fatal error and
2019-08-18 19:36:12:    installation will be aborted.
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:    DNF error: Error unpacking rpm package libidn-1.3=
4-5.el8.aarch64=1B[23;1HPress ENTER to exit: =1B[1;24r=1B[23;22H[  440.40=
1675] systemd-journald[1550]: Journal effective settings seal=3Dyes compr=
ess=3Dyes compress_threshold_bytes=3D512B

It reproduces 100%, usually at different stage (different RPM package). W=
ith Avocado-vt you can reproduce it by putting RHEL-8 DVD image to RHEL.7=
=2Edevel iso location and executing something like this:

avocado --show all run --vt-guest-os RHEL.7.devel --vt-extra-params store=
_vm_register=3Dno take_regular_screendumps=3Dno monitor_type=3Dhuman --vt=
-qemu-bin /home/jenkins/aarch64/qemu-master-build/bin/qemu-system-aarch64=
 -- unattended_install.cdrom.extra_cdrom_ks.default_install.aio_threads

Note: I'm still using RHEL.7.devel profile although the provided DVD is R=
HEL8, it doesn't really matter
Note: The "--vt-extra-params" are workarounds of current issue where freq=
uent use of QMP monitor results in bad things on aarch64

But it should reproduce even without Avocado-vt. The used qemu cmd was:

MALLOC_PERTURB_=3D1  /home/jenkins/aarch64/qemu-master-build/bin/qemu-sys=
tem-aarch64 \
    -S  \
    -name 'avocado-vt-vm1'  \
    -sandbox off  \
    -drive file=3D/usr/share/AAVMF/AAVMF_CODE.fd,if=3Dpflash,format=3Draw=
,unit=3D0,readonly=3Don \
    -drive file=3D/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7=
devel-aarch64_AAVMF_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 \
    -machine virt,gic-version=3Dhost  \
    -nodefaults \
    -device virtio-gpu-pci,bus=3Dpcie.0,addr=3D0x1  \
    -chardev socket,id=3Dhmp_id_qmpmonitor1,path=3D/var/tmp/avocado_kurms=
dn9/monitor-qmpmonitor1-20190821-065917-I0T8uXz4,server,nowait \
    -mon chardev=3Dhmp_id_qmpmonitor1,mode=3Dreadline  \
    -chardev socket,id=3Dhmp_id_catch_monitor,path=3D/var/tmp/avocado_kur=
msdn9/monitor-catch_monitor-20190821-065917-I0T8uXz4,server,nowait \
    -mon chardev=3Dhmp_id_catch_monitor,mode=3Dreadline  \
    -serial unix:'/var/tmp/avocado_kurmsdn9/serial-serial0-20190821-06591=
7-I0T8uXz4',server,nowait \
    -device pcie-root-port,id=3Dpcie.0-root-port-2,slot=3D2,chassis=3D2,a=
ddr=3D0x2,bus=3Dpcie.0 \
    -device qemu-xhci,id=3Dusb1,bus=3Dpcie.0-root-port-2,addr=3D0x0 \
    -device pcie-root-port,id=3Dpcie.0-root-port-3,slot=3D3,chassis=3D3,a=
ddr=3D0x3,bus=3Dpcie.0 \
    -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpcie.0-root-port-=
3,addr=3D0x0 \
    -drive id=3Ddrive_image1,if=3Dnone,format=3Dqcow2,file=3D/var/lib/lib=
virt/images/avocado/avocado-vt/images/rhel7devel-aarch64.qcow2 \
    -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1 \
    -device pcie-root-port,id=3Dpcie.0-root-port-4,slot=3D4,chassis=3D4,a=
ddr=3D0x4,bus=3Dpcie.0 \
    -device virtio-net-pci,mac=3D9a:96:87:89:70:c0,rombar=3D0,id=3DidfUqV=
rx,netdev=3DidNvVkD7,bus=3Dpcie.0-root-port-4,addr=3D0x0  \
    -netdev tap,id=3DidNvVkD7,fd=3D20 \
    -m 4096  \
    -smp 2,maxcpus=3D2,cores=3D1,threads=3D1,sockets=3D2  \
    -cpu 'host' \
    -drive id=3Ddrive_cd1,if=3Dnone,media=3Dcdrom,file=3D/home/isos/RHEL-=
8.1.0-20190820.n.0-aarch64-dvd1.iso \
    -device scsi-cd,id=3Dcd1,drive=3Ddrive_cd1 \
    -drive id=3Ddrive_unattended,if=3Dnone,media=3Dcdrom,file=3D/var/lib/=
libvirt/images/avocado/avocado-vt/images/rhel7-64/ks.iso \
    -device scsi-cd,id=3Dunattended,drive=3Ddrive_unattended \
    -device usb-tablet,id=3Dusb-tablet1,bus=3Dusb1.0,port=3D1  \
    -kernel '/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7-aarc=
h64/vmlinuz'  \
    -append 'ks=3Dcdrom inst.sshd nicdelay=3D60  earlyprintk=3Dpl011,0x90=
00000 console=3DttyAMA0 debug ignore_loglevel rootwait'  \
    -initrd '/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7-aarc=
h64/initrd.img'  \
    -vnc :0  \
    -rtc base=3Dutc,clock=3Dhost \
    -enable-kvm \
    -device pcie-root-port,id=3Dpcie_extra_root_port_0,slot=3D5,chassis=3D=
5,addr=3D0x5,bus=3Dpcie.0 \
    -device pcie-root-port,id=3Dpcie_extra_root_port_1,slot=3D6,chassis=3D=
6,addr=3D0x6,bus=3Dpcie.0

But you should find all the required information in the attached file. It=
's worth mentioning that I haven't seen this issue on other architectures=
 (s390x, ppc64, ppc64le) and reproducibility is 100%.

Regards,
Luk=C3=A1=C5=A1

PS: During bisecting the metadata corruption was usually not there, so at=
taching excerpt of serial console obtained with the commit c8bb23cbdbe32f=
5c326365e0a82e1b0e68cdcd8a:

2019-08-21 07:04:57: ^[[22;1HInstalling kernel-devel.aarch64 (311/1190)^[=
[1;24r^[[23;1H
2019-08-21 07:05:23: [  346.780872] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:23: [  346.788877] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:23: [  346.796951] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:23: [  346.805247] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.250148] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.258148] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.270263] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.287159] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.295778] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.304047] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D^[[23;80H[  372.318162] systemd-journ=
ald[1558]: Journal effective settings seal=3Dyes compress=3Dyes compress_=
threshold_bytes=3D512B
2019-08-21 07:05:49: [  372.332918] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: ^[[1;23r^[[23;80H
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49:
2019-08-21 07:05:49: ^[[15;1H=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D^[[16;1HError^[[18;1H   The =
following error occurred while installing.  This is a fatal error and
2019-08-21 07:05:49:    installation will be aborted.
2019-08-21 07:05:49:
2019-08-21 07:05:49:    DNF error: Error in POSTIN scriptlet in rpm packa=
ge kernel-devel^[[1;24r^[[23;1H[  372.341178] systemd-journald[1558]: Jou=
rnal effective settings seal=3Dyes compress=3Dyes compress_threshold_byte=
s=3D512B
2019-08-21 07:05:49: [  372.371747] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:49: Press ENTER to exit:
2019-08-21 07:05:53: [  377.143065] systemd-coredump[2890]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-21 07:05:53: [  377.150559] systemd-coredump[2890]: Failed to get=
 EXE, ignoring: No such process
2019-08-21 07:05:53: [  377.200294] systemd-coredump[2892]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-21 07:05:53: [  377.207611] systemd-coredump[2892]: Failed to get=
 EXE, ignoring: No such process
2019-08-21 07:05:54: [  377.259821] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.267769] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.278325] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.286222] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.297440] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.307166] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.318449] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.326360] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.337852] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:54: [  377.346173] systemd-journald[1558]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-21 07:05:56: [  379.428425] systemd-coredump[2909]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-21 07:05:56: [  379.435753] systemd-coredump[2909]: Failed to get=
 EXE, ignoring: No such process
2019-08-21 07:05:57: [  380.880584] systemd-coredump[2919]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-21 07:05:57: [  380.887926] systemd-coredump[2919]: Failed to get=
 EXE, ignoring: No such process
2019-08-21 07:05:58: [  381.526076] systemd-coredump[2922]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-21 07:05:58: [  381.533709] systemd-coredump[2922]: Failed to get=
 EXE, ignoring: No such process

--------------6FF53884564E090C45E246C8
Content-Type: text/x-log;
 name="debug.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="debug.log"

19:28:25 INFO | Avocado-VT 'unknown'
19:28:25 DEBUG| Test parameters:
19:28:25 DEBUG|     _name_map_file =3D {'machines.cfg': 'arm64-pci', 'sub=
tests.cfg': '(subtest=3Dio-github-autotest-qemu).(subtest=3Dunattended_in=
stall).cdrom.extra_cdrom_ks.default_install.aio_threads', 'host-os.cfg': =
'Host.RHEL.m8.u1.Host_arch_aarch64', 'guest-os.cfg': 'Guest.Linux.RHEL.7.=
devel.aarch64', 'guest-hw.cfg': 'bridge.default_bios.no_virtio_rng.(image=
_backend=3Dfilesystem).no_9p_export.smallpages.no_pci_assignable.qcow2.vi=
rtio_scsi.smp2.virtio_net', 'tests.cfg': 'qemu_kvm_jeos_quick'}
19:28:25 DEBUG|     _short_name_map_file =3D {'machines.cfg': 'arm64-pci'=
, 'subtests.cfg': 'io-github-autotest-qemu.unattended_install.cdrom.extra=
_cdrom_ks.default_install.aio_threads', 'host-os.cfg': 'Host.RHEL.m8.u1.H=
ost_arch_aarch64', 'guest-os.cfg': 'Guest.Linux.RHEL.7.devel.aarch64', 'g=
uest-hw.cfg': 'bridge.default_bios.no_virtio_rng.filesystem.no_9p_export.=
smallpages.no_pci_assignable.qcow2.virtio_scsi.smp2.virtio_net', 'tests.c=
fg': 'qemu_kvm_jeos_quick'}
19:28:25 DEBUG|     auto_cpu_model =3D no
19:28:25 DEBUG|     automem =3D no
19:28:25 DEBUG|     backup_dir =3D images/
19:28:25 DEBUG|     backup_image =3D no
19:28:25 DEBUG|     backup_image_after_testing_passed =3D yes
19:28:25 DEBUG|     backup_image_before_testing =3D yes
19:28:25 DEBUG|     backup_image_on_check_error =3D no
19:28:25 DEBUG|     boot_menu =3D off
19:28:25 DEBUG|     boot_once =3D d
19:28:25 DEBUG|     boot_order =3D cdn
19:28:25 DEBUG|     boot_path =3D images/pxeboot
19:28:25 DEBUG|     catch_monitor =3D catch_monitor
19:28:25 DEBUG|     cd_format =3D scsi-cd
19:28:25 DEBUG|     cdrom_cd1 =3D isos/linux/RHEL-7-devel-aarch64.iso
19:28:25 DEBUG|     cdrom_check_cdrom_pattern =3D /dev/cdrom-\w+|/dev/cdr=
om\d*
19:28:25 DEBUG|     cdrom_get_cdrom_cmd =3D ls /dev/cdrom*
19:28:25 DEBUG|     cdrom_info_cmd =3D cat /proc/sys/dev/cdrom/info
19:28:25 DEBUG|     cdrom_test_cmd =3D dd if=3D%s of=3D/dev/null bs=3D1 c=
ount=3D1
19:28:25 DEBUG|     cdrom_unattended =3D images/rhel7-64/ks.iso
19:28:25 DEBUG|     cdroms =3D cd1 unattended
19:28:25 DEBUG|     check_image =3D yes
19:28:25 DEBUG|     cmds_installed_host =3D=20
19:28:25 DEBUG|     connect_uri =3D default
19:28:25 DEBUG|     convert_ppm_files_to_png =3D no
19:28:25 DEBUG|     cpu_chk_all_cmd =3D lscpu | grep "^CPU(s)" | grep -o =
"[0-9]*"
19:28:25 DEBUG|     cpu_chk_cmd =3D grep -c "^processor\b" /proc/cpuinfo
19:28:25 DEBUG|     cpu_model =3D host
19:28:25 DEBUG|     cpu_model_flags =3D=20
19:28:25 DEBUG|     create_vm_libvirt =3D no
19:28:25 DEBUG|     dep =3D []
19:28:25 DEBUG|     display =3D vnc
19:28:25 DEBUG|     download_url_stress =3D http://people.seas.harvard.ed=
u/~apw/stress/stress-1.0.4.tar.gz
19:28:25 DEBUG|     drive_format =3D scsi-hd
19:28:25 DEBUG|     drive_index_cd1 =3D 2
19:28:25 DEBUG|     drive_index_image1 =3D 0
19:28:25 DEBUG|     drive_index_unattended =3D 1
19:28:25 DEBUG|     drive_rerror_image1 =3D=20
19:28:25 DEBUG|     drive_werror_image1 =3D=20
19:28:25 DEBUG|     enable_guest_sosreport =3D no
19:28:25 DEBUG|     enable_host_sosreport =3D no
19:28:25 DEBUG|     enable_libvirtd_debug_log =3D yes
19:28:25 DEBUG|     enable_msix_vectors =3D yes
19:28:25 DEBUG|     enable_remote_host_sosreport =3D no
19:28:25 DEBUG|     encode_video_files =3D yes
19:28:25 DEBUG|     env_cleanup =3D no
19:28:25 DEBUG|     file_transfer_client =3D scp
19:28:25 DEBUG|     file_transfer_port =3D 22
19:28:25 DEBUG|     flexible_nic_index =3D no
19:28:25 DEBUG|     force_create_image =3D yes
19:28:25 DEBUG|     grub_file =3D /boot/grub/grub.conf
19:28:25 DEBUG|     guest_dmesg_dump_console =3D no
19:28:25 DEBUG|     guest_dmesg_ignore =3D False
19:28:25 DEBUG|     guest_dmesg_level =3D 3
19:28:25 DEBUG|     guest_port_remote_shell =3D 22
19:28:25 DEBUG|     guest_port_unattended_install =3D 12323
19:28:25 DEBUG|     id =3D io-github-autotest-qemu.unattended_install.cdr=
om.extra_cdrom_ks.default_install.aio_threads
19:28:25 DEBUG|     image_aio =3D threads
19:28:25 DEBUG|     image_backend =3D filesystem
19:28:25 DEBUG|     image_chain =3D=20
19:28:25 DEBUG|     image_clone_command =3D cp --reflink=3Dauto %s %s
19:28:25 DEBUG|     image_copy_on_error =3D no
19:28:25 DEBUG|     image_format =3D qcow2
19:28:25 DEBUG|     image_name =3D images/rhel7devel-aarch64
19:28:25 DEBUG|     image_raw_device =3D no
19:28:25 DEBUG|     image_remove_command =3D rm -rf %s
19:28:25 DEBUG|     image_size =3D 10G
19:28:25 DEBUG|     image_unbootable_pattern =3D Hard Disk.*not a bootabl=
e disk
19:28:25 DEBUG|     image_verify_bootable =3D no
19:28:25 DEBUG|     images =3D image1
19:28:25 DEBUG|     inactivity_treshold =3D 1800
19:28:25 DEBUG|     inactivity_watcher =3D error
19:28:25 DEBUG|     indirect_image_blacklist =3D /dev/hda[\d]* /dev/sda[\=
d]* /dev/sg0 /dev/md0
19:28:25 DEBUG|     initrd =3D images/rhel7-aarch64/initrd.img
19:28:25 DEBUG|     inputs =3D=20
19:28:25 DEBUG|     install_timeout =3D 7200
19:28:25 DEBUG|     install_trigger_time =3D 0
19:28:25 DEBUG|     install_virtio =3D no
19:28:25 DEBUG|     keep_ppm_files =3D no
19:28:25 DEBUG|     keep_ppm_files_on_error =3D no
19:28:25 DEBUG|     keep_screendumps =3D yes
19:28:25 DEBUG|     keep_screendumps_on_error =3D yes
19:28:25 DEBUG|     keep_video_files =3D yes
19:28:25 DEBUG|     keep_video_files_on_error =3D yes
19:28:25 DEBUG|     kernel =3D images/rhel7-aarch64/vmlinuz
19:28:25 DEBUG|     kernel_params =3D ks=3Dcdrom inst.sshd nicdelay=3D60 =
 earlyprintk=3Dpl011,0x9000000 console=3DttyAMA0 debug ignore_loglevel ro=
otwait
19:28:25 DEBUG|     kickstart_reboot_bug =3D no
19:28:25 DEBUG|     kill_timeout =3D 60
19:28:25 DEBUG|     kill_unresponsive_vms =3D yes
19:28:25 DEBUG|     kill_vm =3D yes
19:28:25 DEBUG|     kill_vm_before_test =3D no
19:28:25 DEBUG|     kill_vm_gracefully =3D yes
19:28:25 DEBUG|     kill_vm_libvirt =3D no
19:28:25 DEBUG|     kill_vm_on_error =3D yes
19:28:25 DEBUG|     libvirt_controller =3D virtio-scsi
19:28:25 DEBUG|     libvirtd_debug_file =3D=20
19:28:25 DEBUG|     libvirtd_debug_level =3D 2
19:28:25 DEBUG|     libvirtd_log_cleanup =3D yes
19:28:25 DEBUG|     local_ip =3D ENTER.YOUR.LOCAL.EXAMPLE.COM
19:28:25 DEBUG|     local_pwd =3D=20
19:28:25 DEBUG|     login_timeout =3D 360
19:28:25 DEBUG|     lowest_mem =3D 512
19:28:25 DEBUG|     machine_type =3D arm64-pci:virt
19:28:25 DEBUG|     machine_type_extra_params =3D gic-version=3Dhost
19:28:25 DEBUG|     main_vm =3D avocado-vt-vm1
19:28:25 DEBUG|     malloc_perturb =3D yes
19:28:25 DEBUG|     medium =3D cdrom
19:28:25 DEBUG|     mem =3D 4096
19:28:25 DEBUG|     mem_chk_cmd =3D dmidecode -t 17 | awk -F: '/Size/ {pr=
int $2}'
19:28:25 DEBUG|     mem_chk_cur_cmd =3D grep MemTotal /proc/meminfo
19:28:25 DEBUG|     mem_chk_re_str =3D [^\$]([0-9]+)
19:28:25 DEBUG|     memballoon_model =3D virtio
19:28:25 DEBUG|     migrate_dest_host =3D ENTER.YOUR.DEST.EXAMPLE.COM
19:28:25 DEBUG|     migrate_dest_pwd =3D PASSWORD.DEST.EXAMPLE
19:28:25 DEBUG|     migrate_load_vms =3D=20
19:28:25 DEBUG|     migrate_main_vm =3D avocado-vt-vm1
19:28:25 DEBUG|     migrate_port =3D 49152
19:28:25 DEBUG|     migrate_proto =3D tcp
19:28:25 DEBUG|     migrate_shared_storage =3D SHARED_IMAGE.EXAMPLE
19:28:25 DEBUG|     migrate_source_host =3D ENTER.YOUR.SOURCE.EXAMPLE.COM=

19:28:25 DEBUG|     migrate_source_pwd =3D PASSWORD.SOURCE.EXAMPLE
19:28:25 DEBUG|     migrate_vms =3D=20
19:28:25 DEBUG|     migration_setup =3D no
19:28:25 DEBUG|     monitor_type =3D human
19:28:25 DEBUG|     monitors =3D qmpmonitor1
19:28:25 DEBUG|     name =3D qemu_kvm_jeos_quick.bridge.default_bios.no_v=
irtio_rng.(image_backend=3Dfilesystem).no_9p_export.smallpages.no_pci_ass=
ignable.qcow2.virtio_scsi.smp2.virtio_net.Guest.Linux.RHEL.7.devel.aarch6=
4.Host.RHEL.m8.u1.Host_arch_aarch64.(subtest=3Dio-github-autotest-qemu).(=
subtest=3Dunattended_install).cdrom.extra_cdrom_ks.default_install.aio_th=
reads.arm64-pci
19:28:25 DEBUG|     netdev_peer_re =3D \s{2,}(.*?): .*?\\\s(.*?):
19:28:25 DEBUG|     netdst =3D virbr0
19:28:25 DEBUG|     nettype =3D bridge
19:28:25 DEBUG|     nic_model =3D virtio
19:28:25 DEBUG|     nics =3D nic1
19:28:25 DEBUG|     os_type =3D linux
19:28:25 DEBUG|     os_variant =3D rhel7
19:28:25 DEBUG|     other_tests_dirs =3D=20
19:28:25 DEBUG|     password =3D 123456
19:28:25 DEBUG|     paused_after_start_vm =3D no
19:28:25 DEBUG|     pci_assignable =3D no
19:28:25 DEBUG|     pcie_extra_root_port =3D 2
19:28:25 DEBUG|     ping_pong =3D 5
19:28:25 DEBUG|     profilers =3D kvm_stat
19:28:25 DEBUG|     provider =3D io-github-autotest-qemu
19:28:25 DEBUG|     qemu_binary =3D /home/jenkins/aarch64/qemu-master-bui=
ld/bin/qemu-system-aarch64
19:28:25 DEBUG|     qemu_dst_binary =3D /home/jenkins/aarch64/qemu-master=
-build/bin/qemu-system-aarch64
19:28:25 DEBUG|     qemu_img_binary =3D /home/jenkins/aarch64/qemu-master=
-build/bin/qemu-img
19:28:25 DEBUG|     qemu_io_binary =3D /home/jenkins/aarch64/qemu-master-=
build/bin/qemu-io
19:28:25 DEBUG|     qemu_sandbox =3D=20
19:28:25 DEBUG|     qemu_stop =3D on
19:28:25 DEBUG|     random_trigger =3D no
19:28:25 DEBUG|     reboot_command =3D shutdown -r now
19:28:25 DEBUG|     redirs =3D remote_shell unattended_install
19:28:25 DEBUG|     remote_ip =3D ENTER.YOUR.REMOTE.EXAMPLE.COM
19:28:25 DEBUG|     remote_pwd =3D=20
19:28:25 DEBUG|     remote_user =3D root
19:28:25 DEBUG|     remove_image_image1 =3D no
19:28:25 DEBUG|     restore_image =3D no
19:28:25 DEBUG|     restore_image_after_testing =3D yes
19:28:25 DEBUG|     restore_image_on_check_error =3D no
19:28:25 DEBUG|     rpmbuild_path =3D /root/rpmbuild/
19:28:25 DEBUG|     run_tcpdump =3D yes
19:28:25 DEBUG|     screendump_delay =3D 5
19:28:25 DEBUG|     screendump_quality =3D 30
19:28:25 DEBUG|     screendump_temp_dir =3D /dev/shm
19:28:25 DEBUG|     screendump_verbose =3D no
19:28:25 DEBUG|     scsi_hba =3D virtio-scsi-pci
19:28:25 DEBUG|     serial_type =3D isa-serial
19:28:25 DEBUG|     serials =3D serial0
19:28:25 DEBUG|     shell_client =3D ssh
19:28:25 DEBUG|     shell_linesep =3D \n
19:28:25 DEBUG|     shell_port =3D 22
19:28:25 DEBUG|     shell_prompt =3D ^\[.*\][\#\$]\s*$
19:28:25 DEBUG|     shortname =3D qcow2.virtio_scsi.smp2.virtio_net.Guest=
=2ERHEL.7.devel.aarch64.io-github-autotest-qemu.unattended_install.cdrom.=
extra_cdrom_ks.default_install.aio_threads.arm64-pci
19:28:25 DEBUG|     shutdown_cleanly =3D yes
19:28:25 DEBUG|     shutdown_cleanly_timeout =3D 120
19:28:25 DEBUG|     shutdown_command =3D shutdown -h now
19:28:25 DEBUG|     skip_cluster_leak_warn =3D no
19:28:25 DEBUG|     skip_image_check_during_running =3D no
19:28:25 DEBUG|     skip_image_processing =3D no
19:28:25 DEBUG|     smp =3D 2
19:28:25 DEBUG|     start_vm =3D no
19:28:25 DEBUG|     status_test_command =3D echo $?
19:28:25 DEBUG|     store_vm_register =3D no
19:28:25 DEBUG|     stress_args =3D --cpu 4 --io 4 --vm 2 --vm-bytes 256M=

19:28:25 DEBUG|     stress_install_from_repo =3D no
19:28:25 DEBUG|     strict_mode =3D no
19:28:25 DEBUG|     subtest =3D io-github-autotest-qemu.unattended_instal=
l
19:28:25 DEBUG|     syslog_server_enabled =3D no
19:28:25 DEBUG|     syslog_server_proto =3D udp
19:28:25 DEBUG|     sysprep_options =3D --operations machine-id
19:28:25 DEBUG|     sysprep_required =3D no
19:28:25 DEBUG|     take_regular_screendumps =3D no
19:28:25 DEBUG|     test_timeout =3D 14400
19:28:25 DEBUG|     type =3D unattended_install
19:28:25 DEBUG|     unattended_delivery_method =3D cdrom
19:28:25 DEBUG|     unattended_file =3D unattended/RHEL-7-devel.ks
19:28:25 DEBUG|     unattended_file_kernel_param_name =3D ks
19:28:25 DEBUG|     url =3D http://download.devel.redhat.com/composes/fin=
ished/latest-RHEL-8/compose/BaseOS/aarch64/os/
19:28:25 DEBUG|     url_auto_ip =3D=20
19:28:25 DEBUG|     usb_bus =3D usb1.0
19:28:25 DEBUG|     usb_controller =3D xhci
19:28:25 DEBUG|     usb_devices =3D tablet1
19:28:25 DEBUG|     usb_max_port =3D 6
19:28:25 DEBUG|     usb_type =3D qemu-xhci
19:28:25 DEBUG|     usb_type_tablet1 =3D usb-tablet
19:28:25 DEBUG|     usb_type_usb1 =3D qemu-xhci
19:28:25 DEBUG|     usbs =3D usb1
19:28:25 DEBUG|     use_autostart =3D no
19:28:25 DEBUG|     use_check_cpu =3D yes
19:28:25 DEBUG|     use_debug =3D yes
19:28:25 DEBUG|     use_no_reboot =3D no
19:28:25 DEBUG|     use_os_type =3D yes
19:28:25 DEBUG|     use_os_variant =3D no
19:28:25 DEBUG|     use_virt_install_wait =3D no
19:28:25 DEBUG|     used_cpus =3D 2
19:28:25 DEBUG|     used_mem =3D 512
19:28:25 DEBUG|     username =3D root
19:28:25 DEBUG|     verify_guest_dmesg =3D yes
19:28:25 DEBUG|     verify_host_dmesg =3D yes
19:28:25 DEBUG|     vfd_size =3D 1440k
19:28:25 DEBUG|     vga =3D virtio
19:28:25 DEBUG|     vga_use_legacy_expression =3D no
19:28:25 DEBUG|     vir_domain_undefine_nvram =3D yes
19:28:25 DEBUG|     virt_install_wait_time =3D 300
19:28:25 DEBUG|     virt_test_type =3D qemu libvirt
19:28:25 DEBUG|     virtinstall_extra_args =3D=20
19:28:25 DEBUG|     vm_arch_name =3D aarch64
19:28:25 DEBUG|     vm_mem_minimum =3D 2G
19:28:25 DEBUG|     vm_monitor_exit_status =3D no
19:28:25 DEBUG|     vm_register_delay =3D 5
19:28:25 DEBUG|     vm_type =3D qemu
19:28:25 DEBUG|     vms =3D avocado-vt-vm1
19:28:25 DEBUG|     vnc_autoport =3D yes
19:28:25 DEBUG| Searching for test modules that match 'type =3D unattende=
d_install' and 'provider =3D io-github-autotest-qemu' on this cartesian d=
ict
19:28:25 DEBUG| Found subtest module /var/lib/libvirt/images/avocado/avoc=
ado-vt/test-providers.d/downloads/io-github-autotest-qemu/generic/tests/u=
nattended_install.py
19:28:27 DEBUG| KVM version: 4.18.0-134.el8.aarch64
19:28:29 DEBUG| KVM userspace version(qemu): 4.1.50 (v4.1.0-132-gafd76053=
93-dirty)
19:28:29 INFO | Running 'true'
19:28:29 INFO | Command 'true' finished with 0 after 0.001523017883300781=
2s
19:28:29 INFO | Running 'ps -o comm 1'
19:28:29 DEBUG| [stdout] COMMAND
19:28:29 INFO | Command 'ps -o comm 1' finished with 0 after 0.0556919574=
7375488s
19:28:29 DEBUG| [stdout] systemd
19:28:29 INFO | Checking disk size on /var/lib/libvirt/images/avocado/avo=
cado-vt/images.
19:28:29 DEBUG| Image backup /var/lib/libvirt/images/avocado/avocado-vt/i=
mages/rhel7devel-aarch64.qcow2.backup already exists, skipping...
19:28:29 INFO | Create image on local fs.
19:28:29 INFO | Context: preprocessing --> Create image by command: /home=
/jenkins/aarch64/qemu-master-build/bin/qemu-img create -f qcow2 /var/lib/=
libvirt/images/avocado/avocado-vt/images/rhel7devel-aarch64.qcow2 10G
19:28:30 INFO | Starting unattended install setup
19:28:30 DEBUG| Automatically chosen class for iso9660: isoinfo
19:28:30 INFO | Running 'isoinfo -i /var/lib/libvirt/images/avocado/avoca=
do-vt/isos/linux/RHEL-7-devel-aarch64.iso -d'
19:28:30 DEBUG| [stdout] CD-ROM is in ISO 9660 format
19:28:30 INFO | Command 'isoinfo -i /var/lib/libvirt/images/avocado/avoca=
do-vt/isos/linux/RHEL-7-devel-aarch64.iso -d' finished with 0 after 0.002=
3012161254882812s
19:28:30 DEBUG| [stdout] System id: LINUX
19:28:30 DEBUG| [stdout] Volume id: RHEL-8-0-0-BaseOS-aarch64
19:28:30 DEBUG| [stdout] Volume set id:=20
19:28:30 DEBUG| [stdout] Publisher id:=20
19:28:30 DEBUG| [stdout] Data preparer id:=20
19:28:30 DEBUG| [stdout] Application id: GENISOIMAGE ISO 9660/HFS FILESYS=
TEM CREATOR (C) 1993 E.YOUNGDALE (C) 1997-2006 J.PEARSON/J.SCHILLING (C) =
2006-2007 CDRKIT TEAM
19:28:30 DEBUG| [stdout] Copyright File id:=20
19:28:30 DEBUG| [stdout] Abstract File id:=20
19:28:30 DEBUG| [stdout] Bibliographic File id:=20
19:28:30 DEBUG| [stdout] Volume set size is: 1
19:28:30 DEBUG| [stdout] Volume set sequence number is: 1
19:28:30 DEBUG| [stdout] Logical block size is: 2048
19:28:30 DEBUG| [stdout] Volume size is: 2511949
19:28:30 DEBUG| [stdout] El Torito VD version 1 found, boot catalog is in=
 sector 795
19:28:30 DEBUG| [stdout] Joliet with UCS level 3 found
19:28:30 DEBUG| [stdout] Rock Ridge signatures version 1 found
19:28:30 DEBUG| [stdout] Eltorito validation header:
19:28:30 DEBUG| [stdout]     Hid 1
19:28:30 DEBUG| [stdout]     Arch 239 (Unknown Arch)
19:28:30 DEBUG| [stdout]     ID ''
19:28:30 DEBUG| [stdout]     Key 55 AA
19:28:30 DEBUG| [stdout]     Eltorito defaultboot header:
19:28:30 DEBUG| [stdout]         Bootid 88 (bootable)
19:28:30 DEBUG| [stdout]         Boot media 0 (No Emulation Boot)
19:28:30 DEBUG| [stdout]         Load segment 0
19:28:30 DEBUG| [stdout]         Sys type 0
19:28:30 DEBUG| [stdout]         Nsect 32CC
19:28:30 DEBUG| [stdout]         Bootoff EE7 3815
19:28:32 INFO | Running 'cat /proc/mounts'
19:28:32 DEBUG| [stdout] sysfs /sys sysfs rw,seclabel,nosuid,nodev,noexec=
,relatime 0 0
19:28:32 INFO | Command 'cat /proc/mounts' finished with 0 after 0.005123=
138427734375s
19:28:32 DEBUG| [stdout] proc /proc proc rw,nosuid,nodev,noexec,relatime =
0 0
19:28:32 DEBUG| [stdout] devtmpfs /dev devtmpfs rw,seclabel,nosuid,size=3D=
33202560k,nr_inodes=3D518790,mode=3D755 0 0
19:28:32 DEBUG| [stdout] securityfs /sys/kernel/security securityfs rw,no=
suid,nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] tmpfs /dev/shm tmpfs rw,seclabel,nosuid,nodev 0 =
0
19:28:32 DEBUG| [stdout] devpts /dev/pts devpts rw,seclabel,nosuid,noexec=
,relatime,gid=3D5,mode=3D620,ptmxmode=3D000 0 0
19:28:32 DEBUG| [stdout] tmpfs /run tmpfs rw,seclabel,nosuid,nodev,mode=3D=
755 0 0
19:28:32 DEBUG| [stdout] tmpfs /sys/fs/cgroup tmpfs ro,seclabel,nosuid,no=
dev,noexec,mode=3D755 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/systemd cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,xattr,release_agent=3D/usr/lib/systemd/syst=
emd-cgroups-agent,name=3Dsystemd 0 0
19:28:32 DEBUG| [stdout] pstore /sys/fs/pstore pstore rw,seclabel,nosuid,=
nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] efivarfs /sys/firmware/efi/efivars efivarfs rw,n=
osuid,nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relat=
ime,mode=3D700 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/net_cls,net_prio cgroup rw=
,seclabel,nosuid,nodev,noexec,relatime,net_cls,net_prio 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/memory cgroup rw,seclabel,=
nosuid,nodev,noexec,relatime,memory 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/devices cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,devices 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/cpu,cpuacct cgroup rw,secl=
abel,nosuid,nodev,noexec,relatime,cpu,cpuacct 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/freezer cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,freezer 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/perf_event cgroup rw,secla=
bel,nosuid,nodev,noexec,relatime,perf_event 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/blkio cgroup rw,seclabel,n=
osuid,nodev,noexec,relatime,blkio 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/cpuset cgroup rw,seclabel,=
nosuid,nodev,noexec,relatime,cpuset 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/rdma cgroup rw,seclabel,no=
suid,nodev,noexec,relatime,rdma 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/pids cgroup rw,seclabel,no=
suid,nodev,noexec,relatime,pids 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/hugetlb cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,hugetlb 0 0
19:28:32 DEBUG| [stdout] configfs /sys/kernel/config configfs rw,relatime=
 0 0
19:28:32 DEBUG| [stdout] /dev/mapper/rhel_gigabyte--r120--15-root / xfs r=
w,seclabel,relatime,attr2,inode64,noquota 0 0
19:28:32 DEBUG| [stdout] selinuxfs /sys/fs/selinux selinuxfs rw,relatime =
0 0
19:28:32 DEBUG| [stdout] systemd-1 /proc/sys/fs/binfmt_misc autofs rw,rel=
atime,fd=3D46,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direct,pipe_=
ino=3D1225 0 0
19:28:32 DEBUG| [stdout] debugfs /sys/kernel/debug debugfs rw,seclabel,re=
latime 0 0
19:28:32 DEBUG| [stdout] mqueue /dev/mqueue mqueue rw,seclabel,relatime 0=
 0
19:28:32 DEBUG| [stdout] hugetlbfs /dev/hugepages hugetlbfs rw,seclabel,r=
elatime,pagesize=3D512M 0 0
19:28:32 DEBUG| [stdout] /dev/sda2 /boot xfs rw,seclabel,relatime,attr2,i=
node64,noquota 0 0
19:28:32 DEBUG| [stdout] /dev/sda1 /boot/efi vfat rw,relatime,fmask=3D007=
7,dmask=3D0077,codepage=3D437,iocharset=3Dascii,shortname=3Dwinnt,errors=3D=
remount-ro 0 0
19:28:32 DEBUG| [stdout] /dev/mapper/rhel_gigabyte--r120--15-home /home x=
fs rw,seclabel,relatime,attr2,inode64,noquota 0 0
19:28:32 DEBUG| [stdout] sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw,rel=
atime 0 0
19:28:32 DEBUG| [stdout] tmpfs /run/user/0 tmpfs rw,seclabel,nosuid,nodev=
,relatime,size=3D6643392k,mode=3D700 0 0
19:28:32 DEBUG| [stdout] binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc=
 rw,relatime 0 0
19:28:32 DEBUG| Unattended install contents:
19:28:32 DEBUG| install
19:28:32 DEBUG| cdrom
19:28:32 DEBUG| text
19:28:32 DEBUG| poweroff
19:28:32 DEBUG| lang en_US.UTF-8
19:28:32 DEBUG| keyboard us
19:28:32 DEBUG| network --onboot yes --device eth0 --bootproto dhcp
19:28:32 DEBUG| rootpw --plaintext 123456
19:28:32 DEBUG| firstboot --disable
19:28:32 DEBUG| user --name=3Dtest --password=3D123456
19:28:32 DEBUG| firewall --enabled --ssh
19:28:32 DEBUG| selinux --enforcing
19:28:32 DEBUG| timezone --utc America/New_York
19:28:32 DEBUG| bootloader --location=3Dmbr --append=3D"console=3Dtty0 co=
nsole=3DttyS0,115200"
19:28:32 DEBUG| zerombr
19:28:32 DEBUG|=20
19:28:32 DEBUG| clearpart --all --initlabel
19:28:32 DEBUG| autopart
19:28:32 DEBUG| xconfig --startxonboot
19:28:32 DEBUG|=20
19:28:32 DEBUG| %packages --ignoremissing
19:28:32 DEBUG| @base
19:28:32 DEBUG| @core
19:28:32 DEBUG| @development
19:28:32 DEBUG| @additional-devel
19:28:32 DEBUG| @debugging
19:28:32 DEBUG| @network-tools
19:28:32 DEBUG| @x11
19:28:32 DEBUG| @gnome-desktop
19:28:32 DEBUG| @fonts
19:28:32 DEBUG| @smart-card
19:28:32 DEBUG| gnome-utils
19:28:32 DEBUG| python-imaging
19:28:32 DEBUG| python-six
19:28:32 DEBUG| pyparsing
19:28:32 DEBUG| net-tools
19:28:32 DEBUG| NetworkManager
19:28:32 DEBUG| ntpdate
19:28:32 DEBUG| dconf
19:28:32 DEBUG| watchdog
19:28:32 DEBUG| coreutils
19:28:32 DEBUG| usbutils
19:28:32 DEBUG| spice-xpi
19:28:32 DEBUG| spice-gtk3
19:28:32 DEBUG| docbook-utils
19:28:32 DEBUG| sgml-common
19:28:32 DEBUG| openjade
19:28:32 DEBUG| virt-viewer
19:28:32 DEBUG| pulseaudio-libs-devel
19:28:32 DEBUG| mesa-libGL-devel
19:28:32 DEBUG| pygtk2-devel
19:28:32 DEBUG| libjpeg-turbo-devel
19:28:32 DEBUG| spice-vdagent
19:28:32 DEBUG| usbredir
19:28:32 DEBUG| SDL
19:28:32 DEBUG| totem
19:28:32 DEBUG| dmidecode
19:28:32 DEBUG| alsa-utils
19:28:32 DEBUG| sg3_utils
19:28:32 DEBUG| -gnome-initial-setup
19:28:32 DEBUG| %end
19:28:32 DEBUG|=20
19:28:32 DEBUG| %post
19:28:32 DEBUG| # Output to all consoles defined in /proc/consoles, use "=
major:minor" as
19:28:32 DEBUG| # device names are unreliable on some platforms
19:28:32 DEBUG| # https://bugzilla.redhat.com/show_bug.cgi?id=3D1351968
19:28:32 DEBUG| function ECHO { for TTY in `cat /proc/consoles | awk '{pr=
int $NF}'`; do source "/sys/dev/char/$TTY/uevent" && echo "$*" > /dev/$DE=
VNAME; done }
19:28:32 DEBUG| ECHO "OS install is completed"
19:28:32 DEBUG| ECHO "remove rhgb quiet by grubby"
19:28:32 DEBUG| grubby --remove-args=3D"rhgb quiet" --update-kernel=3D$(g=
rubby --default-kernel)
19:28:32 DEBUG| ECHO "dhclient"
19:28:32 DEBUG| dhclient
19:28:32 DEBUG| ECHO "chkconfig sshd on"
19:28:32 DEBUG| chkconfig sshd on
19:28:32 DEBUG| ECHO "iptables -F"
19:28:32 DEBUG| iptables -F
19:28:32 DEBUG| ECHO "echo 0 > selinux/enforce"
19:28:32 DEBUG| echo 0 > /selinux/enforce
19:28:32 DEBUG| ECHO "chkconfig NetworkManager on"
19:28:32 DEBUG| chkconfig NetworkManager on
19:28:32 DEBUG| ECHO "update ifcfg-eth0"
19:28:32 DEBUG| sed -i "/^HWADDR/d" /etc/sysconfig/network-scripts/ifcfg-=
eth0
19:28:32 DEBUG| ECHO "Disable lock cdrom udev rules"
19:28:32 DEBUG| sed -i "/--lock-media/s/^/#/" /usr/lib/udev/rules.d/60-cd=
rom_id.rules 2>/dev/null>&1
19:28:32 DEBUG| #Workaround for graphical boot as anaconda seems to alway=
s instert skipx
19:28:32 DEBUG| systemctl set-default graphical.target
19:28:32 DEBUG| sed -i "/^HWADDR/d" /etc/sysconfig/network-scripts/ifcfg-=
*
19:28:32 DEBUG| sed -i "s/ONBOOT=3Dno/ONBOOT=3Dyes/" /etc/sysconfig/netwo=
rk-scripts/ifcfg-*
19:28:32 DEBUG| cat > '/etc/gdm/custom.conf' << EOF
19:28:32 DEBUG| [daemon]
19:28:32 DEBUG| AutomaticLogin=3Dtest
19:28:32 DEBUG| AutomaticLoginEnable=3DTrue
19:28:32 DEBUG| EOF
19:28:32 DEBUG| cat >> '/etc/sudoers' << EOF
19:28:32 DEBUG| test ALL =3D NOPASSWD: /sbin/shutdown -r now,/sbin/shutdo=
wn -h now
19:28:32 DEBUG| EOF
19:28:32 DEBUG| cat >> '/home/test/.bashrc' << EOF
19:28:32 DEBUG| alias shutdown=3D'sudo shutdown'
19:28:32 DEBUG| EOF
19:28:32 DEBUG| ECHO 'Post set up finished'
19:28:32 DEBUG| %end
19:28:32 INFO | Running 'cat /proc/mounts'
19:28:32 DEBUG| [stdout] sysfs /sys sysfs rw,seclabel,nosuid,nodev,noexec=
,relatime 0 0
19:28:32 INFO | Command 'cat /proc/mounts' finished with 0 after 0.004851=
341247558594s
19:28:32 DEBUG| [stdout] proc /proc proc rw,nosuid,nodev,noexec,relatime =
0 0
19:28:32 DEBUG| [stdout] devtmpfs /dev devtmpfs rw,seclabel,nosuid,size=3D=
33202560k,nr_inodes=3D518790,mode=3D755 0 0
19:28:32 DEBUG| [stdout] securityfs /sys/kernel/security securityfs rw,no=
suid,nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] tmpfs /dev/shm tmpfs rw,seclabel,nosuid,nodev 0 =
0
19:28:32 DEBUG| [stdout] devpts /dev/pts devpts rw,seclabel,nosuid,noexec=
,relatime,gid=3D5,mode=3D620,ptmxmode=3D000 0 0
19:28:32 DEBUG| [stdout] tmpfs /run tmpfs rw,seclabel,nosuid,nodev,mode=3D=
755 0 0
19:28:32 DEBUG| [stdout] tmpfs /sys/fs/cgroup tmpfs ro,seclabel,nosuid,no=
dev,noexec,mode=3D755 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/systemd cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,xattr,release_agent=3D/usr/lib/systemd/syst=
emd-cgroups-agent,name=3Dsystemd 0 0
19:28:32 DEBUG| [stdout] pstore /sys/fs/pstore pstore rw,seclabel,nosuid,=
nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] efivarfs /sys/firmware/efi/efivars efivarfs rw,n=
osuid,nodev,noexec,relatime 0 0
19:28:32 DEBUG| [stdout] bpf /sys/fs/bpf bpf rw,nosuid,nodev,noexec,relat=
ime,mode=3D700 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/net_cls,net_prio cgroup rw=
,seclabel,nosuid,nodev,noexec,relatime,net_cls,net_prio 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/memory cgroup rw,seclabel,=
nosuid,nodev,noexec,relatime,memory 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/devices cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,devices 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/cpu,cpuacct cgroup rw,secl=
abel,nosuid,nodev,noexec,relatime,cpu,cpuacct 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/freezer cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,freezer 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/perf_event cgroup rw,secla=
bel,nosuid,nodev,noexec,relatime,perf_event 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/blkio cgroup rw,seclabel,n=
osuid,nodev,noexec,relatime,blkio 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/cpuset cgroup rw,seclabel,=
nosuid,nodev,noexec,relatime,cpuset 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/rdma cgroup rw,seclabel,no=
suid,nodev,noexec,relatime,rdma 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/pids cgroup rw,seclabel,no=
suid,nodev,noexec,relatime,pids 0 0
19:28:32 DEBUG| [stdout] cgroup /sys/fs/cgroup/hugetlb cgroup rw,seclabel=
,nosuid,nodev,noexec,relatime,hugetlb 0 0
19:28:32 DEBUG| [stdout] configfs /sys/kernel/config configfs rw,relatime=
 0 0
19:28:32 DEBUG| [stdout] /dev/mapper/rhel_gigabyte--r120--15-root / xfs r=
w,seclabel,relatime,attr2,inode64,noquota 0 0
19:28:32 DEBUG| [stdout] selinuxfs /sys/fs/selinux selinuxfs rw,relatime =
0 0
19:28:32 DEBUG| [stdout] systemd-1 /proc/sys/fs/binfmt_misc autofs rw,rel=
atime,fd=3D46,pgrp=3D1,timeout=3D0,minproto=3D5,maxproto=3D5,direct,pipe_=
ino=3D1225 0 0
19:28:32 DEBUG| [stdout] debugfs /sys/kernel/debug debugfs rw,seclabel,re=
latime 0 0
19:28:32 DEBUG| [stdout] mqueue /dev/mqueue mqueue rw,seclabel,relatime 0=
 0
19:28:32 DEBUG| [stdout] hugetlbfs /dev/hugepages hugetlbfs rw,seclabel,r=
elatime,pagesize=3D512M 0 0
19:28:32 DEBUG| [stdout] /dev/sda2 /boot xfs rw,seclabel,relatime,attr2,i=
node64,noquota 0 0
19:28:32 DEBUG| [stdout] /dev/sda1 /boot/efi vfat rw,relatime,fmask=3D007=
7,dmask=3D0077,codepage=3D437,iocharset=3Dascii,shortname=3Dwinnt,errors=3D=
remount-ro 0 0
19:28:32 DEBUG| [stdout] /dev/mapper/rhel_gigabyte--r120--15-home /home x=
fs rw,seclabel,relatime,attr2,inode64,noquota 0 0
19:28:32 DEBUG| [stdout] sunrpc /var/lib/nfs/rpc_pipefs rpc_pipefs rw,rel=
atime 0 0
19:28:32 DEBUG| [stdout] tmpfs /run/user/0 tmpfs rw,seclabel,nosuid,nodev=
,relatime,size=3D6643392k,mode=3D700 0 0
19:28:32 DEBUG| [stdout] binfmt_misc /proc/sys/fs/binfmt_misc binfmt_misc=
 rw,relatime 0 0
19:28:32 DEBUG| unattended install CD image /var/lib/libvirt/images/avoca=
do/avocado-vt/images/rhel7-64/ks.iso successfully created
19:28:32 DEBUG| Host does not support OpenVSwitch: Command 'ovs-vswitchd'=
 could not be found in any of the PATH dirs: ['/usr/share/Modules/bin', '=
/bin', '/usr/bin', '/usr/libexec', '/sbin', '/usr/local/bin', '/usr/local=
/sbin', '/usr/sbin']
19:28:33 INFO | Running '/home/jenkins/aarch64/qemu-master-build/bin/qemu=
-system-aarch64 -version'
19:28:33 DEBUG| [stdout] QEMU emulator version 4.1.50 (v4.1.0-132-gafd760=
5393-dirty)
19:28:33 DEBUG| [stdout] Copyright (c) 2003-2019 Fabrice Bellard and the =
QEMU Project developers
19:28:33 INFO | Command '/home/jenkins/aarch64/qemu-master-build/bin/qemu=
-system-aarch64 -version' finished with 0 after 0.6501872539520264s
19:28:33 DEBUG| Generating random mac address for nic
19:28:34 DEBUG| Host does not support OpenVSwitch: Command 'ovs-vswitchd'=
 could not be found in any of the PATH dirs: ['/usr/share/Modules/bin', '=
/bin', '/usr/bin', '/usr/libexec', '/sbin', '/usr/local/bin', '/usr/local=
/sbin', '/usr/sbin']
19:28:34 DEBUG| Adding VM avocado-vt-vm1 NIC ifname t0-1UZNrU to bridge v=
irbr0
19:28:34 DEBUG| Host does not support OpenVSwitch: Command 'ovs-vswitchd'=
 could not be found in any of the PATH dirs: ['/usr/share/Modules/bin', '=
/bin', '/usr/bin', '/usr/libexec', '/sbin', '/usr/local/bin', '/usr/local=
/sbin', '/usr/sbin']
19:28:39 WARNI| Support for aarch64 is highly experimental!
19:28:42 DEBUG| Detected CPU vendor as 'unknown'
19:28:42 ERROR| Non existing CPU model host will be passed to qemu (wrong=
 config or negative test)
19:28:43 WARNI| -boot on arm64-pci:virt is usually not supported, use boo=
tindex instead.
19:28:43 DEBUG| qemu will run in KVM mode
19:28:43 DEBUG| Devices of avocado-vt-vm1: [t'PREFIX',t'qemu',t'-S',t'vmn=
ame',t'AAVMF_CODE',t'AAVMF_VARS',t'machine',t'gpex-root',t'nodefaults',a'=
virtio-gpu-pci',t'HMP-qmpmonitor1',t'HMP-catch_monitor',t'SER-serial0',t'=
isa-log',pcie.0-root-port-2,usb1,pcie.0-root-port-3,virtio_scsi_pci0,file=
_image1,drive_image1,image1,pcie.0-root-port-4,idooTV42,t'NET-bridge',t'm=
em',t'smp',t'cpu',file_cd1,drive_cd1,cd1,file_unattended,drive_unattended=
,unattended,usb-tablet1,t'kernel',t'kernel-params',t'initrd',t'tcp-redir'=
,t'tcp-redir',t'display',t'rtc',t'bootmenu',t'kvm',pcie_extra_root_port_0=
,pcie_extra_root_port_1]
19:28:43 DEBUG| Buses of avocado-vt-vm1
  pcie_extra_root_port_1(PCIE): {}
  pcie_extra_root_port_0(PCIE): {}
  drive_unattended(QDrive): {drive:unattended}
  drive_cd1(QDrive): {drive:cd1}
  pcie.0-root-port-4(PCIE): {0x0-0x0:idooTV42}
  drive_image1(QDrive): {drive:image1}
  virtio_scsi_pci0.0(virtio-scsi-pci): {0-0:image1,1-0:cd1,2-0:unattended=
}
  pcie.0-root-port-3(PCIE): {0x0-0x0:virtio_scsi_pci0}
  usb1.0(xhci): {1:usb-tablet1}
  pcie.0-root-port-2(PCIE): {0x0-0x0:usb1}
  _PCI_CHASSIS_NR(None): {}
  _PCI_CHASSIS(None): {}
  pcie.0(PCIE): {0x0-0x0:t'gpex-root',0x1-0x0:a'virtio-gpu-pci',0x2-0x0:p=
cie.0-root-port-2,0x3-0x0:pcie.0-root-port-3,0x4-0x0:pcie.0-root-port-4,0=
x5-0x0:pcie_extra_root_port_0,0x6-0x0:pcie_extra_root_port_1}
19:28:43 INFO | Running qemu command (reformatted):
MALLOC_PERTURB_=3D1  /home/jenkins/aarch64/qemu-master-build/bin/qemu-sys=
tem-aarch64 \
    -S  \
    -name 'avocado-vt-vm1' \
    -drive file=3D/usr/share/AAVMF/AAVMF_CODE.fd,if=3Dpflash,format=3Draw=
,unit=3D0,readonly=3Don \
    -drive file=3D/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7=
devel-aarch64_AAVMF_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 \
    -machine virt,gic-version=3Dhost  \
    -nodefaults \
    -device virtio-gpu-pci,bus=3Dpcie.0,addr=3D0x1  \
    -chardev socket,id=3Dhmp_id_qmpmonitor1,path=3D/var/tmp/avocado_tvjh5=
pxy/monitor-qmpmonitor1-20190818-192502-6nUqJjFV,server,nowait \
    -mon chardev=3Dhmp_id_qmpmonitor1,mode=3Dreadline  \
    -chardev socket,id=3Dhmp_id_catch_monitor,path=3D/var/tmp/avocado_tvj=
h5pxy/monitor-catch_monitor-20190818-192502-6nUqJjFV,server,nowait \
    -mon chardev=3Dhmp_id_catch_monitor,mode=3Dreadline  \
    -serial unix:'/var/tmp/avocado_tvjh5pxy/serial-serial0-20190818-19250=
2-6nUqJjFV',server,nowait \
    -device pcie-root-port,id=3Dpcie.0-root-port-2,slot=3D2,chassis=3D2,a=
ddr=3D0x2,bus=3Dpcie.0 \
    -device qemu-xhci,id=3Dusb1,bus=3Dpcie.0-root-port-2,addr=3D0x0 \
    -device pcie-root-port,id=3Dpcie.0-root-port-3,slot=3D3,chassis=3D3,a=
ddr=3D0x3,bus=3Dpcie.0 \
    -device virtio-scsi-pci,id=3Dvirtio_scsi_pci0,bus=3Dpcie.0-root-port-=
3,addr=3D0x0 \
    -blockdev node-name=3Dfile_image1,driver=3Dfile,filename=3D/var/lib/l=
ibvirt/images/avocado/avocado-vt/images/rhel7devel-aarch64.qcow2 \
    -blockdev node-name=3Ddrive_image1,driver=3Dqcow2,file=3Dfile_image1 =
\
    -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1 \
    -device pcie-root-port,id=3Dpcie.0-root-port-4,slot=3D4,chassis=3D4,a=
ddr=3D0x4,bus=3Dpcie.0 \
    -device virtio-net-pci,mac=3D9a:30:63:fc:96:fc,rombar=3D0,id=3DidooTV=
42,netdev=3DidAVN8sc,bus=3Dpcie.0-root-port-4,addr=3D0x0  \
    -netdev tap,id=3DidAVN8sc,fd=3D19 \
    -m 4096  \
    -smp 2,maxcpus=3D2,cores=3D1,threads=3D1,sockets=3D2  \
    -cpu 'host' \
    -blockdev node-name=3Dfile_cd1,driver=3Dfile,read-only=3Don,filename=3D=
/home/isos/RHEL-8.0.0-20190404.2-aarch64-dvd1.iso \
    -blockdev node-name=3Ddrive_cd1,driver=3Draw,read-only=3Don,file=3Dfi=
le_cd1 \
    -device scsi-cd,id=3Dcd1,drive=3Ddrive_cd1 \
    -blockdev node-name=3Dfile_unattended,driver=3Dfile,read-only=3Don,fi=
lename=3D/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7-64/ks.is=
o \
    -blockdev node-name=3Ddrive_unattended,driver=3Draw,read-only=3Don,fi=
le=3Dfile_unattended \
    -device scsi-cd,id=3Dunattended,drive=3Ddrive_unattended \
    -device usb-tablet,id=3Dusb-tablet1,bus=3Dusb1.0,port=3D1  \
    -kernel '/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7-aarc=
h64/vmlinuz'  \
    -append 'ks=3Dcdrom inst.sshd nicdelay=3D60  earlyprintk=3Dpl011,0x90=
00000 console=3DttyAMA0 debug ignore_loglevel rootwait'  \
    -initrd '/var/lib/libvirt/images/avocado/avocado-vt/images/rhel7-aarc=
h64/initrd.img'  \
    -vnc :0  \
    -rtc base=3Dutc,clock=3Dhost \
    -enable-kvm \
    -device pcie-root-port,id=3Dpcie_extra_root_port_0,slot=3D5,chassis=3D=
5,addr=3D0x5,bus=3Dpcie.0 \
    -device pcie-root-port,id=3Dpcie_extra_root_port_1,slot=3D6,chassis=3D=
6,addr=3D0x6,bus=3Dpcie.0
19:28:44 INFO | Created qemu process with parent PID 18777
19:28:45 INFO | Connecting to monitor '<<class 'virttest.qemu_monitor.Hum=
anMonitor'>> qmpmonitor1'
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1) Sending command 'hel=
p set_link'=20
19:28:45 DEBUG| Send command: help set_link
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1) Response to 'help se=
t_link'
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1)    set_link name on|=
off -- change the link status of a network adapter
19:28:45 INFO | Connecting to monitor '<<class 'virttest.qemu_monitor.Hum=
anMonitor'>> catch_monitor'
19:28:45 DEBUG| (monitor avocado-vt-vm1.catch_monitor) Sending command 'h=
elp set_link'=20
19:28:45 DEBUG| Send command: help set_link
19:28:45 DEBUG| (monitor avocado-vt-vm1.catch_monitor) Response to 'help =
set_link'
19:28:45 DEBUG| (monitor avocado-vt-vm1.catch_monitor)    set_link name o=
n|off -- change the link status of a network adapter
19:28:45 DEBUG| VM appears to be alive with PID 18785
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1) Sending command 'inf=
o cpus'=20
19:28:45 DEBUG| Send command: info cpus
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1) Response to 'info cp=
us'
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1)    * CPU #0: thread_=
id=3D18800
19:28:45 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1)      CPU #1: thread_=
id=3D18802
19:28:47 DEBUG| (monitor avocado-vt-vm1.qmpmonitor1) Sending command 'con=
t'=20
19:28:47 DEBUG| Send command: cont
19:28:47 INFO | Waiting for installation to finish. Timeout set to 7200 s=
 (120 min)
19:28:47 DEBUG| Monitoring serial console log for completion message: /ho=
me/jenkins/workspace/ld-aarch64-gicv3-test/job-2019-08-18T12.53-ec07a5d/t=
est-results/094-functional_git_RHEL-8_dvd io-github-autotest-qemu.unatten=
ded_install.cdrom.extra_cdrom_ks.default_install.aio_threads_-e630/serial=
-serial0-avocado-vt-vm1.log
21:28:47 WARNI| Timeout elapsed while waiting for install to finish=20
21:28:47 DEBUG| Attempting to log into 'avocado-vt-vm1' (timeout 240s)
21:28:47 DEBUG| Retry verifying IP address (0.000015 secs)
21:29:49 DEBUG| Dropped the address cache of HWADDR (9a:30:63:fc:96:fc)
21:32:47 DEBUG| Attempting to log into 'avocado-vt-vm1' via serial consol=
e (timeout 240s)
21:33:01 INFO | [qemu output] (Process terminated with status 0)
21:33:08 WARNI| Error occur when update VM address cache: VM is dead
21:33:08 DEBUG| Sending command: true
21:33:08 INFO | Skipping log_useful_files #0: Shell process terminated wh=
ile waiting for command to complete: 'true'    (status: 1,    output: 'Nc=
at: Broken pipe.\n')
21:33:08 ERROR|=20
21:33:08 ERROR| Reproduced traceback from: /usr/lib/python3.6/site-packag=
es/avocado_vt/test.py:449
21:33:08 ERROR| Traceback (most recent call last):
21:33:08 ERROR|   File "/var/lib/libvirt/images/avocado/avocado-vt/test-p=
roviders.d/downloads/io-github-autotest-qemu/generic/tests/unattended_ins=
tall.py", line 25, in run
21:33:08 ERROR|     unattended_install.run(test, params, env)
21:33:08 ERROR|   File "/usr/lib/python3.6/site-packages/virttest/error_c=
ontext.py", line 135, in new_fn
21:33:08 ERROR|     return fn(*args, **kwargs)
21:33:08 ERROR|   File "/usr/lib/python3.6/site-packages/virttest/tests/u=
nattended_install.py", line 1444, in run
21:33:08 ERROR|     raise exceptions.TestFail("Timeout elapsed while wait=
ing for install to "
21:33:08 ERROR| avocado.core.exceptions.TestFail: Timeout elapsed while w=
aiting for install to finish
21:33:08 ERROR|=20
21:33:09 DEBUG| Host does not support OpenVSwitch: Command 'ovs-vswitchd'=
 could not be found in any of the PATH dirs: ['/usr/share/Modules/bin', '=
/bin', '/usr/bin', '/usr/libexec', '/sbin', '/usr/local/bin', '/usr/local=
/sbin', '/usr/sbin']
21:33:09 DEBUG| Checking image file /var/lib/libvirt/images/avocado/avoca=
do-vt/images/rhel7devel-aarch64.qcow2
21:33:09 DEBUG| Run qemu-img info command on /var/lib/libvirt/images/avoc=
ado/avocado-vt/images/rhel7devel-aarch64.qcow2
21:33:09 INFO | Running '/home/jenkins/aarch64/qemu-master-build/bin/qemu=
-img info -U /var/lib/libvirt/images/avocado/avocado-vt/images/rhel7devel=
-aarch64.qcow2 --output=3Dhuman'
21:33:09 DEBUG| [stdout] image: /var/lib/libvirt/images/avocado/avocado-v=
t/images/rhel7devel-aarch64.qcow2
21:33:09 DEBUG| [stdout] file format: qcow2
21:33:09 DEBUG| [stdout] virtual size: 10 GiB (10737418240 bytes)
21:33:09 INFO | Command '/home/jenkins/aarch64/qemu-master-build/bin/qemu=
-img info -U /var/lib/libvirt/images/avocado/avocado-vt/images/rhel7devel=
-aarch64.qcow2 --output=3Dhuman' finished with 0 after 0.2244665622711181=
6s
21:33:09 DEBUG| [stdout] disk size: 2.73 GiB
21:33:09 DEBUG| [stdout] cluster_size: 65536
21:33:09 DEBUG| [stdout] Format specific information:
21:33:09 DEBUG| [stdout]     compat: 1.1
21:33:09 DEBUG| [stdout]     lazy refcounts: false
21:33:09 DEBUG| [stdout]     refcount bits: 16
21:33:09 DEBUG| [stdout]     corrupt: false
21:33:10 DEBUG| Copying /var/lib/libvirt/images/avocado/avocado-vt/images=
/rhel7devel-aarch64.qcow2.backup -> /var/lib/libvirt/images/avocado/avoca=
do-vt/images/rhel7devel-aarch64.qcow2
21:33:21 INFO | Running 'true'
21:33:21 INFO | Command 'true' finished with 0 after 0.001579761505126953=
1s
21:33:21 INFO | Running 'ps -o comm 1'
21:33:21 DEBUG| [stdout] COMMAND
21:33:21 INFO | Command 'ps -o comm 1' finished with 0 after 0.0528864860=
534668s
21:33:21 DEBUG| [stdout] systemd
21:33:21 ERROR|=20
21:33:21 ERROR| Reproduced traceback from: /usr/local/lib/python3.6/site-=
packages/avocado/core/test.py:853
21:33:22 ERROR| Traceback (most recent call last):
21:33:22 ERROR|   File "/usr/lib/python3.6/site-packages/avocado_vt/test.=
py", line 312, in runTest
21:33:22 ERROR|     raise self.__status  # pylint: disable=3DE0702
21:33:22 ERROR|   File "/usr/lib/python3.6/site-packages/avocado_vt/test.=
py", line 263, in setUp
21:33:22 ERROR|     self._runTest()
21:33:22 ERROR|   File "/usr/lib/python3.6/site-packages/avocado_vt/test.=
py", line 438, in _runTest
21:33:22 ERROR|     run_func(self, params, env)
21:33:22 ERROR|   File "/var/lib/libvirt/images/avocado/avocado-vt/test-p=
roviders.d/downloads/io-github-autotest-qemu/generic/tests/unattended_ins=
tall.py", line 25, in run
21:33:22 ERROR|     unattended_install.run(test, params, env)
21:33:22 ERROR|   File "/usr/lib/python3.6/site-packages/virttest/error_c=
ontext.py", line 135, in new_fn
21:33:22 ERROR|     return fn(*args, **kwargs)
21:33:22 ERROR|   File "/usr/lib/python3.6/site-packages/virttest/tests/u=
nattended_install.py", line 1444, in run
21:33:22 ERROR|     raise exceptions.TestFail("Timeout elapsed while wait=
ing for install to "
21:33:22 ERROR| avocado.core.exceptions.TestFail: Timeout elapsed while w=
aiting for install to finish
21:33:22 ERROR|=20
21:33:22 DEBUG| Local variables:
21:33:54 DEBUG|  -> self <class 'avocado_vt.test.VirtTest'>: 094-function=
al/git/RHEL-8/dvd io-github-autotest-qemu.unattended_install.cdrom.extra_=
cdrom_ks.default_install.aio_threads;-e630
21:33:54 DEBUG| DATA (filename=3Doutput.expected) =3D> NOT FOUND (data so=
urces: variant, test, file)
21:33:54 DEBUG| DATA (filename=3Dstdout.expected) =3D> NOT FOUND (data so=
urces: variant, test, file)
21:33:54 DEBUG| DATA (filename=3Dstderr.expected) =3D> NOT FOUND (data so=
urces: variant, test, file)
21:33:54 ERROR| FAIL 094-functional/git/RHEL-8/dvd io-github-autotest-qem=
u.unattended_install.cdrom.extra_cdrom_ks.default_install.aio_threads;-e6=
30 -> TestFail: Timeout elapsed while waiting for install to finish
21:33:54 INFO |=20

--------------6FF53884564E090C45E246C8
Content-Type: text/x-log;
 name="serial-serial0-avocado-vt-vm1.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="serial-serial0-avocado-vt-vm1.log"

2019-08-18 19:28:47: UEFI firmware starting.
2019-08-18 19:28:47: =00=00
2019-08-18 19:28:51: =1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B[01;01H=1B[2J=1B[0=
1;01H=1B[=3D3h=1B[2J=1B[01;01H=1B[2J=1B[01;01H=1B[=3D3h=1B[2J=1B[01;01H=1B=
[0m=1B[35m=1B[40m
2019-08-18 19:28:51: =1B[0m=1B[37m=1B[40mEFI stub: Booting Linux Kernel..=
=2E
2019-08-18 19:28:51: EFI stub: EFI_RNG_PROTOCOL unavailable, no randomnes=
s supplied
2019-08-18 19:28:51: EFI stub: Generating empty DTB
2019-08-18 19:28:51: EFI stub: Exiting boot services and installing virtu=
al address map...
2019-08-18 19:28:51: [    0.000000] Booting Linux on physical CPU 0x00000=
00000 [0x431f0a11]
2019-08-18 19:28:51: [    0.000000] Linux version 4.18.0-80.el8.aarch64 (=
mockbuild@arm64-026.build.eng.bos.redhat.com) (gcc version 8.2.1 20180905=
 (Red Hat 8.2.1-3) (GCC)) #1 SMP Wed Mar 13 12:16:17 UTC 2019
2019-08-18 19:28:51: [    0.000000] debug: ignoring loglevel setting.
2019-08-18 19:28:51: [    0.000000] efi: Getting EFI parameters from FDT:=

2019-08-18 19:28:51: [    0.000000] efi: EFI v2.70 by EDK II
2019-08-18 19:28:51: [    0.000000] efi:  SMBIOS 3.0=3D0x13f670000  MEMAT=
TR=3D0x13e4c9018  ACPI 2.0=3D0x13c030000  MEMRESERVE=3D0x13c2e3018
2019-08-18 19:28:51: [    0.000000] ACPI: Early table checksum verificati=
on disabled
2019-08-18 19:28:51: [    0.000000] ACPI: RSDP 0x000000013C030000 000024 =
(v02 BOCHS )
2019-08-18 19:28:51: [    0.000000] ACPI: XSDT 0x000000013C020000 00005C =
(v01 BOCHS  BXPCFACP 00000001      01000013)
2019-08-18 19:28:51: [    0.000000] ACPI: FACP 0x000000013BDE0000 00010C =
(v05 BOCHS  BXPCFACP 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: DSDT 0x000000013BDF0000 004848 =
(v02 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: APIC 0x000000013BDD0000 000100 =
(v03 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: GTDT 0x000000013BDC0000 000060 =
(v02 BOCHS  BXPCGTDT 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: MCFG 0x000000013BDB0000 00003C =
(v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: SPCR 0x000000013BDA0000 000050 =
(v02 BOCHS  BXPCSPCR 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: IORT 0x000000013BD90000 00007C =
(v00 BOCHS  BXPCIORT 00000001 BXPC 00000001)
2019-08-18 19:28:51: [    0.000000] ACPI: BGRT 0x000000013BE10000 000038 =
(v01 INTEL  EDK2     00000002      01000013)
2019-08-18 19:28:51: [    0.000000] ACPI: SPCR: console: pl011,mmio,0x900=
0000,9600
2019-08-18 19:28:51: [    0.000000] ACPI: NUMA: Failed to initialise from=
 firmware
2019-08-18 19:28:51: [    0.000000] NUMA: Faking a node at [mem 0x0000000=
000000000-0x000000013fffffff]
2019-08-18 19:28:51: [    0.000000] NUMA: NODE_DATA [mem 0x13ff4e600-0x13=
ff4ffff]
2019-08-18 19:28:51: [    0.000000] Zone ranges:
2019-08-18 19:28:51: [    0.000000]   DMA32    [mem 0x0000000040000000-0x=
00000000ffffffff]
2019-08-18 19:28:51: [    0.000000]   Normal   [mem 0x0000000100000000-0x=
000000013fffffff]
2019-08-18 19:28:51: [    0.000000] Movable zone start for each node
2019-08-18 19:28:52: [    0.000000] Early memory node ranges
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x0000000040000000-0=
x000000013be1ffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013be20000-0=
x000000013bffffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013c000000-0=
x000000013c03ffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013c040000-0=
x000000013c2dffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013c2e0000-0=
x000000013f5bffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013f5c0000-0=
x000000013f64ffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013f650000-0=
x000000013f65ffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013f660000-0=
x000000013f77ffff]
2019-08-18 19:28:52: [    0.000000]   node   0: [mem 0x000000013f780000-0=
x000000013fffffff]
2019-08-18 19:28:52: [    0.000000] Zeroed struct page in unavailable ran=
ges: 99 pages
2019-08-18 19:28:52: [    0.000000] Initmem setup node 0 [mem 0x000000004=
0000000-0x000000013fffffff]
2019-08-18 19:28:52: [    0.000000] On node 0 totalpages: 65536
2019-08-18 19:28:52: [    0.000000]   DMA32 zone: 48 pages used for memma=
p
2019-08-18 19:28:52: [    0.000000]   DMA32 zone: 0 pages reserved
2019-08-18 19:28:52: [    0.000000]   DMA32 zone: 49152 pages, LIFO batch=
:1
2019-08-18 19:28:52: [    0.000000]   Normal zone: 16 pages used for memm=
ap
2019-08-18 19:28:52: [    0.000000]   Normal zone: 16384 pages, LIFO batc=
h:1
2019-08-18 19:28:52: [    0.000000] psci: probing for conduit method from=
 ACPI.
2019-08-18 19:28:52: [    0.000000] psci: PSCIv1.0 detected in firmware.
2019-08-18 19:28:52: [    0.000000] psci: Using standard PSCI v0.2 functi=
on IDs
2019-08-18 19:28:52: [    0.000000] psci: Trusted OS migration not requir=
ed
2019-08-18 19:28:52: [    0.000000] psci: SMC Calling Convention v1.1
2019-08-18 19:28:52: [    0.000000] random: get_random_bytes called from =
start_kernel+0x9c/0x4d8 with crng_init=3D0
2019-08-18 19:28:52: [    0.000000] percpu: Embedded 3 pages/cpu @(____pt=
rval____) s127448 r8192 d60968 u196608
2019-08-18 19:28:52: [    0.000000] pcpu-alloc: s127448 r8192 d60968 u196=
608 alloc=3D3*65536
2019-08-18 19:28:52: [    0.000000] pcpu-alloc: [0] 0 [0] 1
2019-08-18 19:28:52: [    0.000000] Detected VIPT I-cache on CPU0
2019-08-18 19:28:52: [    0.000000] CPU features: enabling workaround for=
 Cavium erratum 27456
2019-08-18 19:28:52: [    0.000000] CPU features: enabling workaround for=
 Cavium erratum 30115
2019-08-18 19:28:52: [    0.000000] CPU features: detected: Software pref=
etching using PRFM
2019-08-18 19:28:52: [    0.000000] CPU features: kernel page table isola=
tion forced OFF by ARM64_WORKAROUND_CAVIUM_27456
2019-08-18 19:28:52: [    0.000000] Built 1 zonelists, mobility grouping =
on.  Total pages: 65472
2019-08-18 19:28:52: [    0.000000] Policy zone: Normal
2019-08-18 19:28:52: [    0.000000] Kernel command line: ks=3Dcdrom inst.=
sshd nicdelay=3D60  earlyprintk=3Dpl011,0x9000000 console=3DttyAMA0 debug=
 ignore_loglevel rootwait initrd=3Dinitrd
2019-08-18 19:28:52: [    0.000000] Specific versions of hardware are cer=
tified with Red Hat Enterprise Linux 8. Please see the list of hardware c=
ertified with Red Hat Enterprise Linux 8 at https://access.redhat.com/eco=
system.
2019-08-18 19:28:52: [    0.000000] software IO TLB: mapped [mem 0xfbff00=
00-0xffff0000] (64MB)
2019-08-18 19:28:52: [    0.000000] Memory: 4029824K/4194304K available (=
8956K kernel code, 1902K rwdata, 5760K rodata, 4288K init, 9197K bss, 164=
480K reserved, 0K cma-reserved)
2019-08-18 19:28:52: [    0.000000] SLUB: HWalign=3D128, Order=3D0-3, Min=
Objects=3D0, CPUs=3D2, Nodes=3D1
2019-08-18 19:28:52: [    0.000000] ftrace: allocating 32209 entries in 8=
 pages
2019-08-18 19:28:52: [    0.000000] rcu: Hierarchical RCU implementation.=

2019-08-18 19:28:52: [    0.000000] rcu: 	RCU restricting CPUs from NR_CP=
US=3D4096 to nr_cpu_ids=3D2.
2019-08-18 19:28:52: [    0.000000] rcu: RCU calculated value of schedule=
r-enlistment delay is 10 jiffies.
2019-08-18 19:28:52: [    0.000000] rcu: Adjusting geometry for rcu_fanou=
t_leaf=3D16, nr_cpu_ids=3D2
2019-08-18 19:28:52: [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocate=
d irqs: 0
2019-08-18 19:28:52: [    0.000000] GICv3: Distributor has no Range Selec=
tor support
2019-08-18 19:28:52: [    0.000000] GICv3: no VLPI support, no direct LPI=
 support
2019-08-18 19:28:52: [    0.000000] GICv3: CPU0: found redistributor 0 re=
gion 0:0x00000000080a0000
2019-08-18 19:28:52: [    0.000000] ACPI: SRAT not present
2019-08-18 19:28:52: [    0.000000] ITS [mem 0x08080000-0x0809ffff]
2019-08-18 19:28:52: [    0.000000] ITS@0x0000000008080000: allocated 819=
2 Devices @100260000 (indirect, esz 8, psz 64K, shr 1)
2019-08-18 19:28:52: [    0.000000] ITS@0x0000000008080000: allocated 819=
2 Interrupt Collections @100270000 (flat, esz 8, psz 64K, shr 1)
2019-08-18 19:28:52: [    0.000000] GICv3: using LPI property table @0x00=
00000100280000
2019-08-18 19:28:52: [    0.000000] GICv3: CPU0: using allocated LPI pend=
ing table @0x00000001002a0000
2019-08-18 19:28:52: [    0.000000] rcu: 	Offload RCU callbacks from CPUs=
: (none).
2019-08-18 19:28:52: [    0.000000] arch_timer: cp15 timer(s) running at =
100.00MHz (virt).
2019-08-18 19:28:52: [    0.000000] clocksource: arch_sys_counter: mask: =
0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
2019-08-18 19:28:52: [    0.000002] sched_clock: 56 bits at 100MHz, resol=
ution 10ns, wraps every 4398046511100ns
2019-08-18 19:28:52: [    0.000155] Console: colour dummy device 80x25
2019-08-18 19:28:52: [    0.000441] ACPI: Core revision 20180531
2019-08-18 19:28:52: [    0.000846] Calibrating delay loop (skipped), val=
ue calculated using timer frequency.. 200.00 BogoMIPS (lpj=3D1000000)
2019-08-18 19:28:52: [    0.000856] pid_max: default: 32768 minimum: 301
2019-08-18 19:28:52: [    0.001069] Security Framework initialized
2019-08-18 19:28:52: [    0.001076] Yama: becoming mindful.
2019-08-18 19:28:52: [    0.001106] SELinux:  Initializing.
2019-08-18 19:28:52: [    0.001446] SELinux:  Starting in permissive mode=

2019-08-18 19:28:52: [    0.002743] Dentry cache hash table entries: 5242=
88 (order: 6, 4194304 bytes)
2019-08-18 19:28:52: [    0.003368] Inode-cache hash table entries: 26214=
4 (order: 5, 2097152 bytes)
2019-08-18 19:28:52: [    0.003421] Mount-cache hash table entries: 8192 =
(order: 0, 65536 bytes)
2019-08-18 19:28:52: [    0.003453] Mountpoint-cache hash table entries: =
8192 (order: 0, 65536 bytes)
2019-08-18 19:28:52: [    0.004998] ACPI PPTT: No PPTT table found, cpu t=
opology may be inaccurate
2019-08-18 19:28:52: [    0.005508] ASID allocator initialised with 32768=
 entries
2019-08-18 19:28:52: [    0.005605] rcu: Hierarchical SRCU implementation=
=2E
2019-08-18 19:28:52: [    0.006407] Platform MSI: ITS@0x8080000 domain cr=
eated
2019-08-18 19:28:52: [    0.006445] PCI/MSI: ITS@0x8080000 domain created=

2019-08-18 19:28:52: [    0.006514] Remapping and enabling EFI services.
2019-08-18 19:28:52: [    0.006945] smp: Bringing up secondary CPUs ...
2019-08-18 19:28:52: [    0.015250] Detected VIPT I-cache on CPU1
2019-08-18 19:28:52: [    0.015317] GICv3: CPU1: found redistributor 1 re=
gion 0:0x00000000080c0000
2019-08-18 19:28:52: [    0.015619] GICv3: CPU1: using allocated LPI pend=
ing table @0x00000001002b0000
2019-08-18 19:28:52: [    0.015770] CPU1: Booted secondary processor 0x00=
00000001 [0x431f0a11]
2019-08-18 19:28:52: [    0.015956] smp: Brought up 1 node, 2 CPUs
2019-08-18 19:28:52: [    0.015968] SMP: Total of 2 processors activated.=

2019-08-18 19:28:52: [    0.015984] CPU features: detected: GIC system re=
gister CPU interface
2019-08-18 19:28:52: [    0.022155] CPU: All CPU(s) started at EL1
2019-08-18 19:28:52: [    0.022204] alternatives: patching kernel code
2019-08-18 19:28:52: [    0.023771] devtmpfs: initialized
2019-08-18 19:28:52: [    0.024597] clocksource: jiffies: mask: 0xfffffff=
f max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
2019-08-18 19:28:52: [    0.024611] futex hash table entries: 512 (order:=
 -1, 32768 bytes)
2019-08-18 19:28:52: [    0.024804] pinctrl core: initialized pinctrl sub=
system
2019-08-18 19:28:52: [    0.025062] SMBIOS 3.0.0 present.
2019-08-18 19:28:52: [    0.025074] DMI: QEMU KVM Virtual Machine, BIOS 0=
=2E0.0 02/06/2015
2019-08-18 19:28:52: [    0.025597] NET: Registered protocol family 16
2019-08-18 19:28:52: [    0.025919] audit: initializing netlink subsys (d=
isabled)
2019-08-18 19:28:52: [    0.026360] audit: type=3D2000 audit(0.020:1): st=
ate=3Dinitialized audit_enabled=3D0 res=3D1
2019-08-18 19:28:52: [    0.026939] cpuidle: using governor menu
2019-08-18 19:28:52: [    0.027058] vdso: 2 pages (1 code @ (____ptrval__=
__), 1 data @ (____ptrval____))
2019-08-18 19:28:52: [    0.027064] hw-breakpoint: found 6 breakpoint and=
 4 watchpoint registers.
2019-08-18 19:28:52: [    0.027286] DMA: preallocated 256 KiB pool for at=
omic allocations
2019-08-18 19:28:52: [    0.027317] ACPI: bus type PCI registered
2019-08-18 19:28:52: [    0.027341] acpiphp: ACPI Hot Plug PCI Controller=
 Driver version: 0.5
2019-08-18 19:28:52: [    0.027510] Serial: AMBA PL011 UART driver
2019-08-18 19:28:52: [    0.032824] HugeTLB registered 2.00 MiB page size=
, pre-allocated 0 pages
2019-08-18 19:28:52: [    0.032830] HugeTLB registered 512 MiB page size,=
 pre-allocated 0 pages
2019-08-18 19:28:52: [    0.033701] cryptd: max_cpu_qlen set to 1000
2019-08-18 19:28:52: [    0.034452] ACPI: Added _OSI(Module Device)
2019-08-18 19:28:52: [    0.034458] ACPI: Added _OSI(Processor Device)
2019-08-18 19:28:52: [    0.034462] ACPI: Added _OSI(3.0 _SCP Extensions)=

2019-08-18 19:28:52: [    0.034467] ACPI: Added _OSI(Processor Aggregator=
 Device)
2019-08-18 19:28:52: [    0.034472] ACPI: Added _OSI(Linux-Dell-Video)
2019-08-18 19:28:52: [    0.062983] ACPI: 1 ACPI AML tables successfully =
acquired and loaded
2019-08-18 19:28:52: [    0.065824] ACPI: Interpreter enabled
2019-08-18 19:28:52: [    0.065829] ACPI: Using GIC for interrupt routing=

2019-08-18 19:28:52: [    0.065857] ACPI: MCFG table detected, 1 entries
2019-08-18 19:28:52: [    0.072260] ARMH0011:00: ttyAMA0 at MMIO 0x900000=
0 (irq =3D 4, base_baud =3D 0) is a SBSA
2019-08-18 19:28:52: [    0.733946] console [ttyAMA0] enabled
2019-08-18 19:28:52: [    0.740432] ACPI: PCI Root Bridge [PCI0] (domain =
0000 [bus 00-ff])
2019-08-18 19:28:52: [    0.745235] acpi PNP0A08:00: _OSC: OS supports [E=
xtendedConfig ASPM ClockPM Segments MSI]
2019-08-18 19:28:52: [    0.751705] acpi PNP0A08:00: _OSC: platform does =
not support [LTR]
2019-08-18 19:28:52: [    0.756697] acpi PNP0A08:00: _OSC: OS now control=
s [PCIeHotplug PME AER PCIeCapability]
2019-08-18 19:28:52: [    0.763363] acpi PNP0A08:00: ECAM area [mem 0x401=
0000000-0x401fffffff] reserved by PNP0C02:00
2019-08-18 19:28:52: [    0.770202] acpi PNP0A08:00: ECAM at [mem 0x40100=
00000-0x401fffffff] for [bus 00-ff]
2019-08-18 19:28:52: [    0.776111] Remapped I/O 0x000000003eff0000 to [i=
o  0x0000-0xffff window]
2019-08-18 19:28:52: [    0.781596] PCI host bridge to bus 0000:00
2019-08-18 19:28:52: [    0.784707] pci_bus 0000:00: root bus resource [m=
em 0x10000000-0x3efeffff window]
2019-08-18 19:28:52: [    0.790391] pci_bus 0000:00: root bus resource [i=
o  0x0000-0xffff window]
2019-08-18 19:28:52: [    0.795769] pci_bus 0000:00: root bus resource [m=
em 0x8000000000-0xffffffffff window]
2019-08-18 19:28:52: [    0.801707] pci_bus 0000:00: root bus resource [b=
us 00-ff]
2019-08-18 19:28:52: [    0.806000] pci 0000:00:00.0: [1b36:0008] type 00=
 class 0x060000
2019-08-18 19:28:52: [    0.812142] pci 0000:00:01.0: [1af4:1050] type 00=
 class 0x038000
2019-08-18 19:28:52: [    0.820978] pci 0000:00:01.0: reg 0x14: [mem 0x10=
305000-0x10305fff]
2019-08-18 19:28:52: [    0.831432] pci 0000:00:01.0: reg 0x20: [mem 0x80=
00200000-0x8000203fff 64bit pref]
2019-08-18 19:28:52: [    0.842795] pci 0000:00:02.0: [1b36:000c] type 01=
 class 0x060400
2019-08-18 19:28:52: [    0.850995] pci 0000:00:02.0: reg 0x10: [mem 0x10=
304000-0x10304fff]
2019-08-18 19:28:52: [    0.863450] pci 0000:00:03.0: [1b36:000c] type 01=
 class 0x060400
2019-08-18 19:28:52: [    0.871652] pci 0000:00:03.0: reg 0x10: [mem 0x10=
303000-0x10303fff]
2019-08-18 19:28:52: [    0.884049] pci 0000:00:04.0: [1b36:000c] type 01=
 class 0x060400
2019-08-18 19:28:52: [    0.892258] pci 0000:00:04.0: reg 0x10: [mem 0x10=
302000-0x10302fff]
2019-08-18 19:28:52: [    0.903365] pci 0000:00:05.0: [1b36:000c] type 01=
 class 0x060400
2019-08-18 19:28:52: [    0.911519] pci 0000:00:05.0: reg 0x10: [mem 0x10=
301000-0x10301fff]
2019-08-18 19:28:52: [    0.924359] pci 0000:00:06.0: [1b36:000c] type 01=
 class 0x060400
2019-08-18 19:28:52: [    0.932500] pci 0000:00:06.0: reg 0x10: [mem 0x10=
300000-0x10300fff]
2019-08-18 19:28:52: [    0.947422] pci 0000:01:00.0: [1b36:000d] type 00=
 class 0x0c0330
2019-08-18 19:28:52: [    0.952559] pci 0000:01:00.0: reg 0x10: [mem 0x10=
200000-0x10203fff 64bit]
2019-08-18 19:28:52: [    0.959890] pci 0000:01:00.0: 2.000 Gb/s availabl=
e PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:02.0 (capable of=
 7.876 Gb/s with 8 GT/s x1 link)
2019-08-18 19:28:52: [    0.973946] pci 0000:02:00.0: [1af4:1048] type 00=
 class 0x010000
2019-08-18 19:28:52: [    0.979061] pci 0000:02:00.0: reg 0x14: [mem 0x10=
100000-0x10100fff]
2019-08-18 19:28:52: [    0.984520] pci 0000:02:00.0: reg 0x20: [mem 0x80=
00000000-0x8000003fff 64bit pref]
2019-08-18 19:28:52: [    0.992768] pci 0000:02:00.0: 2.000 Gb/s availabl=
e PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:03.0 (capable of=
 7.876 Gb/s with 8 GT/s x1 link)
2019-08-18 19:28:52: [    1.007037] pci 0000:03:00.0: [1af4:1041] type 00=
 class 0x020000
2019-08-18 19:28:52: [    1.012168] pci 0000:03:00.0: reg 0x14: [mem 0x10=
000000-0x10000fff]
2019-08-18 19:28:52: [    1.017619] pci 0000:03:00.0: reg 0x20: [mem 0x80=
00100000-0x8000103fff 64bit pref]
2019-08-18 19:28:52: [    1.026216] pci 0000:03:00.0: 2.000 Gb/s availabl=
e PCIe bandwidth, limited by 2.5 GT/s x1 link at 0000:00:04.0 (capable of=
 7.876 Gb/s with 8 GT/s x1 link)
2019-08-18 19:28:52: [    1.055949] pci 0000:00:02.0: BAR 14: assigned [m=
em 0x10000000-0x101fffff]
2019-08-18 19:28:52: [    1.063565] pci 0000:00:02.0: BAR 15: assigned [m=
em 0x8000000000-0x80001fffff 64bit pref]
2019-08-18 19:28:52: [    1.069750] pci 0000:00:03.0: BAR 14: assigned [m=
em 0x10200000-0x103fffff]
2019-08-18 19:28:52: [    1.075169] pci 0000:00:03.0: BAR 15: assigned [m=
em 0x8000200000-0x80003fffff 64bit pref]
2019-08-18 19:28:52: [    1.081364] pci 0000:00:04.0: BAR 14: assigned [m=
em 0x10400000-0x105fffff]
2019-08-18 19:28:52: [    1.086654] pci 0000:00:04.0: BAR 15: assigned [m=
em 0x8000400000-0x80005fffff 64bit pref]
2019-08-18 19:28:52: [    1.092846] pci 0000:00:05.0: BAR 14: assigned [m=
em 0x10600000-0x107fffff]
2019-08-18 19:28:52: [    1.098128] pci 0000:00:05.0: BAR 15: assigned [m=
em 0x8000600000-0x80007fffff 64bit pref]
2019-08-18 19:28:52: [    1.104318] pci 0000:00:06.0: BAR 14: assigned [m=
em 0x10800000-0x109fffff]
2019-08-18 19:28:52: [    1.109619] pci 0000:00:06.0: BAR 15: assigned [m=
em 0x8000800000-0x80009fffff 64bit pref]
2019-08-18 19:28:52: [    1.115787] pci 0000:00:01.0: BAR 4: assigned [me=
m 0x8000a00000-0x8000a03fff 64bit pref]
2019-08-18 19:28:52: [    1.123929] pci 0000:00:01.0: BAR 1: assigned [me=
m 0x10a00000-0x10a00fff]
2019-08-18 19:28:52: [    1.129997] pci 0000:00:02.0: BAR 0: assigned [me=
m 0x10a01000-0x10a01fff]
2019-08-18 19:28:52: [    1.136240] pci 0000:00:02.0: BAR 13: assigned [i=
o  0x1000-0x1fff]
2019-08-18 19:28:52: [    1.140946] pci 0000:00:03.0: BAR 0: assigned [me=
m 0x10a02000-0x10a02fff]
2019-08-18 19:28:52: [    1.147073] pci 0000:00:03.0: BAR 13: assigned [i=
o  0x2000-0x2fff]
2019-08-18 19:28:52: [    1.151786] pci 0000:00:04.0: BAR 0: assigned [me=
m 0x10a03000-0x10a03fff]
2019-08-18 19:28:52: [    1.157902] pci 0000:00:04.0: BAR 13: assigned [i=
o  0x3000-0x3fff]
2019-08-18 19:28:52: [    1.162597] pci 0000:00:05.0: BAR 0: assigned [me=
m 0x10a04000-0x10a04fff]
2019-08-18 19:28:52: [    1.168688] pci 0000:00:05.0: BAR 13: assigned [i=
o  0x4000-0x4fff]
2019-08-18 19:28:52: [    1.174590] pci 0000:00:06.0: BAR 0: assigned [me=
m 0x10a05000-0x10a05fff]
2019-08-18 19:28:52: [    1.180795] pci 0000:00:06.0: BAR 13: assigned [i=
o  0x5000-0x5fff]
2019-08-18 19:28:52: [    1.185496] pci 0000:01:00.0: BAR 0: assigned [me=
m 0x10000000-0x10003fff 64bit]
2019-08-18 19:28:52: [    1.191327] pci 0000:00:02.0: PCI bridge to [bus =
01]
2019-08-18 19:28:52: [    1.195127] pci 0000:00:02.0:   bridge window [io=
  0x1000-0x1fff]
2019-08-18 19:28:52: [    1.201586] pci 0000:00:02.0:   bridge window [me=
m 0x10000000-0x101fffff]
2019-08-18 19:28:53: [    1.207912] pci 0000:00:02.0:   bridge window [me=
m 0x8000000000-0x80001fffff 64bit pref]
2019-08-18 19:28:53: [    1.216574] pci 0000:02:00.0: BAR 4: assigned [me=
m 0x8000200000-0x8000203fff 64bit pref]
2019-08-18 19:28:53: [    1.222917] pci 0000:02:00.0: BAR 1: assigned [me=
m 0x10200000-0x10200fff]
2019-08-18 19:28:53: [    1.228341] pci 0000:00:03.0: PCI bridge to [bus =
02]
2019-08-18 19:28:53: [    1.232156] pci 0000:00:03.0:   bridge window [io=
  0x2000-0x2fff]
2019-08-18 19:28:53: [    1.239626] pci 0000:00:03.0:   bridge window [me=
m 0x10200000-0x103fffff]
2019-08-18 19:28:53: [    1.245956] pci 0000:00:03.0:   bridge window [me=
m 0x8000200000-0x80003fffff 64bit pref]
2019-08-18 19:28:53: [    1.254701] pci 0000:03:00.0: BAR 4: assigned [me=
m 0x8000400000-0x8000403fff 64bit pref]
2019-08-18 19:28:53: [    1.261035] pci 0000:03:00.0: BAR 1: assigned [me=
m 0x10400000-0x10400fff]
2019-08-18 19:28:53: [    1.266462] pci 0000:00:04.0: PCI bridge to [bus =
03]
2019-08-18 19:28:53: [    1.270284] pci 0000:00:04.0:   bridge window [io=
  0x3000-0x3fff]
2019-08-18 19:28:53: [    1.276700] pci 0000:00:04.0:   bridge window [me=
m 0x10400000-0x105fffff]
2019-08-18 19:28:53: [    1.283067] pci 0000:00:04.0:   bridge window [me=
m 0x8000400000-0x80005fffff 64bit pref]
2019-08-18 19:28:53: [    1.291801] pci 0000:00:05.0: PCI bridge to [bus =
04]
2019-08-18 19:28:53: [    1.297868] pci 0000:00:05.0:   bridge window [io=
  0x4000-0x4fff]
2019-08-18 19:28:53: [    1.304522] pci 0000:00:05.0:   bridge window [me=
m 0x10600000-0x107fffff]
2019-08-18 19:28:53: [    1.310881] pci 0000:00:05.0:   bridge window [me=
m 0x8000600000-0x80007fffff 64bit pref]
2019-08-18 19:28:53: [    1.319670] pci 0000:00:06.0: PCI bridge to [bus =
05]
2019-08-18 19:28:53: [    1.323467] pci 0000:00:06.0:   bridge window [io=
  0x5000-0x5fff]
2019-08-18 19:28:53: [    1.329958] pci 0000:00:06.0:   bridge window [me=
m 0x10800000-0x109fffff]
2019-08-18 19:28:53: [    1.336282] pci 0000:00:06.0:   bridge window [me=
m 0x8000800000-0x80009fffff 64bit pref]
2019-08-18 19:28:53: [    1.345172] ACPI: PCI Interrupt Link [GSI0] (IRQs=
 *35)
2019-08-18 19:28:53: [    1.350698] ACPI: PCI Interrupt Link [GSI1] (IRQs=
 *36)
2019-08-18 19:28:53: [    1.354736] ACPI: PCI Interrupt Link [GSI2] (IRQs=
 *37)
2019-08-18 19:28:53: [    1.358655] ACPI: PCI Interrupt Link [GSI3] (IRQs=
 *38)
2019-08-18 19:28:53: [    1.363454] vgaarb: loaded
2019-08-18 19:28:53: [    1.365922] SCSI subsystem initialized
2019-08-18 19:28:53: [    1.369053] libata version 3.00 loaded.
2019-08-18 19:28:53: [    1.372094] ACPI: bus type USB registered
2019-08-18 19:28:53: [    1.375214] usbcore: registered new interface dri=
ver usbfs
2019-08-18 19:28:53: [    1.379646] usbcore: registered new interface dri=
ver hub
2019-08-18 19:28:53: [    1.383738] usbcore: registered new device driver=
 usb
2019-08-18 19:28:53: [    1.387613] pps_core: LinuxPPS API ver. 1 registe=
red
2019-08-18 19:28:53: [    1.391507] pps_core: Software ver. 5.3.6 - Copyr=
ight 2005-2007 Rodolfo Giometti <giometti@linux.it>
2019-08-18 19:28:53: [    1.398467] PTP clock support registered
2019-08-18 19:28:53: [    1.401815] EDAC MC: Ver: 3.0.0
2019-08-18 19:28:53: [    1.405243] Registered efivars operations
2019-08-18 19:28:53: [    1.410496] NetLabel: Initializing
2019-08-18 19:28:53: [    1.413178] NetLabel:  domain hash size =3D 128
2019-08-18 19:28:53: [    1.416476] NetLabel:  protocols =3D UNLABELED CI=
PSOv4 CALIPSO
2019-08-18 19:28:53: [    1.420831] NetLabel:  unlabeled traffic allowed =
by default
2019-08-18 19:28:53: [    1.425529] clocksource: Switched to clocksource =
arch_sys_counter
2019-08-18 19:28:53: [    1.475987] VFS: Disk quotas dquot_6.6.0
2019-08-18 19:28:53: [    1.479046] VFS: Dquot-cache hash table entries: =
8192 (order 0, 65536 bytes)
2019-08-18 19:28:53: [    1.484668] pnp: PnP ACPI init
2019-08-18 19:28:53: [    1.487442] system 00:00: [mem 0x4010000000-0x401=
fffffff window] could not be reserved
2019-08-18 19:28:53: [    1.493432] system 00:00: Plug and Play ACPI devi=
ce, IDs PNP0c02 (active)
2019-08-18 19:28:53: [    1.498747] pnp: PnP ACPI: found 1 devices
2019-08-18 19:28:53: [    1.511481] NET: Registered protocol family 2
2019-08-18 19:28:53: [    1.515382] tcp_listen_portaddr_hash hash table e=
ntries: 4096 (order: 0, 65536 bytes)
2019-08-18 19:28:53: [    1.521710] TCP established hash table entries: 3=
2768 (order: 2, 262144 bytes)
2019-08-18 19:28:53: [    1.527428] TCP bind hash table entries: 32768 (o=
rder: 3, 524288 bytes)
2019-08-18 19:28:53: [    1.532728] TCP: Hash tables configured (establis=
hed 32768 bind 32768)
2019-08-18 19:28:53: [    1.537870] UDP hash table entries: 2048 (order: =
0, 65536 bytes)
2019-08-18 19:28:53: [    1.542465] UDP-Lite hash table entries: 2048 (or=
der: 0, 65536 bytes)
2019-08-18 19:28:53: [    1.547592] NET: Registered protocol family 1
2019-08-18 19:28:53: [    1.550922] NET: Registered protocol family 44
2019-08-18 19:28:53: [    1.555866] pci 0000:01:00.0: enabling device (00=
00 -> 0002)
2019-08-18 19:28:53: [    1.561193] PCI: CLS 0 bytes, default 64
2019-08-18 19:28:53: [    1.564325] Unpacking initramfs...
2019-08-18 19:29:02: [   11.160126] Freeing initrd memory: 53376K
2019-08-18 19:29:02: [   11.164132] hw perfevents: enabled with armv8_pmu=
v3_0 PMU driver, 7 counters available
2019-08-18 19:29:02: [   11.170423] kvm [1]: HYP mode not available
2019-08-18 19:29:03: [   11.236063] Initialise system trusted keyrings
2019-08-18 19:29:03: [   11.239724] workingset: timestamp_bits=3D43 max_o=
rder=3D16 bucket_order=3D0
2019-08-18 19:29:03: [   11.248651] zbud: loaded
2019-08-18 19:29:03: [   11.251053] pstore: using deflate compression
2019-08-18 19:29:03: [   11.254506] SELinux:  Registering netfilter hooks=

2019-08-18 19:29:03: [   11.361618] NET: Registered protocol family 38
2019-08-18 19:29:03: [   11.364989] Key type asymmetric registered
2019-08-18 19:29:03: [   11.368247] Asymmetric key parser 'x509' register=
ed
2019-08-18 19:29:03: [   11.371975] Block layer SCSI generic (bsg) driver=
 version 0.4 loaded (major 247)
2019-08-18 19:29:03: [   11.377849] io scheduler mq-deadline registered
2019-08-18 19:29:03: [   11.381294] io scheduler kyber registered
2019-08-18 19:29:03: [   11.384426] io scheduler bfq registered
2019-08-18 19:29:03: [   11.387695] atomic64_test: passed
2019-08-18 19:29:03: [   11.391610] pl061_gpio ARMH0061:00: PL061 GPIO ch=
ip @0x0000000009030000 registered
2019-08-18 19:29:03: [   11.402679] PCI Interrupt Link [GSI2] enabled at =
IRQ 37
2019-08-18 19:29:03: [   11.414086] PCI Interrupt Link [GSI3] enabled at =
IRQ 38
2019-08-18 19:29:03: [   11.426922] PCI Interrupt Link [GSI0] enabled at =
IRQ 35
2019-08-18 19:29:03: [   11.439580] PCI Interrupt Link [GSI1] enabled at =
IRQ 36
2019-08-18 19:29:03: [   11.456781] pcieport 0000:00:02.0: AER enabled wi=
th IRQ 44
2019-08-18 19:29:03: [   11.462901] pcieport 0000:00:03.0: AER enabled wi=
th IRQ 45
2019-08-18 19:29:03: [   11.467656] pcieport 0000:00:04.0: AER enabled wi=
th IRQ 46
2019-08-18 19:29:03: [   11.472449] pcieport 0000:00:05.0: AER enabled wi=
th IRQ 47
2019-08-18 19:29:03: [   11.477176] pcieport 0000:00:06.0: AER enabled wi=
th IRQ 48
2019-08-18 19:29:03: [   11.481478] pcieport 0000:00:02.0: Signaling PME =
with IRQ 44
2019-08-18 19:29:03: [   11.486778] pcieport 0000:00:03.0: Signaling PME =
with IRQ 45
2019-08-18 19:29:03: [   11.491289] pcieport 0000:00:04.0: Signaling PME =
with IRQ 46
2019-08-18 19:29:03: [   11.495811] pcieport 0000:00:05.0: Signaling PME =
with IRQ 47
2019-08-18 19:29:03: [   11.500308] pcieport 0000:00:06.0: Signaling PME =
with IRQ 48
2019-08-18 19:29:03: [   11.504787] pciehp 0000:00:02.0:pcie004: Slot #2 =
AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoC=
ompl- LLActRep+
2019-08-18 19:29:03: [   11.515087] pciehp 0000:00:03.0:pcie004: Slot #3 =
AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoC=
ompl- LLActRep+
2019-08-18 19:29:03: [   11.525396] pciehp 0000:00:04.0:pcie004: Slot #4 =
AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoC=
ompl- LLActRep+
2019-08-18 19:29:03: [   11.535729] pciehp 0000:00:05.0:pcie004: Slot #5 =
AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoC=
ompl- LLActRep+
2019-08-18 19:29:03: [   11.545590] pciehp 0000:00:05.0:pcie004: Slot(5):=
 Link Up
2019-08-18 19:29:03: [   11.545631] pciehp 0000:00:06.0:pcie004: Slot #6 =
AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoC=
ompl- LLActRep+
2019-08-18 19:29:03: [   11.559755] pciehp 0000:00:06.0:pcie004: Slot(6):=
 Link Up
2019-08-18 19:29:03: [   11.560158] input: Power Button as /devices/LNXSY=
STM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
2019-08-18 19:29:03: [   11.570476] ACPI: Power Button [PWRB]
2019-08-18 19:29:03: [   11.586728] virtio-pci 0000:02:00.0: enabling dev=
ice (0000 -> 0002)
2019-08-18 19:29:03: [   11.601615] virtio-pci 0000:03:00.0: enabling dev=
ice (0000 -> 0002)
2019-08-18 19:29:03: [   11.612170] Serial: 8250/16550 driver, 4 ports, I=
RQ sharing enabled
2019-08-18 19:29:03: [   11.618595] ACPI PPTT: No PPTT table found, cache=
 topology may be inaccurate
2019-08-18 19:29:03: [   11.623944] ACPI PPTT: No PPTT table found, cache=
 topology may be inaccurate
2019-08-18 19:29:03: [   11.629534] cacheinfo: Unable to detect cache hie=
rarchy for CPU 0
2019-08-18 19:29:03: [   11.634193] rdac: device handler registered
2019-08-18 19:29:03: [   11.637682] hp_sw: device handler registered
2019-08-18 19:29:03: [   11.640935] emc: device handler registered
2019-08-18 19:29:03: [   11.644939] alua: device handler registered
2019-08-18 19:29:03: [   11.648654] libphy: Fixed MDIO Bus: probed
2019-08-18 19:29:03: [   11.651996] ehci_hcd: USB 2.0 'Enhanced' Host Con=
troller (EHCI) Driver
2019-08-18 19:29:03: [   11.657159] ehci-pci: EHCI PCI platform driver
2019-08-18 19:29:03: [   11.660590] ohci_hcd: USB 1.1 'Open' Host Control=
ler (OHCI) Driver
2019-08-18 19:29:03: [   11.665268] ohci-pci: OHCI PCI platform driver
2019-08-18 19:29:03: [   11.668859] uhci_hcd: USB Universal Host Controll=
er Interface driver
2019-08-18 19:29:03: [   11.679318] xhci_hcd 0000:01:00.0: xHCI Host Cont=
roller
2019-08-18 19:29:03: [   11.683480] xhci_hcd 0000:01:00.0: new USB bus re=
gistered, assigned bus number 1
2019-08-18 19:29:03: [   11.690611] xhci_hcd 0000:01:00.0: hcc params 0x0=
0087001 hci version 0x100 quirks 0x0000000000000010
2019-08-18 19:29:03: [   11.699963] usb usb1: New USB device found, idVen=
dor=3D1d6b, idProduct=3D0002, bcdDevice=3D 4.18
2019-08-18 19:29:03: [   11.706275] usb usb1: New USB device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
2019-08-18 19:29:03: [   11.711756] usb usb1: Product: xHCI Host Controll=
er
2019-08-18 19:29:03: [   11.715449] usb usb1: Manufacturer: Linux 4.18.0-=
80.el8.aarch64 xhci-hcd
2019-08-18 19:29:03: [   11.720855] usb usb1: SerialNumber: 0000:01:00.0
2019-08-18 19:29:03: [   11.724816] hub 1-0:1.0: USB hub found
2019-08-18 19:29:03: [   11.727916] hub 1-0:1.0: 4 ports detected
2019-08-18 19:29:03: [   11.732089] xhci_hcd 0000:01:00.0: xHCI Host Cont=
roller
2019-08-18 19:29:03: [   11.736293] xhci_hcd 0000:01:00.0: new USB bus re=
gistered, assigned bus number 2
2019-08-18 19:29:03: [   11.742016] xhci_hcd 0000:01:00.0: Host supports =
USB 3.0  SuperSpeed
2019-08-18 19:29:03: [   11.747070] usb usb2: We don't know the algorithm=
s for LPM for this host, disabling LPM.
2019-08-18 19:29:03: [   11.753264] usb usb2: New USB device found, idVen=
dor=3D1d6b, idProduct=3D0003, bcdDevice=3D 4.18
2019-08-18 19:29:03: [   11.759794] usb usb2: New USB device strings: Mfr=
=3D3, Product=3D2, SerialNumber=3D1
2019-08-18 19:29:03: [   11.765257] usb usb2: Product: xHCI Host Controll=
er
2019-08-18 19:29:03: [   11.769181] usb usb2: Manufacturer: Linux 4.18.0-=
80.el8.aarch64 xhci-hcd
2019-08-18 19:29:03: [   11.774262] usb usb2: SerialNumber: 0000:01:00.0
2019-08-18 19:29:03: [   11.778324] hub 2-0:1.0: USB hub found
2019-08-18 19:29:03: [   11.781304] hub 2-0:1.0: 4 ports detected
2019-08-18 19:29:03: [   11.785316] usbcore: registered new interface dri=
ver usbserial_generic
2019-08-18 19:29:03: [   11.790588] usbserial: USB Serial support registe=
red for generic
2019-08-18 19:29:03: [   11.795371] mousedev: PS/2 mouse device common fo=
r all mice
2019-08-18 19:29:03: [   11.800548] rtc-efi rtc-efi: rtc core: registered=
 rtc-efi as rtc0
2019-08-18 19:29:03: [   11.819707] EFI Variables Facility v0.08 2004-May=
-17
2019-08-18 19:29:03: [   11.825612] hidraw: raw HID events driver (C) Jir=
i Kosina
2019-08-18 19:29:03: [   11.829849] usbcore: registered new interface dri=
ver usbhid
2019-08-18 19:29:03: [   11.834065] usbhid: USB HID core driver
2019-08-18 19:29:03: [   11.838088] drop_monitor: Initializing network dr=
op monitor service
2019-08-18 19:29:03: [   11.842951] Initializing XFRM netlink socket
2019-08-18 19:29:03: [   11.846696] NET: Registered protocol family 10
2019-08-18 19:29:03: [   11.850803] Segment Routing with IPv6
2019-08-18 19:29:03: [   11.853621] NET: Registered protocol family 17
2019-08-18 19:29:03: [   11.857205] mpls_gso: MPLS GSO support
2019-08-18 19:29:03: [   11.860818] registered taskstats version 1
2019-08-18 19:29:03: [   11.863961] Loading compiled-in X.509 certificate=
s
2019-08-18 19:29:03: [   11.962190] Loaded X.509 cert 'Red Hat Enterprise=
 Linux kernel signing key: 589b49f029d7d20b4cf56b9b87be5e07e2cc521e'
2019-08-18 19:29:03: [   11.971620] Loaded X.509 cert 'Red Hat Enterprise=
 Linux Driver Update Program (key 3): bf57f3e87362bc7229d9f465321773dfd1f=
77a80'
2019-08-18 19:29:03: [   11.981685] Loaded X.509 cert 'Red Hat Enterprise=
 Linux kpatch signing key: 4d38fd864ebe18c5f0b72e3852e2014c3a676fc8'
2019-08-18 19:29:03: [   11.989984] zswap: loaded using pool lzo/zbud
2019-08-18 19:29:03: [   12.001271] Key type big_key registered
2019-08-18 19:29:03: [   12.004538] rtc-efi rtc-efi: setting system clock=
 to 2019-08-18 23:29:03 UTC (1566170943)
2019-08-18 19:29:03: [   12.018882] Freeing unused kernel memory: 4288K
2019-08-18 19:29:03: [   12.095661] usb 1-1: new high-speed USB device nu=
mber 2 using xhci_hcd
2019-08-18 19:29:03: [   12.117161] systemd[1]: systemd 239 running in sy=
stem mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +L=
IBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMO=
D +IDN2 -IDN +PCRE2 default-hierarchy=3Dlegacy)
2019-08-18 19:29:03: [   12.133848] systemd[1]: Virtualization KVM Virtua=
l Machine found in DMI (/sys/class/dmi/id/product_name)
2019-08-18 19:29:03: [   12.141473] systemd[1]: No virtualization found i=
n CPUID
2019-08-18 19:29:03: [   12.145506] systemd[1]: Found VM virtualization k=
vm
2019-08-18 19:29:03: [   12.149442] systemd[1]: Detected virtualization k=
vm.
2019-08-18 19:29:03: [   12.153215] systemd[1]: Detected architecture arm=
64.
2019-08-18 19:29:03: [   12.157104] systemd[1]: Running in initial RAM di=
sk.
2019-08-18 19:29:03: [   12.161088] systemd[1]: Mounting cgroup to /sys/f=
s/cgroup/cpu,cpuacct of type cgroup with options cpu,cpuacct.
2019-08-18 19:29:03: [   12.170526] systemd[1]: Mounting cgroup to /sys/f=
s/cgroup/freezer of type cgroup with options freezer.
2019-08-18 19:29:03: [   12.179435] systemd[1]: Mounting cgroup to /sys/f=
s/cgroup/cpuset of type cgroup with options cpuset.
2019-08-18 19:29:03:=20
2019-08-18 19:29:04: Welcome to =1B[0;34mRed Hat Enterprise Linux 8.0 (Oo=
tpa) dracut-049-10.git20190115.el8 (Initramfs)=1B[0m!
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.211108] random: systemd: uninitialized urando=
m read (16 bytes read)
2019-08-18 19:29:04: [   12.262778] systemd-gpt-auto-generator[172]: EFI =
loader partition unknown, exiting.
2019-08-18 19:29:04: [   12.272827] systemd-fstab-generator[169]: Could n=
ot find a root=3D entry on the kernel command line.
2019-08-18 19:29:04: [   12.278197] random: ln: uninitialized urandom rea=
d (6 bytes read)
2019-08-18 19:29:04: [   12.282132] usb 1-1: New USB device found, idVend=
or=3D0627, idProduct=3D0001, bcdDevice=3D 0.00
2019-08-18 19:29:04: [   12.286177] random: ln: uninitialized urandom rea=
d (6 bytes read)
2019-08-18 19:29:04: [   12.291497] usb 1-1: New USB device strings: Mfr=3D=
1, Product=3D3, SerialNumber=3D10
2019-08-18 19:29:04: [   12.301572] usb 1-1: Product: QEMU USB Tablet
2019-08-18 19:29:04: [   12.304886] usb 1-1: Manufacturer: QEMU
2019-08-18 19:29:04: [   12.307946] usb 1-1: SerialNumber: 28754-0000:00:=
02.0:00.0-1
2019-08-18 19:29:04: [   12.319925] systemd-fstab-generator[169]: Parsing=
 /etc/fstab
2019-08-18 19:29:04: [   12.324257] systemd-fstab-generator[169]: Parsing=
 /sysroot/etc/fstab
2019-08-18 19:29:04: [   12.332641] input: QEMU QEMU USB Tablet as /devic=
es/pci0000:00/0000:00:02.0/0000:01:00.0/usb1/1-1/1-1:1.0/0003:0627:0001.0=
001/input/input1
2019-08-18 19:29:04: [   12.344731] hid-generic 0003:0627:0001.0001: inpu=
t,hidraw0: USB HID v0.01 Mouse [QEMU QEMU USB Tablet] on usb-0000:01:00.0=
-1/input0
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Soc=
ket.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on Open-iSCSI iscs=
iuio Socket.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on Journal Socket =
(/dev/log).
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Reached target Initrd Root D=
evice.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on Open-iSCSI iscs=
id Socket.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on udev Control So=
cket.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Reached target Slices.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Reached target Timers.
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Listening on Journal Socket.=

2019-08-18 19:29:04:          Starting Journal Service...[   12.475059] s=
ystemd[214]: Operating on architecture: arm
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.481085] systemd[214]: Operating on architectu=
re: arm64
2019-08-18 19:29:04:          [   12.485676] systemd[214]: Operating on a=
rchitecture: arm
2019-08-18 19:29:04: Starting Apply Kernel Variables...[   12.490222] sys=
temd[214]: Operating on architecture: arm64
2019-08-18 19:29:04: [   12.496712] systemd[214]: Operating on architectu=
re: arm
2019-08-18 19:29:04: [   12.500948] systemd[214]: Operating on architectu=
re: arm64
2019-08-18 19:29:04: [   12.505291] systemd[214]: Restricting namespace t=
o: .
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.509450] systemd[214]: Operating on architectu=
re: arm
2019-08-18 19:29:04: [   12.513633] systemd[214]: Blocking cgroup.
2019-08-18 19:29:04: [   12.517726] systemd[214]: Blocking ipc.
2019-08-18 19:29:04: [   12.520709] systemd[214]: Blocking net.
2019-08-18 19:29:04: [   12.523685] systemd[214]: Blocking mnt.
2019-08-18 19:29:04: [   12.523731] systemd[214]: Blocking pid.
2019-08-18 19:29:04: [   12.523772] systemd[214]: Blocking user.
2019-08-18 19:29:04:          [   12.523810] systemd[214]: Blocking uts.
2019-08-18 19:29:04: [   12.524034] systemd[214]: Operating on architectu=
re: arm64
2019-08-18 19:29:04: [   12.524074] systemd[214]: Blocking cgroup.
2019-08-18 19:29:04: [   12.524101] systemd[214]: Blocking ipc.
2019-08-18 19:29:04: Starting iSCSI UserSpace I/O driver...[   12.524128]=
 systemd[214]: Blocking net.
2019-08-18 19:29:04: [   12.524193] systemd[214]: Blocking mnt.
2019-08-18 19:29:04: [   12.524234] systemd[214]: Blocking pid.
2019-08-18 19:29:04: [   12.524286] systemd[214]: Blocking user.
2019-08-18 19:29:04: [   12.524331] systemd[214]: Blocking uts.
2019-08-18 19:29:04: [   12.524903] systemd[214]: Operating on architectu=
re: arm
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Reached target Sockets.[   1=
2.571221] systemd[214]: Failed to add rule for system call epoll_wait_old=
() / -10006, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [   12.581755] systemd[214]: Failed to add rule for =
system call waitpid() / -10073, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.591060] systemd[214]: Failed to add rule for =
system call oldlstat() / -10035, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04:          Starting Create list of required stce nodes=
 for the current kernel...[   12.604018] systemd[214]: Failed to add rule=
 for system call olduname() / -10038, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:04: [   12.614455] systemd[214]: Failed to add rule for =
system call readdir() / -10041, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:04: [   12.623388] systemd[214]: Failed to add rule for =
system call get_thread_area() / -10076, ignoring: Numerical argument out =
of domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.632778] systemd[214]: Failed to add rule for =
system call signal() / -10055, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [   12.641602] systemd[214]: Failed to add rule for =
system call getrlimit() / 163, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [   12.650578] systemd[214]: Failed to add rule for =
system call mmap() / 222, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [   12.658872] systemd[214]: Failed to add rule for =
system call fadvise64() / 223, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [   12.661338] Loading iSCSI transport class v2.0-87=
0.
2019-08-18 19:29:04: [   12.667533] systemd[214]: Failed to add rule for =
system call sync_file_range() / 84, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:04: [   12.680082] systemd[214]: Failed to add rule for =
system call time() / -10108, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m[   12.689023] systemd[214]: F=
ailed to add rule for system call oldolduname() / -10036, ignoring: Numer=
ical argument out of domain
2019-08-18 19:29:04: ] [   12.699058] systemd[214]: Failed to add rule fo=
r system call migrate_pages() / 238, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:04: Reached target Swap.[   12.707919] systemd[214]: Fai=
led to add rule for system call ipc() / -10024, ignoring: Numerical argum=
ent out of domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.717660] systemd[214]: Failed to add rule for =
system call utime() / -10178, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [   12.726204] systemd[214]: Failed to add rule for =
system call oldstat() / -10037, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:04:          [   12.734778] systemd[214]: Failed to add =
rule for system call arch_prctl() / -10001, ignoring: Numerical argument =
out of domain
2019-08-18 19:29:04: [   12.744434] systemd[214]: Failed to add rule for =
system call alarm() / -10148, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [   12.753241] systemd[214]: Failed to add rule for =
system call set_thread_area() / -10079, ignoring: Numerical argument out =
of domain
2019-08-18 19:29:04: Starting Setup Virtual Console...[   12.762608] syst=
emd[214]: Failed to add rule for system call oldfstat() / -10034, ignorin=
g: Numerical argument out of domain
2019-08-18 19:29:04: [   12.773889] systemd[214]: Failed to add rule for =
system call newfstatat() / 79, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [   12.782946] systemd[214]: Failed to add rule for =
system call epoll_ctl_old() / -10005, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.792341] systemd[214]: Failed to add rule for =
system call fadvise64_64() / -10007, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:04: [   12.801532] systemd[214]: Failed to add rule for =
system call select() / -10101, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m[   12.810398] systemd[214]: F=
ailed to add rule for system call socketcall() / -10060, ignoring: Numeri=
cal argument out of domain
2019-08-18 19:29:04: ] Started Apply Kernel Variables.[   12.827477] syst=
emd[214]: Operating on architecture: arm64
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.833681] systemd[214]: Failed to add rule for =
system call eventfd() / -10155, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:04: [   12.842646] systemd[214]: Failed to add rule for =
system call fchown32() / -10008, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: [   12.851742] systemd[214]: Failed to add rule for =
system call ftruncate64() / -10014, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:04: [[   12.860764] systemd[214]: Failed to add rule for=
 system call signalfd() / -10173, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:04: =1B[0;32m  OK  =1B[0m[   12.869635] systemd[214]: Fa=
iled to add rule for system call stat64() / -10062, ignoring: Numerical a=
rgument out of domain
2019-08-18 19:29:04: [   12.879311] systemd[214]: Failed to add rule for =
system call readlink() / -10170, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: ] [   12.887980] systemd[214]: Failed to add rule fo=
r system call getpgrp() / -10159, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:04: [   12.896589] systemd[214]: Failed to add rule for =
system call epoll_wait_old() / -10006, ignoring: Numerical argument out o=
f domain
2019-08-18 19:29:04: Started iSCSI UserSpace I/O driver.[   12.905495] sy=
stemd[214]: Failed to add rule for system call waitpid() / -10073, ignori=
ng: Numerical argument out of domain
2019-08-18 19:29:04: [   12.916949] systemd[214]: Failed to add rule for =
system call lchown() / -10161, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.925337] systemd[214]: Failed to add rule for =
system call setreuid32() / -10051, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:04: [   12.934609] systemd[214]: Failed to add rule for =
system call set_tls() / -10183, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:04: [[   12.943520] systemd[214]: Failed to add rule for=
 system call setgid32() / -10046, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:04: =1B[0;32m  OK  =1B[0m[   12.952490] systemd[214]: Fa=
iled to add rule for system call oldlstat() / -10035, ignoring: Numerical=
 argument out of domain
2019-08-18 19:29:04: ] [   12.962487] systemd[214]: Failed to add rule fo=
r system call send() / -109, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: Started Create list of required stavice nodes for th=
e current kernel.[   12.971053] systemd[214]: Failed to add rule for syst=
em call _newselect() / -10032, ignoring: Numerical argument out of domain=

2019-08-18 19:29:04: [   12.984910] systemd[214]: Failed to add rule for =
system call pause() / -10167, ignoring: Numerical argument out of domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   12.993662] systemd[214]: Failed to add rule for =
system call olduname() / -10038, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: [   13.002673] systemd[214]: Failed to add rule for =
system call lchown32() / -10025, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: [[   13.011532] systemd[214]: Failed to add rule for=
 system call readdir() / -10041, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: [   13.020320] systemd[214]: Failed to add rule for =
system call setfsgid32() / -10044, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:04: =1B[0;32m  OK  =1B[0m[   13.029145] systemd[214]: Fa=
iled to add rule for system call get_thread_area() / -10076, ignoring: Nu=
merical argument out of domain
2019-08-18 19:29:04: ] [   13.039430] systemd[214]: Failed to add rule fo=
r system call signal() / -10055, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:04: Started Setup Virtual Console.[   13.048077] systemd=
[214]: Failed to add rule for system call lstat64() / -10028, ignoring: N=
umerical argument out of domain
2019-08-18 19:29:04: [   13.058667] systemd[214]: Failed to add rule for =
system call setregid32() / -10048, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   13.067427] systemd[214]: Failed to add rule for =
system call fstatfs64() / -10012, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:04: [   13.076194] systemd[214]: Failed to add rule for =
system call sigprocmask() / -10057, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:04:          [   13.084966] systemd[214]: Failed to add =
rule for system call futimesat() / -10157, ignoring: Numerical argument o=
ut of domain
2019-08-18 19:29:04: Starting dracut cmdline hook...[   13.094623] system=
d[214]: Failed to add rule for system call mkdir() / -10164, ignoring: Nu=
merical argument out of domain
2019-08-18 19:29:04: [   13.105461] systemd[214]: Failed to add rule for =
system call pipe() / -10168, ignoring: Numerical argument out of domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   13.115385] systemd[214]: Failed to add rule for =
system call creat() / -10151, ignoring: Numerical argument out of domain
2019-08-18 19:29:04:          [   13.135654] systemd[214]: Failed to add =
rule for system call time() / -10108, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:04: Starting Create Static Device Nodes in /dev...[   13=
=2E143914] systemd[214]: Failed to add rule for system call epoll_wait() =
/ -10154, ignoring: Numerical argument out of domain
2019-08-18 19:29:04:=20
2019-08-18 19:29:04: [   13.158285] systemd[214]: Failed to add rule for =
system call sigsuspend() / -10059, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:04: [   13.168177] systemd[214]: Failed to add rule for =
system call setresgid32() / -10049, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:04: [=1B[0;32m  OK  =1B[0m] Started Create Static Device=
 Nodes in /dev.
2019-08-18 19:29:04: [   13.184205] systemd[214]: Failed to add rule for =
system call open() / -10166, ignoring: Numerical argument out of domain
2019-08-18 19:29:04: [   13.193141] systemd[214]: Failed to add rule for =
system call fstat64() / -10010, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.202345] systemd[214]: Failed to add rule for =
system call setresuid32() / -10050, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.211461] systemd[214]: Failed to add rule for =
system call fcntl64() / -10009, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.220411] systemd[214]: Failed to add rule for =
system call oldolduname() / -10036, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.229458] systemd[214]: Failed to add rule for =
system call setfsuid32() / -10045, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.239854] systemd[214]: Failed to add rule for =
system call getuid32() / -10021, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.248593] systemd[214]: Failed to add rule for =
system call statfs64() / -10063, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.257326] systemd[214]: Failed to add rule for =
system call chown32() / -10004, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.265856] systemd[214]: Failed to add rule for =
system call ipc() / -10024, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.274077] systemd[214]: Failed to add rule for =
system call getegid32() / -10015, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:05: [   13.283181] systemd[214]: Failed to add rule for =
system call truncate64() / -10066, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.292293] systemd[214]: Failed to add rule for =
system call sigaction() / -10054, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:05: [   13.301311] systemd[214]: Failed to add rule for =
system call geteuid32() / -10016, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:05: [   13.310190] systemd[214]: Failed to add rule for =
system call sigpending() / -10056, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.319246] systemd[214]: Failed to add rule for =
system call utime() / -10178, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.327756] systemd[214]: Failed to add rule for =
system call fork() / -10156, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.336236] systemd[214]: Failed to add rule for =
system call oldstat() / -10037, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.344759] systemd[214]: Failed to add rule for =
system call getdents() / -10158, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.353832] systemd[214]: Failed to add rule for =
system call rmdir() / -10172, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.362670] systemd[214]: Failed to add rule for =
system call arch_prctl() / -10001, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.371774] systemd[214]: Failed to add rule for =
system call alarm() / -10148, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.380526] systemd[214]: Failed to add rule for =
system call chown() / -10150, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.389158] systemd[214]: Failed to add rule for =
system call recv() / -110, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.397672] systemd[214]: Failed to add rule for =
system call set_thread_area() / -10079, ignoring: Numerical argument out =
of domain
2019-08-18 19:29:05: [   13.406799] systemd[214]: Failed to add rule for =
system call chmod() / -10149, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.415166] systemd[214]: Failed to add rule for =
system call oldfstat() / -10034, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.424338] systemd[214]: Failed to add rule for =
system call getgid32() / -10017, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.433397] systemd[214]: Failed to add rule for =
system call setgroups32() / -10047, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.442549] systemd[214]: Failed to add rule for =
system call _llseek() / -10026, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.451364] systemd[214]: Failed to add rule for =
system call stat() / -10174, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.459987] systemd[214]: Failed to add rule for =
system call unlink() / -10176, ignoring: Numerical argument out of domain=

2019-08-18 19:29:05: [   13.468594] systemd[214]: Failed to add rule for =
system call setuid32() / -10052, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:05: [   13.477291] systemd[214]: Failed to add rule for =
system call lstat() / -10163, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.485687] systemd[214]: Failed to add rule for =
system call symlink() / -10175, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:05: [   13.494151] systemd[214]: Failed to add rule for =
system call link() / -10162, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.502926] systemd[214]: Failed to add rule for =
system call rename() / -10171, ignoring: Numerical argument out of domain=

2019-08-18 19:29:05: [   13.511746] systemd[214]: Failed to add rule for =
system call sendfile64() / -10043, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.520742] systemd[214]: Failed to add rule for =
system call dup2() / -10152, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.529315] systemd[214]: Failed to add rule for =
system call epoll_create() / -10153, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:05: [   13.538459] systemd[214]: Failed to add rule for =
system call vfork() / -10102, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.546918] systemd[214]: Failed to add rule for =
system call access() / -10147, ignoring: Numerical argument out of domain=

2019-08-18 19:29:05: [   13.555404] systemd[214]: Failed to add rule for =
system call epoll_ctl_old() / -10005, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:05: [   13.565576] systemd[214]: Failed to add rule for =
system call sigreturn() / -10058, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:05: [   13.574188] systemd[214]: Failed to add rule for =
system call fstatat64() / -10011, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:05: [   13.583349] systemd[214]: Failed to add rule for =
system call getgroups32() / -10018, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.592472] systemd[214]: Failed to add rule for =
system call mmap2() / -10029, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.601162] systemd[214]: Failed to add rule for =
system call fadvise64_64() / -10007, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:05: [   13.610249] systemd[214]: Failed to add rule for =
system call nice() / -10033, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.618836] systemd[214]: Failed to add rule for =
system call select() / -10101, ignoring: Numerical argument out of domain=

2019-08-18 19:29:05: [   13.627433] systemd[214]: Failed to add rule for =
system call ugetrlimit() / -10068, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.636245] systemd[214]: Failed to add rule for =
system call poll() / -10169, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.644558] systemd[214]: Failed to add rule for =
system call inotify_init() / -10160, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:05: [   13.653887] systemd[214]: Failed to add rule for =
system call getresgid32() / -10019, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.663176] systemd[214]: Failed to add rule for =
system call socketcall() / -10060, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:05: [   13.672255] systemd[214]: Failed to add rule for =
system call utimes() / -10179, ignoring: Numerical argument out of domain=

2019-08-18 19:29:05: [   13.681006] systemd[214]: Failed to add rule for =
system call getresuid32() / -10020, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:05: [   13.689987] systemd[214]: Failed to add rule for =
system call mknod() / -10165, ignoring: Numerical argument out of domain
2019-08-18 19:29:05: [   13.701489] iscsi: registered transport (tcp)
2019-08-18 19:29:05: [   13.721150] systemd-journald[214]: Found cgroup o=
n /sys/fs/cgroup/systemd, legacy hierarchy
2019-08-18 19:29:05: [   13.729401] systemd-journald[214]: Journal effect=
ive settings seal=3Dno compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:05: [   13.737482] systemd-journald[214]: Fixed min_use=3D=
1.0M max_use=3D199.6M max_size=3D25.0M min_size=3D512.0K keep_free=3D299.=
3M n_max_files=3D100
2019-08-18 19:29:05: [   13.747425] systemd-journald[214]: Reserving 4551=
1 entries in hash table.
2019-08-18 19:29:05: [   13.752724] systemd-journald[214]: Vacuuming...
2019-08-18 19:29:05: [   13.756343] systemd-journald[214]: Vacuuming done=
, freed 0B of archived journals from /run/log/journal/61fd381d9a264007a03=
e9ca48a48282c.
2019-08-18 19:29:05: [   13.766242] systemd-journald[214]: Flushing /dev/=
kmsg...
2019-08-18 19:29:05: [   13.766503] iscsi: registered transport (qla4xxx)=

2019-08-18 19:29:05: [   13.773900] QLogic iSCSI HBA Driver
2019-08-18 19:29:05: [   13.775633] pciehp 0000:00:05.0:pcie004: Failed t=
o check link status
2019-08-18 19:29:05: [   13.781674] pciehp 0000:00:06.0:pcie004: Failed t=
o check link status
2019-08-18 19:29:05: [   13.790467] libcxgbi:libcxgbi_init_module: Chelsi=
o iSCSI driver library libcxgbi v0.9.1-ko (Apr. 2015)
2019-08-18 19:29:05: [   13.850800] systemd-journald[214]: systemd-journa=
ld running as pid 214
2019-08-18 19:29:05: [=1B[0;32m  OK  =1B[0m] Started Journal Service.
2019-08-18 19:29:05: [   13.860633] systemd-journald[214]: Sent READY=3D1=
 notification.
2019-08-18 19:29:05: [   13.864562] Chelsio T4-T6 iSCSI Driver cxgb4i v0.=
9.5-ko (Apr. 2015)
2019-08-18 19:29:05: [   13.865235] systemd-journald[214]: Sent WATCHDOG=3D=
1 notification.
2019-08-18 19:29:05: [   13.870120] iscsi: registered transport (cxgb4i)
2019-08-18 19:29:05: [   13.898621] iscsi: registered transport (be2iscsi=
)
2019-08-18 19:29:05: [   13.902280] In beiscsi_module_init, tt=3D(____ptr=
val____)
2019-08-18 19:29:05: [=1B[0;32m  OK  =1B[0m] Started dracut cmdline hook.=

2019-08-18 19:29:05:          Starting dracut pre-udev hook...
2019-08-18 19:29:05: [   13.822698] dracut-pre-udev[473]: cramfs was load=
ed
2019-08-18 19:29:05: [   14.110073] squashfs: version 4.0 (2009/01/31) Ph=
illip Lougher
2019-08-18 19:29:05: [   13.847853] dracut-pre-udev[473]: squashfs was lo=
aded
2019-08-18 19:29:05: [   13.860350] dracut-pre-udev[473]: iscsi_tcp was l=
oaded
2019-08-18 19:29:05: [   13.864868] dracut-pre-udev[473]: modprobe: FATAL=
: Module floppy not found in directory /lib/modules/4.18.0-80.el8.aarch64=

2019-08-18 19:29:05: [   13.874118] dracut-pre-udev[473]: floppy was NOT =
loaded
2019-08-18 19:29:05: [   13.878713] dracut-pre-udev[473]: modprobe: FATAL=
: Module edd not found in directory /lib/modules/4.18.0-80.el8.aarch64
2019-08-18 19:29:05: [   13.887681] dracut-pre-udev[473]: edd was NOT loa=
ded
2019-08-18 19:29:05: [   13.892099] dracut-pre-udev[473]: modprobe: FATAL=
: Module iscsi_ibft not found in directory /lib/modules/4.18.0-80.el8.aar=
ch64
2019-08-18 19:29:05: [   13.901411] dracut-pre-udev[473]: iscsi_ibft was =
NOT loaded
2019-08-18 19:29:05: [   13.910959] dracut-pre-udev[473]: raid0 was loade=
d
2019-08-18 19:29:06: [   13.930493] dracut-pre-udev[473]: raid1 was loade=
d
2019-08-18 19:29:06: [   14.395594] raid6: int64x1  gen()  1095 MB/s
2019-08-18 19:29:06: [   14.565599] raid6: int64x1  xor()   271 MB/s
2019-08-18 19:29:06: [   14.735599] raid6: int64x2  gen()  1433 MB/s
2019-08-18 19:29:06: [   14.905646] raid6: int64x2  xor()   313 MB/s
2019-08-18 19:29:06: [   15.075567] raid6: int64x4  gen()  1687 MB/s
2019-08-18 19:29:07: [   15.245591] raid6: int64x4  xor()   338 MB/s
2019-08-18 19:29:07: [   15.415590] raid6: int64x8  gen()  1502 MB/s
2019-08-18 19:29:07: [   15.585568] raid6: int64x8  xor()   282 MB/s
2019-08-18 19:29:07: [   15.755568] raid6: neonx1   gen()  1708 MB/s
2019-08-18 19:29:07: [   15.925631] raid6: neonx1   xor()   403 MB/s
2019-08-18 19:29:07: [   16.095572] raid6: neonx2   gen()  2063 MB/s
2019-08-18 19:29:08: [   16.265581] raid6: neonx2   xor()   490 MB/s
2019-08-18 19:29:08: [   16.435585] raid6: neonx4   gen()  2323 MB/s
2019-08-18 19:29:08: [   16.605613] raid6: neonx4   xor()   522 MB/s
2019-08-18 19:29:08: [   16.775568] raid6: neonx8   gen()  2282 MB/s
2019-08-18 19:29:08: [   16.945582] raid6: neonx8   xor()   527 MB/s
2019-08-18 19:29:08: [   16.948820] raid6: using algorithm neonx4 gen() 2=
323 MB/s
2019-08-18 19:29:08: [   16.952915] raid6: .... xor() 522 MB/s, rmw enabl=
ed
2019-08-18 19:29:08: [   16.956719] raid6: using neon recovery algorithm
2019-08-18 19:29:08: [   16.962635] async_tx: api initialized (async)
2019-08-18 19:29:08: [   16.968656] xor: measuring software checksum spee=
d
2019-08-18 19:29:08: [   17.065596]    8regs     :  1203.200 MB/sec
2019-08-18 19:29:08: [   17.165563]    8regs_prefetch:  1760.000 MB/sec
2019-08-18 19:29:09: [   17.265583]    32regs    :  1292.800 MB/sec
2019-08-18 19:29:09: [   17.365564]    32regs_prefetch:  3129.600 MB/sec
2019-08-18 19:29:09: [   17.369067] xor: using function: 32regs_prefetch =
(3129.600 MB/sec)
2019-08-18 19:29:09: [   17.142623] dracut-pre-udev[473]: raid5 was loade=
d
2019-08-18 19:29:09: [   17.153692] dracut-pre-udev[473]: raid6 was loade=
d
2019-08-18 19:29:09: [   17.165432] dracut-pre-udev[473]: raid456 was loa=
ded
2019-08-18 19:29:09: [   17.187252] dracut-pre-udev[473]: raid10 was load=
ed
2019-08-18 19:29:09: [   17.202074] dracut-pre-udev[473]: linear was load=
ed
2019-08-18 19:29:09: [   17.504021] device-mapper: uevent: version 1.0.3
2019-08-18 19:29:09: [   17.507989] device-mapper: ioctl: 4.39.0-ioctl (2=
018-04-03) initialised: dm-devel@redhat.com
2019-08-18 19:29:09: [   17.247758] dracut-pre-udev[473]: dm-mod was load=
ed
2019-08-18 19:29:09: [   17.262262] dracut-pre-udev[473]: dm-zero was loa=
ded
2019-08-18 19:29:09: [   17.286068] dracut-pre-udev[473]: dm-mirror was l=
oaded
2019-08-18 19:29:09: [   17.312156] dracut-pre-udev[473]: dm-snapshot was=
 loaded
2019-08-18 19:29:09: [   17.330258] dracut-pre-udev[473]: dm-multipath wa=
s loaded
2019-08-18 19:29:09: [   17.611607] device-mapper: multipath round-robin:=
 version 1.2.0 loaded
2019-08-18 19:29:09: [   17.349894] dracut-pre-udev[473]: dm-round-robin =
was loaded
2019-08-18 19:29:09: [   17.369146] dracut-pre-udev[473]: dm-crypt was lo=
aded
2019-08-18 19:29:09: [   17.385235] dracut-pre-udev[473]: cbc was loaded
2019-08-18 19:29:09: [   17.401693] dracut-pre-udev[473]: sha256 was load=
ed
2019-08-18 19:29:09: [   17.416608] dracut-pre-udev[473]: lrw was loaded
2019-08-18 19:29:09: [   17.430920] dracut-pre-udev[473]: xts was loaded
2019-08-18 19:29:09: [   17.788605] RPC: Registered named UNIX socket tra=
nsport module.
2019-08-18 19:29:09: [   17.793121] RPC: Registered udp transport module.=

2019-08-18 19:29:09: [   17.796823] RPC: Registered tcp transport module.=

2019-08-18 19:29:09: [   17.800404] RPC: Registered tcp NFSv4.1 backchann=
el transport module.
2019-08-18 19:29:09: [=1B[0;32m  OK  =1B[0m] Started dracut pre-udev hook=
=2E
2019-08-18 19:29:09:          Starting udev Kernel Device Manager...
2019-08-18 19:29:09: [=1B[0;32m  OK  =1B[0m] Started udev Kernel Device M=
anager.
2019-08-18 19:29:09:          Starting dracut pre-trigger hook...
2019-08-18 19:29:10: [   18.025086] dracut-pre-trigger[672]: /tmp/dd_disk=
 file was not created
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Started dracut pre-trigger h=
ook.
2019-08-18 19:29:10:          Starting udev Coldplug all Devices...
2019-08-18 19:29:10:          Mounting Kernel Configuration File System..=
=2E
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Mounted Kernel Configuration=
 File System.
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Started udev Coldplug all De=
vices.
2019-08-18 19:29:10:          Starting Show Plymouth Boot Screen...
2019-08-18 19:29:10:          Starting udev Wait for Complete Device Init=
ialization...
2019-08-18 19:29:10: [   18.756825] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:10: [   18.797090] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Started Show Plymouth Boot S=
creen.
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Reached target Local Encrypt=
ed Volumes.
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Reached target Paths.[   18.=
860527] scsi host0: Virtio SCSI HBA
2019-08-18 19:29:10:=20
2019-08-18 19:29:10: [=1B[0;32m  OK  =1B[0m] Started Forward Password Req=
uests to Plymouth Directory Watch.[   18.884690] scsi 0:0:0:0: Direct-Acc=
ess     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
2019-08-18 19:29:10: [   18.913388] scsi 0:0:1:0: CD-ROM            QEMU =
    QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
2019-08-18 19:29:10:=20
2019-08-18 19:29:10: [   18.952713] scsi 0:0:2:0: CD-ROM            QEMU =
    QEMU CD-ROM      2.5+ PQ: 0 ANSI: 5
2019-08-18 19:29:10: [   19.034432] virtio_net virtio2 ens4: renamed from=
 eth0
2019-08-18 19:29:10: [   19.046300] [drm] pci: virtio-gpu-pci detected at=
 0000:00:01.0
2019-08-18 19:29:10: [   19.051746] [drm] virgl 3d acceleration not suppo=
rted by host
2019-08-18 19:29:10: [   19.059514] [TTM] Zone  kernel: Available graphic=
s memory: 2043744 kiB
2019-08-18 19:29:10: [   19.064900] [TTM] Initializing pool allocator
2019-08-18 19:29:10: [   19.068675] [TTM] Initializing DMA pool allocator=

2019-08-18 19:29:10: [   19.072657] [drm] number of scanouts: 1
2019-08-18 19:29:10: [   19.075924] [drm] number of cap sets: 0
2019-08-18 19:29:10: [   19.081820] Console: switching to colour frame bu=
ffer device 128x48
2019-08-18 19:29:10: [   19.105572] virtio_gpu virtio0: fb0: virtiodrmfb =
frame buffer device
2019-08-18 19:29:10: [   19.155640] [drm] Initialized virtio_gpu 0.0.1 0 =
for virtio0 on minor 0
2019-08-18 19:29:10: [   19.173022] random: fast init done
2019-08-18 19:29:10: [   19.199976] sd 0:0:0:0: Power-on or device reset =
occurred
2019-08-18 19:29:11: [   19.206334] sd 0:0:0:0: [sda] 20971520 512-byte l=
ogical blocks: (10.7 GB/10.0 GiB)
2019-08-18 19:29:11: [   19.212332] sd 0:0:0:0: [sda] Write Protect is of=
f
2019-08-18 19:29:11: [   19.216046] sd 0:0:0:0: [sda] Mode Sense: 63 00 0=
0 08
2019-08-18 19:29:11: [   19.220341] sd 0:0:0:0: [sda] Write cache: enable=
d, read cache: enabled, doesn't support DPO or FUA
2019-08-18 19:29:11: [   19.234338] sd 0:0:0:0: [sda] Attached SCSI disk
2019-08-18 19:29:11: [   19.285186] sr 0:0:1:0: Power-on or device reset =
occurred
2019-08-18 19:29:11: [   19.299159] sr 0:0:1:0: [sr0] scsi3-mmc drive: 16=
x/50x cd/rw xa/form2 cdda tray
2019-08-18 19:29:11: [   19.305234] cdrom: Uniform CD-ROM driver Revision=
: 3.20
2019-08-18 19:29:11: [   19.312440] sr 0:0:1:0: Attached scsi CD-ROM sr0
2019-08-18 19:29:11: [   19.317098] sr 0:0:2:0: Power-on or device reset =
occurred
2019-08-18 19:29:11: [   19.322394] sr 0:0:2:0: [sr1] scsi3-mmc drive: 16=
x/50x cd/rw xa/form2 cdda tray
2019-08-18 19:29:11: [   19.332952] sr 0:0:2:0: Attached scsi CD-ROM sr1
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Started udev Wait for Comple=
te Device Initialization.
2019-08-18 19:29:11:          Starting Device-Mapper Multipath Device Con=
troller...[   19.885391] systemd-journald[214]: Successfully sent stream =
file descriptor to service manager.
2019-08-18 19:29:11:=20
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Started Device-Mapper Multip=
ath Device Controller.[   19.906463] systemd-journald[214]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:29:11: [   19.915281] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:11:=20
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Reached target Local File Sy=
stems (Pre).
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Reached target Local File Sy=
stems.
2019-08-18 19:29:11:          Starting Create Volatile Files and Director=
ies...
2019-08-18 19:29:11:          Starting Open-iSCSI...
2019-08-18 19:29:11: [   19.946908] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Started Create Volatile File=
s and Directories.
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Reached target System Initia=
lization.
2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Reached target Basic System.=

2019-08-18 19:29:11: [=1B[0;32m  OK  =1B[0m] Started Open-iSCSI.
2019-08-18 19:29:11:          Starting dracut initqueue hook...
2019-08-18 19:29:11: [   20.025412] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:11: [   20.033035] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:11: [   19.840179] dracut-initqueue[878]: Bus n/a: chang=
ing state UNSET  OPENING
2019-08-18 19:29:11: [   19.846347] dracut-initqueue[878]: Bus n/a: chang=
ing state OPENING  AUTHENTICATING
2019-08-18 19:29:11: [   19.846580] dracut-initqueue[878]: Bus n/a: chang=
ing state AUTHENTICATING  RUNNING
2019-08-18 19:29:11: [   19.855798] dracut-initqueue[878]: Sent message t=
ype=3Dmethod_call sender=3Dn/a destination=3Dorg.freedesktop.systemd1 pat=
h=3D/org/freedesktop/systemd1 interface=3Dorg.freedesktop.systemd1.Manage=
r member=3DReload cookie=3D1 reply_cookie=3D0 signature=3Dn/a error-name=3D=
n/a error-message=3Dn/a
2019-08-18 19:29:12: [   20.256082] systemd-fstab-generator[895]: Could n=
ot find a root=3D entry on the kernel command line.
2019-08-18 19:29:12: [   20.262978] systemd-fstab-generator[895]: Parsing=
 /etc/fstab
2019-08-18 19:29:12: [   20.274298] systemd-gpt-auto-generator[909]: EFI =
loader partition unknown, exiting.
2019-08-18 19:29:12: [   20.284803] systemd-fstab-generator[895]: Parsing=
 /sysroot/etc/fstab
2019-08-18 19:29:12: [   20.151357] dracut-initqueue[878]: Got message ty=
pe=3Dmethod_return sender=3Dorg.freedesktop.systemd1 destination=3Dn/a pa=
th=3Dn/a interface=3Dn/a member=3Dn/a cookie=3D248 reply_cookie=3D1 signa=
ture=3Dn/a error-name=3Dn/a error-message=3Dn/a
2019-08-18 19:29:12: [   20.167014] dracut-initqueue[878]: Bus n/a: chang=
ing state RUNNING  CLOSED
2019-08-18 19:29:12: [   20.421554] dracut-initqueue[878]: /usr/sbin/fetc=
h-kickstart-disk: line 24: rmdir: command not found
2019-08-18 19:29:15: [   23.704064] dracut-initqueue[878]: /tmp/dd_disk f=
ile was not created
2019-08-18 19:29:15: [   23.743972] dracut-initqueue[878]: device-enumera=
tor: scan all dirs
2019-08-18 19:29:15: [   23.744212] dracut-initqueue[878]:   device-enume=
rator: scanning /sys/bus
2019-08-18 19:29:15: [   23.744390] dracut-initqueue[878]:   device-enume=
rator: scanning /sys/class
2019-08-18 19:29:17: [   25.355130] ISO 9660 Extensions: Microsoft Joliet=
 Level 3
2019-08-18 19:29:17: [   25.365310] ISO 9660 Extensions: RRIP_1991A
2019-08-18 19:29:17: [   25.094368] dracut-initqueue[878]: mount: /run/in=
stall/repo: WARNING: device write-protected, mounted read-only.
2019-08-18 19:29:17: [   25.704865] loop: module loaded
2019-08-18 19:29:17: [=1B[0;32m  OK  =1B[0m] Started dracut initqueue hoo=
k.
2019-08-18 19:29:17:          Starting dracut pre-mount hook...
2019-08-18 19:29:17: [=1B[0;32m  OK  =1B[0m] Reached target Remote File S=
ystems (Pre).[   26.187871] systemd-journald[214]: Successfully sent stre=
am file descriptor to service manager.
2019-08-18 19:29:17:=20
2019-08-18 19:29:17: [   26.194755] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Reached target Remote File S=
ystems.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Started dracut pre-mount hoo=
k.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Reached target Initrd Root F=
ile System.
2019-08-18 19:29:18:          Starting Reload Configuration from the Real=
 Root...[   26.252189] systemd-journald[214]: Successfully sent stream fi=
le descriptor to service manager.
2019-08-18 19:29:18:=20
2019-08-18 19:29:18: [   26.363580] systemd-fstab-generator[1375]: Could =
not find a root=3D entry on the kernel command line.
2019-08-18 19:29:18: [   26.372052] systemd-gpt-auto-generator[1376]: EFI=
 loader partition unknown, exiting.
2019-08-18 19:29:18: [   26.390785] systemd-fstab-generator[1375]: Parsin=
g /etc/fstab
2019-08-18 19:29:18: [   26.395204] systemd-fstab-generator[1375]: Parsin=
g /sysroot/etc/fstab
2019-08-18 19:29:18: [   26.599498] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:18: [   26.642017] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Started Reload Configuration=
 from the Real Root.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Reached target Initrd File S=
ystems.
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Reached target Initrd Defaul=
t Target.[   26.683993] systemd-journald[214]: Successfully sent stream f=
ile descriptor to service manager.
2019-08-18 19:29:18:=20
2019-08-18 19:29:18:          Starting dracut mount hook...
2019-08-18 19:29:18: [   26.698037] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:18: [   26.896202] EXT4-fs (dm-0): mounted filesystem wi=
th ordered data mode. Opts: (null)
2019-08-18 19:29:18: [=1B[0;32m  OK  =1B[0m] Started dracut mount hook.
2019-08-18 19:29:18: [   26.971002] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:18:          Starting dracut pre-pivot and cleanup hook.=
=2E.
2019-08-18 19:29:18: [   26.996537] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Started dracut pre-pivot and=
 cleanup hook.
2019-08-18 19:29:19:          Starting Cleaning Up and Shutting Down Daem=
ons...
2019-08-18 19:29:19: [   27.420434] systemd-journald[214]: Successfully s=
ent stream file descriptor to service manager.
2019-08-18 19:29:19:          Starting Plymouth switch root service...
2019-08-18 19:29:19:          Starting Setup Virtual Console...
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Timers.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut pre-pivot and=
 cleanup hook.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Initrd Defaul=
t Target.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Initrd Root D=
evice.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut mount hook.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut pre-mount hoo=
k.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Remote File S=
ystems.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Remote File S=
ystems (Pre).
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut initqueue hoo=
k.
2019-08-18 19:29:19:          Stopping Open-iSCSI...
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Basic System.=

2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Sockets.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target System Initia=
lization.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Create Volatile File=
s and Directories.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Local File Sy=
stems.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Local File Sy=
stems (Pre).
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Local Encrypt=
ed Volumes.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Apply Kernel Variabl=
es.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Swap.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Slices.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped target Paths.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Started Setup Virtual Consol=
e.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Open-iSCSI.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Started Cleaning Up and Shut=
ting Down Daemons.
2019-08-18 19:29:19:          Stopping Device-Mapper Multipath Device Con=
troller...
2019-08-18 19:29:19:          Stopping iSCSI UserSpace I/O driver...
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Closed Open-iSCSI iscsid Soc=
ket.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped iSCSI UserSpace I/O =
driver.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Closed Open-iSCSI iscsiuio S=
ocket.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Device-Mapper Multip=
ath Device Controller.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped udev Wait for Comple=
te Device Initialization.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped udev Coldplug all De=
vices.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut pre-trigger h=
ook.
2019-08-18 19:29:19:          Stopping udev Kernel Device Manager...
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Started Plymouth switch root=
 service.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped udev Kernel Device M=
anager.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut pre-udev hook=
=2E
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped dracut cmdline hook.=

2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Create Static Device=
 Nodes in /dev.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Stopped Create list of requi=
red stavice nodes for the current kernel.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Closed udev Kernel Socket.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Closed udev Control Socket.
2019-08-18 19:29:19:          Starting Cleanup udevd DB...
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Started Cleanup udevd DB.
2019-08-18 19:29:19: [=1B[0;32m  OK  =1B[0m] Reached target Switch Root.
2019-08-18 19:29:19:          Starting Switch Root...
2019-08-18 19:29:19: [   27.916061] systemd-journal: 23 output lines supp=
ressed due to ratelimiting
2019-08-18 19:29:19: [   28.049212] systemd: 300 output lines suppressed =
due to ratelimiting
2019-08-18 19:29:21: [   30.021462] SELinux: 32768 avtab hash slots, 1167=
61 rules.
2019-08-18 19:29:21: [   30.087055] SELinux: 32768 avtab hash slots, 1167=
61 rules.
2019-08-18 19:29:23: [   31.346864] SELinux:  8 users, 14 roles, 5165 typ=
es, 324 bools, 1 sens, 1024 cats
2019-08-18 19:29:23: [   31.352576] SELinux:  129 classes, 116761 rules
2019-08-18 19:29:23: [   31.372106] SELinux:  Class bpf not defined in po=
licy.
2019-08-18 19:29:23: [   31.376059] SELinux:  Class xdp_socket not define=
d in policy.
2019-08-18 19:29:23: [   31.380445] SELinux: the above unknown classes an=
d permissions will be allowed
2019-08-18 19:29:23: [   31.385982] SELinux:  policy capability network_p=
eer_controls=3D1
2019-08-18 19:29:23: [   31.390492] SELinux:  policy capability open_perm=
s=3D1
2019-08-18 19:29:23: [   31.394261] SELinux:  policy capability extended_=
socket_class=3D1
2019-08-18 19:29:23: [   31.398971] SELinux:  policy capability always_ch=
eck_network=3D0
2019-08-18 19:29:23: [   31.403408] SELinux:  policy capability cgroup_se=
clabel=3D1
2019-08-18 19:29:23: [   31.407647] SELinux:  policy capability nnp_nosui=
d_transition=3D1
2019-08-18 19:29:23: [   31.412148] SELinux:  Completing initialization.
2019-08-18 19:29:23: [   31.415699] SELinux:  Setting up existing superbl=
ocks.
2019-08-18 19:29:23: [   31.506172] audit: type=3D1403 audit(1566170963.0=
00:2): auid=3D4294967295 ses=3D4294967295 lsm=3Dselinux res=3D1
2019-08-18 19:29:23: [   31.510267] systemd[1]: Successfully loaded SELin=
ux policy in 2.088401s.
2019-08-18 19:29:23: [   31.836963] systemd[1]: Relabelled /dev, /run and=
 /sys/fs/cgroup in 147.675ms.
2019-08-18 19:29:23: [   31.849895] systemd[1]: systemd 239 running in sy=
stem mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +L=
IBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMO=
D +IDN2 -IDN +PCRE2 default-hierarchy=3Dlegacy)
2019-08-18 19:29:23: [   31.866706] systemd[1]: Virtualization KVM Virtua=
l Machine found in DMI (/sys/class/dmi/id/product_name)
2019-08-18 19:29:23: [   31.873911] systemd[1]: No virtualization found i=
n CPUID
2019-08-18 19:29:23: [   31.878100] systemd[1]: Found VM virtualization k=
vm
2019-08-18 19:29:23: [   31.881829] systemd[1]: Detected virtualization k=
vm.
2019-08-18 19:29:23: [   31.885643] systemd[1]: Detected architecture arm=
64.
2019-08-18 19:29:23:=20
2019-08-18 19:29:23: Welcome to =1B[0;31mRed Hat Enterprise Linux 8.0 (Oo=
tpa)=1B[0m!
2019-08-18 19:29:23:=20
2019-08-18 19:29:23: [   31.927205] systemd[1]: Failed to add address 127=
=2E0.0.1 to loopback interface: File exists
2019-08-18 19:29:23: [   31.933961] systemd[1]: Failed to add address ::1=
 to loopback interface: File exists
2019-08-18 19:29:23: [   31.940147] systemd[1]: Successfully brought loop=
back interface up
2019-08-18 19:29:23: [   31.946819] systemd[1]: Found cgroup on /sys/fs/c=
group/systemd, legacy hierarchy
2019-08-18 19:29:23: [   32.090864] systemd-getty-generator[1535]: Automa=
tically adding serial getty for /dev/ttyAMA0.
2019-08-18 19:29:23: [   32.125482] systemd-fstab-generator[1534]: Parsin=
g /etc/fstab
2019-08-18 19:29:23: [   32.130044] systemd-gpt-auto-generator[1536]: EFI=
 loader partition unknown, exiting.
2019-08-18 19:29:23: [   32.136697] systemd-gpt-auto-generator[1536]: Fai=
led to read /sys/dev/block/253:0/slaves/loop2/../dev: No such file or dir=
ectory
2019-08-18 19:29:23: [   32.145479] systemd-gpt-auto-generator[1536]: Fai=
led to chase block device '/', ignoring: No such file or directory
2019-08-18 19:29:23: [   32.154841] systemd-gpt-auto-generator[1536]: /de=
v/dm-0: not a partitioned device, ignoring.
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Stopped Switch Root.
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Stopped Journal Service.
2019-08-18 19:29:25:          Starting Journal Service...
2019-08-18 19:29:25:          Mounting POSIX Message Queue File System...=

2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Created slice system-anacond=
a\x2dtmux.slice.
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Reached target Paths.[   33.=
585778] systemd[1550]: Operating on architecture: arm
2019-08-18 19:29:25:=20
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Reached target Local Encrypt=
ed Volumes.[   33.601180] systemd[1550]: Operating on architecture: arm64=

2019-08-18 19:29:25: [   33.605848] systemd[1550]: Operating on architect=
ure: arm
2019-08-18 19:29:25:=20
2019-08-18 19:29:25: [   33.610172] systemd[1550]: Operating on architect=
ure: arm64
2019-08-18 19:29:25: [   33.614741] systemd[1550]: Operating on architect=
ure: arm
2019-08-18 19:29:25: [   33.614943] systemd[1550]: Operating on architect=
ure: arm64
2019-08-18 19:29:25: [   33.615143] systemd[1550]: Restricting namespace =
to: .
2019-08-18 19:29:25: [   33.615168] systemd[1550]: Operating on architect=
ure: arm
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Listening on Process Core Du=
mp Socket.[   33.615211] systemd[1550]: Blocking cgroup.
2019-08-18 19:29:25:=20
2019-08-18 19:29:25: [   33.615269] systemd[1550]: Blocking ipc.
2019-08-18 19:29:25: [   33.615323] systemd[1550]: Blocking net.
2019-08-18 19:29:25: [   33.615366] systemd[1550]: Blocking mnt.
2019-08-18 19:29:25: [   33.615431] systemd[1550]: Blocking pid.
2019-08-18 19:29:25: [   33.615476] systemd[1550]: Blocking user.
2019-08-18 19:29:25: [   33.615585] systemd[1550]: Blocking uts.
2019-08-18 19:29:25: [   33.615822] systemd[1550]: Operating on architect=
ure: arm64
2019-08-18 19:29:25: [   33.615879] systemd[1550]: Blocking cgroup.
2019-08-18 19:29:25: [   33.615916] systemd[1550]: Blocking ipc.
2019-08-18 19:29:25: [   33.615948] systemd[1550]: Blocking net.
2019-08-18 19:29:25: [   33.615986] systemd[1550]: Blocking mnt.
2019-08-18 19:29:25: [   33.616036] systemd[1550]: Blocking pid.
2019-08-18 19:29:25: [   33.616068] systemd[1550]: Blocking user.
2019-08-18 19:29:25: [   33.616099] systemd[1550]: Blocking uts.
2019-08-18 19:29:25: [   33.616693] systemd[1550]: Operating on architect=
ure: arm
2019-08-18 19:29:25: [   33.616828] systemd[1550]: Failed to add rule for=
 system call oldolduname() / -10036, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:25: [   33.616940] systemd[1550]: Failed to add rule for=
 system call select() / -10101, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   33.617086] systemd[1550]: Failed to add rule for=
 system call newfstatat() / 79, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   33.617255] systemd[1550]: Failed to add rule for=
 system call oldstat() / -10037, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:25: [   33.617370] systemd[1550]: Failed to add rule for=
 system call fadvise64() / 223, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   33.617439] systemd[1550]: Failed to add rule for=
 system call arch_prctl() / -10001, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [   33.617536] systemd[1550]: Failed to add rule for=
 system call waitpid() / -10073, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:25: [   33.617587] systemd[1550]: Failed to add rule for=
 system call oldfstat() / -10034, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   33.617698] systemd[1550]: Failed to add rule for=
 system call epoll_ctl_old() / -10005, ignoring: Numerical argument out o=
f domain
2019-08-18 19:29:25: [   33.617820] systemd[1550]: Failed to add rule for=
 system call ipc() / -10024, ignoring: Numerical argument out of domain
2019-08-18 19:29:25: [   33.617921] systemd[1550]: Failed to add rule for=
 system call alarm() / -10148, ignoring: Numerical argument out of domain=

2019-08-18 19:29:25: [   33.618028] systemd[1550]: Failed to add rule for=
 system call getrlimit() / 163, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   33.618182] systemd[1550]: Failed to add rule for=
 system call sync_file_range() / 84, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:25: [   33.618442] systemd[1550]: Failed to add rule for=
 system call fadvise64_64() / -10007, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:25: [   33.618715] systemd[1550]: Failed to add rule for=
 system call utime() / -10178, ignoring: Numerical argument out of domain=

2019-08-18 19:29:25: [   33.618880] systemd[1550]: Failed to add rule for=
 system call socketcall() / -10060, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [   33.618947] systemd[1550]: Failed to add rule for=
 system call olduname() / -10038, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   33.619365] systemd[1550]: Failed to add rule for=
 system call time() / -10108, ignoring: Numerical argument out of domain
2019-08-18 19:29:25: [   33.619453] systemd[1550]: Failed to add rule for=
 system call migrate_pages() / 238, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [   33.619521] systemd[1550]: Failed to add rule for=
 system call get_thread_area() / -10076, ignoring: Numerical argument out=
 of domain
2019-08-18 19:29:25: [   33.619599] systemd[1550]: Failed to add rule for=
 system call mmap() / 222, ignoring: Numerical argument out of domain
2019-08-18 19:29:25: [   33.619637] systemd[1550]: Failed to add rule for=
 system call epoll_wait_old() / -10006, ignoring: Numerical argument out =
of domain
2019-08-18 19:29:25: [   33.619791] systemd[1550]: Failed to add rule for=
 system call set_thread_area() / -10079, ignoring: Numerical argument out=
 of domain
2019-08-18 19:29:25: [   33.619966] systemd[1550]: Failed to add rule for=
 system call signal() / -10055, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   33.620019] systemd[1550]: Failed to add rule for=
 system call oldlstat() / -10035, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   33.620464] systemd[1550]: Failed to add rule for=
 system call readdir() / -10041, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:25: [   33.626338] systemd[1550]: Operating on architect=
ure: arm64
2019-08-18 19:29:25:          Starting Remount Root and Kernel File Syste=
ms...
2019-08-18 19:29:25: [   33.937449] systemd[1550]: Failed to add rule for=
 system call setfsuid32() / -10045, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [   33.946826] systemd[1550]: Failed to add rule for=
 system call lchown() / -10161, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [[   33.955328] systemd[1550]: Failed to add rule fo=
r system call fcntl64() / -10009, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   33.964417] systemd[1550]: Failed to add rule for=
 system call setresgid32() / -10049, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:25: [   33.973700] systemd[1550]: Failed to add rule for=
 system call readlink() / -10170, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   33.986593] systemd[1550]: Failed to add rule for=
 system call getegid32() / -10015, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:25: [   33.995987] systemd[1550]: Failed to add rule for=
 system call getgid32() / -10017, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: =1B[0;32m  OK  =1B[0m] Listening on initctl Compatib=
ility Named Pipe.[   34.005459] systemd[1550]: Failed to add rule for sys=
tem call epoll_wait() / -10154, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25:=20
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Created slice system-sshd\x2=
dkeygen.slice.[   34.005509] systemd[1550]: Failed to add rule for system=
 call oldolduname() / -10036, ignoring: Numerical argument out of domain
2019-08-18 19:29:25:=20
2019-08-18 19:29:25:          Starting Apply Kernel Variables...
2019-08-18 19:29:25: [   34.005601] systemd[1550]: Failed to add rule for=
 system call open() / -10166, ignoring: Numerical argument out of domain
2019-08-18 19:29:25: [   34.005656] systemd[1550]: Failed to add rule for=
 system call mmap2() / -10029, ignoring: Numerical argument out of domain=

2019-08-18 19:29:25: [   34.005705] systemd[1550]: Failed to add rule for=
 system call setgid32() / -10046, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   34.005743] systemd[1550]: Failed to add rule for=
 system call select() / -10101, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:25: [   34.005789] systemd[1550]: Failed to add rule for=
 system call getuid32() / -10021, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   34.005850] systemd[1550]: Failed to add rule for=
 system call eventfd() / -10155, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:25: [   34.005891] systemd[1550]: Failed to add rule for=
 system call getresuid32() / -10020, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:25: [   34.005941] systemd[1550]: Failed to add rule for=
 system call setreuid32() / -10051, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [=1B[0;32m  OK  =1B[0m] Set up automount Arbitrary E=
xecutabrmats File System Automount Point.[   34.005978] systemd[1550]: Fa=
iled to add rule for system call oldstat() / -10037, ignoring: Numerical =
argument out of domain
2019-08-18 19:29:25:=20
2019-08-18 19:29:25: [   34.006025] systemd[1550]: Failed to add rule for=
 system call fchown32() / -10008, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:25: [   34.006063] systemd[1550]: Failed to add rule for=
 system call nice() / -10033, ignoring: Numerical argument out of domain
2019-08-18 19:29:25: [   34.006103] systemd[1550]: Failed to add rule for=
 system call lstat() / -10163, ignoring: Numerical argument out of domain=

2019-08-18 19:29:25: [   34.006142] systemd[1550]: Failed to add rule for=
 system call arch_prctl() / -10001, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:25: [   34.006185] systemd[1550]: Failed to add rule for=
 system call getpgrp() / -10159, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:25: [   34.006220] systemd[1550]: Failed to add rule for=
 system call lchown32() / -10025, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.006256] systemd[1550]: Failed to add rule for=
 system call waitpid() / -10073, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.006289] systemd[1550]: Failed to add rule for=
 system call oldfstat() / -10034, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.006333] systemd[1550]: Failed to add rule for=
 system call stat() / -10174, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.006377] systemd[1550]: Failed to add rule for=
 system call sigprocmask() / -10057, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.006422] systemd[1550]: Failed to add rule for=
 system call epoll_ctl_old() / -10005, ignoring: Numerical argument out o=
f domain
2019-08-18 19:29:26: [   34.006468] systemd[1550]: Failed to add rule for=
 system call sigaction() / -10054, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.006509] systemd[1550]: Failed to add rule for=
 system call ugetrlimit() / -10068, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.006549] systemd[1550]: Failed to add rule for=
 system call ipc() / -10024, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.006588] systemd[1550]: Failed to add rule for=
 system call setgroups32() / -10047, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.006627] systemd[1550]: Failed to add rule for=
 system call unlink() / -10176, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.006662] systemd[1550]: Failed to add rule for=
 system call alarm() / -10148, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.006715] systemd[1550]: Failed to add rule for=
 system call send() / -109, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.006755] systemd[1550]: Failed to add rule for=
 system call creat() / -10151, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.006803] systemd[1550]: Failed to add rule for=
 system call symlink() / -10175, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.006867] systemd[1550]: Failed to add rule for=
 system call setfsgid32() / -10044, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.006906] systemd[1550]: Failed to add rule for=
 system call getdents() / -10158, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.006952] systemd[1550]: Failed to add rule for=
 system call fork() / -10156, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.007000] systemd[1550]: Failed to add rule for=
 system call sendfile64() / -10043, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.007043] systemd[1550]: Failed to add rule for=
 system call geteuid32() / -10016, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.007082] systemd[1550]: Failed to add rule for=
 system call fadvise64_64() / -10007, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:26: [   34.007126] systemd[1550]: Failed to add rule for=
 system call access() / -10147, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.007172] systemd[1550]: Failed to add rule for=
 system call lstat64() / -10028, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.007226] systemd[1550]: Failed to add rule for=
 system call ftruncate64() / -10014, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.007271] systemd[1550]: Failed to add rule for=
 system call fstatfs64() / -10012, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.007316] systemd[1550]: Failed to add rule for=
 system call setresuid32() / -10050, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.007359] systemd[1550]: Failed to add rule for=
 system call sigpending() / -10056, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.007396] systemd[1550]: Failed to add rule for=
 system call utime() / -10178, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.007440] systemd[1550]: Failed to add rule for=
 system call fstatat64() / -10011, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.007483] systemd[1550]: Failed to add rule for=
 system call _llseek() / -10026, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.007521] systemd[1550]: Failed to add rule for=
 system call inotify_init() / -10160, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:26: [   34.007568] systemd[1550]: Failed to add rule for=
 system call mkdir() / -10164, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.007606] systemd[1550]: Failed to add rule for=
 system call chown32() / -10004, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.007643] systemd[1550]: Failed to add rule for=
 system call socketcall() / -10060, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.007685] systemd[1550]: Failed to add rule for=
 system call olduname() / -10038, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.007750] systemd[1550]: Failed to add rule for=
 system call setregid32() / -10048, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.007798] systemd[1550]: Failed to add rule for=
 system call rename() / -10171, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.007835] systemd[1550]: Failed to add rule for=
 system call truncate64() / -10066, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.007878] systemd[1550]: Failed to add rule for=
 system call chown() / -10150, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.007928] systemd[1550]: Failed to add rule for=
 system call sigreturn() / -10058, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.007964] systemd[1550]: Failed to add rule for=
 system call link() / -10162, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008017] systemd[1550]: Failed to add rule for=
 system call _newselect() / -10032, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.008055] systemd[1550]: Failed to add rule for=
 system call sigsuspend() / -10059, ignoring: Numerical argument out of d=
omain
2019-08-18 19:29:26: [   34.008101] systemd[1550]: Failed to add rule for=
 system call setuid32() / -10052, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.008138] systemd[1550]: Failed to add rule for=
 system call pause() / -10167, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.008184] systemd[1550]: Failed to add rule for=
 system call time() / -10108, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008229] systemd[1550]: Failed to add rule for=
 system call stat64() / -10062, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.008281] systemd[1550]: Failed to add rule for=
 system call get_thread_area() / -10076, ignoring: Numerical argument out=
 of domain
2019-08-18 19:29:26: [   34.008317] systemd[1550]: Failed to add rule for=
 system call futimesat() / -10157, ignoring: Numerical argument out of do=
main
2019-08-18 19:29:26: [   34.008353] systemd[1550]: Failed to add rule for=
 system call pipe() / -10168, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008402] systemd[1550]: Failed to add rule for=
 system call epoll_wait_old() / -10006, ignoring: Numerical argument out =
of domain
2019-08-18 19:29:26: [   34.008450] systemd[1550]: Failed to add rule for=
 system call utimes() / -10179, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.008500] systemd[1550]: Failed to add rule for=
 system call recv() / -110, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008543] systemd[1550]: Failed to add rule for=
 system call set_thread_area() / -10079, ignoring: Numerical argument out=
 of domain
2019-08-18 19:29:26: [   34.008579] systemd[1550]: Failed to add rule for=
 system call getgroups32() / -10018, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.008628] systemd[1550]: Failed to add rule for=
 system call statfs64() / -10063, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.008687] systemd[1550]: Failed to add rule for=
 system call vfork() / -10102, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.008733] systemd[1550]: Failed to add rule for=
 system call signal() / -10055, ignoring: Numerical argument out of domai=
n
2019-08-18 19:29:26: [   34.008780] systemd[1550]: Failed to add rule for=
 system call oldlstat() / -10035, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.008822] systemd[1550]: Failed to add rule for=
 system call epoll_create() / -10153, ignoring: Numerical argument out of=
 domain
2019-08-18 19:29:26: [   34.008882] systemd[1550]: Failed to add rule for=
 system call poll() / -10169, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008932] systemd[1550]: Failed to add rule for=
 system call dup2() / -10152, ignoring: Numerical argument out of domain
2019-08-18 19:29:26: [   34.008970] systemd[1550]: Failed to add rule for=
 system call rmdir() / -10172, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.009008] systemd[1550]: Failed to add rule for=
 system call fstat64() / -10010, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.009103] systemd[1550]: Failed to add rule for=
 system call signalfd() / -10173, ignoring: Numerical argument out of dom=
ain
2019-08-18 19:29:26: [   34.009159] systemd[1550]: Failed to add rule for=
 system call set_tls() / -10183, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.009215] systemd[1550]: Failed to add rule for=
 system call chmod() / -10149, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.009268] systemd[1550]: Failed to add rule for=
 system call mknod() / -10165, ignoring: Numerical argument out of domain=

2019-08-18 19:29:26: [   34.009341] systemd[1550]: Failed to add rule for=
 system call readdir() / -10041, ignoring: Numerical argument out of doma=
in
2019-08-18 19:29:26: [   34.009389] systemd[1550]: Failed to add rule for=
 system call getresgid32() / -10019, ignoring: Numerical argument out of =
domain
2019-08-18 19:29:26: [   34.104686] systemd-journald[1550]: Found cgroup =
on /sys/fs/cgroup/systemd, legacy hierarchy
2019-08-18 19:29:26:          Mounting Kernel Debug File System...[   34.=
818537] systemd-journald[1550]: Journal effective settings seal=3Dno comp=
ress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:26:=20
2019-08-18 19:29:26: [   34.827772] systemd-journald[1550]: Fixed min_use=
=3D1.0M max_use=3D199.6M max_size=3D25.0M min_size=3D512.0K keep_free=3D2=
99.3M n_max_files=3D100
2019-08-18 19:29:26: [   34.838322] systemd-journald[1550]: Reserving 455=
11 entries in hash table.
2019-08-18 19:29:26: [   34.843776] systemd-journald[1550]: Vacuuming...
2019-08-18 19:29:26:          Starting Create list of required stce nodes=
 for the current kernel...[   34.847483] systemd-journald[1550]: Vacuumin=
g done, freed 0B of archived journals from /run/log/journal/b99ea0039d064=
546a9b5719fa152fcc1.
2019-08-18 19:29:26: [   34.847528] systemd-journald[1550]: Flushing /dev=
/kmsg...
2019-08-18 19:29:26:=20
2019-08-18 19:29:26: [   34.859584] systemd-journald[1550]: systemd-journ=
ald running as pid 1550
2019-08-18 19:29:26: [   34.873074] systemd-journald[1550]: Sent READY=3D=
1 notification.
2019-08-18 19:29:26: [   34.877730] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Listening on multipathd cont=
rol socket.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Listening on udev Control So=
cket.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Created slice User and Sessi=
on Slice.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Reached target Slices.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Listening on LVM2 poll daemo=
n socket.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Reached target Swap.
2019-08-18 19:29:26:          Mounting Temporary Directory (/tmp)...
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Stopped target Switch Root.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Stopped target Initrd File S=
ystems.
2019-08-18 19:29:26:          Starting Setup Virtual Console...
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Listening on udev Kernel Soc=
ket.
2019-08-18 19:29:26:          Starting udev Coldplug all Devices...
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Stopped target Initrd Root F=
ile System.
2019-08-18 19:29:26:          Mounting Huge Pages File System...
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Started Journal Service.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Mounted POSIX Message Queue =
File System.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Started Remount Root and Ker=
nel File Systems.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Started Apply Kernel Variabl=
es.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Mounted Kernel Debug File Sy=
stem.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Started Create list of requi=
red stavice nodes for the current kernel.
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Mounted Temporary Directory =
(/tmp).
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Mounted Huge Pages File Syst=
em.
2019-08-18 19:29:26:          Starting Load/Save Random Seed...
2019-08-18 19:29:26:          Starting Create System Users...
2019-08-18 19:29:26:          Starting Rebuild Hardware Database...
2019-08-18 19:29:26:          Starting Flush Journal to Persistent Storag=
e...
2019-08-18 19:29:26: [=1B[0;32m  OK  =1B[0m] Started Load/Save Random See=
d.
2019-08-18 19:29:27: [=1B[0;32m  OK  =1B[0m] Started Create System Users.=

2019-08-18 19:29:27:          Starting Create Static Device Nodes in /dev=
=2E..
2019-08-18 19:29:27: [=1B[0;32m  OK  =1B[0m] Started Flush Journal to Per=
sistent Storage.
2019-08-18 19:29:27: [=1B[0;32m  OK  =1B[0m] Started Create Static Device=
 Nodes in /dev.
2019-08-18 19:29:27: [=1B[0;32m  OK  =1B[0m] Started Setup Virtual Consol=
e.
2019-08-18 19:29:27: [=1B[0;32m  OK  =1B[0m] Started udev Coldplug all De=
vices.
2019-08-18 19:29:27:          Starting udev Wait for Complete Device Init=
ialization...
2019-08-18 19:29:28: [=1B[0;32m  OK  =1B[0m] Started Rebuild Hardware Dat=
abase.
2019-08-18 19:29:28:          Starting udev Kernel Device Manager...
2019-08-18 19:29:28: [=1B[0;32m  OK  =1B[0m] Started udev Kernel Device M=
anager.
2019-08-18 19:29:28: [   37.052290] sd 0:0:0:0: Attached scsi generic sg0=
 type 0
2019-08-18 19:29:28: [   37.058667] sr 0:0:1:0: Attached scsi generic sg1=
 type 5
2019-08-18 19:29:28: [   37.064248] sr 0:0:2:0: Attached scsi generic sg2=
 type 5
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Started udev Wait for Comple=
te Device Initialization.
2019-08-18 19:29:29:          Starting Device-Mapper Multipath Device Con=
troller...
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Started Device-Mapper Multip=
ath Device Controller.
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Reached target Local File Sy=
stems (Pre).
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Reached target Local File Sy=
stems.
2019-08-18 19:29:29:          Starting Import network configuration from =
initramfs...
2019-08-18 19:29:29:          Starting Tell Plymouth To Write Out Runtime=
 Data...
2019-08-18 19:29:29:          Starting Rebuild Journal Catalog...
2019-08-18 19:29:29:          Starting Rebuild Dynamic Linker Cache...
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Started Tell Plymouth To Wri=
te Out Runtime Data.
2019-08-18 19:29:29: [=1B[0;32m  OK  =1B[0m] Started Rebuild Journal Cata=
log.
2019-08-18 19:29:30: [=1B[0;32m  OK  =1B[0m] Started Import network confi=
guration from initramfs.
2019-08-18 19:29:30:          Starting Create Volatile Files and Director=
ies...
2019-08-18 19:29:30: [=1B[0;32m  OK  =1B[0m] Started Create Volatile File=
s and Directories.
2019-08-18 19:29:30:          Starting Update UTMP about System Boot/Shut=
down...
2019-08-18 19:29:30: [=1B[0;32m  OK  =1B[0m] Started Update UTMP about Sy=
stem Boot/Shutdown.
2019-08-18 19:29:34: [   43.046231] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [   43.054158] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Started Rebuild Dynamic Link=
er Cache.[   43.062698] systemd-journald[1550]: Journal effective setting=
s seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34:=20
2019-08-18 19:29:34:          Starting Update is Completed...[   43.07809=
7] systemd-journald[1550]: Journal effective settings seal=3Dyes compress=
=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34:=20
2019-08-18 19:29:34: [   43.086549] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [   43.094467] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [   43.103232] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:29:34: [   43.111513] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [   43.119698] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [   43.127943] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Started Update is Completed.=

2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Reached target System Initia=
lization.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Started Daily Cleanup of Tem=
porary Directories.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Reached target Timers.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Listening on Open-iSCSI iscs=
id Socket.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Listening on Activation sock=
et for spice guest agent daemon.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Listening on Open-iSCSI iscs=
iuio Socket.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Listening on D-Bus System Me=
ssage Bus Socket.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Reached target Sockets.
2019-08-18 19:29:34: [=1B[0;32m  OK  =1B[0m] Reached target Basic System.=

2019-08-18 19:29:35:          Starting OpenSSH ed25519 Server Key Generat=
ion...
2019-08-18 19:29:35:          Starting OpenSSH ecdsa Server Key Generatio=
n...
2019-08-18 19:29:35: [=1B[0;32m  OK  =1B[0m] Started anaconda performance=
 monitor.
2019-08-18 19:29:35:          Starting Service enabling compressing RAM w=
ith zRam...
2019-08-18 19:29:35:          Starting OpenSSH rsa Server Key Generation.=
=2E.
2019-08-18 19:29:35:          Starting Anaconda NetworkManager configurat=
ion...
2019-08-18 19:29:35:          Starting Hold until boot process finishes u=
p...
2019-08-18 19:29:35:          Starting Login Service...
2019-08-18 19:29:35:          Starting pre-anaconda logging service...
2019-08-18 19:29:35: [=1B[0;32m  OK  =1B[0m] Started Hardware RNG Entropy=
 Gatherer Daemon.
2019-08-18 19:29:35:          Starting Terminate Plymouth Boot Screen...
2019-08-18 19:29:35: [=1B[0;32m  OK  =1B[0m] Started Service enabling com=
pressing RAM with zRam.
2019-08-18 19:29:36: [   44.277753] anaconda-pre-log-gen[1689]: Creating =
dump directory: /tmp/pre-anaconda-logs/lvmdump
2019-08-18 19:29:36: [   44.290291] anaconda-pre-log-gen[1689]:
2019-08-18 19:29:36: [   44.293885] anaconda-pre-log-gen[1689]: Gathering=
 LVM & device-mapper version info...
2019-08-18 19:29:36: [   44.475709] anaconda-pre-log-gen[1689]: Gathering=
 dmsetup info...
2019-08-18 19:29:36: [   44.625907] anaconda-pre-log-gen[1689]: Gathering=
 process info...
2019-08-18 19:29:36: [   44.738770] anaconda-pre-log-gen[1689]: Gathering=
 console messages...
2019-08-18 19:29:36: [   44.756118] anaconda-pre-log-gen[1689]: Gathering=
 /etc/lvm info...
2019-08-18 19:29:37: [   44.976389] anaconda-pre-log-gen[1689]: Gathering=
 /dev listing...
2019-08-18 19:29:37: [   45.016782] anaconda-pre-log-gen[1689]: Gathering=
 /sys/block listing...
2019-08-18 19:29:37: [   45.184352] anaconda-pre-log-gen[1689]: Gathering=
 system info...
2019-08-18 19:29:38: [   46.213445] IPv6: ADDRCONF(NETDEV_UP): ens4: link=
 is not ready
2019-08-18 19:29:39: [   47.116619] anaconda-pre-log-gen[1689]: Gathering=
 udev info...
2019-08-18 19:29:44: [   52.576493] random: crng init done
2019-08-18 19:29:44: [   52.576869] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.579152] random: 7 urandom warning(s) missed d=
ue to ratelimiting
2019-08-18 19:29:44: [   52.595057] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.615728] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.623888] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.660759] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.684707] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.707306] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.715231] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.747066] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.754975] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:44: [   52.514765] anaconda-pre-log-gen[1689]: Ncat: No =
such file or directory.
2019-08-18 19:29:44: [   52.531075] anaconda-pre-log-gen[1689]: WARNING: =
Neither socat nor nc -U seems to be available.
2019-08-18 19:29:44: [   52.542871] anaconda-pre-log-gen[1689]: /usr/sbin=
/lvmdump: line 331: return: can only `return' from a function or sourced =
script
2019-08-18 19:29:49: [   57.800941] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.820657] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.829883] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.837915] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.846443] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:29:49: [   57.853277] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.861493] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.870545] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:29:49: [   57.877431] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:49: [   57.885987] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:50: =1B[r=1B[H=1B[2J
2019-08-18 19:29:50: =1B[H=1B[J=1B[m=1B(B=1B[?1003l=1B[?1006l=1B[?2004l=1B=
[1;1H=1B[1;24r=1B[1;1H=1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[7m[anaconda]1:main* 2:shell  3:log  4:sto><'echo=
 -n "Switch tab: Alt+Tab | Help: F=1B[m=1B(B=1B[1;1H=1B[m=1B(B=1B[?1003l=1B=
[?1006l=1B[?2004l=1B[1;1H=1B[1;24r=1B[1;1H=1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[K
2019-08-18 19:29:50: =1B[7m[anaconda]1:main* 2:shell  3:log  4:sto><'echo=
 -n "Switch tab: Alt+Tab | Help: F=1B[m=1B(B=1B[1;1H=1B[24;1H=1B[7m[anaco=
nda]1:main* 2:shell  3:log  4:storage-log >Switch tab: Alt+Tab | Help: F1=
 =1B[m=1B(B=1B[1;1HStarting installer, one moment...
2019-08-18 19:29:58: [   66.632195] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   66.640723] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   66.954368] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   66.967255] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   66.977246] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   66.985170] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   67.003805] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   67.012367] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   67.027372] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:58: [   67.035289] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:29:59: anaconda 29.19.0.40-1.el8 for Red Hat Enterprise Lin=
ux 8.0.0 started.
2019-08-18 19:29:59:  * installation log files are stored in /tmp during =
the installation
2019-08-18 19:29:59:  * shell is available on TTY2
2019-08-18 19:29:59:  * if the graphical installation interface fails to =
start, try again with the
2019-08-18 19:29:59:    inst.text bootoption to start text installation
2019-08-18 19:29:59:  * when reporting a bug add logs from /tmp as separa=
te text/plain attachments
2019-08-18 19:30:04: [   72.611091] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:04: [   72.625633] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:04: [   73.116181] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:04: [   73.124124] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:04: [   73.195866] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:05: [   73.203808] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:05: [   73.295770] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:05: [   73.303699] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:05: [   73.385752] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:05: [   73.393676] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.616725] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.626509] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.635968] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.643896] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.836954] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.845185] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.854200] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.862609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.871519] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:09: [   77.879685] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:10: 23:30:10 Not asking for VNC because of an automated =
install
2019-08-18 19:30:10: 23:30:10 Not asking for VNC because text mode was ex=
plicitly asked for in kickstart
2019-08-18 19:30:10: 23:30:10 Not asking for VNC because we don't have a =
network
2019-08-18 19:30:11: [   79.617737] SGI XFS with ACLs, security attribute=
s, no debug enabled
2019-08-18 19:30:14: [   82.637945] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.646124] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.654651] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.663474] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.673842] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.682287] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.691425] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.699810] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.708256] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:14: [   82.716618] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:16: Starting automated install.
2019-08-18 19:30:17: .
2019-08-18 19:30:18: .
2019-08-18 19:30:19: [   87.672660] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.680979] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.689391] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.697442] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.762780] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.770996] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.788955] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.796971] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.811251] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: [   87.819630] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:19: .
2019-08-18 19:30:20: .
2019-08-18 19:30:21: .
2019-08-18 19:30:22: .
2019-08-18 19:30:23: .
2019-08-18 19:30:24: .
2019-08-18 19:30:25: .
2019-08-18 19:30:26: .
2019-08-18 19:30:27: [   95.690794] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:27: [   95.699009] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:27: [   95.707347] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:27: [   95.715246] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: .
2019-08-18 19:30:29: [   97.711790] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: [   97.732933] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: [   98.009162] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: [   98.017164] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: [   98.025220] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:29: [   98.033543] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:30:=20
2019-08-18 19:30:30: Generating updated storage configuration
2019-08-18 19:30:32: [  100.742838] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.751154] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.770149] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.778291] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.862887] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.871134] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.902304] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.910499] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.918921] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: [  100.926880] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:32: Checking storage configuration...
2019-08-18 19:30:32:=20
2019-08-18 19:30:33: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[17;1H=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[18;1H
2019-08-18 19:30:33: =1B[1;23r=1B[23;80H
2019-08-18 19:30:33:=20
2019-08-18 19:30:33:=20
2019-08-18 19:30:33:=20
2019-08-18 19:30:33:=20
2019-08-18 19:30:33:=20
2019-08-18 19:30:33: =1B[12;1HInstallation=1B[14;1H1) [x] Language settin=
gs                 2) [x] Time settings
2019-08-18 19:30:33:        (English (United States))                (Ame=
rica/New_York timezone)
2019-08-18 19:30:33: 3) [x] Installation source               4) [x] Soft=
ware selection
2019-08-18 19:30:33:        (Local media)                            (Cus=
tom software selected)
2019-08-18 19:30:33: 5) [x] Installation Destination          6) [x] Kdum=
p
2019-08-18 19:30:33:        (Automatic partitioning                  (Kdu=
mp is enabled)
2019-08-18 19:30:33:        selected)
2019-08-18 19:30:33: 7) [ ] Network configuration             8) [x] Shel=
l
2019-08-18 19:30:33:        (Not connected)                          (Sta=
rt shell)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[22;1H=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[23;1H=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[=
23;1H=1B[1;24r=1B[23;80H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33:=20
2019-08-18 19:30:33: =1B[21;1HProgress=1B[1;24r=1B[23;1H
2019-08-18 19:30:33: .=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[22;1HSetting up the installation environment=1B[=
1;24r=1B[23;1H.=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:33: =1B[22;1HConfiguring storage=1B[1;24r=1B[23;1H
2019-08-18 19:30:33: ..
2019-08-18 19:30:35: =1B[1;23r=1B[23;80H
2019-08-18 19:30:35:=20
2019-08-18 19:30:35: =1B[22;1HCreating disklabel on /dev/sda=1B[1;24r=1B[=
23;1H
2019-08-18 19:30:35: [  104.081360]  sda:
2019-08-18 19:30:36: [  104.395307]  sda:
2019-08-18 19:30:36: [  104.626125]  sda: sda1
2019-08-18 19:30:36: [  105.109933]  sda: sda1
2019-08-18 19:30:37: [  105.752775] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.761046] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.769428] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: =1B[1;23r=1B[23;80H
2019-08-18 19:30:37: =1B[22;1HCreating xfs on /dev/sda2=1B[1;24r=1B[23;1H=
[  105.782033] systemd-journald[1550]: Journal effective settings seal=3D=
yes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.790389] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.798566] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.806719] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.814619] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.823240] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:37: [  105.831504] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:38: [  106.779646]  sda: sda1 sda2
2019-08-18 19:30:39: =1B[1;23r=1B[23;80H
2019-08-18 19:30:39: =1B[22;1HCreating lvmpv on /dev/sda3=1B[1;24r=1B[23;=
1H
2019-08-18 19:30:39: [  107.735196]  sda: sda1 sda2 sda3
2019-08-18 19:30:42: =1B[1;23r=1B[23;80H
2019-08-18 19:30:42: =1B[22;1HCreating swap on /dev/mapper/rhel-swap=1B[1=
;24r=1B[23;1H
2019-08-18 19:30:42: [  110.845167] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.855343] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.864007] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.872286] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.880628] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.888712] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.938575] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.946571] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.955412] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:42: [  110.965068] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:43: =1B[1;23r=1B[23;80H
2019-08-18 19:30:43: =1B[22;1HCreating xfs on /dev/mapper/rhel-root=1B[1;=
24r=1B[23;1H
2019-08-18 19:30:43: =1B[1;23r=1B[23;80H
2019-08-18 19:30:43: =1B[22;1HCreating efi on /dev/sda1=1B[1;24r=1B[23;1H=

2019-08-18 19:30:44: [  113.171902] Adding 1048512k swap on /dev/mapper/r=
hel-swap.  Priority:-2 extents:1 across:1048512k FS
2019-08-18 19:30:45: [  113.756413] XFS (dm-3): Mounting V5 Filesystem
2019-08-18 19:30:45: [  113.768489] XFS (dm-3): Ending clean mount
2019-08-18 19:30:46: [  114.515578] XFS (sda2): Mounting V5 Filesystem
2019-08-18 19:30:46: [  114.527293] XFS (sda2): Ending clean mount
2019-08-18 19:30:47: [  115.862806] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  115.871144] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  115.905578] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  115.913511] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  115.957146] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  115.965070] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  116.000212] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  116.008362] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  116.082578] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:47: [  116.090747] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.922791] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.931040] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.971438] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.979829] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.989942] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  120.998007] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  121.062496] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  121.070758] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  121.105872] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:52: [  121.113796] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:30:54: ..=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[22;1HRunning pre-installation scripts=1B[1;24r=1B=
[23;1H.=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[22;1HDiscovering realm to join=1B[1;24r=1B[23;1H=
=2E=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:54: =1B[22;1HRunning pre-installation tasks=1B[1;24r=1B[=
23;1H...
2019-08-18 19:30:55: ..
2019-08-18 19:30:55: .=1B[1;23r=1B[23;80H
2019-08-18 19:30:55: =1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:30:55:=20
2019-08-18 19:30:55: =1B[21;1HInstalling.
2019-08-18 19:30:55: Starting package installation process=1B[1;24r=1B[23=
;1H
2019-08-18 19:31:00: [  129.101748] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:00: [  129.109928] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.871348] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.879487] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.887743] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.895665] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.903723] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.914247] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.952589] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:01: [  129.960834] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:02: =1B[1;23r=1B[23;80H
2019-08-18 19:31:02: =1B[22;1HDownloading packages=1B[1;24r=1B[23;1H
2019-08-18 19:31:17: [  145.257029] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:17: [  145.265493] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:17: [  145.274378] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:17: [  145.282705] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:17: =1B[1;23r=1B[23;80H
2019-08-18 19:31:17: =1B[22;1HPreparing transaction from installation sou=
rce=1B[1;24r=1B[23;1H
2019-08-18 19:31:17: [  145.517557] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:17: [  145.526026] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:19: [  148.143069] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:19: [  148.151467] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:19: [  148.159837] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:19: [  148.167960] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.899922] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.908016] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.916232] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.926905] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.935009] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:36: [  164.965644] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:55: [  183.663131] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:31:55: [  183.671758] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.416392] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:32:45: [  233.421722] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.431134] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.440698] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.448802] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.457016] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.464901] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.473395] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.481629] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:45: [  233.489938] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:47: =1B[1;23r=1B[23;80H
2019-08-18 19:32:47: =1B[22;1HInstalling libgcc.aarch64 (1/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:32:47: =1B[1;23r=1B[23;80H
2019-08-18 19:32:47: =1B[22;1HInstalling fontpackages-filesystem.noarch (=
2/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:47: =1B[22;1HInstalling google-noto-fonts-common.noarch =
(3/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:47: =1B[22;1HInstalling kernel-headers.aarch64 (4/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:32:50: =1B[1;23r=1B[23;80H
2019-08-18 19:32:50: =1B[22;1HInstalling hwdata.noarch (5/1180)=1B[1;24r=1B=
[23;1H[  238.689935] systemd-journald[1550]: Journal effective settings s=
eal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: [  238.705658] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: =1B[1;23r=1B[23;80H
2019-08-18 19:32:50: =1B[22;1HInstalling emacs-filesystem.noarch (6/1180)=
=1B[1;24r=1B[23;1H[  239.110728] systemd-journald[1550]: Journal effectiv=
e settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: =1B[1;23r=1B[23;80H
2019-08-18 19:32:50: =1B[22;1HInstalling dejavu-fonts-common.noarch (7/11=
80)=1B[1;24r=1B[23;1H[  239.127732] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: [  239.135920] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: [  239.143825] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:50: =1B[1;23r=1B[23;80H
2019-08-18 19:32:50: =1B[22;1HInstalling gnu-free-fonts-common.noarch (8/=
1180)=1B[1;24r=1B[23;1H[  239.160107] systemd-journald[1550]: Journal eff=
ective settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B=

2019-08-18 19:32:50: [  239.168167] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:51: =1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling cmake-filesystem.aarch64 (9/1180=
)=1B[1;24r=1B[23;1H[  239.211977] systemd-journald[1550]: Journal effecti=
ve settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:51: [  239.220225] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:51: =1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling bind-license.noarch (10/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling libreport-filesystem.aarch64 (11=
/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling vim-filesystem.noarch (12/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling python-srpm-macros.noarch (13/11=
80)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling mesa-khr-devel.aarch64 (14/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling google-noto-cjk-fonts-common.noa=
rch (15/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling geolite2-country.noarch (16/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:32:51: =1B[1;23r=1B[23;80H
2019-08-18 19:32:51: =1B[22;1HInstalling geolite2-city.noarch (17/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:32:55: =1B[1;23r=1B[23;80H
2019-08-18 19:32:55: =1B[22;1HInstalling adobe-mappings-cmap.noarch (18/1=
180)=1B[1;24r=1B[23;1H[  243.815403] systemd-journald[1550]: Journal effe=
ctive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:55: [  243.823771] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:56: [  245.189385] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:32:56: =1B[1;23r=1B[23;80H
2019-08-18 19:32:57: =1B[22;1HInstalling tzdata.noarch (19/1180)=1B[1;24r=
=1B[23;1H[  245.202853] systemd-journald[1550]: Journal effective setting=
s seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:00: =1B[1;23r=1B[23;80H
2019-08-18 19:33:00: =1B[22;1HInstalling adobe-mappings-cmap-deprecated.n=
oarch (20/1180)=1B[1;24r=1B[23;1H[  249.110183] systemd-journald[1550]: J=
ournal effective settings seal=3Dyes compress=3Dyes compress_threshold_by=
tes=3D512B
2019-08-18 19:33:00: [  249.118441] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:00: =1B[1;23r=1B[23;80H
2019-08-18 19:33:01: =1B[22;1HInstalling python-rpm-macros.noarch (21/118=
0)=1B[1;24r=1B[23;1H[  249.200504] systemd-journald[1550]: Journal effect=
ive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: =1B[1;23r=1B[23;80H
2019-08-18 19:33:01: =1B[22;1HInstalling dnf-data.noarch (22/1180)=1B[1;2=
4r=1B[23;1H[  249.219901] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: [  249.235904] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: [  249.243812] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: =1B[1;23r=1B[23;80H
2019-08-18 19:33:01: =1B[22;1HInstalling dejavu-sans-fonts.noarch (23/118=
0)=1B[1;24r=1B[23;1H[  249.269622] systemd-journald[1550]: Journal effect=
ive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: [  249.277731] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:01: =1B[1;23r=1B[23;80H
2019-08-18 19:33:01: =1B[22;1HInstalling google-droid-sans-fonts.noarch (=
24/1180)=1B[1;24r=1B[23;1H[  249.662822] systemd-journald[1550]: Journal =
effective settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D5=
12B
2019-08-18 19:33:01: [  249.671115] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:02: =1B[1;23r=1B[23;80H
2019-08-18 19:33:02: =1B[22;1HInstalling khmeros-fonts-common.noarch (25/=
1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:02: =1B[22;1HInstalling smc-fonts-common.noarch (26/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:02: =1B[22;1HInstalling thai-scalable-fonts-common.noarc=
h (27/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:02: =1B[22;1HInstalling xkeyboard-config.noarch (28/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:33:03: =1B[1;23r=1B[23;80H
2019-08-18 19:33:03: =1B[22;1HInstalling tzdata-java.noarch (29/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:06: [  254.514145] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: =1B[1;23r=1B[23;80H
2019-08-18 19:33:06: =1B[22;1HInstalling rust-srpm-macros.noarch (30/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:06: =1B[22;1HInstalling qt5-srpm-macros.noarch (31/1180)=
=1B[1;24r=1B[23;1H[  254.537905] systemd-journald[1550]: Journal effectiv=
e settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: =1B[1;23r=1B[23;80H
2019-08-18 19:33:06:=20
2019-08-18 19:33:06: =1B[21;1HInstalling python3-rpm-macros.noarch (32/11=
80)
2019-08-18 19:33:06: Installing python2-rpm-macros.noarch (33/1180)=1B[1;=
24r=1B[23;1H[  254.559087] systemd-journald[1550]: Journal effective sett=
ings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: =1B[1;23r=1B[23;80H
2019-08-18 19:33:06: =1B[22;1HInstalling pygtk2-doc.noarch (34/1180)=1B[1=
;24r=1B[23;1H[  254.572219] systemd-journald[1550]: Journal effective set=
tings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.580627] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.588700] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.596911] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.604805] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.613363] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:06: [  254.621694] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:08: =1B[1;23r=1B[23;80H
2019-08-18 19:33:08: =1B[22;1HInstalling pygobject2-doc.aarch64 (35/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:09: =1B[1;23r=1B[23;80H
2019-08-18 19:33:09: =1B[22;1HInstalling perl-srpm-macros.noarch (36/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:09: =1B[22;1HInstalling openblas-srpm-macros.noarch (37/=
1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:09: =1B[22;1HInstalling ocaml-srpm-macros.noarch (38/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:09: =1B[22;1HInstalling mariadb-connector-c-config.noarc=
h (39/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:09: =1B[22;1HInstalling libX11-common.noarch (40/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:10: =1B[1;23r=1B[23;80H
2019-08-18 19:33:10: =1B[22;1HInstalling javapackages-filesystem.noarch (=
41/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:33:10: =1B[1;23r=1B[23;80H
2019-08-18 19:33:10: =1B[22;1HInstalling go-srpm-macros.noarch (42/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:10: =1B[22;1HInstalling gl-manpages.noarch (43/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:13: [  261.673328] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:13: =1B[1;23r=1B[23;80H
2019-08-18 19:33:13: =1B[22;1HInstalling ghc-srpm-macros.noarch (44/1180)=
=1B[1;24r=1B[23;1H[  261.683859] systemd-journald[1550]: Journal effectiv=
e settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:13: [  261.695938] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:13: =1B[1;23r=1B[23;80H
2019-08-18 19:33:13: =1B[22;1HInstalling adwaita-cursor-theme.noarch (45/=
1180)=1B[1;24r=1B[23;1H[  261.704307] systemd-journald[1550]: Journal eff=
ective settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B=

2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling adobe-mappings-pdf.noarch (46/11=
80)=1B[1;24r=1B[23;1H[  262.379440] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:14: [  262.392327] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling subscription-manager-rhsm-certif=
icates.aarch64 (47/1180)=1B[1;24r=1B[23;1H[  262.825369] systemd-journald=
[1550]: Journal effective settings seal=3Dyes compress=3Dyes compress_thr=
eshold_bytes=3D512B
2019-08-18 19:33:14: [  262.834397] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling redhat-release-eula.aarch64 (48/=
1180)=1B[1;24r=1B[23;1H[  262.842955] systemd-journald[1550]: Journal eff=
ective settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B=

2019-08-18 19:33:14: [  262.856994] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling redhat-release.aarch64 (49/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling setup.noarch (50/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:14: =1B[1;23r=1B[23;80H
2019-08-18 19:33:14: =1B[22;1HInstalling filesystem.aarch64 (51/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:17: =1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling urw-base35-fonts-common.noarch (=
52/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling efi-filesystem.noarch (53/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling basesystem.noarch (54/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling quota-nls.noarch (55/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling publicsuffix-list-dafsa.noarch (=
56/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling pkgconf-m4.noarch (57/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling ncurses-base.noarch (58/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:17: =1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling pcre2.aarch64 (59/1180)=1B[1;24r=
=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling libselinux.aarch64 (60/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling ncurses-libs.aarch64 (61/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:17: =1B[1;23r=1B[23;80H
2019-08-18 19:33:17: =1B[22;1HInstalling glibc-langpack-en.aarch64 (62/11=
80)=1B[1;24r=1B[23;1H
2019-08-18 19:33:18: [  267.145206] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:18: =1B[1;23r=1B[23;80H
2019-08-18 19:33:18: =1B[22;1HInstalling glibc-common.aarch64 (63/1180)=1B=
[1;24r=1B[23;1H[  267.159224] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:19: [  267.494711] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:19: [  267.503381] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:19: =1B[1;23r=1B[23;80H
2019-08-18 19:33:19: =1B[22;1HInstalling glibc.aarch64 (64/1180)=1B[1;24r=
=1B[23;1H[  267.517435] systemd-journald[1550]: Journal effective setting=
s seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:19: [  267.525337] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:21: [  269.940322] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:21: [  269.948479] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:22: =1B[1;23r=1B[23;80H
2019-08-18 19:33:22: =1B[22;1HInstalling bash.aarch64 (65/1180)=1B[1;24r=1B=
[23;1H[  270.512475] systemd-journald[1550]: Journal effective settings s=
eal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:22: [  270.520758] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling libsepol.aarch64 (66/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling zlib.aarch64 (67/1180)=1B[1;24r=1B=
[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling libstdc++.aarch64 (68/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling info.aarch64 (69/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling libcom_err.aarch64 (70/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling popt.aarch64 (71/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:23: =1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling xz-libs.aarch64 (72/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:23: =1B[22;1HInstalling libxml2.aarch64 (73/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:24: [  272.232436] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: =1B[1;23r=1B[23;80H
2019-08-18 19:33:24: =1B[22;1HInstalling libxcrypt.aarch64 (74/1180)=1B[1=
;24r=1B[23;1H[  272.245828] systemd-journald[1550]: Journal effective set=
tings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: =1B[1;23r=1B[23;80H
2019-08-18 19:33:24: =1B[22;1HInstalling perl-Carp.noarch (75/1180)=1B[1;=
24r=1B[23;1H[  272.286930] systemd-journald[1550]: Journal effective sett=
ings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: [  272.294822] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: =1B[1;23r=1B[23;80H
2019-08-18 19:33:24: =1B[22;1HInstalling perl-Exporter.noarch (76/1180)=1B=
[1;24r=1B[23;1H[  272.313074] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: [  272.321401] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: =1B[1;23r=1B[23;80H
2019-08-18 19:33:24: =1B[22;1HInstalling perl-libs.aarch64 (77/1180)=1B[1=
;24r=1B[23;1H[  272.340071] systemd-journald[1550]: Journal effective set=
tings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:24: [  272.355694] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:28: [  276.605483] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:28: =1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling elfutils-libelf.aarch64 (78/1180=
)=1B[1;24r=1B[23;1H[  276.620087] systemd-journald[1550]: Journal effecti=
ve settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:28: =1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling bzip2-libs.aarch64 (79/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling libcap.aarch64 (80/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:33:28: =1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling readline.aarch64 (81/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:28: =1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling libuuid.aarch64 (82/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:28: =1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling expat.aarch64 (83/1180)=1B[1;24r=
=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:28: =1B[22;1HInstalling libgpg-error.aarch64 (84/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:29: [  277.273969] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling libjpeg-turbo.aarch64 (85/1180)=1B=
[1;24r=1B[23;1H[  277.288534] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling libtalloc.aarch64 (86/1180)=1B[1=
;24r=1B[23;1H[  277.326194] systemd-journald[1550]: Journal effective set=
tings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: [  277.334099] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: [  277.350046] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: [  277.358232] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling chkconfig.aarch64 (87/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling sqlite-libs.aarch64 (88/1180)=1B=
[1;24r=1B[23;1H[  277.684863] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: [  277.705631] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling libpng.aarch64 (89/1180)=1B[1;24=
r=1B[23;1H[  277.824427] systemd-journald[1550]: Journal effective settin=
gs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: [  277.832748] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling freetype.aarch64 (90/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:29: =1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling libffi.aarch64 (91/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:29: =1B[22;1HInstalling libtdb.aarch64 (92/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling boost-system.aarch64 (93/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling gmp.aarch64 (94/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling pcre.aarch64 (95/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling grep.aarch64 (96/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling nspr.aarch64 (97/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling perl-Scalar-List-Utils.aarch64 (=
98/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:33:30: =1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling libcap-ng.aarch64 (99/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling audit-libs.aarch64 (100/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling nss-util.aarch64 (101/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling libtevent.aarch64 (102/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:30: =1B[22;1HInstalling libgcrypt.aarch64 (103/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:31: =1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling lua-libs.aarch64 (104/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling findutils.aarch64 (105/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:31: =1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling json-c.aarch64 (106/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling keyutils-libs.aarch64 (107/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libattr.aarch64 (108/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libacl.aarch64 (109/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling sed.aarch64 (110/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:31: =1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libbasicobjects.aarch64 (111/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libcollection.aarch64 (112/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libdhash.aarch64 (113/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libref_array.aarch64 (114/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling libICE.aarch64 (115/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:31: =1B[22;1HInstalling boost-chrono.aarch64 (116/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:32: =1B[1;23r=1B[23;80H
2019-08-18 19:33:32: =1B[22;1HInstalling libnl3.aarch64 (117/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:32: =1B[1;23r=1B[23;80H
2019-08-18 19:33:32: =1B[22;1HInstalling libSM.aarch64 (118/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:32: =1B[22;1HInstalling mpfr.aarch64 (119/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:33:32: =1B[1;23r=1B[23;80H
2019-08-18 19:33:32: =1B[22;1HInstalling p11-kit.aarch64 (120/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:32: =1B[1;23r=1B[23;80H
2019-08-18 19:33:32: =1B[22;1HInstalling augeas-libs.aarch64 (121/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:33: =1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling libtool-ltdl.aarch64 (122/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:33: =1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling lz4-libs.aarch64 (123/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling libX11-xcb.aarch64 (124/1180)=1B=
[1;24r=1B[23;1HInstalling boost-thread.aarch64 (125/1180)=1B[1;23r=1B[23;=
80H
2019-08-18 19:33:33: =1B[1;24r=1B[23;1H
2019-08-18 19:33:33: =1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling libwayland-client.aarch64 (126/1=
180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling perl-parent.noarch (127/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:33: =1B[22;1HInstalling libunistring.aarch64 (128/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:33: =1B[1;23r=1B[23;80H
2019-08-18 19:33:34: =1B[22;1HInstalling libidn2.aarch64 (129/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:34: =1B[1;23r=1B[23;80H
2019-08-18 19:33:34: =1B[22;1HInstalling libicu.aarch64 (130/1180)=1B[1;2=
4r=1B[23;1H[  282.371076] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:34: [  282.379321] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.429147] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.437221] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.499203] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.507218] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libtar.aarch64 (131/1180)=1B[1;2=
4r=1B[23;1H[  284.548457] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libmnl.aarch64 (132/1180)=1B[1;2=
4r=1B[23;1H[  284.561457] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.575934] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: [  284.583859] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libsss_idmap.aarch64 (133/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libogg.aarch64 (134/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libvorbis.aarch64 (135/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling boost-regex.aarch64 (136/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling libsemanage.aarch64 (137/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:36: =1B[22;1HInstalling xz.aarch64 (138/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:36: =1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling boost-filesystem.aarch64 (139/11=
80)=1B[1;24r=1B[23;1H
2019-08-18 19:33:37: =1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling file-libs.aarch64 (140/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:37: =1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling file.aarch64 (141/1180)=1B[1;24r=
=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling efivar-libs.aarch64 (142/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:37: =1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling gdbm-libs.aarch64 (143/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling jansson.aarch64 (144/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling libaio.aarch64 (145/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling which.aarch64 (146/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling libglvnd.aarch64 (147/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling pixman.aarch64 (148/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling libwayland-cursor.aarch64 (149/1=
180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:37: =1B[22;1HInstalling nettle.aarch64 (150/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:37: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling libassuan.aarch64 (151/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling perl-Text-ParseWords.noarch (152=
/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling xml-common.noarch (153/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling boost-context.aarch64 (154/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling boost-date-time.aarch64 (155/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling hunspell-en-GB.noarch (156/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling hunspell-en.noarch (157/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling hunspell-en-US.noarch (158/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling hunspell.aarch64 (159/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:38: =1B[1;23r=1B[23;80H
2019-08-18 19:33:38: =1B[22;1HInstalling grub2-common.noarch (160/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:39: [  287.386548] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.394491] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling cpio.aarch64 (161/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling libsmartcols.aarch64 (162/1180)=1B=
[1;24r=1B[23;1H[  287.557732] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.565675] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.597680] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.605669] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.701214] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.709596] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling lzo.aarch64 (163/1180)=1B[1;24r=1B=
[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling libXau.aarch64 (164/1180)=1B[1;2=
4r=1B[23;1H[  287.756191] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: [  287.764098] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling libxcb.aarch64 (165/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling libX11.aarch64 (166/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:39: =1B[1;23r=1B[23;80H
2019-08-18 19:33:39: =1B[22;1HInstalling libXext.aarch64 (167/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXrender.aarch64 (168/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXfixes.aarch64 (169/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXi.aarch64 (170/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXt.aarch64 (171/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXmu.aarch64 (172/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXrandr.aarch64 (173/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXinerama.aarch64 (174/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXcursor.aarch64 (175/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXdamage.aarch64 (176/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXcomposite.aarch64 (177/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXtst.aarch64 (178/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXpm.aarch64 (179/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libdrm.aarch64 (180/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:40: =1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libepoxy.aarch64 (181/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:40: =1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libieee1284.aarch64 (182/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:40: =1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libwayland-egl.aarch64 (183/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libxkbcommon.aarch64 (184/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXp.aarch64 (185/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libXxf86vm.aarch64 (186/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:40: =1B[22;1HInstalling libmpc.aarch64 (187/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:40: =1B[1;23r=1B[23;80H
2019-08-18 19:33:41: =1B[22;1HInstalling libnl3-cli.aarch64 (188/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:41: =1B[1;23r=1B[23;80H
2019-08-18 19:33:41: =1B[22;1HInstalling boost-timer.aarch64 (189/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:41: =1B[1;23r=1B[23;80H
2019-08-18 19:33:41: =1B[22;1HInstalling tar.aarch64 (190/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:41: =1B[1;23r=1B[23;80H
2019-08-18 19:33:41: =1B[22;1HInstalling libxslt.aarch64 (191/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling libwayland-server.aarch64 (192/1=
180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling unzip.aarch64 (193/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling e2fsprogs-libs.aarch64 (194/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling diffutils.aarch64 (195/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling libgomp.aarch64 (196/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:42: =1B[22;1HInstalling m4.aarch64 (197/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:42: =1B[1;23r=1B[23;80H
2019-08-18 19:33:43: =1B[22;1HInstalling boost-atomic.aarch64 (198/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:43: =1B[1;23r=1B[23;80H
2019-08-18 19:33:43: =1B[22;1HInstalling glibc-headers.aarch64 (199/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:45: =1B[1;23r=1B[23;80H
2019-08-18 19:33:45: =1B[22;1HInstalling libseccomp.aarch64 (200/1180)=1B=
[1;24r=1B[23;1H[  293.664213] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.672542] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.709433] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.717524] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: =1B[1;23r=1B[23;80H
2019-08-18 19:33:45: =1B[22;1HInstalling libtasn1.aarch64 (201/1180)=1B[1=
;24r=1B[23;1H[  293.863493] systemd-journald[1550]: Journal effective set=
tings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.871764] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.908406] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  293.922647] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: =1B[1;23r=1B[23;80H
2019-08-18 19:33:45: =1B[22;1HInstalling p11-kit-trust.aarch64 (202/1180)=
=1B[1;24r=1B[23;1H[  294.005901] systemd-journald[1550]: Journal effectiv=
e settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: [  294.013804] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:45: =1B[1;23r=1B[23;80H
2019-08-18 19:33:45: =1B[22;1HInstalling numactl-libs.aarch64 (203/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:45: =1B[1;23r=1B[23;80H
2019-08-18 19:33:46: =1B[22;1HInstalling pciutils-libs.aarch64 (204/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:33:46: =1B[1;23r=1B[23;80H
2019-08-18 19:33:46: =1B[22;1HInstalling slang.aarch64 (205/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:33:46: =1B[1;23r=1B[23;80H
2019-08-18 19:33:46: =1B[22;1HInstalling newt.aarch64 (206/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:33:46: =1B[1;23r=1B[23;80H
2019-08-18 19:33:46: =1B[22;1HInstalling gpm-libs.aarch64 (207/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling mesa-libglapi.aarch64 (208/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling opus.aarch64 (209/1180)=1B[1;24r=
=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling orc.aarch64 (210/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling boost-log.aarch64 (211/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling zip.aarch64 (212/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling boost-test.aarch64 (213/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling libXaw.aarch64 (214/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:47: =1B[1;23r=1B[23;80H
2019-08-18 19:33:47: =1B[22;1HInstalling boost-wave.aarch64 (215/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:48: =1B[1;23r=1B[23;80H
2019-08-18 19:33:48: =1B[22;1HInstalling boost-coroutine.aarch64 (216/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:48: =1B[22;1HInstalling boost-fiber.aarch64 (217/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:51: [  299.837458] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  299.845392] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: =1B[1;23r=1B[23;80H
2019-08-18 19:33:51: =1B[22;1HInstalling gdbm.aarch64 (218/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:33:51: =1B[1;23r=1B[23;80H
2019-08-18 19:33:51: =1B[22;1HInstalling boost-graph.aarch64 (219/1180)=1B=
[1;24r=1B[23;1H[  300.015937] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.024134] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.061965] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.070212] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: =1B[1;23r=1B[23;80H
2019-08-18 19:33:51: =1B[22;1HInstalling celt051.aarch64 (220/1180)=1B[1;=
24r=1B[23;1H[  300.129649] systemd-journald[1550]: Journal effective sett=
ings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.137695] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.172539] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:51: [  300.180904] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:52: =1B[1;23r=1B[23;80H
2019-08-18 19:33:52: =1B[22;1HInstalling libnftnl.aarch64 (221/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:33:52: =1B[1;23r=1B[23;80H
2019-08-18 19:33:52: =1B[22;1HInstalling boost-locale.aarch64 (222/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:52: =1B[1;23r=1B[23;80H
2019-08-18 19:33:52: =1B[22;1HInstalling libpsl.aarch64 (223/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:52: =1B[22;1HInstalling boost-type_erasure.aarch64 (224/=
1180)=1B[1;24r=1B[23;1H
2019-08-18 19:33:52: =1B[1;23r=1B[23;80H
2019-08-18 19:33:52: =1B[22;1HInstalling groff-base.aarch64 (225/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:53: =1B[1;23r=1B[23;80H
2019-08-18 19:33:53: =1B[22;1HInstalling patch.aarch64 (226/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:53: =1B[22;1HInstalling boost-random.aarch64 (227/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:33:53: =1B[1;23r=1B[23;80H
2019-08-18 19:33:53: =1B[22;1HInstalling sqlite.aarch64 (228/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:53: =1B[1;23r=1B[23;80H
2019-08-18 19:33:53: =1B[22;1HInstalling libv4l.aarch64 (229/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:33:53: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling libgpg-error-devel.aarch64 (230/=
1180)=1B[1;24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling libksba.aarch64 (231/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling libmetalink.aarch64 (232/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling bzip2.aarch64 (233/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling boost-iostreams.aarch64 (234/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-Term-ANSIColor.noarch (235/=
1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-macros.aarch64 (236/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-Errno.aarch64 (237/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-Socket.aarch64 (238/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-Text-Tabs+Wrap.noarch (239/=
1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-Unicode-Normalize.aarch64 (=
240/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-File-Path.noarch (241/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-IO.aarch64 (242/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-PathTools.aarch64 (243/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:33:54: =1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-constant.noarch (244/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-threads.aarch64 (245/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:54: =1B[22;1HInstalling perl-threads-shared.aarch64 (246=
/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:55: =1B[22;1HInstalling perl-interpreter.aarch64 (247/11=
80)=1B[1;24r=1B[23;1H
2019-08-18 19:33:58: =1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-MIME-Base64.aarch64 (248/11=
80)=1B[1;24r=1B[23;1H[  306.855328] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:33:58: [  306.861073] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: [  306.869332] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: [  306.877992] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: [  306.885948] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: =1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-Data-Dumper.aarch64 (249/11=
80)=1B[1;24r=1B[23;1H[  306.902157] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: [  306.910496] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: =1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-IO-Socket-IP.noarch (250/11=
80)=1B[1;24r=1B[23;1H[  306.936766] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: [  306.944663] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: =1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-version.aarch64 (251/1180)=1B=
[1;24r=1B[23;1H[  306.975032] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:33:58: =1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-Time-Local.noarch (252/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-CPAN-Meta-Requirements.noar=
ch (253/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-File-Temp.noarch (254/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:58: =1B[22;1HInstalling perl-Time-HiRes.aarch64 (255/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:33:59: =1B[22;1HInstalling mozjs52.aarch64 (256/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:34:00: =1B[1;23r=1B[23;80H
2019-08-18 19:34:00: =1B[22;1HInstalling snappy.aarch64 (257/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:00: =1B[22;1HInstalling boost-container.aarch64 (258/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:34:00: =1B[1;23r=1B[23;80H
2019-08-18 19:34:00: =1B[22;1HInstalling boost-math.aarch64 (259/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:34:00: =1B[1;23r=1B[23;80H
2019-08-18 19:34:00: =1B[22;1HInstalling boost-program-options.aarch64 (2=
60/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:34:00: =1B[1;23r=1B[23;80H
2019-08-18 19:34:01: =1B[22;1HInstalling boost-serialization.aarch64 (261=
/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:34:01: =1B[1;23r=1B[23;80H
2019-08-18 19:34:01: =1B[22;1HInstalling boost-signals.aarch64 (262/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:34:01: =1B[1;23r=1B[23;80H
2019-08-18 19:34:01: =1B[22;1HInstalling boost-stacktrace.aarch64 (263/11=
80)=1B[1;24r=1B[23;1H
2019-08-18 19:34:01: =1B[1;23r=1B[23;80H
2019-08-18 19:34:01: =1B[22;1HInstalling graphite2.aarch64 (264/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:34:01: =1B[1;23r=1B[23;80H
2019-08-18 19:34:01: =1B[22;1HInstalling tcl.aarch64 (265/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:34:02: =1B[1;23r=1B[23;80H
2019-08-18 19:34:02: =1B[22;1HInstalling less.aarch64 (266/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:34:02: =1B[1;23r=1B[23;80H
2019-08-18 19:34:02: =1B[22;1HInstalling lksctp-tools.aarch64 (267/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:34:02: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling c-ares.aarch64 (268/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling dmidecode.aarch64 (269/1180)=1B[=
1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling ethtool.aarch64 (270/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libedit.aarch64 (271/1180)=1B[1;=
24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libnfnetlink.aarch64 (272/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libnetfilter_conntrack.aarch64 (=
273/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libpath_utils.aarch64 (274/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libini_config.aarch64 (275/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libverto.aarch64 (276/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling libyaml.aarch64 (277/1180)=1B[1;=
24r=1B[23;1H[  311.877024] systemd-journald[1550]: Journal effective sett=
ings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: [  311.888994] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling lm_sensors-libs.aarch64 (278/118=
0)=1B[1;24r=1B[23;1H[  311.924818] systemd-journald[1550]: Journal effect=
ive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: [  311.933572] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: [  312.002011] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: [  312.010223] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: =1B[1;23r=1B[23;80H
2019-08-18 19:34:03: =1B[22;1HInstalling ncurses.aarch64 (279/1180)=1B[1;=
24r=1B[23;1H[  312.074704] systemd-journald[1550]: Journal effective sett=
ings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:03: [  312.083018] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling pcsc-lite-libs.aarch64 (280/1180=
)=1B[1;24r=1B[23;1H[  312.244022] systemd-journald[1550]: Journal effecti=
ve settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:04: [  312.252470] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling sg3_utils-libs.aarch64 (281/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling SDL.aarch64 (282/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling fribidi.aarch64 (283/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling lcms2.aarch64 (284/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling libasyncns.aarch64 (285/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling libpfm.aarch64 (286/1180)=1B[1;2=
4r=1B[23;1H
2019-08-18 19:34:04: =1B[1;23r=1B[23;80H
2019-08-18 19:34:04: =1B[22;1HInstalling papi-libs.aarch64 (287/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:34:05: =1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling libwebp.aarch64 (288/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:34:05: =1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling libxshmfence.aarch64 (289/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling libglvnd-glx.aarch64 (290/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling mesa-libGL.aarch64 (291/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling mesa-libGLU.aarch64 (292/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling papi.aarch64 (293/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:34:05: =1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling perl-Term-Cap.noarch (294/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling lm_sensors-devel.aarch64 (295/11=
80)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling boost.aarch64 (296/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling perl-Digest.noarch (297/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling perl-Digest-MD5.aarch64 (298/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:34:05: =1B[1;23r=1B[23;80H
2019-08-18 19:34:05: =1B[22;1HInstalling kernel-debug-devel.aarch64 (299/=
1180)=1B[1;24r=1B[23;1H
2019-08-18 19:34:55: [  363.663245] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:55: [  363.671505] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:59: [  368.025393] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:59: [  368.033909] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:59: [  368.119607] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:59: [  368.127675] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:34:59: =1B[1;23r=1B[23;80H
2019-08-18 19:35:00: =1B[22;1HInstalling kernel-devel.aarch64 (300/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:35:54: [  422.701166] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:35:54: [  422.706906] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: [  422.715390] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: [  422.724945] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: [  422.733859] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-Math-Complex.noarch (301/11=
80)=1B[1;24r=1B[23;1H[  422.761403] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: [  422.769577] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-Math-BigInt.noarch (302/118=
0)=1B[1;24r=1B[23;1H[  422.789356] systemd-journald[1550]: Journal effect=
ive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: [  422.797417] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-Pod-Escapes.noarch (303/118=
0)=1B[1;24r=1B[23;1H[  422.906523] systemd-journald[1550]: Journal effect=
ive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-Storable.aarch64 (304/1180)=
=1B[1;24r=1B[23;1H
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-CPAN-Meta-YAML.noarch (305/=
1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:54: =1B[22;1HInstalling perl-Error.noarch (306/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:35:54: =1B[1;23r=1B[23;80H
2019-08-18 19:35:55: =1B[22;1HInstalling perl-ExtUtils-Command.noarch (30=
7/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:55: =1B[22;1HInstalling perl-ExtUtils-Manifest.noarch (3=
08/1180)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:55: =1B[22;1HInstalling perl-TermReadKey.aarch64 (309/11=
80)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:55: =1B[22;1HInstalling perl-XML-Parser.aarch64 (310/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:35:55: =1B[1;23r=1B[23;80H
2019-08-18 19:35:55: =1B[22;1HInstalling valgrind.aarch64 (311/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:35:57: =1B[1;23r=1B[23;80H
2019-08-18 19:35:57: =1B[22;1HInstalling perl-Thread-Queue.noarch (312/11=
80)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling libgcrypt-devel.aarch64 (313/118=
0)=1B[1;24r=1B[23;1H
2019-08-18 19:35:58: =1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling mesa-libgbm.aarch64 (314/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:35:58: =1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling libglvnd-egl.aarch64 (315/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling mesa-libEGL.aarch64 (316/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling libglvnd-gles.aarch64 (317/1180)=
=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling libteam.aarch64 (318/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:35:58: =1B[1;23r=1B[23;80H
2019-08-18 19:35:58: =1B[22;1HInstalling cpp.aarch64 (319/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:36:01: [  430.107580] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:01: [  430.116396] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:01: =1B[1;23r=1B[23;80H
2019-08-18 19:36:01: =1B[22;1HInstalling libieee1284-devel.aarch64 (320/1=
180)=1B[1;24r=1B[23;1H[  430.134724] systemd-journald[1550]: Journal effe=
ctive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:01: [  430.143059] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling xorg-x11-xauth.aarch64 (321/1180=
)=1B[1;24r=1B[23;1H[  430.264264] systemd-journald[1550]: Journal effecti=
ve settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: [  430.272538] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling libXv.aarch64 (322/1180)=1B[1;24=
r=1B[23;1H[  430.287874] systemd-journald[1550]: Journal effective settin=
gs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: [  430.295824] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling libXxf86misc.aarch64 (323/1180)=1B=
[1;24r=1B[23;1H[  430.311470] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: [  430.319658] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling xcb-util.aarch64 (324/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling startup-notification.aarch64 (32=
5/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling squashfs-tools.aarch64 (326/1180=
)=1B[1;24r=1B[23;1H
2019-08-18 19:36:02: =1B[1;23r=1B[23;80H
2019-08-18 19:36:02: =1B[22;1HInstalling iso-codes.noarch (327/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:36:05: =1B[1;23r=1B[23;80H
2019-08-18 19:36:05: =1B[22;1HInstalling libglvnd-opengl.aarch64 (328/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling device-mapper-persistent-data.aa=
rch64 (329/1180)=1B[1;24r=1B[23;1H
2019-08-18 19:36:06: =1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling efivar.aarch64 (330/1180)=1B[1;2=
4r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling flac-libs.aarch64 (331/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:36:06: =1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling libtheora.aarch64 (332/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:36:06: =1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling ipset-libs.aarch64 (333/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:36:06: =1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling ipset.aarch64 (334/1180)=1B[1;24=
r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:06: =1B[22;1HInstalling unixODBC.aarch64 (335/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:36:07: [  435.247363] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: [  435.255336] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling acl.aarch64 (336/1180)=1B[1;24r=1B=
[23;1H[  435.421728] systemd-journald[1550]: Journal effective settings s=
eal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: [  435.429901] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling vim-minimal.aarch64 (337/1180)=1B=
[1;24r=1B[23;1H[  435.506929] systemd-journald[1550]: Journal effective s=
ettings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: [  435.514848] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling attr.aarch64 (338/1180)=1B[1;24r=
=1B[23;1H[  435.631309] systemd-journald[1550]: Journal effective setting=
s seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: [  435.639430] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling keyutils-libs-devel.aarch64 (339=
/1180)=1B[1;24r=1B[23;1H[  435.737983] systemd-journald[1550]: Journal ef=
fective settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512=
B
2019-08-18 19:36:07: [  435.745953] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling lua.aarch64 (340/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling copy-jdk-configs.noarch (341/118=
0)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling nss-softokn-freebl.aarch64 (342/=
1180)=1B[1;24r=1B[23;1H
2019-08-18 19:36:07: =1B[1;23r=1B[23;80H
2019-08-18 19:36:07: =1B[22;1HInstalling nss-softokn.aarch64 (343/1180)=1B=
[1;24r=1B[23;1H
2019-08-18 19:36:08: =1B[1;23r=1B[23;80H
2019-08-18 19:36:08: =1B[22;1HInstalling pcre-cpp.aarch64 (344/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:08: =1B[22;1HInstalling gmp-c++.aarch64 (345/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:36:08: =1B[1;23r=1B[23;80H
2019-08-18 19:36:08: =1B[22;1HInstalling gmp-devel.aarch64 (346/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:36:08: =1B[1;23r=1B[23;80H
2019-08-18 19:36:08: =1B[22;1HInstalling isl.aarch64 (347/1180)=1B[1;24r=1B=
[23;1H
2019-08-18 19:36:08: =1B[1;23r=1B[23;80H
2019-08-18 19:36:08: =1B[22;1HInstalling ttmkfdir.aarch64 (348/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling jasper-libs.aarch64 (349/1180)=1B=
[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling libcomps.aarch64 (350/1180)=1B[1=
;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling dwz.aarch64 (351/1180)=1B[1;24r=1B=
[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling perl-Fedora-VSP.noarch (352/1180=
)=1B[1;24r=1B[23;1H=1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling libss.aarch64 (353/1180)=1B[1;24=
r=1B[23;1H
2019-08-18 19:36:09: =1B[1;23r=1B[23;80H
2019-08-18 19:36:09: =1B[22;1HInstalling coreutils-common.aarch64 (354/11=
80)=1B[1;24r=1B[23;1H
2019-08-18 19:36:10: =1B[1;23r=1B[23;80H
2019-08-18 19:36:10: =1B[22;1HInstalling libasan.aarch64 (355/1180)=1B[1;=
24r=1B[23;1H
2019-08-18 19:36:10: =1B[1;23r=1B[23;80H
2019-08-18 19:36:10: =1B[22;1HInstalling libatomic.aarch64 (356/1180)=1B[=
1;24r=1B[23;1H
2019-08-18 19:36:10: =1B[1;23r=1B[23;80H
2019-08-18 19:36:10: =1B[22;1HInstalling libubsan.aarch64 (357/1180)=1B[1=
;24r=1B[23;1H
2019-08-18 19:36:10: =1B[1;23r=1B[23;80H
2019-08-18 19:36:10: =1B[22;1HInstalling make.aarch64 (358/1180)=1B[1;24r=
=1B[23;1H
2019-08-18 19:36:11: =1B[1;23r=1B[23;80H
2019-08-18 19:36:11: =1B[22;1HInstalling check.aarch64 (359/1180)=1B[1;24=
r=1B[23;1H[  439.335155] XFS (dm-3): Metadata corruption detected at xfs_=
inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 xfs_inode_bu=
f_verify
2019-08-18 19:36:11: [  439.345295] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:36:11: [  439.349167] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:36:11: =1B[1;23r=1B[23;80H
2019-08-18 19:36:11: =1B[22;1HInstalling libidn.aarch64 (360/1180)=1B[1;2=
4r=1B[23;1H[  439.354063] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00  ................
2019-08-18 19:36:11: [  439.365513] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.371929] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.378175] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.384242] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.390603] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.396784] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.402838] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:36:11: [  439.409314] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:36:11: [  439.416866] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:36:12: [  440.341560] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[23;80H=1B[1;23r=1B[23;80H
2019-08-18 19:36:12:=20
2019-08-18 19:36:12: =1B[22;1H=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=1B[23;1HError=1B[1;24r=1B[2=
3;6H[  440.371152] systemd-journald[1550]: Journal effective settings sea=
l=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.381579] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: =1B[1;23r=1B[23;80H
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:=20
2019-08-18 19:36:12: =1B[18;1H   The following error occurred while insta=
lling.  This is a fatal error and
2019-08-18 19:36:12:    installation will be aborted.
2019-08-18 19:36:12:=20
2019-08-18 19:36:12:    DNF error: Error unpacking rpm package libidn-1.3=
4-5.el8.aarch64=1B[23;1HPress ENTER to exit: =1B[1;24r=1B[23;22H[  440.40=
1675] systemd-journald[1550]: Journal effective settings seal=3Dyes compr=
ess=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.416875] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.424834] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.435956] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.444636] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.453797] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:12: [  440.462058] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:55: [  483.663229] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:36:55: [  483.671575] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:16: [  505.133873] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:37:16: [  505.139557] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:16: [  505.147607] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:16: [  505.156986] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:16: [  505.164899] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:55: [  543.663208] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:37:55: [  543.671456] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.698607] systemd-coredump[3271]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:38:27: [  575.700791] systemd-coredump[3268]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:38:27: [  575.706527] systemd-coredump[3271]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:38:27: [  575.714246] systemd-coredump[3268]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:38:27: [  575.725169] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.746134] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.765759] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.774448] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.786627] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.794530] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.803113] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.811948] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:27: [  575.820362] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:38:27: [  575.826144] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.755824] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.763742] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.772198] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.780329] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.805826] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.813708] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.845822] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.853705] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.862128] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:32: [  580.870253] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:34: [  582.348127] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:38:34: [  582.357927] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:38:34: [  582.361582] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:38:34: [  582.366572] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.372859] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.379138] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.385212] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.391628] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.397851] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.403924] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.410259] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:34: [  582.416439] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:38:34: [  582.423679] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:38:43: [  591.410284] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.418981] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.429551] systemd-coredump[3408]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:38:43: [  591.437014] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.444907] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.453329] systemd-coredump[3408]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:38:43: [  591.460625] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.468781] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.477845] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.485848] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.493931] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:43: [  591.504891] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  597.974290] systemd-coredump[3516]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:38:49: [  597.982108] systemd-coredump[3516]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:38:49: [  597.987991] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  597.995942] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.022295] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.032079] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.041732] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.050082] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.059185] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.067836] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.076633] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:38:49: [  598.083878] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:38:49: [  598.113183] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:38:49: [  598.123190] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:38:49: [  598.126936] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:38:49: [  598.131828] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.138047] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.144107] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.150441] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.156597] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.162661] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.168920] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.174984] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:49: [  598.181414] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:38:49: [  598.188956] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:38:50: [  598.195327] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:38:50: [  598.205512] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:38:50: [  598.209380] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:38:50: [  598.214476] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.220839] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.227081] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.233150] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.239441] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.245746] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.251816] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.258036] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.264149] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:38:50: [  598.271785] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:38:50: [  598.278068] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:38:50: [  598.288136] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:38:50: [  598.291783] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:38:50: [  598.296764] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.302835] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.309116] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.315190] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.321607] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.327820] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.333887] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.340216] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:38:50: [  598.346385] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:38:50: [  598.346392] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:39:12: [  621.055482] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.063892] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.077880] systemd-coredump[3591]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:39:12: [  621.085187] systemd-coredump[3591]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:39:12: [  621.091216] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.114094] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.137596] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.145495] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.166090] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.173968] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:12: [  621.184310] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:39:13: [  621.191413] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:13: [  622.103951] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:39:13: [  622.114037] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:39:13: [  622.117835] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:39:13: [  622.122893] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.129191] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.136087] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.142165] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.148415] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.154488] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.160875] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.167063] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:13: [  622.173188] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:39:13: [  622.180813] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:39:51: [  659.584729] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.593151] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.642024] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.650309] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.658585] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.668380] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.913354] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:51: [  659.921623] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:55: [  663.204686] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:55: [  663.213076] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.432272] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:39:58: [  666.442277] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:39:58: [  666.446014] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:39:58: [  666.446141] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.450912] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.450918] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.459006] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.465003] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465006] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465008] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465010] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465013] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465015] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:39:58: [  666.465053] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:39:58: [  666.471590] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.479451] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:39:58: [  666.538480] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.546553] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.554438] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.562840] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.571090] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.579263] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:39:58: [  666.587268] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  679.965625] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  679.973566] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.031245] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.039500] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.048029] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.055976] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.064539] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:11: [  680.072839] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.242176] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.250432] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.300035] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.308255] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.316411] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:17: [  685.324337] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.672882] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:40:23: [  691.682946] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:40:23: [  691.686704] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:40:23: [  691.686836] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.691603] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.691609] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.699751] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.705770] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.712021] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.719905] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.719907] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.719912] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.726062] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.733834] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.740289] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.746252] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:40:23: [  691.746279] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:40:23: [  691.752380] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.760427] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:40:23: [  691.766677] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.809875] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.818011] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:23: [  691.825943] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:55: [  723.663462] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:55: [  723.671741] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:57: [  725.570594] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:40:57: [  725.579463] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.699963] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:41:04: [  732.709879] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:41:04: [  732.713519] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:41:04: [  732.718612] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.718740] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.724688] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.724693] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.733038] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.739235] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.739237] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.739242] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.745488] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.753576] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.753581] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:41:04: [  732.759976] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.766128] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:41:04: [  732.772582] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.780575] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:41:04: [  732.786778] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.830212] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.838280] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.846376] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:04: [  732.854286] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.299275] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.307366] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.355419] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.363867] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.372340] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.380641] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.720876] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:14: [  742.729353] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:16: [  744.695782] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:16: [  744.703760] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:28: [  756.977330] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:41:28: [  756.983348] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:28: [  756.991595] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:28: [  757.000455] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:28: [  757.008612] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:30: [  758.214321] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:30: [  758.223253] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:30: [  758.280088] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:30: [  758.288654] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:30: [  758.298281] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:38: [  766.237558] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:38: [  766.245728] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:55: [  783.663130] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:55: [  783.671379] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.727947] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.736684] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.785296] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.793843] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.802760] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:56: [  784.811681] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:57: [  785.807139] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:41:57: [  785.815077] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.614520] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.624893] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.633648] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.641917] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.650540] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.658625] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.667153] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:42:01: [  789.673924] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.682212] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:01: [  789.690592] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:07: [  796.142654] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:42:07: [  796.152675] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:42:07: [  796.156415] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:42:07: [  796.156542] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:07: [  796.161307] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:07: [  796.161313] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:07: [  796.169442] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.175405] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.181980] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.189861] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.189864] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.189866] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.189868] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.189873] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:08: [  796.196028] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.203839] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:42:08: [  796.210389] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.216373] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:42:08: [  796.222490] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.272411] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.280661] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.289336] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:08: [  796.297354] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:09: [  797.960189] XFS (dm-3): Metadata corruption detec=
ted at xfs_inode_buf_verify+0x174/0x190 [xfs], xfs_inode block 0xb1d960 x=
fs_inode_buf_verify
2019-08-18 19:42:09: [  797.970061] XFS (dm-3): Unmount and run xfs_repai=
r
2019-08-18 19:42:09: [  797.973696] XFS (dm-3): First 128 bytes of corrup=
ted metadata buffer:
2019-08-18 19:42:09: [  797.978801] 00000000: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  797.984852] 00000010: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  797.991251] 00000020: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  797.997453] 00000030: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  798.003513] 00000040: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  798.009861] 00000050: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  798.016017] 00000060: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  798.022102] 00000070: 00 00 00 00 00 00 00 00 00 =
00 00 00 00 00 00 00  ................
2019-08-18 19:42:09: [  798.028414] XFS (dm-3): metadata I/O error in "xf=
s_trans_read_buf_map" at daddr 0xb1d960 len 32 error 117
2019-08-18 19:42:09: [  798.035713] XFS (dm-3): xfs_imap_to_bp: xfs_trans=
_read_buf() returned error -117.
2019-08-18 19:42:16: [  805.114807] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.123500] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.135910] systemd-coredump[4364]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:42:16: [  805.143579] systemd-coredump[4364]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:42:16: [  805.149526] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.159008] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.167104] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.175008] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:16: [  805.183959] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:17: [  805.195375] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:17: [  805.205716] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:17: [  805.213620] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:27: [  815.234519] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:27: [  815.243082] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.214091] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.222943] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.271155] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.279417] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.288140] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.296070] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.304586] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:45: [  833.312878] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:47: [  835.214375] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:47: [  835.223423] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.627689] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.636406] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.676757] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.684698] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.697598] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.708692] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.717360] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.725326] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.738151] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:42:50: [  838.746219] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.431246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:43:02: [  850.436841] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.444749] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.453642] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.461986] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.470413] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.480258] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.494804] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:43:02: [  850.501981] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:02: [  850.510151] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:06: [  854.563205] systemd-coredump[4540]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:43:06: [  854.570867] systemd-coredump[4540]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:43:10: [  858.466173] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.474156] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.482755] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.491026] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.499324] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.507423] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.515577] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.523460] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:10: [  858.532113] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:43:10: [  858.539133] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.606789] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.615492] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.663728] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.672034] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.680668] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:26: [  874.688770] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:30: [  878.623054] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:30: [  878.631895] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:30: [  878.680528] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:30: [  878.688680] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.916420] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.925169] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.974102] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.982460] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.990840] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:37: [  885.998952] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:38: [  886.210255] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:38: [  886.218780] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:40: [  888.372899] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:40: [  888.381763] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.663152] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.673385] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.681900] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.698762] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.709221] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.717650] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.727040] systemd-journald[1550]: Successfully =
sent stream file descriptor to service manager.
2019-08-18 19:43:55: [  903.733790] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.742167] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:43:55: [  903.750559] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:44:55: [  963.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:44:55: [  963.667646] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:44:55: [  963.675866] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:42: [ 1011.085591] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:42: [ 1011.093564] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.375979] systemd-coredump[4976]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:45:43: [ 1011.383522] systemd-coredump[4976]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:45:43: [ 1011.389524] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.405813] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.421948] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.431930] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.442813] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.451710] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.460246] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:43: [ 1011.468518] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:44: [ 1012.860522] systemd-coredump[5086]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:45:44: [ 1012.868034] systemd-coredump[5086]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:45:44: [ 1012.879067] systemd-coredump[5087]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:45:44: [ 1012.895226] systemd-coredump[5087]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:45:44: [ 1012.927500] systemd-coredump[5091]: Failed to get=
 COMM, falling back to the command line: No such process
2019-08-18 19:45:44: [ 1012.937912] systemd-coredump[5091]: Failed to get=
 EXE, ignoring: No such process
2019-08-18 19:45:55: [ 1023.663133] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:55: [ 1023.671394] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:59: [ 1027.306602] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:45:59: [ 1027.312109] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:59: [ 1027.320277] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:59: [ 1027.328948] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:45:59: [ 1027.336958] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.662219] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:47:55: [ 1143.667598] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.675540] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.683702] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.691943] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.700269] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:47:55: [ 1143.708338] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:35: [ 1243.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:49:35: [ 1243.667599] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:35: [ 1243.675609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:55: [ 1263.663143] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:55: [ 1263.671365] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:55: [ 1263.679702] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:49:55: [ 1263.687739] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:50:45: [ 1313.662241] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:50:45: [ 1313.667597] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:50:45: [ 1313.675578] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:51:55: [ 1383.663162] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:51:55: [ 1383.671401] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:51:55: [ 1383.679763] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:51:55: [ 1383.687797] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:52:35: [ 1423.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:52:35: [ 1423.667595] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:52:35: [ 1423.675571] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.662393] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:53:55: [ 1503.667744] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.675702] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.683853] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.692115] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.700542] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:53:55: [ 1503.708646] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:35: [ 1603.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:55:35: [ 1603.667609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:35: [ 1603.675563] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:55: [ 1623.663099] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:55: [ 1623.671429] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:55: [ 1623.679809] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:55:55: [ 1623.687855] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:56:55: [ 1683.662242] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:56:55: [ 1683.667735] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:56:55: [ 1683.675697] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:57:55: [ 1743.663160] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:57:55: [ 1743.671422] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:57:55: [ 1743.679768] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:57:55: [ 1743.687816] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:58:35: [ 1783.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:58:35: [ 1783.667629] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:58:35: [ 1783.675593] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.662400] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 19:59:55: [ 1863.668366] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.676370] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.684525] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.692845] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.701217] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 19:59:55: [ 1863.709348] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:35: [ 1963.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:01:35: [ 1963.667599] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:35: [ 1963.675513] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:55: [ 1983.663097] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:55: [ 1983.671361] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:55: [ 1983.679726] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:01:55: [ 1983.687763] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:02:55: [ 2043.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:02:55: [ 2043.667613] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:02:55: [ 2043.675577] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:03:55: [ 2103.663150] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:03:55: [ 2103.671409] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:03:55: [ 2103.679766] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:03:55: [ 2103.687792] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:04:35: [ 2143.662238] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:04:35: [ 2143.667597] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:04:35: [ 2143.675514] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.662394] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:05:55: [ 2223.667825] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.675761] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.683901] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.692168] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.700508] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:05:55: [ 2223.708583] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:35: [ 2323.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:07:35: [ 2323.667619] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:35: [ 2323.676240] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:55: [ 2343.663097] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:55: [ 2343.671342] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:55: [ 2343.679683] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:07:55: [ 2343.687705] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:08:55: [ 2403.662249] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:08:55: [ 2403.667620] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:08:55: [ 2403.675575] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:09:55: [ 2463.663157] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:09:55: [ 2463.671424] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:09:55: [ 2463.679779] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:09:55: [ 2463.687829] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:10:35: [ 2503.662250] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:10:35: [ 2503.667645] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:10:35: [ 2503.675609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.662436] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:11:55: [ 2583.667800] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.675732] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.683863] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.692115] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.700444] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:11:55: [ 2583.708519] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:35: [ 2683.662249] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:13:35: [ 2683.667696] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:35: [ 2683.675631] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:55: [ 2703.663098] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:55: [ 2703.671347] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:55: [ 2703.679681] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:13:55: [ 2703.687710] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:14:55: [ 2763.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:14:55: [ 2763.667588] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:14:55: [ 2763.675515] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:15:55: [ 2823.663145] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:15:55: [ 2823.672146] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:15:55: [ 2823.680618] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:15:55: [ 2823.688733] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:16:35: [ 2863.662242] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:16:35: [ 2863.667610] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:16:35: [ 2863.675602] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.662594] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:17:55: [ 2943.668555] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.676539] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.684673] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.692984] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.701376] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:17:55: [ 2943.709503] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:35: [ 3043.662252] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:19:35: [ 3043.667631] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:35: [ 3043.675590] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:55: [ 3063.663128] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:55: [ 3063.671441] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:55: [ 3063.679963] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:19:55: [ 3063.688012] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:20:55: [ 3123.662250] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:20:55: [ 3123.667636] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:20:55: [ 3123.675610] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:21:55: [ 3183.663151] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:21:55: [ 3183.671379] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:21:55: [ 3183.679741] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:21:55: [ 3183.687776] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:22:35: [ 3223.662242] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:22:35: [ 3223.667624] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:22:35: [ 3223.675592] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.662389] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:23:55: [ 3303.667747] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.675702] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.683882] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.692163] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.700488] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:23:55: [ 3303.708563] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:35: [ 3403.662249] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:25:35: [ 3403.667600] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:35: [ 3403.676058] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:55: [ 3423.663101] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:55: [ 3423.671356] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:55: [ 3423.679694] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:25:55: [ 3423.688136] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:26:55: [ 3483.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:26:55: [ 3483.667594] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:26:55: [ 3483.675499] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:27:55: [ 3543.663147] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:27:55: [ 3543.671394] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:27:55: [ 3543.679744] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:27:55: [ 3543.688578] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:28:35: [ 3583.662250] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:28:35: [ 3583.667592] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:28:35: [ 3583.675493] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.662387] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:29:55: [ 3663.667768] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.675679] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.683808] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.692059] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.700376] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:29:55: [ 3663.708431] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:35: [ 3763.662239] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:31:35: [ 3763.667614] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:35: [ 3763.675511] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:55: [ 3783.663087] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:55: [ 3783.671439] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:55: [ 3783.679815] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:31:55: [ 3783.687865] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:32:55: [ 3843.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:32:55: [ 3843.667626] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:32:55: [ 3843.675569] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:33:55: [ 3903.663203] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:33:55: [ 3903.671454] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:33:55: [ 3903.679813] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:33:55: [ 3903.687850] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:34:35: [ 3943.662251] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:34:35: [ 3943.667622] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:34:35: [ 3943.675550] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.662387] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:35:55: [ 4023.667751] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.675690] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.683821] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.692070] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.700384] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:35:55: [ 4023.708447] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:35: [ 4123.662238] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:37:35: [ 4123.667585] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:35: [ 4123.675482] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:55: [ 4143.663096] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:55: [ 4143.671320] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:55: [ 4143.679678] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:37:55: [ 4143.687682] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:38:55: [ 4203.662234] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:38:55: [ 4203.667599] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:38:55: [ 4203.675492] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:39:55: [ 4263.663139] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:39:55: [ 4263.671403] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:39:55: [ 4263.679736] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:39:55: [ 4263.687737] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:40:35: [ 4303.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:40:35: [ 4303.667644] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:40:35: [ 4303.675556] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.662385] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:41:55: [ 4383.667750] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.675651] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.683776] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.692005] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.700303] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:41:55: [ 4383.708340] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:35: [ 4483.662239] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:43:35: [ 4483.667627] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:35: [ 4483.675555] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:55: [ 4503.663095] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:55: [ 4503.671342] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:55: [ 4503.679692] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:43:55: [ 4503.687707] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:44:55: [ 4563.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:44:55: [ 4563.667631] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:44:55: [ 4563.675592] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:45:55: [ 4623.663182] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:45:55: [ 4623.671511] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:45:55: [ 4623.679890] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:45:55: [ 4623.687922] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:46:35: [ 4663.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:46:35: [ 4663.667602] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:46:35: [ 4663.675508] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.662396] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:47:55: [ 4743.667824] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.675810] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.683950] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.692208] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.700560] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:47:55: [ 4743.708756] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:35: [ 4843.662241] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:49:35: [ 4843.667593] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:35: [ 4843.675575] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:55: [ 4863.663079] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:55: [ 4863.671320] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:55: [ 4863.679658] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:49:55: [ 4863.687684] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:50:55: [ 4923.662233] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:50:55: [ 4923.667604] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:50:55: [ 4923.675517] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:51:55: [ 4983.663146] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:51:55: [ 4983.671376] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:51:55: [ 4983.679728] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:51:55: [ 4983.687769] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:52:35: [ 5023.662238] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:52:35: [ 5023.667631] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:52:35: [ 5023.675577] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.662387] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:53:55: [ 5103.667753] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.675692] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.683815] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.692060] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.700374] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:53:55: [ 5103.708424] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:35: [ 5203.662245] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:55:35: [ 5203.667727] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:35: [ 5203.675685] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:55: [ 5223.663072] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:55: [ 5223.671336] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:55: [ 5223.679689] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:55:55: [ 5223.687729] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:56:55: [ 5283.662239] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:56:55: [ 5283.667632] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:56:55: [ 5283.675609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:57:55: [ 5343.663213] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:57:55: [ 5343.671505] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:57:55: [ 5343.679889] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:57:55: [ 5343.687960] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:58:35: [ 5383.662245] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:58:35: [ 5383.667621] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:58:35: [ 5383.675601] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.662381] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 20:59:55: [ 5463.667746] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.675725] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.683877] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.692138] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.700491] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 20:59:55: [ 5463.708557] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:35: [ 5563.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:01:35: [ 5563.667607] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:35: [ 5563.675603] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:55: [ 5583.663181] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:55: [ 5583.671427] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:55: [ 5583.679906] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:01:55: [ 5583.687985] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:02:55: [ 5643.662249] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:02:55: [ 5643.667618] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:02:55: [ 5643.675605] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:03:55: [ 5703.663307] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:03:55: [ 5703.671570] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:03:55: [ 5703.679943] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:03:55: [ 5703.688015] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:04:35: [ 5743.662251] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:04:35: [ 5743.667642] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:04:35: [ 5743.675615] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.662486] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:05:55: [ 5823.667919] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.675878] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.684010] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.692277] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.700624] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:05:55: [ 5823.708711] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:35: [ 5923.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:07:35: [ 5923.667653] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:35: [ 5923.675624] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:55: [ 5943.663220] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:55: [ 5943.671524] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:55: [ 5943.679913] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:07:55: [ 5943.688082] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:08:55: [ 6003.662248] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:08:55: [ 6003.667645] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:08:55: [ 6003.675620] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:09:55: [ 6063.663159] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:09:55: [ 6063.671384] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:09:55: [ 6063.679744] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:09:55: [ 6063.687796] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:10:35: [ 6103.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:10:35: [ 6103.667600] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:10:35: [ 6103.675588] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.662393] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:11:55: [ 6183.667751] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.675704] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.683847] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.692113] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.700452] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:11:55: [ 6183.708524] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:35: [ 6283.662246] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:13:35: [ 6283.667609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:35: [ 6283.675601] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:55: [ 6303.663098] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:55: [ 6303.671479] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:55: [ 6303.679888] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:13:55: [ 6303.688056] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:14:55: [ 6363.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:14:55: [ 6363.667646] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:14:55: [ 6363.675611] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:15:55: [ 6423.663159] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:15:55: [ 6423.671416] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:15:55: [ 6423.679772] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:15:55: [ 6423.687832] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:16:35: [ 6463.662245] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:16:35: [ 6463.667621] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:16:35: [ 6463.675589] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.662399] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:17:55: [ 6543.667801] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.675769] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.683908] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.692175] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.700510] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:17:55: [ 6543.708600] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:35: [ 6643.662244] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:19:35: [ 6643.667625] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:35: [ 6643.675599] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:55: [ 6663.663142] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:55: [ 6663.671390] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:55: [ 6663.679758] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:19:55: [ 6663.687813] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:20:55: [ 6723.662286] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:20:55: [ 6723.667641] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:20:55: [ 6723.675630] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:21:55: [ 6783.663147] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:21:55: [ 6783.671410] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:21:55: [ 6783.679750] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:21:55: [ 6783.687859] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:22:35: [ 6823.662247] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:22:35: [ 6823.667610] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:22:35: [ 6823.675614] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.662399] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:23:55: [ 6903.667807] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.675796] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.683967] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.692411] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.700796] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:23:55: [ 6903.709003] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:35: [ 7003.662243] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:25:35: [ 7003.667586] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:35: [ 7003.675510] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:55: [ 7023.663434] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:55: [ 7023.671817] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:55: [ 7023.680228] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:25:55: [ 7023.688316] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:26:55: [ 7083.662245] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:26:55: [ 7083.667636] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:26:55: [ 7083.675589] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:27:55: [ 7143.663197] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:27:55: [ 7143.671480] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:27:55: [ 7143.679848] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:27:55: [ 7143.687906] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:28:35: [ 7183.662241] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:28:35: [ 7183.667634] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:28:35: [ 7183.675595] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.662382] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:29:55: [ 7263.667775] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.675848] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.683985] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.692274] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.700727] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:29:55: [ 7263.708843] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:35: [ 7363.662242] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:31:35: [ 7363.667725] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:35: [ 7363.675686] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:55: [ 7383.663135] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:55: [ 7383.671382] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:55: [ 7383.679755] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:31:55: [ 7383.687813] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:55: [ 7443.662248] systemd-journald[1550]: Sent WATCHDOG=
=3D1 notification.
2019-08-18 21:32:55: [ 7443.667609] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:55: [ 7443.675582] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: [ 7446.246623] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: [ 7446.254579] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: =1B[1;23r=1B[23;80H
2019-08-18 21:32:58: =1B[1;24r=1B[23;1H[ 7446.265329] systemd-journald[15=
50]: Journal effective settings seal=3Dyes compress=3Dyes compress_thresh=
old_bytes=3D512B
2019-08-18 21:32:58: [ 7446.273839] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: [ 7446.282388] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: [ 7446.291279] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: [ 7446.299603] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:32:58: =1B[1;0r=1B[m=1B(B=1B[H=1B[J[terminated]
2019-08-18 21:32:58: =1B[r=1B[H=1B[2J
2019-08-18 21:32:59: [ 7447.337098] audit: type=3D1131 audit(1566178379.1=
20:1333): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsyste=
m_u:system_r:kernel_t:s0 msg=3D'unit=3Discsi-shutdown comm=3D"systemd" ex=
e=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Ds=
uccess'
2019-08-18 21:32:59: [ 7447.409032] audit: type=3D1130 audit(1566178379.1=
80:1334): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsyste=
m_u:system_r:kernel_t:s0 msg=3D'unit=3Dplymouth-poweroff comm=3D"systemd"=
 exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3D=
success'
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Anaconda.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Anaconda Syst=
em Services.
2019-08-18 21:32:59:          Stopping Service enabling compressing RAM w=
ith zRam...
2019-08-18 21:32:59:          Stopping OpenSSH server daemon...
2019-08-18 21:32:59:          Stopping Login Service...
2019-08-18 21:32:59:          Stopping System Logging Service...[ 7447.57=
2820] audit: type=3D1131 audit(1566178379.210:1335): pid=3D1 uid=3D0 auid=
=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:kernel_t:s0 msg=3D=
'unit=3Danaconda comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostna=
me=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59: [ 7447.590927] audit: type=3D2404 audit(1566178379.3=
00:1336): pid=3D1848 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsy=
stem_u:system_r:kernel_t:s0 msg=3D'op=3Ddestroy kind=3Dserver fp=3DSHA256=
:79:3b:74:0e:fa:40:75:53:fd:d8:1f:ae:40:05:37:48:72:9f:1a:d1:5b:b5:f4:34:=
38:7d:77:cb:0a:98:13:94 direction=3D? spid=3D1848 suid=3D0  exe=3D"/usr/s=
bin/sshd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59: [ 7447.590933] audit: type=3D2404 audit(1566178379.3=
00:1337): pid=3D1848 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsy=
stem_u:system_r:kernel_t:s0 msg=3D'op=3Ddestroy kind=3Dserver fp=3DSHA256=
:92:bb:fc:8a:66:ee:0a:56:4c:c9:44:4a:af:92:60:11:b9:8c:90:ea:be:0b:6c:3d:=
04:7f:86:bf:e8:02:d6:4b direction=3D? spid=3D1848 suid=3D0  exe=3D"/usr/s=
bin/sshd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59:=20
2019-08-18 21:32:59: [ 7447.590940] audit: type=3D2404 audit(1566178379.3=
00:1338): pid=3D1848 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsy=
stem_u:system_r:kernel_t:s0 msg=3D'op=3Ddestroy kind=3Dserver fp=3DSHA256=
:75:1f:4e:25:6c:83:7b:21:72:0a:48:47:ce:99:78:e3:fa:1d:2f:8d:2e:95:c9:1c:=
85:62:c3:c4:98:11:ce:9f direction=3D? spid=3D1848 suid=3D0  exe=3D"/usr/s=
bin/sshd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59:          Stopping anaconda performance monitor...
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped anaconda performance=
 monitor.
2019-08-18 21:32:59: [ 7447.695584] audit: type=3D1131 audit(1566178379.4=
70:1339): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsyste=
m_u:system_r:kernel_t:s0 msg=3D'unit=3Dinstperf comm=3D"systemd" exe=3D"/=
usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess=
'
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped System Logging Servi=
ce.[ 7447.712755] audit: type=3D1131 audit(1566178379.470:1340): pid=3D1 =
uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:kerne=
l_t:s0 msg=3D'unit=3Drsyslog comm=3D"systemd" exe=3D"/usr/lib/systemd/sys=
temd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59:=20
2019-08-18 21:32:59: [ 7447.733325] audit: type=3D1131 audit(1566178379.4=
70:1341): pid=3D1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsyste=
m_u:system_r:kernel_t:s0 msg=3D'unit=3Danaconda-sshd comm=3D"systemd" exe=
=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsu=
ccess'
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped OpenSSH server daemo=
n.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Login Service.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Disk Manager.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target sshd-keygen.t=
arget.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Network is On=
line.[ 7447.810268] audit: type=3D1131 audit(1566178379.550:1342): pid=3D=
1 uid=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:ker=
nel_t:s0 msg=3D'unit=3Dsystemd-logind comm=3D"systemd" exe=3D"/usr/lib/sy=
stemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
2019-08-18 21:32:59:=20
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Network.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Network Manager Wait=
 Online.
2019-08-18 21:32:59:          Stopping Network Manager...
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Service enabling com=
pressing RAM with zRam.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped LVM event activation=
 on device 8:3.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Removed slice system-lvm2\x2=
dpvscan.slice.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped Network Manager.
2019-08-18 21:32:59:          Stopping D-Bus System Message Bus...
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped D-Bus System Message=
 Bus.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Basic System.=

2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Sockets.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Closed Open-iSCSI iscsiuio S=
ocket.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Closed Activation socket for=
 spice guest agent daemon.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Closed Open-iSCSI iscsid Soc=
ket.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Slices.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Removed slice User and Sessi=
on Slice.
2019-08-18 21:32:59: [=1B[0;32m  OK  =1B[0m] Stopped target Paths.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Forward Password Req=
uests to Plymouth Directory Watch.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Closed D-Bus System Message =
Bus Socket.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped target System Initia=
lization.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Apply Kernel Variabl=
es.
2019-08-18 21:33:00:          Stopping Update UTMP about System Boot/Shut=
down...
2019-08-18 21:33:00:          Stopping Load/Save Random Seed...
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Update is Completed.=

2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Rebuild Hardware Dat=
abase.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped target Local Encrypt=
ed Volumes.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Rebuild Dynamic Link=
er Cache.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Rebuild Journal Cata=
log.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Update UTMP about Sy=
stem Boot/Shutdown.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Create Volatile File=
s and Directories.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Import network confi=
guration from initramfs.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped target Local File Sy=
stems.
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/proc...
2019-08-18 21:33:00:          Unmounting /run/install/repo...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/sys/fs/selinux...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/run...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/boot/efi...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/dev/pts...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/dev/shm...
2019-08-18 21:33:00:          Unmounting Temporary Directory (/tmp)...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/sys/firmware/efi/e=
fivars...
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Load/Save Random See=
d.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/proc=
=2E
2019-08-18 21:33:00: [=1B[0;1;31mFAILED=1B[0m] Failed unmounting /run/ins=
tall/repo.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/sys/=
fs/selinux.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/run.=

2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/boot=
/efi.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/dev/=
pts.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/dev/=
shm.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted Temporary Director=
y (/tmp).
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/sys/=
firmware/efi/efivars.
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/dev...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/boot...
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped target Swap.
2019-08-18 21:33:00:          Deactivating swap /dev/disk/by-id/dm-name-r=
hel-swap...
2019-08-18 21:33:00:          Unmounting /mnt/sysimage/sys...
2019-08-18 21:33:00: [ 7448.525848] XFS (sda2): Unmounting Filesystem
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/dev.=

2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/sys.=

2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/rhel/s=
wap.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/mapper=
/rhel-swap.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/disk/b=
y-uuid/f8e9c-0506-45d2-a772-80a5bcddaa50.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/disk/b=
y-id/dm0wvGGvmFU5Pizu7qD5HbcX4F47VDbGMOH.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/disk/b=
y-id/dm-name-rhel-swap.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Deactivated swap /dev/dm-2.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage/boot=
=2E
2019-08-18 21:33:00:          Unmounting /mnt/sysimage...
2019-08-18 21:33:00: [ 7448.823604] XFS (dm-3): Unmounting Filesystem
2019-08-18 21:33:00: [ 7448.840017] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00: [ 7448.848107] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Unmounted /mnt/sysimage.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Reached target Unmount All F=
ilesystems.[ 7448.933188] systemd-journald[1550]: Journal effective setti=
ngs seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00:=20
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped target Local File Sy=
stems (Pre).
2019-08-18 21:33:00:          Stopping Device-Mapper Multipath Device Con=
troller...
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Create Static Device=
 Nodes in /dev.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Create System Users.=
[ 7448.969267] systemd-journald[1550]: Journal effective settings seal=3D=
yes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00: [ 7448.984718] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00:=20
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Remount Root and Ker=
nel File Systems.[ 7448.999031] systemd-journald[1550]: Journal effective=
 settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00:=20
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Reached target Shutdown.
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Reached target Final Step.[ =
7449.011707] systemd-journald[1550]: Journal effective settings seal=3Dye=
s compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00:=20
2019-08-18 21:33:00:          Starting Power-Off...
2019-08-18 21:33:00: [=1B[0;32m  OK  =1B[0m] Stopped Device-Mapper Multip=
ath Device Controller.[ 7449.030138] systemd-journald[1550]: Journal effe=
ctive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00:=20
2019-08-18 21:33:00: [ 7449.038826] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:00: [ 7449.051822] systemd-journald[1550]: Journal effec=
tive settings seal=3Dyes compress=3Dyes compress_threshold_bytes=3D512B
2019-08-18 21:33:01: [ 7449.140230] systemd-shutdow: 555 output lines sup=
pressed due to ratelimiting
2019-08-18 21:33:01: [ 7449.158963] systemd-shutdown[1]: Found cgroup on =
/sys/fs/cgroup/systemd, legacy hierarchy
2019-08-18 21:33:01: [ 7449.371561] systemd-shutdown[1]: Successfully for=
ked off '(sd-sync)' as PID 13260.
2019-08-18 21:33:01: [ 7449.377953] systemd-shutdown[1]: Syncing filesyst=
ems and block devices.
2019-08-18 21:33:01: [ 7449.383322] systemd-shutdown[1]: Sending SIGTERM =
to remaining processes...
2019-08-18 21:33:01: [ 7449.398880] systemd-journal: 50795 output lines s=
uppressed due to ratelimiting
2019-08-18 21:33:01: [ 7449.446607] systemd-shutdown[1]: Sending SIGKILL =
to remaining processes...
2019-08-18 21:33:01: [ 7449.458654] systemd-shutdown[1]: Unmounting file =
systems.
2019-08-18 21:33:01: [ 7449.464042] systemd-shutdown[1]: Successfully for=
ked off '(sd-remount)' as PID 13261.
2019-08-18 21:33:01: [ 7449.464421] [13261]: Remounting '/' read-only in =
with options 'seclabel'.
2019-08-18 21:33:01: [ 7449.488986] EXT4-fs (dm-0): re-mounted. Opts:
2019-08-18 21:33:01: [ 7449.495078] systemd-shutdown[1]: Successfully for=
ked off '(sd-umount)' as PID 13262.
2019-08-18 21:33:01: [ 7449.495452] [13262]: Unmounting '/run/install/rep=
o'.
2019-08-18 21:33:01: [ 7449.505572] [13262]: Failed to unmount /run/insta=
ll/repo: Device or resource busy
2019-08-18 21:33:01: [ 7449.511630] systemd-shutdown[1]: Unmounting '/run=
/install/repo' failed abnormally, child process 13262 aborted or exited n=
on-zero.
2019-08-18 21:33:01: [ 7449.521176] systemd-shutdown[1]: Not all file sys=
tems unmounted, 1 left.
2019-08-18 21:33:01: [ 7449.648114] [13263]: Unmounting '/run/install/rep=
o'.
2019-08-18 21:33:01: [ 7449.651941] [13263]: Failed to unmount /run/insta=
ll/repo: Device or resource busy
2019-08-18 21:33:01: [ 7449.661075] [13264]: Unmounting '/run/install/rep=
o'.
2019-08-18 21:33:01: [ 7449.664913] [13264]: Failed to unmount /run/insta=
ll/repo: Device or resource busy
2019-08-18 21:33:01: [ 7449.779473] sd 0:0:0:0: [sda] Synchronizing SCSI =
cache
2019-08-18 21:33:01: [ 7449.802628] reboot: Power down
2019-08-18 21:33:08: Ncat: Broken pipe.
2019-08-18 21:33:08: (Process terminated with status 1)

--------------6FF53884564E090C45E246C8--

--EYEE16o1OBUdy1wDEU3gIqP3xUcys3GRw--

--IJ2W3dmtyzEfBaGNxTZlSEq492BFIAr2j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl1dUc8ACgkQJrNi5H/P
IsFo4Af/ZET8Ysif34w/1ARFmcinxXiwo5z8x3xSyxDjTOr5fXE33buhG2dnE7jH
yCKwxzrDcYd51llJVTWkzw7+YmMWmGIJ17jQWLdKjwKx/DhsanXSKa1ptiPpH2dd
7UAIzE2C91kS3kZLj5YKvxTr8LlBoxOPV+oFQozmR15UklUyuqxgujRD+I+ch5dW
ybRcZ3WUTvU/IjZE+fHOG8py+FUzpzb6HIpCNDCz4qpoZNT4ThS1yp4g8pEtpSeO
97nm2ec5A8ZL3NExP6N3Y3TtK8lu1HlMxaMD97cMVOEFqru3/EKCkqU8x9k4lEJy
Ol9shn4zJAmrt2L6GIeZ7Ru6iJ1WHw==
=DvsP
-----END PGP SIGNATURE-----

--IJ2W3dmtyzEfBaGNxTZlSEq492BFIAr2j--

