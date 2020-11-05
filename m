Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D92C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB41A20786
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB41A20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kagOT-0004YM-Ob
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kagNl-00042K-34
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:36:57 -0500
Resent-Date: Thu, 05 Nov 2020 09:36:57 -0500
Resent-Message-Id: <E1kagNl-00042K-34@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kagNi-0007Cx-BC
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:36:56 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604587003; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=a4ayVsT6KiLSO/Vg+bJwGG9oGof/up/zlXaN8YCdBKwxB91xWCTE827Yihi5QMhggsA3snh2KdQJh5Yv9Fu2anwrKG3QzQ6kGJjpB7J0nuRNs3iGK0g1laPtMgmYt935CM5zb+IDzhHwbOi1ejov6cOhiAbb6VBX0+Lh1ZdS8C8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604587003;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=bT1LeyCZsjtRsyZK9+1L5s13aQMpGZOFw6Keg7lAHIE=; 
 b=cLLeUnQ8tcq5FNz2NtnMc9i85sZdQHnwCHxhSIfNQXm5Tqt0mY1zHsA21LJaSHag2XW+84Zb47vspK+cfQjG2tsTAhF6LrD2hN+mgiLnRx9rPGlHLtbVjaWh0ve79/yy4NdQmFIYrUS3ra1x3pXMpDC/czWi8o1pM7jh8k4XdTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604587000816837.0824582938402;
 Thu, 5 Nov 2020 06:36:40 -0800 (PST)
Subject: Re: [PATCH for-5.2 0/2] deprecate short-form boolean options
Message-ID: <160458699957.17446.6811965072569074279@66eaa9a8a123>
In-Reply-To: <20201105142731.623428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Thu, 5 Nov 2020 06:36:40 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 09:36:51
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwNTE0MjczMS42MjM0
MjgtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDExMDUxNDI3MzEuNjIz
NDI4LTEtcGJvbnppbmlAcmVkaGF0LmNvbQpTdWJqZWN0OiBbUEFUQ0ggZm9yLTUuMiAwLzJdIGRl
cHJlY2F0ZSBzaG9ydC1mb3JtIGJvb2xlYW4gb3B0aW9ucwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0g
W3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8xNjA0NTU2NjE0MTEuMzQ1NS40MTc3OTUzOTEyMzA0
NzUyODkyLnN0Z2l0QHBhc2hhLVRoaW5rUGFkLVgyODAgLT4gcGF0Y2hldy8xNjA0NTU2NjE0MTEu
MzQ1NS40MTc3OTUzOTEyMzA0NzUyODkyLnN0Z2l0QHBhc2hhLVRoaW5rUGFkLVgyODAKIC0gW3Rh
ZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTEwNTEzNDExMi4yNTExOS0xLWtyYXhlbEByZWRo
YXQuY29tIC0+IHBhdGNoZXcvMjAyMDExMDUxMzQxMTIuMjUxMTktMS1rcmF4ZWxAcmVkaGF0LmNv
bQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMTA1MTQyNzMxLjYyMzQyOC0xLXBi
b256aW5pQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTEwNTE0MjczMS42MjM0MjgtMS1wYm9u
emluaUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMmIwM2M1MCBx
ZW11LW9wdGlvbjogd2FybiBmb3Igc2hvcnQtZm9ybSBib29sZWFuIG9wdGlvbnMKNjJkMmJiNyBx
ZW11LW9wdGlvbjogbW92ZSBoZWxwIGhhbmRsaW5nIHRvIGdldF9vcHRfbmFtZV92YWx1ZQoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCA2MmQyYmI3OGQzYjMgKHFlbXUt
b3B0aW9uOiBtb3ZlIGhlbHAgaGFuZGxpbmcgdG8gZ2V0X29wdF9uYW1lX3ZhbHVlKQoyLzIgQ2hl
Y2tpbmcgY29tbWl0IDJiMDNjNTBhOTkxZCAocWVtdS1vcHRpb246IHdhcm4gZm9yIHNob3J0LWZv
cm0gYm9vbGVhbiBvcHRpb25zKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNTY6
IEZJTEU6IGluY2x1ZGUvcWVtdS9vcHRpb24uaDo2ODoKKyAgICBib29sIGFsbG93X2ZsYWdfb3B0
aW9uczsgLyogV2hldGhlciB0byB3YXJuIGZvciBzaG9ydC1mb3JtIGJvb2xlYW4gb3B0aW9ucyAq
LwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxMTA6IEZJTEU6IHV0aWwvcWVtdS1v
cHRpb24uYzo4MTA6CisgICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJzaG9ydC1mb3JtIGJv
b2xlYW4gb3B0aW9uICclcyVzJyBkZXByZWNhdGVkIiwgcHJlZml4LCAqbmFtZSk7CgpXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTI5OiBGSUxFOiB1dGlsL3FlbXUtb3B0aW9uLmM6
ODM4OgorICAgICAgICBwID0gZ2V0X29wdF9uYW1lX3ZhbHVlKHAsIGZpcnN0bmFtZSwgd2Fybl9v
bl9mbGFnLCBoZWxwX3dhbnRlZCwgJm9wdGlvbiwgJnZhbHVlKTsKCnRvdGFsOiAxIGVycm9ycywg
MiB3YXJuaW5ncywgMTE3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMiBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAyMDExMDUxNDI3MzEuNjIzNDI4LTEtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

