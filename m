Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F42CC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ECFC2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECFC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i350L-0006so-C2
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i34zP-000601-K8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i34zN-0002ZK-8V
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:56:22 -0400
Resent-Date: Wed, 28 Aug 2019 16:56:22 -0400
Resent-Message-Id: <E1i34zN-0002ZK-8V@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i34zI-0002X4-EZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 16:56:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1567025765; cv=none; d=zoho.com; s=zohoarc; 
 b=X+c0lBibFUULt5ywFolFsC6FDfvJR9iurk8EKunQEh7VFLT+XOnjzMXS6NImWSBAENTZb+gY3YakxyQJMIgsxIVGGWweEcK+xLT7FNLzlonpWQ310V8l0T1Sekd8IJNf4kHwSmUtVRu6w0csJefLQdGtuLcnXTkoQEhBF2LKEn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1567025765;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3YqoaWwP/XS0orBb0M/cksXtiXDK8NhJnygpFVACygw=; 
 b=Cw7jLv8wdqZSzv/gB5r0MjK3CDAj+18/MbrLzRh1PtwLBSyHTxhbLMYyic3V9p66cjDUNZNlmiRsCgCnQ29btTKnTNgvrP5mD8fMe6x04MCXX2FvrfiVeAJ2i4yE0xFvbKiU3uvoDLt7EQp7uPMRtECl5UY58mVSTx8zomcCMdc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1567025764418638.4416941810907;
 Wed, 28 Aug 2019 13:56:04 -0700 (PDT)
In-Reply-To: <20190828193628.7687-1-crosa@redhat.com>
Message-ID: <156702576316.26945.12238021410252316609@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: crosa@redhat.com
Date: Wed, 28 Aug 2019 13:56:04 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/3] Acceptance test
 x86_cpu_model_versions: fixes and minor improvements
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 wrampazz@redhat.com, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyODE5MzYyOC43Njg3
LTEtY3Jvc2FAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCAwLzNdIEFjY2VwdGFuY2UgdGVz
dCB4ODZfY3B1X21vZGVsX3ZlcnNpb25zOiBmaXhlcyBhbmQgbWlub3IgaW1wcm92ZW1lbnRzCk1l
c3NhZ2UtaWQ6IDIwMTkwODI4MTkzNjI4Ljc2ODctMS1jcm9zYUByZWRoYXQuY29tClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwoyYTU3MTQ3IEFjY2VwdGFuY2UgdGVzdCB4ODZfY3B1X21vZGVsX3ZlcnNpb25z
OiBzcGxpdCBpbnRvIHNtYWxsZXIgdGVzdHMKMzBjNjc4MiBBY2NlcHRhbmNlIHRlc3QgeDg2X2Nw
dV9tb2RlbF92ZXJzaW9uczogZml4IG1pc21hdGNoZXMgYmV0d2VlbiB0ZXN0IGFuZCBtZXNzYWdl
cwpmNjNiNjBmIEFjY2VwdGFuY2UgdGVzdCB4ODZfY3B1X21vZGVsX3ZlcnNpb25zOiBzaHV0ZG93
biBWTXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMyBDaGVja2luZyBjb21taXQgZjYzYjYwZjQ5
ZTdhIChBY2NlcHRhbmNlIHRlc3QgeDg2X2NwdV9tb2RlbF92ZXJzaW9uczogc2h1dGRvd24gVk1z
KQoyLzMgQ2hlY2tpbmcgY29tbWl0IDMwYzY3ODI3NzAwMSAoQWNjZXB0YW5jZSB0ZXN0IHg4Nl9j
cHVfbW9kZWxfdmVyc2lvbnM6IGZpeCBtaXNtYXRjaGVzIGJldHdlZW4gdGVzdCBhbmQgbWVzc2Fn
ZXMpCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMjI6IEZJTEU6IHRlc3RzL2FjY2Vw
dGFuY2UveDg2X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyODM6CisgICAgICAgICAgICAgICAgICAg
ICAgICAgJ3BjLWk0NDBmeC00LjAgKyBDYXNjYWRlbGFrZS1TZXJ2ZXItdjEgc2hvdWxkIG5vdCBo
YXZlIGFyY2gtY2FwYWJpbGl0aWVzJykKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwoj
MzE6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2UveDg2X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyOTI6
CisgICAgICAgICAgICAgICAgICAgICAgICAgJ3BjLWk0NDBmeC00LjAgKyBDYXNjYWRlbGFrZS1T
ZXJ2ZXItdjIgc2hvdWxkIGhhdmUgYXJjaC1jYXBhYmlsaXRpZXMnKQoKRVJST1I6IGxpbmUgb3Zl
ciA5MCBjaGFyYWN0ZXJzCiMzOTogRklMRTogdGVzdHMvYWNjZXB0YW5jZS94ODZfY3B1X21vZGVs
X3ZlcnNpb25zLnB5OjI5OToKKyAgICAgICAgdm0uYWRkX2FyZ3MoJy1jcHUnLCAnQ2FzY2FkZWxh
a2UtU2VydmVyLXYxLHgtZm9yY2UtZmVhdHVyZXM9b24sY2hlY2s9b2ZmLGVuZm9yY2U9b2ZmLCth
cmNoLWNhcGFiaWxpdGllcycpCgp0b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDI0IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8zIENoZWNr
aW5nIGNvbW1pdCAyYTU3MTQ3YTg2MmIgKEFjY2VwdGFuY2UgdGVzdCB4ODZfY3B1X21vZGVsX3Zl
cnNpb25zOiBzcGxpdCBpbnRvIHNtYWxsZXIgdGVzdHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwODI4MTkzNjI4Ljc2ODctMS1jcm9zYUBy
ZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


