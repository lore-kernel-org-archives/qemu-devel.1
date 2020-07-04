Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011DEC433E2
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF25720724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF25720724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlG1-00056L-3Z
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrlDO-0001G4-9T
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:40:34 -0400
Resent-Date: Sat, 04 Jul 2020 12:40:34 -0400
Resent-Message-Id: <E1jrlDO-0001G4-9T@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrlDL-0005kZ-DY
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:40:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593880814; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iV/OlEsR8NDvNEOZZf7QF+InBBCzgofyDfk149qEpkm20KxOormN1wV+xWUcclZtwR2XuBI3uaNbEN8tSXpSWwb2JQEIpTb6liABWxXMpPo3jiFznMSh5kC6KRPV3cLOospzEPBdO1dL4pg5v/GXWr6DFittslqUzDATTUkGbJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593880814;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RzSLpZmSfUsnZA5hsSF0U1zNV2V126gZjLegWzow7U4=; 
 b=i1T2t5m3DQJJ04W8z4fQTNXmXaK2x1gE6xu8LcPI0o72stKWsOZ+HZ/LPtIB8LRJFgiaR8Sh3twMlmNXfFdfebYSxtpI57lX7DndjaYaOnfhYOPj80/qIPP5M+igm+P4JjdL8cZhmsiTTHpmcsjfkWsHX3dukTJCuDwvmP4z8Yw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593880811323408.7232443661711;
 Sat, 4 Jul 2020 09:40:11 -0700 (PDT)
Message-ID: <159388081008.22113.3452498152146061351@d1fd068a5071>
Subject: Re: [PULL 00/12] Linux user for 5.1 patches
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Sat, 4 Jul 2020 09:40:11 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:40:27
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
Cc: riku.voipio@iki.fi, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcwNDE2MjU0NS4zMTEx
MzMtMS1sYXVyZW50QHZpdmllci5ldS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMDAvMTJdIExpbnV4IHVzZXIgZm9yIDUuMSBwYXRj
aGVzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcwNDE2MjU0NS4zMTExMzMtMS1sYXVy
ZW50QHZpdmllci5ldQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20g
aHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAg
ICAgIHBhdGNoZXcvMjAyMDA3MDQxNjI1NDUuMzExMTMzLTEtbGF1cmVudEB2aXZpZXIuZXUgLT4g
cGF0Y2hldy8yMDIwMDcwNDE2MjU0NS4zMTExMzMtMS1sYXVyZW50QHZpdmllci5ldQpTd2l0Y2hl
ZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmNiM2E0ZmMgTUFJTlRBSU5FUlM6IHVwZGF0ZSBsaW51
eC11c2VyIG1haW50YWluZXIKN2IzZjZjZCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBpb2N0bCgpCjlkMTdiYmMgbGludXgtdXNlcjogQWRk
IHRodW5rIGFyZ3VtZW50IHR5cGVzIGZvciBTSU9DR1NUQU1QIGFuZCBTSU9DR1NUQU1QTlMKNThk
ODQ3ZCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50
cyBvZiBmYWxsb2NhdGUoKQowM2JjMDI4IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBm
b3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGNob3duKCkvbGNob3duKCkKNTNhZDI2MiBsaW51eC11
c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBsc2Vlaygp
CjNmNjdiYTQgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1
bWVudCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmRlZCBhdHRyaWJ1dGVzCjE2MWFlMTkgbGlu
dXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBhIGdyb3VwIG9mIHN5c2NhbGxzCmRiNGMx
N2QgbGludXgtdXNlcjogRXh0ZW5kIHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1bWVudCBw
cmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1dGlvbgoyMmJjODEyIGxpbnV4LXVzZXI6IHN5c2Nh
bGw6IGlvY3Rsczogc3VwcG9ydCBEUk1fSU9DVExfVkVSU0lPTgplOTcxOTVlIGxpbnV4LXVzZXIv
c3BhcmM2NDogRml4IHRoZSBoYW5kbGluZyBvZiB3aW5kb3cgc3BpbGwgdHJhcAo1NzVlMGFkIHRh
cmdldC9zcGFyYzogVHJhbnNsYXRlIGZsdXNodyBvcGNvZGUKCj09PSBPVVRQVVQgQkVHSU4gPT09
CjEvMTIgQ2hlY2tpbmcgY29tbWl0IDU3NWUwYWRmN2Q3ZSAodGFyZ2V0L3NwYXJjOiBUcmFuc2xh
dGUgZmx1c2h3IG9wY29kZSkKMi8xMiBDaGVja2luZyBjb21taXQgZTk3MTk1ZWMzMWQ3IChsaW51
eC11c2VyL3NwYXJjNjQ6IEZpeCB0aGUgaGFuZGxpbmcgb2Ygd2luZG93IHNwaWxsIHRyYXApCjMv
MTIgQ2hlY2tpbmcgY29tbWl0IDIyYmM4MTIyNDI2OCAobGludXgtdXNlcjogc3lzY2FsbDogaW9j
dGxzOiBzdXBwb3J0IERSTV9JT0NUTF9WRVJTSU9OKQo0LzEyIENoZWNraW5nIGNvbW1pdCBkYjRj
MTdkNDA0ZjIgKGxpbnV4LXVzZXI6IEV4dGVuZCBzdHJhY2Ugc3VwcG9ydCB0byBlbmFibGUgYXJn
dW1lbnQgcHJpbnRpbmcgYWZ0ZXIgc3lzY2FsbCBleGVjdXRpb24pCjUvMTIgQ2hlY2tpbmcgY29t
bWl0IDE2MWFlMTkyY2ViZCAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBhIGdy
b3VwIG9mIHN5c2NhbGxzKQo2LzEyIENoZWNraW5nIGNvbW1pdCAzZjY3YmE0ZGRhZTAgKGxpbnV4
LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2Fs
bHMgdXNlZCBmb3IgZXh0ZW5kZWQgYXR0cmlidXRlcykKNy8xMiBDaGVja2luZyBjb21taXQgNTNh
ZDI2MjMwMGY0IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFy
Z3VtZW50cyBvZiBsc2VlaygpKQo4LzEyIENoZWNraW5nIGNvbW1pdCAwM2JjMDI4MThlNWYgKGxp
bnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGNo
b3duKCkvbGNob3duKCkpCjkvMTIgQ2hlY2tpbmcgY29tbWl0IDU4ZDg0N2QwZThlYiAobGludXgt
dXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgZmFsbG9j
YXRlKCkpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9m
IHRoZSBkZWNsYXJhdGlvbgojNzI6IEZJTEU6IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTEzODoKK1VO
VVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIGZhbGxvY19mbGFnc1tdID0gewoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOS8xMiBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKMTAvMTIgQ2hlY2tpbmcgY29tbWl0IDlkMTdiYmNhMmNhYiAobGlu
dXgtdXNlcjogQWRkIHRodW5rIGFyZ3VtZW50IHR5cGVzIGZvciBTSU9DR1NUQU1QIGFuZCBTSU9D
R1NUQU1QTlMpCjExLzEyIENoZWNraW5nIGNvbW1pdCA3YjNmNmNkMWY1M2QgKGxpbnV4LXVzZXI6
IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGlvY3RsKCkpCjEy
LzEyIENoZWNraW5nIGNvbW1pdCBjYjNhNGZjYWI2M2EgKE1BSU5UQUlORVJTOiB1cGRhdGUgbGlu
dXgtdXNlciBtYWludGFpbmVyKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8yMDIwMDcwNDE2MjU0NS4zMTExMzMtMS1sYXVyZW50QHZpdmllci5ldS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

