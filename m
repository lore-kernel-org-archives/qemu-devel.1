Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55604C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28EA620659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EA620659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqem-0003gs-2K
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iHqP6-0005QJ-1m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iHqP4-0007RK-30
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:23:55 -0400
Resent-Date: Tue, 08 Oct 2019 10:23:55 -0400
Resent-Message-Id: <E1iHqP4-0007RK-30@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21434)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iHqP3-0007Q9-Qu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:23:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570544620; cv=none; d=zoho.com; s=zohoarc; 
 b=I0GtMcLLO8vMMn7X8PmevGUJdz7DHhgHBbct9d9DWHT0NwrIl1E8oNrxfzmNTviIRGsL6HbJNAlk7Op659fP1orB7AeRqn1eKwRcLsYsILCRZRq+IumuMdI6DXvA0QRYgY2qX7y7Vl9ckiWrvMiBslgZaQZ+0FO8wSEkuYpWE8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570544620;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+ycmfg5YqU/MjRxgk0L9SFvtgaqGSTZnF0gL2xBr/ZM=; 
 b=MbqMOyZsVC/IImYWFiGxJxHSmujJKPFubPeRqnGy3nES8NjWjHbN6Dvxz5JLVGTRDndkZlVtjnJAartjQNY3J/LL0NZQIAJoJWJXU7bYRLc7LcU/zt6Tr5U23DEuM14o5DYMslxXTwpF0fXk1Rvq4k9YcHVOnYn/lwfsan1I46E=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570544618352729.3529374379904;
 Tue, 8 Oct 2019 07:23:38 -0700 (PDT)
In-Reply-To: <20191008105259.5378-1-lersek@redhat.com>
Subject: Re: [PATCH 0/4] hw/i386: pass "MachineState.smp.max_cpus" to OVMF
Message-ID: <157054461677.41.846008670674761262@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lersek@redhat.com
Date: Tue, 8 Oct 2019 07:23:38 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Reply-To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwODEwNTI1OS41Mzc4
LTEtbGVyc2VrQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGlvL2No
YW5uZWwtdGxzLm8KICBDQyAgICAgIGlvL2NoYW5uZWwtd2F0Y2gubwoKRW5jb2RpbmcgZXJyb3I6
Cid1dGYtOCcgY29kZWMgY2FuJ3QgZGVjb2RlIGJ5dGUgMHg5NSBpbiBwb3NpdGlvbiA3OTk6IGlu
dmFsaWQgc3RhcnQgYnl0ZQpUaGUgZnVsbCB0cmFjZWJhY2sgaGFzIGJlZW4gc2F2ZWQgaW4gL3Rt
cC9zcGhpbngtZXJyLXgwMGxpMGJoLmxvZywgaWYgeW91IHdhbnQgdG8gcmVwb3J0IHRoZSBpc3N1
ZSB0byB0aGUgZGV2ZWxvcGVycy4KICBDQyAgICAgIGlvL2NoYW5uZWwtdXRpbC5vCiAgQ0MgICAg
ICBpby9jaGFubmVsLXdlYnNvY2subwptYWtlOiAqKiogW01ha2VmaWxlOjk5NDogZG9jcy9pbnRl
cm9wL2luZGV4Lmh0bWxdIEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVz
dHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjYyLCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNl
IENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vz
c0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVs
JywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWYwNTQyOWZkMjMzNGY2MDliM2NlMTcwZjBiYzA4
NzknLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQn
LCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09Q
VFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NI
T1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9t
ZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXB5YnlrY3V5L3NyYy9kb2NrZXItc3Jj
LjIwMTktMTAtMDgtMTAuMTkuMDUuMzIyMDY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVk
b3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9OWYwNTQyOWZkMjMzNGY2MDliM2NlMTcwZjBiYzA4NzkKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtcHlieWtjdXkvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1t
aW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG0zMi4zMzJzCnVzZXIgICAgMG04LjY3MHMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkxMDA4MTA1MjU5LjUzNzgtMS1sZXJzZWtAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5n
d0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


