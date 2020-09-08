Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26AFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C42218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJEiNOSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C42218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYCO-0002pU-A5
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4s-0001WH-KD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4q-0003om-PD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uej+9/PferUhRpA5AZ1L9n0B9MQ0JKQia68hSmWaE1E=;
 b=hJEiNOSD2H4jCX+IEnikmmVeyQXyefRL1KzlDtEfNhqWz1eQSTjWV7IusGYflBVXNGbJph
 0/cAhaEgmBUaEQnEru81dYpYrGHcZCAcuCm3HbAsU4iFD9S46XftvIg9LgmOIk1zjVrG9X
 nixMDePCO35EMVChqVTtzLAjtDD74OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-S3O6Ho0mPbGpZfZ1d9SlTQ-1; Tue, 08 Sep 2020 03:30:00 -0400
X-MC-Unique: S3O6Ho0mPbGpZfZ1d9SlTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E58D807351
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:30:00 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C320811BC;
 Tue,  8 Sep 2020 07:29:57 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 09/10] pc-bios: update the README file with edk2-stable202008
 information
Date: Tue,  8 Sep 2020 09:29:38 +0200
Message-Id: <20200908072939.30178-10-lersek@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
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

UmVmcmVzaCB0aGUgInBjLWJpb3MvUkVBRE1FIiBmaWxlIHdpdGggZWRrMiBhbmQgT3BlblNTTCBy
ZWxlYXNlIGluZm8sCm1hdGNoaW5nIHRoZSBlZGsyLXN0YWJsZTIwMjAwOCBmaXJtd2FyZSBpbWFn
ZXMgYWRkZWQgaW4gdGhlIHByZXZpb3VzCnBhdGNoLgoKQ2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1
ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KUmVmOiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9x
ZW11LytidWcvMTg1MjE5NgpTaWduZWQtb2ZmLWJ5OiBMYXN6bG8gRXJzZWsgPGxlcnNla0ByZWRo
YXQuY29tPgotLS0KIHBjLWJpb3MvUkVBRE1FIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3BjLWJpb3MvUkVBRE1F
IGIvcGMtYmlvcy9SRUFETUUKaW5kZXggZmE4YjU4Yjc5NzJhLi4yZTQ5YmU2MDdlMDIgMTAwNjQ0
Ci0tLSBhL3BjLWJpb3MvUkVBRE1FCisrKyBiL3BjLWJpb3MvUkVBRE1FCkBAIC01Miw4ICs1Miw4
IEBACiAgIHZhcmlhYmxlIHN0b3JlIHRlbXBsYXRlcyBidWlsdCBmcm9tIHRoZSBUaWFub0NvcmUg
Y29tbXVuaXR5J3MgRUZJIERldmVsb3BtZW50CiAgIEtpdCBJSSBwcm9qZWN0CiAgIDxodHRwczov
L2dpdGh1Yi5jb20vdGlhbm9jb3JlL3RpYW5vY29yZS5naXRodWIuaW8vd2lraS9FREstSUk+LiBU
aGUgaW1hZ2VzCi0gIHdlcmUgYnVpbHQgYXQgZ2l0IHRhZyAiZWRrMi1zdGFibGUyMDE5MDUiLiBU
aGUgZmlybXdhcmUgYmluYXJpZXMgYnVuZGxlIHBhcnRzCi0gIG9mIHRoZSBPcGVuU1NMIHByb2pl
Y3QsIGF0IGdpdCB0YWcgIk9wZW5TU0xfMV8xXzFiIiAodGhlIE9wZW5TU0wgdGFnIGlzIGEKKyAg
d2VyZSBidWlsdCBhdCBnaXQgdGFnICJlZGsyLXN0YWJsZTIwMjAwOCIuIFRoZSBmaXJtd2FyZSBi
aW5hcmllcyBidW5kbGUgcGFydHMKKyAgb2YgdGhlIE9wZW5TU0wgcHJvamVjdCwgYXQgZ2l0IHRh
ZyAiT3BlblNTTF8xXzFfMWciICh0aGUgT3BlblNTTCB0YWcgaXMgYQogICBmdW5jdGlvbiBvZiB0
aGUgZWRrMiB0YWcpLiBQYXJ0cyBvZiB0aGUgQmVya2VsZXkgU29mdEZsb2F0IGxpYnJhcnkgYXJl
CiAgIGJ1bmRsZWQgYXMgd2VsbCwgYXQgUmVsZWFzZSAzZSBwbHVzIGEgc3Vic2VxdWVudCB0eXBv
IGZpeCAoY29tbWl0CiAgIGI2NGFmNDFjMzI3NmY5N2YwZTE4MTkyMDQwMGVlMDU2YjljODgwMzcp
LCBhcyBhbiBPcGVuU1NMIGRlcGVuZGVuY3kgb24gMzItYml0Ci0tIAoyLjE5LjEuMy5nMzAyNDdh
YTVkMjAxCgoK


