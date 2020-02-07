Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94448C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FA82082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2bZ/i0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FA82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j00vm-00010u-F6
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 05:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j00u4-0007MB-Sl
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j00u3-0002tc-1E
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:30:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41118
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j00u2-0002sG-UB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 05:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581071425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=P6tWVHrGgMZv6SnPnuEwsRA3WMoMRm5QggFAuD3aA2A=;
 b=T2bZ/i0Em2zsXv3w8O9aleVkMB6tg9AQQjTZe+xOdWmA6/JOJGSshhEdkxoQMKZKl29OXN
 TwzZ3t6dwZPym95McIcZah+nmP/41JbKTVJWFnllaIFu+1aL4CgYaXqXZFCNCPg6RNcV1i
 05kYLI40Ux5mDKwUBlO/4SLYfgCr4wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-c57z9swVMdO2cp_g7rfogA-1; Fri, 07 Feb 2020 05:30:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DC7514E0;
 Fri,  7 Feb 2020 10:30:18 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D60A8E611;
 Fri,  7 Feb 2020 10:30:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] MAINTAINERS: Cover orphean qapi/json files
Date: Fri,  7 Feb 2020 11:30:09 +0100
Message-Id: <20200207103012.27049-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: c57z9swVMdO2cp_g7rfogA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Few orphean files noticed while looking at Peter series:
"Convert QAPI doc comments to generate rST instead of texinfo"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg677500.html

Philippe Mathieu-Daud=C3=A9 (3):
  MAINTAINERS: Cover qapi/rocker.json in 'Rocker' section
  MAINTAINERS: Cover qapi/block{-core}.json in 'Block layer core'
    section
  MAINTAINERS: Cover qapi/trace.json in 'Tracing' section

 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

--=20
2.21.1


