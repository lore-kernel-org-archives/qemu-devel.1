Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF059C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E5E206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E5E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOlM-0000iW-Td
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1joOkS-0007lT-6r
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:04:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhartmay@linux.ibm.com>)
 id 1joOkQ-0001YW-Am
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:04:47 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05PA3gE1144519
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:04:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbmtxkkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:04:43 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PA4gHG150187
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:04:42 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31vbmtxkj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 06:04:42 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PA1VFx025021;
 Thu, 25 Jun 2020 10:04:40 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 31uusjhkd9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2020 10:04:40 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 05PA4bgA64946646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2020 10:04:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1D8B4203F;
 Thu, 25 Jun 2020 10:04:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F1AF42041;
 Thu, 25 Jun 2020 10:04:37 +0000 (GMT)
Received: from marcibm.ibmuc.com (unknown [9.145.42.231])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2020 10:04:37 +0000 (GMT)
From: Marc Hartmayer <mhartmay@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC 0/4] Enable virtio-fs on s390x
Date: Thu, 25 Jun 2020 12:04:26 +0200
Message-Id: <20200625100430.22407-1-mhartmay@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-25_04:2020-06-25,
 2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 clxscore=1015 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mhartmay@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 06:04:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This RFC is about enabling virtio-fs on s390x. For that we need
 + some shim code (first patch), and we need
 + libvhost-user to deal with virtio endiannes as mandated by the spec.
 
The second part is trickier, because unlike QEMU we are not certain
about the guest's native endianness, which is needed to handle the
legacy-interface appropriately. In fact, this is the reason why just
RFC.

One of the open questions is whether to build separate versions, one
for guest little endian and one for guest big endian, or do we want
something like a command line option? (Digression on the libvirt
modeling)

A third option would be to refuse legacy altogether.

libvhost-access.h is based on hw/virtio/virtio-access.h.


How to use?

For general instructions how to use virtio-fs (on x86) please have a
look at https://virtio-fs.gitlab.io/howto-qemu.html. Most of the
instructions can also be applied on s390x.

In short:

1. Install self-compiled QEMU with this patch series applied
2. Prepare host and guest kernel so they support virtio-fs

Start virtiofsd on the host

 $ virtiofsd -f --socket-path=/tmp/vhostqemu -o source=/tmp/shared

Now you can start QEMU in a separate shell on the host:

 $ qemu-system-s390x -machine type=s390-ccw-virtio,accel=kvm,memory-backend=mem \
   -object memory-backend-file,id=mem,size=2G,mem-path=/dev/shm/virtiofs,share=on,prealloc=on,prealloc-threads=1 \
   -chardev socket,id=char0,path=/tmp/vhostqemu -device vhost-user-fs-ccw,queue-size=1024,chardev=char0,tag=myfs \
   -drive if=virtio,file=disk.qcow2 \
   -m 2G -smp 2 -nographic

Log into the guest and mount it

 $ mount -t virtiofs myfs /mnt


Halil Pasic (1):
  virtio: add vhost-user-fs-ccw device

Marc Hartmayer (3):
  libvhost-user: print invalid address on vu_panic
  libvhost-user: handle endianness as mandated by the spec
  HACK: Hard-code the libvhost-user.o-cflags for s390x

 Makefile.objs                           |   1 +
 contrib/libvhost-user/libvhost-access.h |  87 +++++++++++++++++
 contrib/libvhost-user/libvhost-user.c   | 124 ++++++++++++------------
 hw/s390x/Makefile.objs                  |   1 +
 hw/s390x/vhost-user-fs-ccw.c            |  74 ++++++++++++++
 5 files changed, 227 insertions(+), 60 deletions(-)
 create mode 100644 contrib/libvhost-user/libvhost-access.h
 create mode 100644 hw/s390x/vhost-user-fs-ccw.c

-- 
2.25.4


