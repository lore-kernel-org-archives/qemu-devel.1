Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9570C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90279206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB80WVem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90279206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4ldO-0008PI-NI
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lXL-0005Vq-QY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lXK-0005Lg-Mm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lXK-0005L9-IT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sxNYWqNUijyMJnaH8NFL0bgSwoZM6mID2KmYVvs4o6o=;
 b=iB80WVemBldDNvccpO5KdtUJSyRvgVFOLgL5FLBTHzGinEfgcMDnticLNkaOcAGHq4D8tN
 L3oGXdz/qf1VmLi+DTmfY1rHYWloPq8i6D6U1rWEEJJ2ZIsPQt8w6Q9Qg1j1ET10JSJeo0
 H+flqSKKyBkAOapaMuKVfnFfwyEoYcI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-7oJAmdi8N5Wo6lcg3gwIug-1; Thu, 20 Feb 2020 08:06:36 -0500
Received: by mail-wr1-f72.google.com with SMTP id u18so1697685wrn.11
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HqjVrldq/ACwB3h0fVhMHW95VpOuJ6iegNutM3g++eM=;
 b=WeqPO9nqxUoRi2Wp1NM5vnchvvHyvsnWM1KcEwOTorWGDTjFqkDXqY188JQOCMESRK
 TUMCjE+YJE0Jdew2hqE6BoAOR/qYGGu1zqlWmAonCvDoig9uc8B/x+328/HF3DTLjk72
 TzC3pQFURHvTXhZkXXAzfrIaRYaEVIA7l6eZjWt5cqASiK1oDsxqWA7LOw9RllwcqndL
 5auRJcD7oPLxurD8xKu1emxGgFA3f/NhscN8iTlmDsKhCA0j3/+Ou4xJozc2M8b0mTIi
 hAcBz0OoD0xQqywC2yMAzxftWdETWtdwIqlMUFVNphs6imPanCLZ1xrRCNXE7oIcWgBF
 j8qA==
X-Gm-Message-State: APjAAAWuwJPV+sTC08bsr5UjowazsPk87xcEZxse71xVY0P8F+vifXtu
 vBMwsY4pV2X6+AtzcSfBn4PT0L9hM6p5kOpm7fZR1RQ7HvWxAYQPsOPk+yHSyD8dPZr/oM43Aoe
 rd2CJAGgC+z8Q2EE=
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr40461387wru.233.1582203995251; 
 Thu, 20 Feb 2020 05:06:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxMGFl+IFZrtHZDte4P/R96xDKYdgOkawy+8epg2tZDd8Fi56EKpiHK5Ha76g6PPzAayNlwiw==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr40461365wru.233.1582203995044; 
 Thu, 20 Feb 2020 05:06:35 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/20] hw/ide/internal: Remove unused DMARestartFunc typedef
Date: Thu, 20 Feb 2020 14:05:39 +0100
Message-Id: <20200220130548.29974-12-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 7oJAmdi8N5Wo6lcg3gwIug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The IDE DMA restart callback has been removed in commit fe09c7c9f0.

Fixes: fe09c7c9f0
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/ide/internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 52ec197da0..ce766ac485 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -326,7 +326,6 @@ typedef int DMAIntFunc(IDEDMA *, int);
 typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
 typedef void DMAu32Func(IDEDMA *, uint32_t);
 typedef void DMAStopFunc(IDEDMA *, bool);
-typedef void DMARestartFunc(void *, int, RunState);
=20
 struct unreported_events {
     bool eject_request;
--=20
2.21.1


