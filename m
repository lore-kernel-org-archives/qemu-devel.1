Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4481C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1F2207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1F2207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB195-0001dB-OE
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iB17h-0008Ca-0h
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iB17f-0001X4-Cq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:25:44 -0400
Resent-Date: Thu, 19 Sep 2019 14:25:44 -0400
Resent-Message-Id: <E1iB17f-0001X4-Cq@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iB17f-0001WM-3u
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 14:25:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568917525; cv=none; d=zoho.com; s=zohoarc; 
 b=KWewICZbp7pH4Wsw8c+K6I0qM66mH26toj/Z5Zg36x4CTVl68dkmv/62E4mo/JmpULFW/AXKp/A3YH+UnFqQNA9ntNXG1dWfUZui4CsQEsJmI5OHSMxCGAP0NckGaeETolqI0sv2u7RV4fP9Gw+xdyuucAIzi0835xUk+pycD0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568917525;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=GWJfFnG11sp2v77PmqEqkeA/vnk9/FULHJUjsAhUDLM=; 
 b=ffkKG/kUm07p2/krsjjgIVj1X8dqzeDEjLN5M5vbzvSUkQX+uo8SQkW4IwhNIsfUsnE4HdSPX1pLiM+51jC0CzQDAbWFbdFbnzmgKklr2hItAEYASSuJgK3+r6ckFQXlQl1q04eQmjcEGYPH2Tq9U18vdyqqdrb6AuMf0FCb8Vs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568917524037258.73509645988486;
 Thu, 19 Sep 2019 11:25:24 -0700 (PDT)
In-Reply-To: <20190912053638.4858-1-tao3.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v11 00/11] Build ACPI Heterogeneous Memory
 Attribute Table (HMAT)
Message-ID: <156891752255.2065.17524153793380132093@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: tao3.xu@intel.com
Date: Thu, 19 Sep 2019 11:25:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
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
Cc: ehabkost@redhat.com, jingqi.liu@intel.com, tao3.xu@intel.com,
 fan.du@intel.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 imammedo@redhat.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMjA1MzYzOC40ODU4
LTEtdGFvMy54dUBpbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbGlidWRldiAgICAgICAgICAgbm8K
ZGVmYXVsdCBkZXZpY2VzICAgeWVzCgp3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQKd2FybmluZzogUHl0aG9uIDMgd2lsbCBiZSByZXF1aXJlZCBmb3IgYnVpbGRpbmcgZnV0
dXJlIHZlcnNpb25zIG9mIFFFTVUKY3Jvc3MgY29udGFpbmVycyAgbm8KCk5PVEU6IGd1ZXN0IGNy
b3NzLWNvbXBpbGVycyBlbmFibGVkOiBjYwotLS0KTG9va2luZyBmb3IgZXhwZWN0ZWQgZmlsZSAn
dGVzdHMvZGF0YS9hY3BpL3BjL1NSQVQuYWNwaWhtYXQnCkxvb2tpbmcgZm9yIGV4cGVjdGVkIGZp
bGUgJ3Rlc3RzL2RhdGEvYWNwaS9wYy9TUkFUJwoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMv
dGVzdHMvYmlvcy10YWJsZXMtdGVzdC5jOjMyNzpsb2FkX2V4cGVjdGVkX2FtbDogYXNzZXJ0aW9u
IGZhaWxlZDogKGV4cF9zZHQuYW1sX2ZpbGUpCkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAv
cWVtdS10ZXN0L3NyYy90ZXN0cy9iaW9zLXRhYmxlcy10ZXN0LmM6MzI3OmxvYWRfZXhwZWN0ZWRf
YW1sOiBhc3NlcnRpb24gZmFpbGVkOiAoZXhwX3NkdC5hbWxfZmlsZSkKbWFrZTogKioqIFtjaGVj
ay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDM3CgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxMjA1MzYzOC40ODU4LTEt
dGFvMy54dUBpbnRlbC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


