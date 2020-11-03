Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE9622264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE9622264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyie-0002lo-8g
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZyJt-00020K-P9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:01 -0500
Resent-Date: Tue, 03 Nov 2020 10:34:01 -0500
Resent-Message-Id: <E1kZyJt-00020K-P9@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kZyJp-0001Qd-Mo
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604417626; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HnIcfW2PX+o+W1N5OAIgVV3H6H2UWb2f4d0TsfRHPP5k0x2FTjgMA8RyRnpB18egWh9EJCZ8oI57Mb7fDmsOt9Q+HHd0HDYPjB/og4cJRz7G7S7KfQFS9Xz+5rS93ATA3dAOOwzQQKdI2Hj4V//DaejA/p5jOtSkeiWulyEpw1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604417626;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2k5G3DchvPh0hJMCyQc5l4nfPQgrK2PhDE7IBxp+XsY=; 
 b=XsjECPRrbQoYndnRbxuJSJ1kGgVqtS74jkcUv6de/lxpniKvUnrSx6Y7Wx3ufvXA66OG09WWbNl5CrrcW+RAODVyg5hFTavOhQzML4HOyzcmeh/EHUCtdyqNPYsnmDYLUaZK8m79w9VjUl7EBjnrc3jSh1l3vfwrorVtsu0/X3s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604417622790121.15564023069157;
 Tue, 3 Nov 2020 07:33:42 -0800 (PST)
Subject: Re: [PATCH for-5.2 0/4] deprecate short-form boolean options
Message-ID: <160441762174.31101.10900651951647123138@66eaa9a8a123>
In-Reply-To: <20201103151452.416784-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 3 Nov 2020 07:33:42 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 09:22:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwMzE1MTQ1Mi40MTY3
ODQtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDExMDMxNTE0NTIuNDE2
Nzg0LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggZm9yLTUuMiAwLzRdIGRl
cHJlY2F0ZSBzaG9ydC1mb3JtIGJvb2xlYW4gb3B0aW9ucwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTEwMzE1MTQ1Mi40MTY3ODQtMS1wYm9uemlu
aUByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDExMDMxNTE0NTIuNDE2Nzg0LTEtcGJvbnppbmlA
cmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjFiNDJkOTkgcWVtdS1v
cHRpb246IHdhcm4gZm9yIHNob3J0LWZvcm0gYm9vbGVhbiBvcHRpb25zCjk5MjdkMDAgcXRlc3Q6
IGVzY2FwZSBkZXZpY2UgbmFtZSBpbiBkZXZpY2UtaW50cm9zcGVjdC10ZXN0CmRkNDI3YjcgcWVt
dS1vcHRpb246IG1vdmUgaGVscCBoYW5kbGluZyB0byBnZXRfb3B0X25hbWVfdmFsdWUKZTEyNzNi
MiBpdnNobWVtLXRlc3Q6IGRvIG5vdCB1c2Ugc2hvcnQtZm9ybSBib29sZWFuIG9wdGlvbgoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCBlMTI3M2IyZWFiMmUgKGl2c2ht
ZW0tdGVzdDogZG8gbm90IHVzZSBzaG9ydC1mb3JtIGJvb2xlYW4gb3B0aW9uKQoyLzQgQ2hlY2tp
bmcgY29tbWl0IGRkNDI3Yjc0MmUzYiAocWVtdS1vcHRpb246IG1vdmUgaGVscCBoYW5kbGluZyB0
byBnZXRfb3B0X25hbWVfdmFsdWUpCjMvNCBDaGVja2luZyBjb21taXQgOTkyN2QwMDkwNDk0IChx
dGVzdDogZXNjYXBlIGRldmljZSBuYW1lIGluIGRldmljZS1pbnRyb3NwZWN0LXRlc3QpCjQvNCBD
aGVja2luZyBjb21taXQgMWI0MmQ5OTQ3YzE4IChxZW11LW9wdGlvbjogd2FybiBmb3Igc2hvcnQt
Zm9ybSBib29sZWFuIG9wdGlvbnMpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM1
NjogRklMRTogaW5jbHVkZS9xZW11L29wdGlvbi5oOjY4OgorICAgIGJvb2wgYWxsb3dfZmxhZ19v
cHRpb25zOyAvKiBXaGV0aGVyIHRvIHdhcm4gZm9yIHNob3J0LWZvcm0gYm9vbGVhbiBvcHRpb25z
ICovCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzExNzogRklMRTogdXRpbC9xZW11
LW9wdGlvbi5jOjgxMjoKKyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoInNob3J0LWZvcm0g
Ym9vbGVhbiBvcHRpb24gJyVzJXMnIGRlcHJlY2F0ZWQiLCBwcmVmaXgsICpuYW1lKTsKCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMzY6IEZJTEU6IHV0aWwvcWVtdS1vcHRpb24u
Yzo4NDA6CisgICAgICAgIHAgPSBnZXRfb3B0X25hbWVfdmFsdWUocCwgZmlyc3RuYW1lLCB3YXJu
X29uX2ZsYWcsIGhlbHBfd2FudGVkLCAmb3B0aW9uLCAmdmFsdWUpOwoKdG90YWw6IDEgZXJyb3Jz
LCAyIHdhcm5pbmdzLCAxMjQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMTEwMzE1MTQ1Mi40MTY3ODQtMS1wYm9uemluaUByZWRoYXQuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

