Received: from eggs.gnu.org ([2001:4830:134:3::10]:35896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKLP6-00030c-DS
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gKLOz-0001SB-KA
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gKLOx-0000cX-FB
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 05:49:35 -0500
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Wed,  7 Nov 2018 11:49:18 +0100
Message-Id: <20181107104921.20536-1-lhrazky@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH spice/qemu v3 0/3] QXL interface to set
 monitor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

Hello,

another version of the proposed API for monitor identification
information. Still not for merge yet, the plan is to merge when it's
complete.

Changes since v2:
* Merged the two API functions into one:
  spice_qxl_set_device_info(QXLInstance *instance,
                            const char *device_address,
                            uint32_t device_display_id_start,
                            uint32_t device_display_id_count)

* Minor fixes and documentation adjustments

--=20
2.19.1
