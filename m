Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 479BD2074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 21:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479BD2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiPgH-0003kU-H3
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 17:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jiPfX-0003JT-FR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:50:59 -0400
Resent-Date: Mon, 08 Jun 2020 17:50:59 -0400
Resent-Message-Id: <E1jiPfX-0003JT-FR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jiPfV-0007eV-Rs
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 17:50:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591653048; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eAAOiMxvgasGLL+vyjMCWCIyKvL6vHyZRE4nhzku3kRWNNPcPTxapUbBq+GUNpWUl+jTdZUt9Kw4rmMC1bboGzrLmBGzNGurrR7OG7Iws1zL4NZ0OyxYihWb2Jufu42uQ70zZpi/PZbClyzHQHt/Mnj7Zb8DDcgeUaP2KEp6fO4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591653048;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0jirPntVSsVP6HPYHL52TP8siVYISZpKNipVW4d2dA0=; 
 b=fyXZ4BiH6XSN8rYxfy85fvsEGUuEeUYyKhLTNWhNXmwYR5xMXRiCdO0DFLa9Epf1lEdj3zc9P/bNitqxuGIvRBd4x++bLX8gvTP3nBKNOU1GQZdHJ2QIvQ11I2SRSn1fFNsjcYSxRpMnenlzRvX1JrODE//AhX7mhIHl6TKc3ek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591653047224714.2870453804212;
 Mon, 8 Jun 2020 14:50:47 -0700 (PDT)
Message-ID: <159165304616.7663.9164615315453169920@45ef0f9c86ae>
In-Reply-To: <20200608164357.25065-1-filip.bozuta@syrmia.com>
Subject: Re: [PATCH v2 0/6] Add strace support for printing arguments of
 selected syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Mon, 8 Jun 2020 14:50:47 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 17:50:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwODE2NDM1Ny4yNTA2
NS0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDYwODE2NDM1Ny4yNTA2NS0xLWZpbGlw
LmJvenV0YUBzeXJtaWEuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzZdIEFkZCBzdHJhY2Ugc3Vw
cG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIHNlbGVjdGVkIHN5c2NhbGxzClR5cGU6IHNl
cmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNm
NWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwpkYzQ3NzAyIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJp
bnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpCjg0NzhlYTggbGludXgtdXNlcjogQWRkIHN0
cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKQpm
Mjg3YjdmIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1l
bnRzIG9mIGxzZWVrKCkKNjE1YTVkOCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9y
IHByaW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVuZGVkIGF0dHJpYnV0
ZXMKYjBhY2JlOSBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Yg
c3lzY2FsbHMKMzM3MGNlMiBsaW51eC11c2VyOiBFeHRlbmQgc3RyYWNlIHN1cHBvcnQgdG8gZW5h
YmxlIGFyZ3VtZW50IHByaW50aW5nIGFmdGVyIHN5c2NhbGwgZXhlY3V0aW9uCgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0IDMzNzBjZTI4ZjgzNiAobGludXgtdXNlcjog
RXh0ZW5kIHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJsZSBhcmd1bWVudCBwcmludGluZyBhZnRlciBz
eXNjYWxsIGV4ZWN1dGlvbikKMi82IENoZWNraW5nIGNvbW1pdCBiMGFjYmU5ZWYyN2QgKGxpbnV4
LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBzeXNjYWxscykKMy82IENo
ZWNraW5nIGNvbW1pdCA2MTVhNWQ4ZTlkMjEgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9y
dCBmb3IgcHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBmb3IgZXh0ZW5kZWQgYXR0
cmlidXRlcykKNC82IENoZWNraW5nIGNvbW1pdCBmMjg3YjdmODA2MzAgKGxpbnV4LXVzZXI6IEFk
ZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGxzZWVrKCkpCjUvNiBD
aGVja2luZyBjb21taXQgODQ3OGVhODE3Njk1IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBjaG93bigpL2xjaG93bigpKQo2LzYgQ2hlY2tp
bmcgY29tbWl0IGRjNDc3MDI3ZGY2NCAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZv
ciBwcmludGluZyBhcmd1bWVudHMgb2YgZmFsbG9jYXRlKCkpCkVSUk9SOiBzdG9yYWdlIGNsYXNz
IHNob3VsZCBiZSBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZSBkZWNsYXJhdGlvbgojNjk6IEZJTEU6
IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTE0NzoKK1VOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIGZh
bGxvY19mbGFnc1tdID0gewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNi82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYwODE2NDM1Ny4y
NTA2NS0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

