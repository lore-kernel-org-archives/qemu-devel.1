Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CDC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E2120674
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E2120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrlQF-0004Wk-Pk
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrlPj-00045p-3u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:53:19 -0400
Resent-Date: Sat, 04 Jul 2020 12:53:19 -0400
Resent-Message-Id: <E1jrlPj-00045p-3u@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jrlPf-0008HO-QB
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:53:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593881582; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AnZeoG15KPbemKaqdBNGwqMOQ56ixb5kms+k7icpUt7gOBEED6+IDn0J6vQXKtSkN9augev3yaVlUt1lXyShKVHXkCHcBz3NFfQ4DvPrGHQqVX0V1MJqvtG2nv9aDqns6hsr2kyc4rToWB4gGlHXbIv/gm7ZUFXWKgVXnh6+mLM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593881582;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=IBOJnpAeJIkwZ1ZN7S6c9+Bxs5jS8psXK7cNzSD+tUc=; 
 b=TiXOmCq+5F9Wk6SxZRwySZ2lt+0ozARgy5jY6oijsbkso3WCCDkp2mP2b8/JFwrtXwEhAJqyPvoTQYS10kepiKIfydwKpyb886YZqzuIPCBPr6W3Cql3MVZ7hbnCix4XkXxsgWWQI6qKrUHJWs+haSR19b7nJhvgmf3KZFYOzPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593881580386505.02970155101957;
 Sat, 4 Jul 2020 09:53:00 -0700 (PDT)
