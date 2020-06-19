Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08084C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23BB207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23BB207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHnn-0006n9-4E
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmHnC-00062J-03
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:14:54 -0400
Resent-Date: Fri, 19 Jun 2020 10:14:54 -0400
Resent-Message-Id: <E1jmHnC-00062J-03@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmHn9-00050s-75
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:14:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592576076; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BopwsxeOHkF2yiAfj0nFMUnvqgUqyH7lQ60i/nwuZaNAfqAbIVGIOkCp14+nKoYoaNIh3ANVNyjoC+C5O0dRn3vi2PP7Nst7hPiLDaT6SD37U5EuBt6OL4bOXo+jNu4e8gsWqspynG9Jnpb18dmrf60k0U8GUnjtTnPErh0iK38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592576076;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O2T9pUPdv5i5di4mfCxPKcdL7up9gOHCxRhm2DQ8luE=; 
 b=mfeOqjkXamcKSivh7pAxFzJRu6/YfuERUbFHVHbwLrmCfQ3WTG44B1rfX9X3OU1DbtAfzCCJ/haVZkmLpEfrtpkIjINxDCzJpca3piBm3ac0IcWHCzOFhAVCZjiKmHwooybwetT5QwL6GNlvjSN4ISNDfuzjYCiEgRj0JnpM44Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592576074374451.73974208067466;
 Fri, 19 Jun 2020 07:14:34 -0700 (PDT)
Message-ID: <159257607333.2529.14090425890760412762@d1fd068a5071>
Subject: Re: [PATCH v5 0/6] Add strace support for printing arguments of
 selected syscalls
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Fri, 19 Jun 2020 07:14:34 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTEyMzMzMS4xNzM4
Ny0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjUgMC82XSBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBzZWxlY3RlZCBzeXNjYWxscwpUeXBlOiBzZXJp
ZXMKTWVzc2FnZS1pZDogMjAyMDA2MTkxMjMzMzEuMTczODctMS1maWxpcC5ib3p1dGFAc3lybWlh
LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNTky
NTczOTU2ODkuNTI5MDguNDQwOTMxNDUwMzk4ODI4OTQ4MS5zdGdpdEBuYXBsZXMtYmFidS5hbWQu
Y29tIC0+IHBhdGNoZXcvMTU5MjU3Mzk1Njg5LjUyOTA4LjQ0MDkzMTQ1MDM5ODgyODk0ODEuc3Rn
aXRAbmFwbGVzLWJhYnUuYW1kLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAw
NjE5MTM1ODQ0LjIzMzA3LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZyAtPiBwYXRjaGV3LzIwMjAw
NjE5MTM1ODQ0LjIzMzA3LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZwpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCmZjNTFlNzQgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZv
ciBwcmludGluZyBhcmd1bWVudHMgb2YgZmFsbG9jYXRlKCkKMGE0YzVjZSBsaW51eC11c2VyOiBB
ZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBjaG93bigpL2xjaG93
bigpCjFmODgwMTcgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBh
cmd1bWVudHMgb2YgbHNlZWsoKQowZTRlN2Y2IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9y
dCBmb3IgcHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBmb3IgZXh0ZW5kZWQgYXR0
cmlidXRlcwo2MGJiYjhkIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91
cCBvZiBzeXNjYWxscwo2MWE3OGM0IGxpbnV4LXVzZXI6IEV4dGVuZCBzdHJhY2Ugc3VwcG9ydCB0
byBlbmFibGUgYXJndW1lbnQgcHJpbnRpbmcgYWZ0ZXIgc3lzY2FsbCBleGVjdXRpb24KCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvNiBDaGVja2luZyBjb21taXQgNjFhNzhjNGRiOTI1IChsaW51eC11
c2VyOiBFeHRlbmQgc3RyYWNlIHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50IHByaW50aW5nIGFm
dGVyIHN5c2NhbGwgZXhlY3V0aW9uKQoyLzYgQ2hlY2tpbmcgY29tbWl0IDYwYmJiOGQ5OWMyZCAo
bGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBhIGdyb3VwIG9mIHN5c2NhbGxzKQoz
LzYgQ2hlY2tpbmcgY29tbWl0IDBlNGU3ZjZjNjFhNSAobGludXgtdXNlcjogQWRkIHN0cmFjZSBz
dXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmRl
ZCBhdHRyaWJ1dGVzKQo0LzYgQ2hlY2tpbmcgY29tbWl0IDFmODgwMTc4NWIxZiAobGludXgtdXNl
cjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgbHNlZWsoKSkK
NS82IENoZWNraW5nIGNvbW1pdCAwYTRjNWNlNmRiOGMgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ug
c3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGNob3duKCkvbGNob3duKCkpCjYvNiBD
aGVja2luZyBjb21taXQgZmM1MWU3NDJhNTQzIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBmYWxsb2NhdGUoKSkKRVJST1I6IHN0b3JhZ2Ug
Y2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM3MDog
RklMRTogbGludXgtdXNlci9zdHJhY2UuYzoxMTM4OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxh
Z3MgZmFsbG9jX2ZsYWdzW10gPSB7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwNCBs
aW5lcyBjaGVja2VkCgpQYXRjaCA2LzYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjE5MTIz
MzMxLjE3Mzg3LTEtZmlsaXAuYm96dXRhQHN5cm1pYS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

