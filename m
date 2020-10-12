Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61B6C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4D02076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 12:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBbOWDvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4D02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRxFK-00073T-C4
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 08:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCW-0004lc-Mt
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kRxCT-0008SJ-5p
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 08:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602506711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0VfM6Y1Z4oOM9AviCLT3C6cOeCH1n4rJ8RPo235glro=;
 b=VBbOWDvQSSdjtN9g2mulYJNfC31+ky2cslFVpOIEnMgFJ99frMoIk1NazuVFo+e+YX37Ow
 d+OQ07M1f+WGu5C1U9/YhQotPJXp1ItMXk/+KeIhCPmKzqpiGGqgG/ZrqBqTKPuxg+VeVc
 s/Ch5tXdWdTUcEPkMqM88HvwSBcMhqA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-Gtjf4e_eNLWwdrwGi9-t-w-1; Mon, 12 Oct 2020 08:45:10 -0400
X-MC-Unique: Gtjf4e_eNLWwdrwGi9-t-w-1
Received: by mail-wm1-f71.google.com with SMTP id m14so5192215wmi.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UtSObLJfNIzbJcrgKRU5Cu+zNLd9lEQsFGBvfOC7Lok=;
 b=lf1nDdML4leYdsbsVcGvuWjIjm6PSEpiXaMEaFV/xjtKDzH30INW5parl4xxIQ+HbX
 7bLAygSjnlaJfogMPMZ8ndKUGHWLmaqqJp7ko+JrPhiShyRl63mieZWNCOYSfOHXZSsn
 h9IA5i6x+aEphtD6au7y80c7UQ7KYDNAvaYcqRgkfcvMhqGUB1g4wckfCrDD3tHMjyr5
 wT1dOMQCAo0vQQ840dbi9EhJCGJvwUlzwS5R1BTXu8VUHizjHrmRwVAWQNJRraJBzOsc
 QUCoKYMVWePTdHnNCiFGCgoQqT1qD9ryV9IoZJWY565TGSVgNIBdFnnwr3+7tWVIM4Z/
 AhsA==
X-Gm-Message-State: AOAM533cvNX2j/zSKouJk1ON9hqs6CRArGn4vNzlL0hOrscqceJlKmXj
 rGkD+VYvISsLjRjkl6RWEUCtWDE3sAjJDo3q57jGmPct12hfsT5HyRUyuZ+/U6+i4CWOLgHprJQ
 v69nQq7G6bJM+js8=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr9137862wrs.101.1602506709379; 
 Mon, 12 Oct 2020 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz6hFiVJHdaU7cfa/kbxEMNRyQTLhhCcs5f5STC6wr7DnE8rXhJdscPh109XPd+XACdRYSYQ==
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr9137815wrs.101.1602506709130; 
 Mon, 12 Oct 2020 05:45:09 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d2sm14916054wrq.34.2020.10.12.05.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 05:45:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw: Use PCI macros from 'hw/pci/pci.h'
Date: Mon, 12 Oct 2020 14:45:01 +0200
Message-Id: <20201012124506.3406909-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial patches using the generic PCI macros from "hw/pci/pci.h".=0D
=0D
Philippe Mathieu-Daud=C3=A9 (5):=0D
  hw/pci-host/bonito: Make PCI_ADDR() macro more readable=0D
  hw/pci-host: Use the PCI_BUILD_BDF() macro from 'hw/pci/pci.h'=0D
  hw/pci-host/uninorth: Use the PCI_FUNC() macro from 'hw/pci/pci.h'=0D
  hw: Use the PCI_SLOT() macro from 'hw/pci/pci.h'=0D
  hw: Use the PCI_DEVFN() macro from 'hw/pci/pci.h'=0D
=0D
 hw/arm/virt.c          | 3 ++-=0D
 hw/hppa/dino.c         | 2 +-=0D
 hw/i386/xen/xen-hvm.c  | 2 +-=0D
 hw/isa/piix3.c         | 2 +-=0D
 hw/mips/gt64xxx_pci.c  | 2 +-=0D
 hw/pci-host/bonito.c   | 5 ++---=0D
 hw/pci-host/pnv_phb4.c | 2 +-=0D
 hw/pci-host/ppce500.c  | 2 +-=0D
 hw/pci-host/uninorth.c | 8 +++-----=0D
 hw/ppc/ppc4xx_pci.c    | 2 +-=0D
 hw/sh4/sh_pci.c        | 2 +-=0D
 11 files changed, 15 insertions(+), 17 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


