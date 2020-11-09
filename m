Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCDD20657
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OngHB8KR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCDD20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc9vG-0001JN-TB
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc9tL-0007pF-QE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kc9tJ-0006pd-Ms
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604938771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oXAM647lsCOO3xGqMCxLL46+CPMON3JlH9CYi6pDy6s=;
 b=OngHB8KRS9tPvStSdSFW9uZwHOGizjKbfxxrfGr4Zjh3BYUuGZ7B/rVlSs5T1h/E5wS8r+
 RQ/LT3efODwOVijMzIrXTo+rM6DAztO88D7T/5Mw6PCxlqalQsVyEjhnLUryPSgbn0kA6H
 +96WbrjtggW9QptUK+1Ay9mAgs1EDbA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-nX3mWUO-MU-SXOMQQflgKg-1; Mon, 09 Nov 2020 11:19:28 -0500
X-MC-Unique: nX3mWUO-MU-SXOMQQflgKg-1
Received: by mail-wr1-f70.google.com with SMTP id d8so3565353wrr.10
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dHq6I8m/bFvQFAnLIMQ8fpVu9agI4PVxZHj0cOeVzBE=;
 b=b7gprKqYTz4I4FUzyK/mNB/KOp3tYtiMlo7+wx2VDmSSIC9TLycZNdXd7Vz/LR11fy
 brQQrMr5IvjoXg3egCyJAL3Oz4Nxi9vbadypP4sdIKVl5DquU6Gj+IFkCMXMwZ9YuRYX
 zes/RElW5o+QTUoq2CoAWgezWEqIMwn6L4qRa0sH5K+YeQP0xD28w/nhP0UdTOx5b1xa
 IwdYnr5Z9MCX1gE6cWkVcct8OOhsqpnomA0M4jvs5pFv25c0XqFnsW3Mvpj4QLWuU46C
 yfEDZxkaAGgGEg4EI+Fs0XvKU9XVMhCamUbVSLi+9TQ99V+CzphhTIJD73HXtj8YJyWK
 F3rA==
X-Gm-Message-State: AOAM532l9oL1ksilTEhfK8RItLvqsT1JJ3jxA8N/az2iswCi1BaY+3HQ
 4a0QcdHyycMW5hSht8OyCblEjK3iRb2eA6WBaC+y9sa3bmxQ5tLFNL/tZ0N/5G+yCtQKfese08U
 MQAHZK3UltXL92gw=
X-Received: by 2002:a5d:6892:: with SMTP id h18mr7870781wru.49.1604938766553; 
 Mon, 09 Nov 2020 08:19:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJza4e77jhtWMHzrC6lmNMqew+h0MEFrY8Za1s+2Kyz85vguJoLfM95sreMVTY3+G0ivA+f70Q==
X-Received: by 2002:a5d:6892:: with SMTP id h18mr7870762wru.49.1604938766343; 
 Mon, 09 Nov 2020 08:19:26 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f8sm13635257wrt.88.2020.11.09.08.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 08:19:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 0/2] scripts/checkpatch: Test if >100 chars per
 line is easy to review
Date: Mon,  9 Nov 2020 17:19:21 +0100
Message-Id: <20201109161923.2632747-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test if this changes are allowed by checkpatch.=0D
Patchew should reply with a simple warning.=0D
=0D
Based-on: <20201105154208.12442-1-ganqixin@huawei.com>=0D
https://www.mail-archive.com/qemu-devel@nongnu.org/msg758018.html=0D
=0D
Philippe Mathieu-Daud=C3=A9 (2):=0D
  hw/net: Test line with 342 chars=0D
  hw/pci: Test line with 391 chars=0D
=0D
 include/hw/net/imx_fec.h   |  8 +-------=0D
 include/hw/pci/pcie_regs.h | 17 +----------------=0D
 2 files changed, 2 insertions(+), 23 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


