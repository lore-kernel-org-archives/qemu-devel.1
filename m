Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E967C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EE120731
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eM+0CO9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EE120731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlAo-0003aV-LX
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlAA-0002oh-UV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHlA8-0004pR-PU
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600077160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Rr6Sgx+JsbGq1vlqml8WFzDSKT7fqM0veDAqkk4mfig=;
 b=eM+0CO9drWCgyUU6JaYlQlDDvQ6K+sDJbuzSsqVf15EGhuPfP/5F9h2Odt4Yr0mrzb4+BE
 tU0VxMQtGQSVWzWbV6maoQImSvD7D8D7gxyzeMxS0aMdNSrK7K8ULrueONuQpuSz2Jbaf7
 RASP2MmEqOHv5Hwv4Uzd7hhI/syoVbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-P9yzhv92Ml21wqePgB1elA-1; Mon, 14 Sep 2020 05:52:36 -0400
X-MC-Unique: P9yzhv92Ml21wqePgB1elA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4156D800683;
 Mon, 14 Sep 2020 09:52:35 +0000 (UTC)
Received: from localhost (ovpn-114-157.ams2.redhat.com [10.36.114.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDC7760E1C;
 Mon, 14 Sep 2020 09:52:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] configure: add missing CONFIG_FOO variables
Date: Mon, 14 Sep 2020 10:52:28 +0100
Message-Id: <20200914095231.621068-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIG1lc29uLmJ1aWxkIGZlYXR1cmUgc3VtbWFyeSBjaGVja3MgdGhlIHByZXNlbmNlIG9mIENP
TkZJR19GT08gdmFyaWFibGVzLgpTZXZlcmFsIG9mIHRoZXNlIHZhcmlhYmxlcyBhcmUgbmV2ZXIg
ZW1pdHRlZCBieSAuL2NvbmZpZ3VyZSBzbyB0aGUgZmVhdHVyZQpzdW1tYXJ5IGFsd2F5cyBzaG93
cyB0aGVzZSBmZWF0dXJlcyBhcyBkaXNhYmxlZC4KClN0ZWZhbiBIYWpub2N6aSAoMyk6CiAgY29u
ZmlndXJlOiBhZGQgbWlzc2luZyBDT05GSUdfVENNQUxMT0MKICBjb25maWd1cmU6IGFkZCBtaXNz
aW5nIENPTkZJR19KRU1BTExPQwogIGNvbmZpZ3VyZTogcmVuYW1lIFFFTVVfR0FfTVNJX0VOQUJM
RUQgdG8gQ09ORklHX1FHQV9NU0kKCiBjb25maWd1cmUgICB8IDEwICsrKysrKysrKy0KIE1ha2Vm
aWxlICAgIHwgIDIgKy0KIG1lc29uLmJ1aWxkIHwgIDIgKy0KIDMgZmlsZXMgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCi0tIAoyLjI2LjIKCg==


