Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DABC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD5024692
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD5024692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isOdT-0001Td-Ow
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1isOcv-000117-BL
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1isOcs-0001IG-Nh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:13:16 -0500
Resent-Date: Fri, 17 Jan 2020 05:13:16 -0500
Resent-Message-Id: <E1isOcs-0001IG-Nh@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1isOcs-0001HM-Fh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:13:14 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579255975285943.3267080258317;
 Fri, 17 Jan 2020 02:12:55 -0800 (PST)
In-Reply-To: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH 0/4] linux-user: Fix some issues in termbits.h files 
Message-ID: <157925597419.3991.2478032997321602729@197193fa8d23>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 17 Jan 2020 02:12:55 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTc5MjI3MTE3LTYzMTAtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTU3OTIyNzExNy02
MzEwLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20KVHlwZTog
c2VyaWVzClN1YmplY3Q6IFtQQVRDSCAwLzRdIGxpbnV4LXVzZXI6IEZpeCBzb21lIGlzc3VlcyBp
biB0ZXJtYml0cy5oIGZpbGVzIAoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBU
cnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFn
XSAgICAgICAgIHBhdGNoZXcvMTU3OTIyNzExNy02MzEwLTEtZ2l0LXNlbmQtZW1haWwtYWxla3Nh
bmRhci5tYXJrb3ZpY0BydC1yay5jb20gLT4gcGF0Y2hldy8xNTc5MjI3MTE3LTYzMTAtMS1naXQt
c2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjJhMTgzOTQgbGludXgtdXNlcjogRml4IHNvbWUgY29uc3RhbnRzIGlu
IHJlbWFpbmluZyB0ZXJtYml0cy5oCjExYWNhZjYgbGludXgtdXNlcjogeHRlbnNhOiBGaXggc29t
ZSBjb25zdGFudHMgaW4gdGVybWJpdHMuaAo1ZjY0MDk4IGxpbnV4LXVzZXI6IG1pcHM6IFN5bmNo
cm9uaXplIHRlcm1iaXRzLmggd2l0aCBrZXJuZWwKMGQ1MjMxYSBsaW51eC11c2VyOiBhbHBoYTog
U3luY2hyb25pemUgdGVybWJpdHMuaCB3aXRoIGtlcm5lbAoKPT09IE9VVFBVVCBCRUdJTiA9PT0K
MS80IENoZWNraW5nIGNvbW1pdCAwZDUyMzFhNWM1OGYgKGxpbnV4LXVzZXI6IGFscGhhOiBTeW5j
aHJvbml6ZSB0ZXJtYml0cy5oIHdpdGgga2VybmVsKQoyLzQgQ2hlY2tpbmcgY29tbWl0IDVmNjQw
OTgwZThmMyAobGludXgtdXNlcjogbWlwczogU3luY2hyb25pemUgdGVybWJpdHMuaCB3aXRoIGtl
cm5lbCkKRVJST1I6IGlmIHRoaXMgY29kZSBpcyByZWR1bmRhbnQgY29uc2lkZXIgcmVtb3Zpbmcg
aXQKIzgzOiBGSUxFOiBsaW51eC11c2VyL21pcHMvdGVybWJpdHMuaDo2MDoKKyNpZiAwCgp0b3Rh
bDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE4NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzQgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvNCBDaGVja2luZyBjb21taXQgMTFhY2FmNmIwNDYw
IChsaW51eC11c2VyOiB4dGVuc2E6IEZpeCBzb21lIGNvbnN0YW50cyBpbiB0ZXJtYml0cy5oKQo0
LzQgQ2hlY2tpbmcgY29tbWl0IDJhMTgzOTRiMGQzYyAobGludXgtdXNlcjogRml4IHNvbWUgY29u
c3RhbnRzIGluIHJlbWFpbmluZyB0ZXJtYml0cy5oKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTc5MjI3MTE3LTYzMTAtMS1naXQtc2VuZC1lbWFp
bC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