Message-ID: <159388157913.22113.1206281745620963878@d1fd068a5071>
Subject: Re: [PULL 00/12] Linux user for 5.1 patches
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Sat, 4 Jul 2020 09:53:00 -0700 (PDT)
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
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczov
L2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0
Y2hldy8yMDIwMDcwMzA5MDgxNi4zMjk1LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tIC0+IHBh
dGNoZXcvMjAyMDA3MDMwOTA4MTYuMzI5NS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbQogLSBb
dGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNzA0MTQ0OTQzLjE4MjkyLTEtZjRidWdAYW1z
YXQub3JnIC0+IHBhdGNoZXcvMjAyMDA3MDQxNDQ5NDMuMTgyOTItMS1mNGJ1Z0BhbXNhdC5vcmcK
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDcwNDE2MjU0NS4zMTExMzMtMS1sYXVy
ZW50QHZpdmllci5ldSAtPiBwYXRjaGV3LzIwMjAwNzA0MTYyNTQ1LjMxMTEzMy0xLWxhdXJlbnRA
dml2aWVyLmV1CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA3MDQxNjM5MjcuMjgx
ODgtMS1waGlsbWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNzA0MTYzOTI3LjI4MTg4LTEt
cGhpbG1kQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2OTRmNTY4
IE1BSU5UQUlORVJTOiB1cGRhdGUgbGludXgtdXNlciBtYWludGFpbmVyCjE3MWM5OTAgbGludXgt
dXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgaW9jdGwo
KQphNDI0YmI2IGxpbnV4LXVzZXI6IEFkZCB0aHVuayBhcmd1bWVudCB0eXBlcyBmb3IgU0lPQ0dT
VEFNUCBhbmQgU0lPQ0dTVEFNUE5TCjI3YmYzMTAgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBw
b3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgZmFsbG9jYXRlKCkKZjFiMTIwNiBsaW51eC11
c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBjaG93bigp
L2xjaG93bigpCjkzOTZmMDMgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmlu
dGluZyBhcmd1bWVudHMgb2YgbHNlZWsoKQo1YzcwNGNmIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ug
c3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBmb3IgZXh0ZW5k
ZWQgYXR0cmlidXRlcwo3NzYyYTNkIGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
YSBncm91cCBvZiBzeXNjYWxscwplOTBkODZjIGxpbnV4LXVzZXI6IEV4dGVuZCBzdHJhY2Ugc3Vw
cG9ydCB0byBlbmFibGUgYXJndW1lbnQgcHJpbnRpbmcgYWZ0ZXIgc3lzY2FsbCBleGVjdXRpb24K
N2I4OGM5NyBsaW51eC11c2VyOiBzeXNjYWxsOiBpb2N0bHM6IHN1cHBvcnQgRFJNX0lPQ1RMX1ZF
UlNJT04KOGY0ZWRlOSBsaW51eC11c2VyL3NwYXJjNjQ6IEZpeCB0aGUgaGFuZGxpbmcgb2Ygd2lu
ZG93IHNwaWxsIHRyYXAKZmJmNzIxNiB0YXJnZXQvc3BhcmM6IFRyYW5zbGF0ZSBmbHVzaHcgb3Bj
b2RlCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEyIENoZWNraW5nIGNvbW1pdCBmYmY3MjE2MzE1
MmIgKHRhcmdldC9zcGFyYzogVHJhbnNsYXRlIGZsdXNodyBvcGNvZGUpCjIvMTIgQ2hlY2tpbmcg
Y29tbWl0IDhmNGVkZTkyZjVjYiAobGludXgtdXNlci9zcGFyYzY0OiBGaXggdGhlIGhhbmRsaW5n
IG9mIHdpbmRvdyBzcGlsbCB0cmFwKQozLzEyIENoZWNraW5nIGNvbW1pdCA3Yjg4Yzk3NTUyZjcg
KGxpbnV4LXVzZXI6IHN5c2NhbGw6IGlvY3Rsczogc3VwcG9ydCBEUk1fSU9DVExfVkVSU0lPTikK
NC8xMiBDaGVja2luZyBjb21taXQgZTkwZDg2Yzk2ZDk2IChsaW51eC11c2VyOiBFeHRlbmQgc3Ry
YWNlIHN1cHBvcnQgdG8gZW5hYmxlIGFyZ3VtZW50IHByaW50aW5nIGFmdGVyIHN5c2NhbGwgZXhl
Y3V0aW9uKQo1LzEyIENoZWNraW5nIGNvbW1pdCA3NzYyYTNkOTA2MmYgKGxpbnV4LXVzZXI6IEFk
ZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBzeXNjYWxscykKNi8xMiBDaGVja2luZyBj
b21taXQgNWM3MDRjZjQ0MzQ1IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHBy
aW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVuZGVkIGF0dHJpYnV0ZXMp
CjcvMTIgQ2hlY2tpbmcgY29tbWl0IDkzOTZmMDM3NTE2MiAobGludXgtdXNlcjogQWRkIHN0cmFj
ZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgbHNlZWsoKSkKOC8xMiBDaGVja2lu
ZyBjb21taXQgZjFiMTIwNjUzZmUxIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9y
IHByaW50aW5nIGFyZ3VtZW50cyBvZiBjaG93bigpL2xjaG93bigpKQo5LzEyIENoZWNraW5nIGNv
bW1pdCAyN2JmMzEwZjZmOGYgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJp
bnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpKQpFUlJPUjogc3RvcmFnZSBjbGFzcyBzaG91
bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzcyOiBGSUxFOiBsaW51
eC11c2VyL3N0cmFjZS5jOjExMzg6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBmYWxsb2Nf
ZmxhZ3NbXSA9IHsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDkvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjEwLzEyIENoZWNraW5n
IGNvbW1pdCBhNDI0YmI2MjVhNjggKGxpbnV4LXVzZXI6IEFkZCB0aHVuayBhcmd1bWVudCB0eXBl
cyBmb3IgU0lPQ0dTVEFNUCBhbmQgU0lPQ0dTVEFNUE5TKQoxMS8xMiBDaGVja2luZyBjb21taXQg
MTcxYzk5MGY2ODYzIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5n
IGFyZ3VtZW50cyBvZiBpb2N0bCgpKQoxMi8xMiBDaGVja2luZyBjb21taXQgNjk0ZjU2OGNhYjMw
IChNQUlOVEFJTkVSUzogdXBkYXRlIGxpbnV4LXVzZXIgbWFpbnRhaW5lcikKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA3MDQxNjI1NDUuMzEx
MTMzLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

