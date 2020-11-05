Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1708EC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1D420729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KuUO4zQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1D420729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafVd-00031Z-DS
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUC-0001GJ-Bc
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUA-0003S6-N6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3xfwgy7x6maB3mzBw+OGNXwMMqUfwN/lS8/5lRWWaM=;
 b=KuUO4zQQI9XOzESEsilFs4b4PsM0/b7ouqkpG/lq+eIv59p3Ln14SVQTApTl12hPOjZhoG
 x4Yc6qVysD5GwQxElkkDZFq68EoXYd1Kgoo3ifuo4rv5HPAMCbiFSzKd2QjVB6JxnA4Mza
 i19D7N2YIkCO5I6Fk/uFSsgZgmXUunw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-65sW8Jg9Oeye_DYEFZTSAA-1; Thu, 05 Nov 2020 08:39:28 -0500
X-MC-Unique: 65sW8Jg9Oeye_DYEFZTSAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A6AB19080B5;
 Thu,  5 Nov 2020 13:39:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D13285C22D;
 Thu,  5 Nov 2020 13:39:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EF0DF9CBC; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] tests/acpi: update expected data files
Date: Thu,  5 Nov 2020 14:39:22 +0100
Message-Id: <20201105133923.23821-12-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/data/acpi/microvm/APIC.ioapic2 | Bin 0 -> 82 bytes
 tests/data/acpi/microvm/DSDT.ioapic2 | Bin 0 -> 365 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/microvm/APIC.ioapic2 b/tests/data/acpi/microvm/APIC.ioapic2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..a305f89d99eca881109ba54090da0f90262a402c 100644
GIT binary patch
literal 82
zcmZ<^@N^DhU|?W;=H&0}5v<@85#a0y6k`O6f!H9Lf#JbFFwFr}2jnsGfW!{`1Cfk8
QAd!RrB!DCf+kc<{0EO5N0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/microvm/DSDT.ioapic2 b/tests/data/acpi/microvm/DSDT.ioapic2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..aee44dd3de1bb16585bf571ff0ca8e44d467d009 100644
GIT binary patch
literal 365
zcmX9(OHRWu6nxI7Bu)e7BUK=fDh^QGRy{!CxM`%c32{G2L2@sE#1^qBT~uPt1$qRI
z!g0E)cy2a+^JYAnd5KEqZv?=)j|(wT-T0*x335n*!Dh1bTB}&s+unF3#-5&JN%$<M
z3(olfJgw#t4LmI>bs18c66P|Ov_GKU4n#5SpZ>R_KbLrVktO&V!$o6YG)&3CKG@(r
zGBBRJmC8gnA(1FE&ig|QL1%~pB9n7YgYOpD#K(4M+Q>?#&<5BasZ)OiW))J&ynFMY
z<#O)7n`OOcKc8!A0kwAJs*35R-rgF}gq5?B3oe>0ED}4*YA|fHd{z~B?WhrH2U~~;
jFEL&2XlLgGf!^;CECB39$kVA8W3OmXBYkz|P#39x8pcfl

literal 0
HcmV?d00001

-- 
2.27.0


