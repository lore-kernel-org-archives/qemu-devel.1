Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526C3C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCC02064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFAwCjvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCC02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6abo-0002P2-Ab
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1R-0005C9-IA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1Q-0001Mr-Hw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6a1Q-0001Lu-EV
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cJrY81EHH84SxmMM6EBUXctXwTonc2aP8ntTajtgm8s=;
 b=iFAwCjvZe8B5xbxU2E2x1wD7LE9Gkx1WE8M3EPQQibt5gTgn3uWMYVVY1CKsFPZQ0JsuZX
 r6aBm2M5udn6iyxwdEsAghE3zEFSzo4UH/Y5Ondj1BZT/dC86H/R2JXRwHh4c3nv9H5HTN
 UIvZmNnCWpCagTswtBLyajqgjmMRFgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-vWk_ZYebN2GsKmerrVsZAg-1; Tue, 25 Feb 2020 08:13:08 -0500
X-MC-Unique: vWk_ZYebN2GsKmerrVsZAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D2738017CC
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 13:13:08 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B28C191840;
 Tue, 25 Feb 2020 13:13:03 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] Acceptance test: Extension of migration tests
Date: Tue, 25 Feb 2020 15:12:58 +0200
Message-Id: <20200225131302.4792-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series adds a new migration test through RDMA.
To correct uses of migration need to add a new function to work
with RDMA service.
And as a part of migration tests, the series makes small updates to EXEC
migration and to _get_free_port function

V2:
 - improves commit message in Acceptance test: adds param 'address'
   in _get_free_port
 - provides import check for netifaces library
 - makes fix to _get_ip_rdma function
 - adds skip to test if not upload python module

Oksana Vohchana (4):
  Acceptance test: adds param 'address' in _get_free_port
  Acceptance test: EXEC migration
  Acceptance test: provides new functions
  Acceptance test: provides to use RDMA transport for migration test

 tests/acceptance/migration.py | 41 +++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

--=20
2.21.1


