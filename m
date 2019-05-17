Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6EDC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1EF02053B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 18:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EF02053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRhlR-0000Wz-VH
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 14:39:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfH-0004Ah-Fq
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRhfF-0006Lc-CT
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52328
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRhfF-0006Ko-5h
	for qemu-devel@nongnu.org; Fri, 17 May 2019 14:33:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4HINeis130605
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:33:02 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sj0n3ky8f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:33:02 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 17 May 2019 19:33:00 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 17 May 2019 19:32:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4HIWvIJ53674102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 17 May 2019 18:32:57 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A163411C04C;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF6711C06E;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 17 May 2019 18:32:57 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-156-103.de.ibm.com [9.145.156.103])
	by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
	1D2232203F3; Fri, 17 May 2019 20:32:57 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 20:32:40 +0200
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190517183240.689188-1-groug@kaod.org>
References: <20190517183240.689188-1-groug@kaod.org>
X-TM-AS-GCONF: 00
x-cbid: 19051718-4275-0000-0000-00000335EB48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051718-4276-0000-0000-0000384577DD
Message-Id: <20190517183240.689188-7-groug@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-17_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905170108
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PULL 6/6] virtfs: Fix documentation of -fsdev and
 -virtfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes several things:
- add "id" description to -virtfs documentation
- split the description into several lines in both usage and documentation
  for accurateness and clarity
- add documentation and usage of the synth fsdriver
- add "throttling.*" description to -fsdev local
- add some missing periods
- add proper reference to the virtfs-proxy-helper(1) manual page
- document that the virtio device may be either virtio-9p-pci, virtio-9p-ccw
  or virtio-9p-device, depending on the machine type

Buglink: https://bugs.launchpad.net/qemu/+bug/1581976
Signed-off-by: Greg Kurz <groug@kaod.org>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 93 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 27 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index e54c56593b25..5daa5a8fb0a8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1232,26 +1232,35 @@ the write back by pressing @key{C-a s} (@pxref{disk_images}).
 ETEXI
 
 DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
-    "-fsdev fsdriver,id=id[,path=path,][security_model={mapped-xattr|mapped-file|passthrough|none}]\n"
-    " [,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n"
+    "-fsdev local,id=id,path=path,security_model=mapped-xattr|mapped-file|passthrough|none\n"
+    " [,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
     " [[,throttling.bps-total=b]|[[,throttling.bps-read=r][,throttling.bps-write=w]]]\n"
     " [[,throttling.iops-total=i]|[[,throttling.iops-read=r][,throttling.iops-write=w]]]\n"
     " [[,throttling.bps-total-max=bm]|[[,throttling.bps-read-max=rm][,throttling.bps-write-max=wm]]]\n"
     " [[,throttling.iops-total-max=im]|[[,throttling.iops-read-max=irm][,throttling.iops-write-max=iwm]]]\n"
-    " [[,throttling.iops-size=is]]\n",
+    " [[,throttling.iops-size=is]]\n"
+    "-fsdev proxy,id=id,socket=socket[,writeout=immediate][,readonly]\n"
+    "-fsdev proxy,id=id,sock_fd=sock_fd[,writeout=immediate][,readonly]\n"
+    "-fsdev synth,id=id\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -fsdev @var{fsdriver},id=@var{id},path=@var{path},[security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
+@item -fsdev local,id=@var{id},path=@var{path},security_model=@var{security_model} [,writeout=@var{writeout}][,readonly][,fmode=@var{fmode}][,dmode=@var{dmode}] [,throttling.@var{option}=@var{value}[,throttling.@var{option}=@var{value}[,...]]]
+@itemx -fsdev proxy,id=@var{id},socket=@var{socket}[,writeout=@var{writeout}][,readonly]
+@itemx -fsdev proxy,id=@var{id},sock_fd=@var{sock_fd}[,writeout=@var{writeout}][,readonly]
+@itemx -fsdev synth,id=@var{id}[,readonly]
 @findex -fsdev
 Define a new file system device. Valid options are:
 @table @option
-@item @var{fsdriver}
-This option specifies the fs driver backend to use.
-Currently "local" and "proxy" file system drivers are supported.
+@item local
+Accesses to the filesystem are done by QEMU.
+@item proxy
+Accesses to the filesystem are done by virtfs-proxy-helper(1).
+@item synth
+Synthetic filesystem, only used by QTests.
 @item id=@var{id}
-Specifies identifier for this device
+Specifies identifier for this device.
 @item path=@var{path}
 Specifies the export path for the file system device. Files under
 this path will be available to the 9p client on the guest.
@@ -1279,48 +1288,76 @@ Enables exporting 9p share as a readonly mount for guests. By default
 read-write access is given.
 @item socket=@var{socket}
 Enables proxy filesystem driver to use passed socket file for communicating
-with virtfs-proxy-helper
+with virtfs-proxy-helper(1).
 @item sock_fd=@var{sock_fd}
 Enables proxy filesystem driver to use passed socket descriptor for
-communicating with virtfs-proxy-helper. Usually a helper like libvirt
-will create socketpair and pass one of the fds as sock_fd
+communicating with virtfs-proxy-helper(1). Usually a helper like libvirt
+will create socketpair and pass one of the fds as sock_fd.
 @item fmode=@var{fmode}
 Specifies the default mode for newly created files on the host. Works only
 with security models "mapped-xattr" and "mapped-file".
 @item dmode=@var{dmode}
 Specifies the default mode for newly created directories on the host. Works
 only with security models "mapped-xattr" and "mapped-file".
