Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A6C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:22:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DC6207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 01:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DC6207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4E4j-0000kz-Gi
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 20:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j4E41-0000DJ-A5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j4E3w-0006Qb-P4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 20:22:08 -0500
Resent-Date: Tue, 18 Feb 2020 20:22:06 -0500
Resent-Message-Id: <E1j4E3w-0006Qb-P4@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j4E3w-0006Q8-HY; Tue, 18 Feb 2020 20:22:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582075301; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ChtSpJuARbs/fvLnktmd5Mqnr2i2PXF6aEvTPJaoUd1rUbTPZik5W4ACXJz4BNkeUZR7qne3Rr4GtKPEeGOc1GTe1dctW0RU0lfw/ho7N1Gu9HDb8nKY6NcJ2kEcUv7LqNdJqGHXqVpz4aI24aPQdOeZ+sZdyCCag9ICxH0KMEo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582075301;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=K+znV4GKNEhyu1hEHfuK88l3MPxPcfQ39eO3PfuHO3o=; 
 b=XF3W9el3bxet7VVYHMQYkT2jhoY41qT1LoaAAKOBjBNoEqAXOCqEnCogBm5gJ9H+p6QlSiISkaFtftie60JQlsx4QzawNqVnZ0SsCYtkfJDpJfD70zkkwqOgPHwLtkjQuTwQtuZ6wu0o/AanqYnLmziHQmERl29TVJ5dlRwfA98=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582075297824307.2309368113548;
 Tue, 18 Feb 2020 17:21:37 -0800 (PST)
In-Reply-To: <20200219005414.15635-1-david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 00/12] target/ppc: Correct some errors with real mode
 handling
Message-ID: <158207529589.20350.13094839224352717874@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: david@gibson.dropbear.id.au
Date: Tue, 18 Feb 2020 17:21:37 -0800 (PST)
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mark.cave-ayland@ilande.co.uk,
 groug@kaod.org, qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org,
 qemu-ppc@nongnu.org, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxOTAwNTQxNC4xNTYz
