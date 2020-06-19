Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AADC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FC120776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FC120776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGYw-0007fu-HY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmGYD-0006kJ-Dm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:55:21 -0400
Resent-Date: Fri, 19 Jun 2020 08:55:21 -0400
Resent-Message-Id: <E1jmGYD-0006kJ-Dm@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmGYB-0007cc-5d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:55:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592571306; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jo4jxZ68rGpjAOwXRaM6fCCX64mflLktPy1pn8vt92V1zaQniTITDsiipk6NHrD2J1tKVZiFQZqvlNl2mXyG+TmoXhY7SxXKxg3ij/US3eM8LgAK6LP0cuqUoqSmuHRdP075DF9S0mYD3EM3REvUIlxk0iz+yKAb98VwYpimhdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592571306;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PzGgM5g6p2CcMrCYD/FBMeg7OGbWyKrYUFVC4UZTx6U=; 
 b=LVxrKHt9S6/bn1McgFnW3VhP4i1cH0SG4LoS8yvdsysNzbYpXpU35+hMz0fkOBWNUkuMitUJEuy9wNIl35XOhg1rNGPLVLPlj9ZHOWsIlHYxjOON7G92ZGr5WwLjl3YM1nEjdkuWhtNbgX1lasKoFUwsD4qfny2NarpIxl6Zbz4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592571304823588.1803655332094;
 Fri, 19 Jun 2020 05:55:04 -0700 (PDT)
Message-ID: <159257130377.466.16273092559732587725@d1fd068a5071>
Subject: Re: [PATCH v5 0/6] Add strace support for printing arguments of
 selected syscalls
In-Reply-To: <20200619123331.17387-1-filip.bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Fri, 19 Jun 2020 05:55:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 07:15:10
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
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIDI5MmVmMTguLjRkMjg1ODIgIG1hc3Rl
ciAgICAgLT4gbWFzdGVyCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9x
ZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA2MTkxMjMzMzEuMTczODctMS1m
aWxpcC5ib3p1dGFAc3lybWlhLmNvbSAtPiBwYXRjaGV3LzIwMjAwNjE5MTIzMzMxLjE3Mzg3LTEt
ZmlsaXAuYm96dXRhQHN5cm1pYS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo0
YjBhZTE4IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1l
bnRzIG9mIGZhbGxvY2F0ZSgpCjVlZDNkNzYgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0
IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKQo5NjUyY2Y1IGxpbnV4
LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVr
KCkKNWNiMmRiOCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFy
Z3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVuZGVkIGF0dHJpYnV0ZXMKYzYzNTY1NiBs
aW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMKMTZm
Njc0YSBsaW51eC11c2VyOiBFeHRlbmQgc3RyYWNlIHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50
IHByaW50aW5nIGFmdGVyIHN5c2NhbGwgZXhlY3V0aW9uCgo9PT0gT1VUUFVUIEJFR0lOID09PQox
LzYgQ2hlY2tpbmcgY29tbWl0IDE2ZjY3NGE3NDczZCAobGludXgtdXNlcjogRXh0ZW5kIHN0cmFj
ZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1bWVudCBwcmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1
dGlvbikKMi82IENoZWNraW5nIGNvbW1pdCBjNjM1NjU2YzVlMDYgKGxpbnV4LXVzZXI6IEFkZCBz
dHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBzeXNjYWxscykKMy82IENoZWNraW5nIGNvbW1p
dCA1Y2IyZGI4ODhjZTQgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRp
bmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBmb3IgZXh0ZW5kZWQgYXR0cmlidXRlcykKNC82
IENoZWNraW5nIGNvbW1pdCA5NjUyY2Y1YmEzZWUgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3Vw
cG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkpCjUvNiBDaGVja2luZyBjb21t
aXQgNWVkM2Q3NmJhNjc1IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50
aW5nIGFyZ3VtZW50cyBvZiBjaG93bigpL2xjaG93bigpKQo2LzYgQ2hlY2tpbmcgY29tbWl0IDRi
MGFlMTg1NWYzYyAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBh
cmd1bWVudHMgb2YgZmFsbG9jYXRlKCkpCkVSUk9SOiBzdG9yYWdlIGNsYXNzIHNob3VsZCBiZSBh
dCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNzA6IEZJTEU6IGxpbnV4LXVzZXIv
c3RyYWNlLmM6MTEzODoKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIGZhbGxvY19mbGFnc1td
ID0gewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0
Y2ggNi82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRl
c3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxOTEyMzMzMS4xNzM4Ny0xLWZpbGlw
LmJvenV0YUBzeXJtaWEuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

