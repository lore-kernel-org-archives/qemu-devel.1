Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BACECE587
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786DA20815
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786DA20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSKv-0008Bn-6n
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrq-0001ED-6E
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRrm-0001Wd-9i
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:47:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21910
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRrl-0001RW-QJ; Tue, 01 Oct 2019 19:47:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlQR2037587; Tue, 1 Oct 2019 19:47:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcer2b327-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:33 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlXOV037810;
 Tue, 1 Oct 2019 19:47:33 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcer2b321-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:33 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjkJw027153;
 Tue, 1 Oct 2019 23:47:32 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 2v9y587bg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:32 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlVaF53346612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA96D28059;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F68228058;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/97] usbredir: fix buffer-overflow on vmload
Date: Tue,  1 Oct 2019 18:45:16 -0500
Message-Id: <20191001234616.7825-38-mdroth@linux.vnet.ibm.com>
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
 mx0a-001b2d01.pphosted.com id x91NlQR2037587
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If interface_count is NO_INTERFACE_INFO, let's not access the arrays
out-of-bounds.

=3D=3D994=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address 0=
x625000243930 at pc 0x5642068086a8 bp 0x7f0b6f9ffa50 sp 0x7f0b6f9ffa40
READ of size 1 at 0x625000243930 thread T0
    #0 0x5642068086a7 in usbredir_check_bulk_receiving /home/elmarco/src/=
qemu/hw/usb/redirect.c:1503
    #1 0x56420681301c in usbredir_post_load /home/elmarco/src/qemu/hw/usb=
/redirect.c:2154
    #2 0x5642068a56c2 in vmstate_load_state /home/elmarco/src/qemu/migrat=
ion/vmstate.c:168
    #3 0x56420688e2ac in vmstate_load /home/elmarco/src/qemu/migration/sa=
vevm.c:829
    #4 0x5642068980cb in qemu_loadvm_section_start_full /home/elmarco/src=
/qemu/migration/savevm.c:2211
    #5 0x564206899645 in qemu_loadvm_state_main /home/elmarco/src/qemu/mi=
gration/savevm.c:2395
    #6 0x5642068998cf in qemu_loadvm_state /home/elmarco/src/qemu/migrati=
on/savevm.c:2467
    #7 0x56420685f3e9 in process_incoming_migration_co /home/elmarco/src/=
qemu/migration/migration.c:449
    #8 0x564207106c47 in coroutine_trampoline /home/elmarco/src/qemu/util=
/coroutine-ucontext.c:115
    #9 0x7f0c0604e37f  (/lib64/libc.so.6+0x4d37f)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20190807084048.4258-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 7b84b90966568da0e05655ecaa78c209300aae6e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/redirect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 7cb6b120d4..586c7db025 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1494,6 +1494,11 @@ static void usbredir_check_bulk_receiving(USBRedir=
Device *dev)
     for (i =3D EP2I(USB_DIR_IN); i < MAX_ENDPOINTS; i++) {
         dev->endpoint[i].bulk_receiving_enabled =3D 0;
     }
+
+    if (dev->interface_info.interface_count =3D=3D NO_INTERFACE_INFO) {
+        return;
+    }
+
     for (i =3D 0; i < dev->interface_info.interface_count; i++) {
         quirks =3D usb_get_quirks(dev->device_info.vendor_id,
                                 dev->device_info.product_id,
--=20
2.17.1


