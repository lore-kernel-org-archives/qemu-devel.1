Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3DEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E2620675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E2620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqILh-0004IJ-9F
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqIKp-0003VO-Pa; Tue, 30 Jun 2020 11:38:12 -0400
Resent-Date: Tue, 30 Jun 2020 11:38:11 -0400
Resent-Message-Id: <E1jqIKp-0003VO-Pa@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqIKn-0003Cm-57; Tue, 30 Jun 2020 11:38:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593531480; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kVAwjzp0jdxGAT3HZjDMO5gFAVmuse5UgHmVmoKWy6vUxFMv/2RE0E7PGIcQsjO9SAdHs2GG13LLWBgk8Ho5P48Ia+Rzb6JsgmgJ8vXEPCYKdNYaYsJG2eRyAPueY/XaXOx9uGm0+bTQcsno0WMRrIxitlmP0e16IflC4KxWEYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593531480;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IAH/q5saEPmBsQ4zMbTL3o9f/g6jXJCuPTjla0RLJ04=; 
 b=GrZfDfkOCXxCg8OMuPsknBAqaKey7pf5CKmkPpgmSlgzdjwUu3+9rEW/6rC3lpBx3ezi/gh5tjtyNQwwx3d3kD8em/mjOKoQwUF/QWtFcqJHinwOfaoUSp1i/TLBHIUMqQHgk8sBEU1nCyWlp1zZ2HytT+lU1J4Qhvw3/O9DXX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593531479083694.2142522302343;
 Tue, 30 Jun 2020 08:37:59 -0700 (PDT)
Message-ID: <159353147796.15477.3191349844047794688@d1fd068a5071>
Subject: Re: [PATCH] KVM: x86: believe what KVM says about WAITPKG
In-Reply-To: <20200630151150.536580-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 30 Jun 2020 08:37:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:38:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: qemu-devel@nongnu.org
Cc: mlevitsk@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYzMDE1MTE1MC41MzY1
ODAtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIEtWTTogeDg2OiBiZWxpZXZlIHdoYXQgS1ZN
IHNheXMgYWJvdXQgV0FJVFBLRwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA2MzAxNTEx
NTAuNTM2NTgwLTEtcGJvbnppbmlAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDYyNDEyMTg0MS4xNzk3MS0xLXBhdWxAeGVuLm9y
ZyAtPiBwYXRjaGV3LzIwMjAwNjI0MTIxODQxLjE3OTcxLTEtcGF1bEB4ZW4ub3JnCiAqIFtuZXcg
dGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MzAxNTI1MzEuMjA2NTctMS1hbGVrc2FuZGFyLnFl
bXUuZGV2ZWxAZ21haWwuY29tIC0+IHBhdGNoZXcvMjAyMDA2MzAxNTI1MzEuMjA2NTctMS1hbGVr
c2FuZGFyLnFlbXUuZGV2ZWxAZ21haWwuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcv
Y292ZXIuMTU5MzI3MzY3MS5naXQuZWxlbmEudWZpbXRzZXZhQG9yYWNsZS5jb20gLT4gcGF0Y2hl
dy9jb3Zlci4xNTkzMjczNjcxLmdpdC5lbGVuYS51ZmltdHNldmFAb3JhY2xlLmNvbQpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjcwZjBkN2IgS1ZNOiB4ODY6IGJlbGlldmUgd2hhdCBL
Vk0gc2F5cyBhYm91dCBXQUlUUEtHCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzMyOiBGSUxFOiB0YXJnZXQvaTM4Ni9jcHUuYzo2NTQxOgorICAg
ICAgICAgICAgICAgIHg4Nl9jcHVfZ2V0X3N1cHBvcnRlZF9mZWF0dXJlX3dvcmQoRkVBVF8xX0VD
WCwgY3B1LT5taWdyYXRhYmxlKSAmIENQVUlEX0VYVF9NT05JVE9SOwoKRVJST1I6IGxpbmUgb3Zl
ciA5MCBjaGFyYWN0ZXJzCiMzNDogRklMRTogdGFyZ2V0L2kzODYvY3B1LmM6NjU0MzoKKyAgICAg
ICAgICAgICAgICB4ODZfY3B1X2dldF9zdXBwb3J0ZWRfZmVhdHVyZV93b3JkKEZFQVRfN18wX0VD
WCwgY3B1LT5taWdyYXRhYmxlKSAmIENQVUlEXzdfMF9FQ1hfV0FJVFBLRzsKCnRvdGFsOiAyIGVy
cm9ycywgMCB3YXJuaW5ncywgMjMgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDcwZjBkN2IzMzhiMiAo
S1ZNOiB4ODY6IGJlbGlldmUgd2hhdCBLVk0gc2F5cyBhYm91dCBXQUlUUEtHKSBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYzMDE1MTE1MC41MzY1ODAtMS1wYm9uemluaUByZWRoYXQuY29tL3Rl
c3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9t
YXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5
b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

