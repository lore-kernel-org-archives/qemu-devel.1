Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F99C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2472082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2472082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38802 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEyFz-0000ie-QZ
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 11:38:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyEe-0008T3-Jv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hEyEd-0001LL-Ht
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 11:37:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hEyEd-0001KX-Az; Fri, 12 Apr 2019 11:36:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45127307D84F;
	Fri, 12 Apr 2019 15:36:56 +0000 (UTC)
Received: from localhost (ovpn-112-59.ams2.redhat.com [10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C28075C206;
	Fri, 12 Apr 2019 15:36:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Apr 2019 17:36:34 +0200
Message-Id: <20190412153647.19027-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 12 Apr 2019 15:36:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 00/13] vhost-user for input & GPU
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412153634.wPlpDd95VPDhHTQN0EKd24FbBhbb-dC_H8RISLg5GOI@z>

Hi,

vhost-user allows to drive a virtio device in a seperate
process. After vhost-user-net, we have seen
vhost-user-{scsi,blk,crypto} added more recently.

This series, initially proposed ~3 years ago, time flies
(https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
contributes with vhost-user-input and vhost-user-gpu.

You may start a vhost-user-gpu with virgl rendering in a separate
process like this:

$ ./vhost-user-gpu --virgl -s vgpu.sock &
$ qemu...
  -chardev socket,id=3Dchr,path=3Dvgpu.sock
  -device vhost-user-vga,chardev=3Dchr

v5:
 - remove user-creatable version of vhost-user-backend
 - remove optinal management of sub-process in vhost-user-backend
 - removed daemonize/pid code
 - drop introduction of new input & gpu messages for PCI config space
   handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
 - plain mem & udmabuf fallback for 2d rendering
 - rebased, kconfig-ify, rst-ify

Gerd Hoffmann (1):
  curses: fix wchar_t printf warning

Greg Kurz (1):
  spapr_pci: Fix broken naming of PCI bus

Marc-Andr=C3=A9 Lureau (10):
  Add vhost-user-backend
  Add vhost-user-input-pci
  libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
  contrib: add vhost-user-input
  vhost-user: add vhost_user_gpu_set_socket()
  virtio: add virtio-gpu bswap helpers header
  contrib: add vhost-user-gpu
  virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
  virtio-gpu: split virtio-gpu-pci & virtio-vga
  hw/display: add vhost-user-vga & gpu-pci

Peter Maydell (1):
  Update version for v4.0.0-rc3 release

--=20
2.21.0.313.ge35b8cb8e2


