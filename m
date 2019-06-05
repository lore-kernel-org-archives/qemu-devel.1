Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ECC28D18
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF5D206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 20:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF5D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYcEI-0001Zc-SR
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 16:09:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5Y-0003EM-Kw
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hYc5R-0005ml-UG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hYc5O-0005aI-VT
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 16:00:39 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so5013586qtn.7
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 13:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=k+AJ3Fh6N8GnLwjJBflOCLdYcgacwSZPHZMjqBixblY=;
	b=Rsg0qorcKj51NYBfGC/5e+wJq5mLZz0U7nb2+odIYcbEtFF7XFoejBawdz0WE3nXUD
	mOCDf5pz1YvXBo1c/KVqtGNpiQCxFencvx6wSuMOTaEmbMvYYm+zM6t4e5DJXT/UNi2D
	WTjNNuK4myRjkWXdjq4TtjMvMMfyblyz41LdAE/54puBXWrGGHmAt6F79WfNrWmd4ecD
	ThEZ4AS/wxGznCpNdgm97OsoGMJdPVajX63f54sglPWL/By94frtcF7RuzMCvRFVa6NV
	U8OjNAT9rLa8dspdHRVaXlh9Eh28y1BQwMuiv+6Lz9OvY0R/INdJntXSUpj/SlaK9kpT
	L5YQ==
X-Gm-Message-State: APjAAAWTD5FGRgQQaoWEIwmgCmDsCN2DQmIO3fYAjiqE4cO1ahFAai5C
	+EvVSEtwNMG/9j8mhfWyI04rkWcgY6Y=
X-Google-Smtp-Source: APXvYqyOAgyshQ55J1J8QyAccDWTZ+hUQHLet398MUFVcUNHa/WjhQy9s4lDFABEYm7uhVB4juh+mw==
X-Received: by 2002:ac8:87d:: with SMTP id x58mr36566795qth.368.1559764835011; 
	Wed, 05 Jun 2019 13:00:35 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net.
	[100.0.197.103]) by smtp.gmail.com with ESMTPSA id
	f9sm13488264qkb.97.2019.06.05.13.00.33
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 05 Jun 2019 13:00:34 -0700 (PDT)
Date: Wed, 5 Jun 2019 16:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190416125912.44001-2-liran.alon@oracle.com>
References: <20190605195913.12243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605195913.12243-1-mst@redhat.com>
X-Mailer: git-send-email 2.17.1.1206.gb667731e2e.dirty
X-Mutt-Fcc: =sent
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.194
Subject: [Qemu-devel] [PULL v3 11/17] vhost-scsi: The vhost backend should
 be stopped when the VM is not running
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
	Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Nir Weiner <nir.weiner@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190605200033.gyppgpfZ8Ug_3xv-dlRaFQ8tlNNy_WYdiGFdzmG22ys@z>

From: Nir Weiner <nir.weiner@oracle.com>

vhost-scsi doesn’t takes into account whether the VM is running or not in
order to decide if it should start/stop vhost backend.
This would lead to vhost backend still being active when VM's RunState
suddenly change to stopped.

An example of when this issue is encountered is when Live-Migration Pre-Copy
phase completes. As in this case, VM state will be changed to stopped (while
vhost backend is still active), which will result in
virtio_vmstate_change() -> virtio_set_status() -> vhost_scsi_set_status()
executed but vhost_scsi_set_status() will just return without stopping
vhost backend.

To handle this, change code to consider that vhost processing should be
stopped when VM is not running. Similar to how it is done in vhost-vsock
device at vhost_vsock_set_status().

Fixes: 5e9be92d7752 ("vhost-scsi: new device supporting the tcm_vhost Linux kernel module”)
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
Message-Id: <20190416125912.44001-2-liran.alon@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/vhost-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 61e2e57da9..ca42cff1b9 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -114,6 +114,10 @@ static void vhost_scsi_set_status(VirtIODevice *vdev, uint8_t val)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
     bool start = (val & VIRTIO_CONFIG_S_DRIVER_OK);
 
+    if (!vdev->vm_running) {
+        start = false;
+    }
+
     if (vsc->dev.started == start) {
         return;
     }
-- 
MST


