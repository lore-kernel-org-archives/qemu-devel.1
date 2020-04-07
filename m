Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F721C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5742072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbcLmaGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5742072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqbn-000670-K2
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqaq-0004jL-Eg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqap-0002Iw-FU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58728
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jLqap-0002IA-C8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586275010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hgEfDuNBmIyNK89rWPeVPTfEfxHAEV5r+LtsOTbL5Z4=;
 b=SbcLmaGb7FmA3ulapuWRcluDenmSmKsBaADll9kpkVOIoPxC1yocP/HKnIprUT099VwjqO
 KezVvpP6xylO8gG6+vAoq7p2tbyHh9nF6O/e8r+RK38p6jzre4vjp8BRarFOtKaycgkl+F
 zoNQMsaftrBNVoFELP2l9+v3zZn8jzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Ot03YHQpMuOHQQIBushlUQ-1; Tue, 07 Apr 2020 11:56:49 -0400
X-MC-Unique: Ot03YHQpMuOHQQIBushlUQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41DA1DB62
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 15:56:48 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-114-200.ams2.redhat.com [10.36.114.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC5EC5DA7B;
 Tue,  7 Apr 2020 15:56:43 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] Acceptance test: Extension of migration tests
Date: Tue,  7 Apr 2020 18:56:39 +0300
Message-Id: <20200407155642.10716-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

V3:
 - removes unrelated changes
 - updates functions with new avocado features

V4:
 - moves RDMA's functions outside the Migration class

V5:
 - improvement to comments
 - updates to functions

Oksana Vohchana (3):
  Acceptance test: adds param 'address' in _get_free_port
  Acceptance test: provides new functions
  Acceptance test: provides to use RDMA transport for migration test

 tests/acceptance/migration.py | 61 +++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

--=20
2.21.1


