Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D78C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E8521D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um/fgOHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E8521D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY5x-0003Py-6B
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4w-0001f4-W5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4v-0003pA-26
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o274/PiZC6KYlxIK2Es/O7Qwtv6sZHgZOMd1mbHMNc8=;
 b=Um/fgOHDxA3az3ptrhVm+UKt+8w5JPoeo6Eqlei8Q7vOZ6VIGYO4aSRRdLulWMlLh0+4Iq
 XcH2F8I2P1PJe6h8a2q+YR3DsXXJzPtH8JT+MOhd4CPVb1+xAWVIEUjfOBEECEZCUydEJQ
 SBqjhsJpbv6neSeFmk5xo+IxdyA/4us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ATDTwubSNcucd725buo_pw-1; Tue, 08 Sep 2020 03:30:06 -0400
X-MC-Unique: ATDTwubSNcucd725buo_pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D811DDEF
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:30:05 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78D767E30C;
 Tue,  8 Sep 2020 07:30:00 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 10/10] tests: acpi: update "virt/SSDT.memhp" for
 edk2-stable202008
Date: Tue,  8 Sep 2020 09:29:39 +0200
Message-Id: <20200908072939.30178-11-lersek@redhat.com>
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIE5WRElNTV9BQ1BJX01FTV9BRERSIGR3b3JkIGluICJ2aXJ0L1NTRFQubWVtaHAiIG5lZWRz
IGFuIHVwZGF0ZSBkdWUgdG8KdGhlIGZpcm13YXJlIG5vdyBhbGxvY2F0aW5nIE5WRElNTV9EU01f
TUVNX0ZJTEUgYXQgYSBsb3dlciBhZGRyZXNzLgoKPiAgICAgICAgICB9Cj4gICAgICB9Cj4KPiAt
ICAgIE5hbWUgKE1FTUEsIDB4NDNERDAwMDApCj4gKyAgICBOYW1lIChNRU1BLCAweDQzRDEwMDAw
KQo+ICB9Cj4KCkNjOiAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJlZGhhdC5jb20+CkNjOiBJ
Z29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPgpDYzogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpSZWY6IGh0dHBzOi8vYnVncy5sYXVuY2hwYWQubmV0
L3FlbXUvK2J1Zy8xODUyMTk2ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8bGVyc2VrQHJl
ZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYu
aCB8ICAgMSAtCiB0ZXN0cy9kYXRhL2FjcGkvdmlydC9TU0RULm1lbWhwICAgICAgICAgICAgIHwg
QmluIDczNiAtPiA3MzYgYnl0ZXMKIDIgZmlsZXMgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggYi90
ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oCmluZGV4IGU1NjkwOThh
YmRkYy4uZGZiODUyM2M4YmY0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10
ZXN0LWFsbG93ZWQtZGlmZi5oCisrKyBiL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxs
b3dlZC1kaWZmLmgKQEAgLTEsMiArMSBAQAogLyogTGlzdCBvZiBjb21tYS1zZXBhcmF0ZWQgY2hh
bmdlZCBBTUwgZmlsZXMgdG8gaWdub3JlICovCi0idGVzdHMvZGF0YS9hY3BpL3ZpcnQvU1NEVC5t
ZW1ocCIsCmRpZmYgLS1naXQgYS90ZXN0cy9kYXRhL2FjcGkvdmlydC9TU0RULm1lbWhwIGIvdGVz
dHMvZGF0YS9hY3BpL3ZpcnQvU1NEVC5tZW1ocAppbmRleCBkYjYxZDY3MzMyODQuLjM3NWQ3YjZm
Yzg1YSAxMDA2NDQKQmluYXJ5IGZpbGVzIGEvdGVzdHMvZGF0YS9hY3BpL3ZpcnQvU1NEVC5tZW1o
cCBhbmQgYi90ZXN0cy9kYXRhL2FjcGkvdmlydC9TU0RULm1lbWhwIGRpZmZlcgotLSAKMi4xOS4x
LjMuZzMwMjQ3YWE1ZDIwMQoK


