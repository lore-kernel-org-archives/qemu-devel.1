Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F4C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CD2207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7EW6eFz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD2207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41969 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5g1-0008Pp-HK
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5V4-00032m-48
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5V2-0004xC-Vn
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34133
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5V2-0004wp-RV
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mD5CnKaHCqEnDtYsfaWuvKKdqaTymxgk4zlUTmpGAA8=;
 b=S7EW6eFzeabOJsimzcFvugXWdUZJbWwa0RN27fkF9x7N1fiJq9iV2VIy9lWqaeMzCiDdAh
 zRMty6mcfUPDvld6fbD/QGcebQWbcg4B916DF0maKGnbkIoX1eZfUqkQACVCsugDeT2TDY
 DHrH18BzQevl/aIYFoRHDqPqVIShJSo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-fCsge2F-PGqIu3qZiBaeEQ-1; Sun, 05 Jan 2020 07:59:18 -0500
Received: by mail-qv1-f71.google.com with SMTP id p3so6445846qvt.9
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=zrcV6NduOW424RfDjQAFC57USpEMc62nbflawLr92Qk=;
 b=ujjOgt9aNRUcf+0LotGmuVHslMtHYXVJtg3xN1L71Q1hHqY226MgtpCbasPjghayry
 cdOXuBvGQJLsJwe8U2bzQzSgrRLwz9jUeGuiI+IQPlnY+p9R7/8KAHsmmJQfJQfcz4mJ
 jhoi4cGGNcHwpsxWpo+TrIIPrpktei3LLAgb7dY1FQePLXR3oTmQZTWWu75+lllWBjWh
 bVO03FVQZU/bC8Wp2L4rsQxJGm9kMlRFAvnIMOKPjqtcEj4jwi9wfvxDVp5QDg9LfuBT
 XDebw/HY3B1n4ax4nYIlNF9ptJ6w4xs8qA4+NNcdq6qoowCo3Xr50vpWFFqaR4pvhIy9
 R2zw==
X-Gm-Message-State: APjAAAVOg93HKc177MiHQ+KOl8Wt3P2RagImmmz22aZwGPtUv3mwMTDS
 vwfRmFSm5cORJmcZ8pda8jBZTxBIBZ0s+ti09Rmm8dwEc4mlLa9XSGpkyMd2KV1nu2qGqh8mIqB
 Gv3ofab3U6QvfT18=
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr71927446qte.327.1578229157404; 
 Sun, 05 Jan 2020 04:59:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWMcYFeCQL+hxuvjqX/2J5hH6/mtPZrR5nM8FCmZmwzrzWsGxrmi1aGhdpm4DL6F0LXtcWaw==
X-Received: by 2002:ac8:31f0:: with SMTP id i45mr71927442qte.327.1578229157239; 
 Sun, 05 Jan 2020 04:59:17 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id f4sm19082258qka.89.2020.01.05.04.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:16 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 22/32] hw/pci/pci_host: Let pci_data_[read/write] use
 unsigned 'size' argument
Message-ID: <20200105125622.27231-23-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: fCsge2F-PGqIu3qZiBaeEQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Both functions are called by MemoryRegionOps.[read/write] handlers
with unsigned 'size' argument. Both functions call
pci_host_config_[read/write]_common() which expect a uint32_t 'len'
parameter (also unsigned).
Since it is pointless (and confuse) to use a signed value, use a
unsigned type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20191216002134.18279-3-philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci_host.h | 4 ++--
 hw/pci/pci_host.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595fc7..9ce088bd13 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -62,8 +62,8 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uin=
t32_t addr,
 uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
                                      uint32_t limit, uint32_t len);
=20
-void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len);
-uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len);
+void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, unsigned len);
+uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
=20
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 0958d157de..ce7bcdb1d5 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -106,7 +106,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev=
, uint32_t addr,
     return ret;
 }
=20
-void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, int len)
+void pci_data_write(PCIBus *s, uint32_t addr, uint32_t val, unsigned len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
@@ -119,7 +119,7 @@ void pci_data_write(PCIBus *s, uint32_t addr, uint32_t =
val, int len)
                                  val, len);
 }
=20
-uint32_t pci_data_read(PCIBus *s, uint32_t addr, int len)
+uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len)
 {
     PCIDevice *pci_dev =3D pci_dev_find_by_addr(s, addr);
     uint32_t config_addr =3D addr & (PCI_CONFIG_SPACE_SIZE - 1);
--=20
MST