+@item throttling.bps-total=@var{b},throttling.bps-read=@var{r},throttling.bps-write=@var{w}
+Specify bandwidth throttling limits in bytes per second, either for all request
+types or for reads or writes only.
+@item throttling.bps-total-max=@var{bm},bps-read-max=@var{rm},bps-write-max=@var{wm}
+Specify bursts in bytes per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit
+temporarily.
+@item throttling.iops-total=@var{i},throttling.iops-read=@var{r}, throttling.iops-write=@var{w}
+Specify request rate limits in requests per second, either for all request
+types or for reads or writes only.
+@item throttling.iops-total-max=@var{im},throttling.iops-read-max=@var{irm}, throttling.iops-write-max=@var{iwm}
+Specify bursts in requests per second, either for all request types or for reads
+or writes only.  Bursts allow the guest I/O to spike above the limit temporarily.
+@item throttling.iops-size=@var{is}
+Let every @var{is} bytes of a request count as a new request for iops
+throttling purposes.
 @end table
 
--fsdev option is used along with -device driver "virtio-9p-pci".
-@item -device virtio-9p-pci,fsdev=@var{id},mount_tag=@var{mount_tag}
-Options for virtio-9p-pci driver are:
+-fsdev option is used along with -device driver "virtio-9p-...".
+@item -device virtio-9p-@var{type},fsdev=@var{id},mount_tag=@var{mount_tag}
+Options for virtio-9p-... driver are:
 @table @option
+@item @var{type}
+Specifies the variant to be used. Supported values are "pci", "ccw" or "device",
+depending on the machine type.
 @item fsdev=@var{id}
-Specifies the id value specified along with -fsdev option
+Specifies the id value specified along with -fsdev option.
 @item mount_tag=@var{mount_tag}
-Specifies the tag name to be used by the guest to mount this export point
+Specifies the tag name to be used by the guest to mount this export point.
 @end table
 
 ETEXI
 
 DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
-    "-virtfs local,path=path,mount_tag=tag,security_model=[mapped-xattr|mapped-file|passthrough|none]\n"
-    "        [,id=id][,writeout=immediate][,readonly][,socket=socket|sock_fd=sock_fd][,fmode=fmode][,dmode=dmode]\n",
+    "-virtfs local,path=path,mount_tag=tag,security_model=mapped-xattr|mapped-file|passthrough|none\n"
+    "        [,id=id][,writeout=immediate][,readonly][,fmode=fmode][,dmode=dmode]\n"
+    "-virtfs proxy,mount_tag=tag,socket=socket[,id=id][,writeout=immediate][,readonly]\n"
+    "-virtfs proxy,mount_tag=tag,sock_fd=sock_fd[,id=id][,writeout=immediate][,readonly]\n"
+    "-virtfs synth,mount_tag=tag[,id=id][,readonly]\n",
     QEMU_ARCH_ALL)
 
 STEXI
 
-@item -virtfs @var{fsdriver}[,path=@var{path}],mount_tag=@var{mount_tag}[,security_model=@var{security_model}][,writeout=@var{writeout}][,readonly][,socket=@var{socket}|sock_fd=@var{sock_fd}][,fmode=@var{fmode}][,dmode=@var{dmode}]
+@item -virtfs local,path=@var{path},mount_tag=@var{mount_tag} ,security_model=@var{security_model}[,writeout=@var{writeout}][,readonly] [,fmode=@var{fmode}][,dmode=@var{dmode}]
+@itemx -virtfs proxy,socket=@var{socket},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
+@itemx -virtfs proxy,sock_fd=@var{sock_fd},mount_tag=@var{mount_tag} [,writeout=@var{writeout}][,readonly]
+@itemx -virtfs synth,mount_tag=@var{mount_tag}
 @findex -virtfs
 
-The general form of a Virtual File system pass-through options are:
+Define a new filesystem device and expose it to the guest using a virtio-9p-device. The general form of a Virtual File system pass-through options are:
 @table @option
-@item @var{fsdriver}
-This option specifies the fs driver backend to use.
-Currently "local" and "proxy" file system drivers are supported.
+@item local
+Accesses to the filesystem are done by QEMU.
+@item proxy
+Accesses to the filesystem are done by virtfs-proxy-helper(1).
+@item synth
+Synthetic filesystem, only used by QTests.
 @item id=@var{id}
-Specifies identifier for this device
+Specifies identifier for the filesystem device
 @item path=@var{path}
 Specifies the export path for the file system device. Files under
 this path will be available to the 9p client on the guest.
@@ -1348,17 +1385,19 @@ Enables exporting 9p share as a readonly mount for guests. By default
 read-write access is given.
 @item socket=@var{socket}
 Enables proxy filesystem driver to use passed socket file for
-communicating with virtfs-proxy-helper. Usually a helper like libvirt
-will create socketpair and pass one of the fds as sock_fd
+communicating with virtfs-proxy-helper(1). Usually a helper like libvirt
+will create socketpair and pass one of the fds as sock_fd.
 @item sock_fd
 Enables proxy filesystem driver to use passed 'sock_fd' as the socket
-descriptor for interfacing with virtfs-proxy-helper
+descriptor for interfacing with virtfs-proxy-helper(1).
 @item fmode=@var{fmode}
 Specifies the default mode for newly created files on the host. Works only
 with security models "mapped-xattr" and "mapped-file".
 @item dmode=@var{dmode}
 Specifies the default mode for newly created directories on the host. Works
 only with security models "mapped-xattr" and "mapped-file".
+@item mount_tag=@var{mount_tag}
+Specifies the tag name to be used by the guest to mount this export point.
 @end table
 ETEXI
 
-- 
2.17.2