NS0xLWRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAwLzEyXSB0YXJnZXQvcHBj
OiBDb3JyZWN0IHNvbWUgZXJyb3JzIHdpdGggcmVhbCBtb2RlIGhhbmRsaW5nCk1lc3NhZ2UtaWQ6
IDIwMjAwMjE5MDA1NDE0LjE1NjM1LTEtZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1ClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMjAyMDAyMTkwMDU0MTQuMTU2MzUtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUg
LT4gcGF0Y2hldy8yMDIwMDIxOTAwNTQxNC4xNTYzNS0xLWRhdmlkQGdpYnNvbi5kcm9wYmVhci5p
ZC5hdQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI3NWRiMmYgdGFyZ2V0L3BwYzog
RG9uJ3Qgc3RvcmUgVlJNQSBTTEJFIHBlcnNpc3RlbnRseQo4ZjRlZjc4IHRhcmdldC9wcGM6IFN0
cmVhbWxpbmUgY29uc3RydWN0aW9uIG9mIFZSTUEgU0xCIGVudHJ5CjUzMjlmM2IgdGFyZ2V0L3Bw
YzogT25seSBjYWxjdWxhdGUgUk1MUyBkZXJpdmVkIFJNQSBsaW1pdCBvbiBkZW1hbmQKNjU2YTM3
MiB0YXJnZXQvcHBjOiBDb3JyZWN0IFJNTFMgdGFibGUKNjQzMmU3ZiB0YXJnZXQvcHBjOiBTdHJl
YW1saW5lIGNhbGN1bGF0aW9uIG9mIFJNQSBsaW1pdCBmcm9tIExQQ1JbUk1MU10KMDBmNzhjZCB0
YXJnZXQvcHBjOiBVc2UgY2xhc3MgZmllbGRzIHRvIHNpbXBsaWZ5IExQQ1IgbWFza2luZwpjNmY2
Y2VhIHRhcmdldC9wcGM6IFJlbW92ZSBSTU9SIHJlZ2lzdGVyIGZyb20gUE9XRVI5ICYgUE9XRVIx
MApjNmRhYWU2IHNwYXByLCBwcGM6IFJlbW92ZSBWUE0wL1JNTFMgaGFja3MgZm9yIFBPV0VSOQoz
Mzc0MTk3IHRhcmdldC9wcGM6IEludHJvZHVjZSBwcGNfaGFzaDY0X3VzZV92cm1hKCkgaGVscGVy
CjdlMTRlOTcgdGFyZ2V0L3BwYzogQ29ycmVjdCBoYW5kbGluZyBvZiByZWFsIG1vZGUgYWNjZXNz
ZXMgd2l0aCB2aHlwIG9uIGhhc2ggTU1VCjdjMjk4Y2IgcHBjOiBSZW1vdmUgc3R1YiBvZiBQUEM5
NzAgSElENCBpbXBsZW1lbnRhdGlvbgo0NTI1ODc5IHBwYzogUmVtb3ZlIHN0dWIgc3VwcG9ydCBm
b3IgMzItYml0IGh5cGVydmlzb3IgbW9kZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8xMiBDaGVj
a2luZyBjb21taXQgNDUyNTg3OWU2ZmFlIChwcGM6IFJlbW92ZSBzdHViIHN1cHBvcnQgZm9yIDMy
LWJpdCBoeXBlcnZpc29yIG1vZGUpCjIvMTIgQ2hlY2tpbmcgY29tbWl0IDdjMjk4Y2I1ODgyMSAo
cHBjOiBSZW1vdmUgc3R1YiBvZiBQUEM5NzAgSElENCBpbXBsZW1lbnRhdGlvbikKV0FSTklORzog
QmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzk4OiBG
SUxFOiB0YXJnZXQvcHBjL3RyYW5zbGF0ZV9pbml0LmluYy5jOjc5MDQ6CisgICAgLyogUFBDOTcw
OiBISUQ0IGNvdmVycyB0aGluZ3MgbGF0ZXIgY29udHJvbGxlZCBieSB0aGUgTFBDUiBhbmQKCldB
Uk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICovIG9uIGEgc2VwYXJhdGUgbGlu
ZQojMTAyOiBGSUxFOiB0YXJnZXQvcHBjL3RyYW5zbGF0ZV9pbml0LmluYy5jOjc5MDg6CisgICAg
ICogaWdub3JlIGl0ICovCgp0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3MsIDcxIGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDIvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMy8xMiBDaGVja2lu
ZyBjb21taXQgN2UxNGU5N2ZhNzI1ICh0YXJnZXQvcHBjOiBDb3JyZWN0IGhhbmRsaW5nIG9mIHJl
YWwgbW9kZSBhY2Nlc3NlcyB3aXRoIHZoeXAgb24gaGFzaCBNTVUpCjQvMTIgQ2hlY2tpbmcgY29t
bWl0IDMzNzQxOTczOWVlOCAodGFyZ2V0L3BwYzogSW50cm9kdWNlIHBwY19oYXNoNjRfdXNlX3Zy
bWEoKSBoZWxwZXIpCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24g
YSBzZXBhcmF0ZSBsaW5lCiM0MTogRklMRTogdGFyZ2V0L3BwYy9tbXUtaGFzaDY0LmM6Njc1Ogor
ICAgICAgICAvKiBJU0F2My4wIChQT1dFUjkpIGFsd2F5cyB1c2VzIFZSTUEsIHRoZSBWUE0wIGZp
ZWxkIGFuZCBSTU9SCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBv
biBhIHNlcGFyYXRlIGxpbmUKIzQyOiBGSUxFOiB0YXJnZXQvcHBjL21tdS1oYXNoNjQuYzo2NzY6
CisgICAgICAgICAqIHJlZ2lzdGVyIG5vIGxvbmdlciBleGlzdCAqLwoKdG90YWw6IDAgZXJyb3Jz
LCAyIHdhcm5pbmdzLCA4MyBsaW5lcyBjaGVja2VkCgpQYXRjaCA0LzEyIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCjUvMTIgQ2hlY2tpbmcgY29tbWl0IGM2ZGFhZTZlOWIwNiAoc3BhcHIsIHBw
YzogUmVtb3ZlIFZQTTAvUk1MUyBoYWNrcyBmb3IgUE9XRVI5KQo2LzEyIENoZWNraW5nIGNvbW1p
dCBjNmY2Y2VhYTQzZmMgKHRhcmdldC9wcGM6IFJlbW92ZSBSTU9SIHJlZ2lzdGVyIGZyb20gUE9X
RVI5ICYgUE9XRVIxMCkKNy8xMiBDaGVja2luZyBjb21taXQgMDBmNzhjZGZlYmJkICh0YXJnZXQv
cHBjOiBVc2UgY2xhc3MgZmllbGRzIHRvIHNpbXBsaWZ5IExQQ1IgbWFza2luZykKOC8xMiBDaGVj
a2luZyBjb21taXQgNjQzMmU3ZmU4NjRmICh0YXJnZXQvcHBjOiBTdHJlYW1saW5lIGNhbGN1bGF0
aW9uIG9mIFJNQSBsaW1pdCBmcm9tIExQQ1JbUk1MU10pCjkvMTIgQ2hlY2tpbmcgY29tbWl0IDY1
NmEzNzJmNjc3YyAodGFyZ2V0L3BwYzogQ29ycmVjdCBSTUxTIHRhYmxlKQoxMC8xMiBDaGVja2lu
ZyBjb21taXQgNTMyOWYzYjA3ZmJhICh0YXJnZXQvcHBjOiBPbmx5IGNhbGN1bGF0ZSBSTUxTIGRl
cml2ZWQgUk1BIGxpbWl0IG9uIGRlbWFuZCkKMTEvMTIgQ2hlY2tpbmcgY29tbWl0IDhmNGVmNzhh
NGFmMyAodGFyZ2V0L3BwYzogU3RyZWFtbGluZSBjb25zdHJ1Y3Rpb24gb2YgVlJNQSBTTEIgZW50
cnkpCkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBz
dGF0ZW1lbnQKIzgwOiBGSUxFOiB0YXJnZXQvcHBjL21tdS1oYXNoNjQuYzoxMDg0OgorICAgICAg
ICBpZiAoYnVpbGRfdnJtYV9zbGJlKGNwdSwgc2xiKSA9PSAwKQpbLi4uXQoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCA5NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxMS8xMiBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKMTIvMTIgQ2hlY2tpbmcgY29tbWl0IDI3NWRiMmZlMmE4NCAodGFy
Z2V0L3BwYzogRG9uJ3Qgc3RvcmUgVlJNQSBTTEJFIHBlcnNpc3RlbnRseSkKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAyMTkwMDU0MTQuMTU2
MzUtMS1kYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

