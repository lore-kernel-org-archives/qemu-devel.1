Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D15C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D68B206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9eVVAL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D68B206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0dW-00038s-T3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c3-0001Id-B4
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32916
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jj0c0-0005bS-Ux
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 09:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591795067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bBwIlUJKvdI8mJIkr5f/ihhX536ZYcXtU9gYYsc6uaI=;
 b=D9eVVAL0G9N+9reupSdH7okn3dZTZcpANFVLZ7urfVdh7PG3hAaPyi2KuAbVvbVVEzCe3L
 xLPC3K7muvFa9uYCRqM3CeUKnPh+HFesy42bXWJEp8wPv9VsZqAGsv62GDdo4iHb1I1TV7
 fy6YXl1mzpGqhNgaG+viPOvsy1sZ2Fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-hOFIcVPgMriET-n_0UXrvw-1; Wed, 10 Jun 2020 09:17:43 -0400
X-MC-Unique: hOFIcVPgMriET-n_0UXrvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAA6F107ACCA
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 498EC1025EB0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:17:42 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] A pair of HMAT docs fixes
Date: Wed, 10 Jun 2020 15:17:33 +0200
Message-Id: <cover.1591794890.git.mprivozn@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Technically, this is a v2 of:

https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg08316.html

But as it turned out during the review of v1, we don't need to change
the code rather than documentation.

Michal Privoznik (2):
  qemu-options.hx: Mark all hmat-cache attributes required
  qemu-options.hx: Document hmat-lb and hmat-cache order

 qemu-options.hx | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.26.2


