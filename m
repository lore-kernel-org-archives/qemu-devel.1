Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDC2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342E8206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhHXCxp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342E8206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjJf-0004oK-50
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAa-0004HY-1l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAU-0000rN-CR
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OpjtDe/YLxrKTC0AksHtwdm44IVNclrLi2SKNr+harA=;
 b=IhHXCxp1vxhCLD5o4rU9DfR3AJlNOUU+i7TssK2lqUSbtSxUp7lJVGwQ+WQyJAv7QusYoX
 iE6ZEPJlkSpmQOAp9loY4y47t8MsveyvRSTuJuvDJKTQf+HbMI/AZSPMgi8bMDogWUls1v
 xoPWNe1rirGUfbGne4ZmFGNxvplYRmA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-1ssWeqbdPv2sWIFMWtjqMw-1; Wed, 14 Oct 2020 11:58:14 -0400
X-MC-Unique: 1ssWeqbdPv2sWIFMWtjqMw-1
Received: by mail-wr1-f72.google.com with SMTP id i6so1534234wrx.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=++v11npN/lWVqroo1CkgID5ViQLTOmQEDgJOhev2gcE=;
 b=YNWcqVWovKgPzVBmfIdwkGKqCvVPgdaZAF3Nc1yYyAzOLJAkE9CBSLbXriBr9DSvrX
 FL7ozMd/KRJZhKtDuj5oreKDTteSRzwbpcym1VsUhKpYq2k0enn0v+GMc19BIYYbcAzg
 GTcpzaBBvJe55Id4oqp6mnm+od3a5lmBl5B5SwHra5zMzO+Queqh/Rc0vem/+JXTyOS5
 jhXkpSbDd0L6lAzaSyc27I33HtxOaABud8Mw6iQZtn+xyz7Od8qMC9OfNheneUY0dMaZ
 mWs8v/PgV24HWyd2IF99su4bR2qkKMr0uXVbzJwPE58q5Xj+zV5ckKvoIhM50e3zjq/T
 j38A==
X-Gm-Message-State: AOAM532UQkiEnRHHa0pPPKzBzU/XNp6Svw+Ox7HRnWK3bIn7vgRXwKR5
 QeKzqmbFRaNmu4UF2HGSe1MR71JwJfjHuUVPerjQxT02co86FmWF60EHqdUd0dEBykn2mOqFKYO
 /B/CPZJ6kOmZELUU=
X-Received: by 2002:adf:e292:: with SMTP id v18mr6285772wri.256.1602691092972; 
 Wed, 14 Oct 2020 08:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf6GEzxFVb11DI3dKnxscuoW0JEEkKmCSrNgXGaU4/9iY39uLwSRruRo1yWQSnHTi9zLt4Pg==
X-Received: by 2002:adf:e292:: with SMTP id v18mr6285748wri.256.1602691092774; 
 Wed, 14 Oct 2020 08:58:12 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x15sm6185716wrr.36.2020.10.14.08.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/15] block/nvme: Improve debugging experience and minor fixes
Date: Wed, 14 Oct 2020 17:57:55 +0200
Message-Id: <20201014155810.102841-1-philmd@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another set of boring patches, in preparation of=0D
supporting multiple queues (the next series).=0D
=0D
Based-on: <20201014115253.25276-1-philmd@redhat.com>=0D
"util/vfio-helpers: Improve debugging experience"=0D
https://www.mail-archive.com/qemu-block@nongnu.org/msg75637.html=0D
=0D
Philippe Mathieu-Daud=C3=A9 (15):=0D
  block/nvme: Move nvme_poll_cb() earlier=0D
  block/nvme: Trace nvme_poll_queue() per queue=0D
  block/nvme: Use unsigned integer for queue counter/size=0D
  block/nvme: Improve nvme_free_req_queue_wait() trace information=0D
  block/nvme: Trace queue pair creation/deletion=0D
  block/nvme: Make nvme_identify() return boolean indicating error=0D
  block/nvme: Make nvme_init_queue() return boolean indicating error=0D
  block/nvme: Pass AioContext argument to nvme_add_io_queue()=0D
  block/nvme: Introduce Completion Queue definitions=0D
  block/nvme: Use definitions instead of magic values in add_io_queue()=0D
  block/nvme: Trace controller capabilities=0D
  block/nvme: Simplify device reset=0D
  block/nvme: Simplify ADMIN queue access=0D
  block/nvme: Report warning with warn_report()=0D
  block/nvme: Set request_alignment at initialization=0D
=0D
 include/block/nvme.h |  17 ++++---=0D
 block/nvme.c         | 116 +++++++++++++++++++++++++------------------=0D
 block/trace-events   |  17 ++++---=0D
 3 files changed, 88 insertions(+), 62 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


