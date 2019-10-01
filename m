Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D9C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3DC20815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 01:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3DC20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFT3v-0007xW-Qe
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 21:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsd-00023O-AN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsW-0002aZ-PC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42008
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsT-000228-7D; Tue, 01 Oct 2019 19:48:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPZD179350; Tue, 1 Oct 2019 19:47:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnd43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:58 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlwTY180845;
 Tue, 1 Oct 2019 19:47:58 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vcdgpnd3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlC8023568;
 Tue, 1 Oct 2019 23:47:58 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577h13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:58 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nlvgx46596410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:57 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E65328059;
 Tue,  1 Oct 2019 23:47:57 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 713CF2805E;
 Tue,  1 Oct 2019 23:47:57 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:57 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 83/97] block/create: Do not abort if a block driver is not
 available
Date: Tue,  1 Oct 2019 18:46:02 -0500
Message-Id: <20191001234616.7825-84-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x91NlPZD179350
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The 'blockdev-create' QMP command was introduced as experimental
feature in commit b0292b851b8, using the assert() debug call.
It got promoted to 'stable' command in 3fb588a0f2c, but the
assert call was not removed.

Some block drivers are optional, and bdrv_find_format() might
return a NULL value, triggering the assertion.

Stable code is not expected to abort, so return an error instead.

This is easily reproducible when libnfs is not installed:

  ./configure
  [...]
  module support    no
  Block whitelist (rw)
  Block whitelist (ro)
  libiscsi support  yes
  libnfs support    no
  [...]

Start QEMU:

  $ qemu-system-x86_64 -S -qmp unix:/tmp/qemu.qmp,server,nowait

Send the 'blockdev-create' with the 'nfs' driver:

  $ ( cat << 'EOF'
  {'execute': 'qmp_capabilities'}
  {'execute': 'blockdev-create', 'arguments': {'job-id': 'x', 'options': =
{'size': 0, 'driver': 'nfs', 'location': {'path': '/', 'server': {'host':=
 '::1', 'type': 'inet'}}}}, 'id': 'x'}
  EOF
  ) | socat STDIO UNIX:/tmp/qemu.qmp
  {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 4}, "pa=
ckage": "v4.1.0-733-g89ea03a7dc"}, "capabilities": ["oob"]}}
  {"return": {}}

QEMU crashes:

  $ gdb qemu-system-x86_64 core
  Program received signal SIGSEGV, Segmentation fault.
  (gdb) bt
  #0  0x00007ffff510957f in raise () at /lib64/libc.so.6
  #1  0x00007ffff50f3895 in abort () at /lib64/libc.so.6
  #2  0x00007ffff50f3769 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
  #3  0x00007ffff5101a26 in .annobin_assert.c_end () at /lib64/libc.so.6
  #4  0x0000555555d7e1f1 in qmp_blockdev_create (job_id=3D0x555556baee40 =
"x", options=3D0x555557666610, errp=3D0x7fffffffc770) at block/create.c:6=
9
  #5  0x0000555555c96b52 in qmp_marshal_blockdev_create (args=3D0x7fffdc0=
03830, ret=3D0x7fffffffc7f8, errp=3D0x7fffffffc7f0) at qapi/qapi-commands=
-block-core.c:1314
  #6  0x0000555555deb0a0 in do_qmp_dispatch (cmds=3D0x55555645de70 <qmp_c=
ommands>, request=3D0x7fffdc005c70, allow_oob=3Dfalse, errp=3D0x7fffffffc=
898) at qapi/qmp-dispatch.c:131
  #7  0x0000555555deb2a1 in qmp_dispatch (cmds=3D0x55555645de70 <qmp_comm=
ands>, request=3D0x7fffdc005c70, allow_oob=3Dfalse) at qapi/qmp-dispatch.=
c:174

With this patch applied, QEMU returns a QMP error:

  {'execute': 'blockdev-create', 'arguments': {'job-id': 'x', 'options': =
{'size': 0, 'driver': 'nfs', 'location': {'path': '/', 'server': {'host':=
 '::1', 'type': 'inet'}}}}, 'id': 'x'}
  {"id": "x", "error": {"class": "GenericError", "desc": "Block driver 'n=
fs' not found or not supported"}}

Cc: qemu-stable@nongnu.org
Reported-by: Xu Tian <xutian@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d90d5cae2b10efc0e8d0b3cc91ff16201853d3ba)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/create.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/create.c b/block/create.c
index 95341219ef..de5e97bb18 100644
--- a/block/create.c
+++ b/block/create.c
@@ -63,9 +63,13 @@ void qmp_blockdev_create(const char *job_id, BlockdevC=
reateOptions *options,
     const char *fmt =3D BlockdevDriver_str(options->driver);
     BlockDriver *drv =3D bdrv_find_format(fmt);
=20
+    if (!drv) {
+        error_setg(errp, "Block driver '%s' not found or not supported",=
 fmt);
+        return;
+    }
+
     /* If the driver is in the schema, we know that it exists. But it ma=
y not
      * be whitelisted. */
-    assert(drv);
     if (bdrv_uses_whitelist() && !bdrv_is_whitelisted(drv, false)) {
         error_setg(errp, "Driver is not whitelisted");
         return;
--=20
2.17.1


