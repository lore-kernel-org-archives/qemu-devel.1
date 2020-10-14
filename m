Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3185C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B59120848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dn2wpmvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B59120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfPM-0004oS-1H
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLX-0008S2-Tj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLW-0000VF-2q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6FTuIuR3+XHqJPLeTbnNrOgtIIQYXp8K+Lm+xIrz/N0=;
 b=dn2wpmvXEizC+kwHNE96dpIsXxEsuD1QyThr2lhg1iC58XUORZ7qEdtVz4I9FaNHlIIdoE
 AOHnMTpKLY5iBC1wWAUU73+KKXQ+qzaztE13l80pKSusXXkJXu2MIDf6oAAizgKBZqXDZQ
 7Lqfz5BH+3BFcJdTY1PtFDz4ve8ss50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-hoUsj79hPfiGIniDcgHTeA-1; Wed, 14 Oct 2020 07:52:57 -0400
X-MC-Unique: hoUsj79hPfiGIniDcgHTeA-1
Received: by mail-wr1-f72.google.com with SMTP id b6so1162071wrn.17
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v8EnNK3sIBGzEU69JoCHfHAHWcYD5moQxQRsWF71Ae8=;
 b=eZEM4mld4Os7I/LEzQP9l1xR9Izkqvl/LlRGX5rgEgsfpdECu5nB/BHqLPJPcYd7L5
 h/P9CuZE7C2jAvVv2gJHaa++pdA53zZKBsQ8lEHDARcz1cUwQX+4f2WPJ83iJKBNrMYh
 /bcO/tf0O8W3ssHW4i7Ninli0iFKsSZ7bIXGRxEIz0uHbGuY01j09FJabf+FMFgDJBoV
 tUM90vY12HnU36yTL0sXr6l14tC5DDrp6lQqVOXNkvFhFvOpYiCZUTnAeW8/7y8Mzi2Z
 azP3+6tSPblELYFyrjhknmzZHDqM7in1GZsmuBVIX4LO+nzeT37Bcg5njeqhR5cCfXQC
 EEoA==
X-Gm-Message-State: AOAM533mwnwiJf0r1QQKZNHbocbikr9uf3VQvbqC5oakV51m67anG/FW
 VEfMy8VW4bFZ/xObUl2wG02qubW7kL4HKggchHnLeFj4O8B1qcHbQIVF3sMe6pOpMuvpbQXcdMO
 QD2DAYorvbKQj3rA=
X-Received: by 2002:a1c:6856:: with SMTP id d83mr3162808wmc.71.1602676376071; 
 Wed, 14 Oct 2020 04:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8gxZfVYo+NwObfGKA6nAsUhkYiMquc9/RMvGJyl/KS/IHNSc3IGp43Pq/w/LLuBmpFinZpw==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr3162788wmc.71.1602676375864; 
 Wed, 14 Oct 2020 04:52:55 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 64sm3553343wmd.3.2020.10.14.04.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:52:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/9] util/vfio-helpers: Improve debugging experience
Date: Wed, 14 Oct 2020 13:52:44 +0200
Message-Id: <20201014115253.25276-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A bunch of boring patches that have been proven helpful=0D
while debugging.=0D
=0D
Philippe Mathieu-Daud=C3=A9 (9):=0D
  util/vfio-helpers: Improve reporting unsupported IOMMU type=0D
  util/vfio-helpers: Trace PCI I/O config accesses=0D
  util/vfio-helpers: Trace PCI BAR region info=0D
  util/vfio-helpers: Trace where BARs are mapped=0D
  util/vfio-helpers: Improve DMA trace events=0D
  util/vfio-helpers: Convert vfio_dump_mapping to trace events=0D
  util/vfio-helpers: Let qemu_vfio_dma_map() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_do_mapping() propagate Error=0D
  util/vfio-helpers: Let qemu_vfio_verify_mappings() use error_report()=0D
=0D
 include/qemu/vfio-helpers.h |  2 +-=0D
 block/nvme.c                | 14 ++++----=0D
 util/vfio-helpers.c         | 66 +++++++++++++++++++++----------------=0D
 util/trace-events           | 10 ++++--=0D
 4 files changed, 54 insertions(+), 38 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


