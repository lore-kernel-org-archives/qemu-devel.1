Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9644CC06513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0B521721
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0B521721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKYs-0008Sj-M1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57648)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hiKJy-0003Ld-Hc
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hiKJs-0005yv-0a
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:03:49 -0400
Resent-Date: Tue, 02 Jul 2019 11:03:49 -0400
Resent-Message-Id: <E1hiKJs-0005yv-0a@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hiKJh-0005nw-Er
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562079691; cv=none; d=zoho.com; s=zohoarc; 
 b=iUd0g/2qQq7Byf+nk/G91kJaNVPUMzyaMptwYkm8TdnZBF6hnmSUbTJeWbhAfix8kw3FHrnRtXHsGF+oC0932W2PpGddhO5YhtOXT6m5jfwju52C7EAvBxjxEgIc3dqT6Hfz/jof6WT3wBSEr/3tuZcYjjKqL2a8SobZz0SJ2dc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562079691;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=S4JzOCVlUdj5hSK6jCZTRocd8NwDPyCQKzYC5WfufSQ=; 
 b=bKm1bAzDzKEISIpaRVesfffH180fn06Hn2id+MdG+/gAEDyri313TtiLaW4HmJlfvGTYSjOBaTVidoKqIAhk3eW1XRE+U076B7SGCgF2EmzqWfBuk1ZcsKeQV+UQvBmPYyP4DcWB91Vgq/FBiy+M2dazmeU8XxAd+9BfOlGajPY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562079689925223.00783116594903;
 Tue, 2 Jul 2019 08:01:29 -0700 (PDT)
Message-ID: <156207968837.14342.12037455571447779508@c4a48874b076>
In-Reply-To: <20190702121106.28374-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: slp@redhat.com
Date: Tue, 2 Jul 2019 08:01:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: ehabkost@redhat.com, slp@redhat.com, maran.wilson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMjEyMTEwNi4yODM3
NC0xLXNscEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MyAwLzRd
IEludHJvZHVjZSB0aGUgbWljcm92bSBtYWNoaW5lIHR5cGUKTWVzc2FnZS1pZDogMjAxOTA3MDIx
MjExMDYuMjgzNzQtMS1zbHBAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1
cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MDcwMjExMzQxNC42ODk2LTEtYXJtYnJ1QHJlZGhhdC5j
b20gLT4gcGF0Y2hldy8yMDE5MDcwMjExMzQxNC42ODk2LTEtYXJtYnJ1QHJlZGhhdC5jb20KU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo4ZWJlNTQwIGh3L2kzODY6IEludHJvZHVjZSB0
aGUgbWljcm92bSBtYWNoaW5lIHR5cGUKYWM3MWMyYSBody9pMzg2OiBGYWN0b3JpemUgUFZIIHJl
bGF0ZWQgZnVuY3Rpb25zCmZhZWNjYmQgaHcvaTM4NjogQWRkIGFuIEludGVsIE1QVGFibGUgZ2Vu
ZXJhdG9yCjc1NDBiOTMgaHcvdmlydGlvOiBGYWN0b3JpemUgdmlydGlvLW1taW8gaGVhZGVycwoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCA3NTQwYjkzNThhMGYgKGh3
L3ZpcnRpbzogRmFjdG9yaXplIHZpcnRpby1tbWlvIGhlYWRlcnMpCldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzY2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywg
MTA1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoy
LzQgQ2hlY2tpbmcgY29tbWl0IGZhZWNjYmQyYzU4OSAoaHcvaTM4NjogQWRkIGFuIEludGVsIE1Q
VGFibGUgZ2VuZXJhdG9yKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNjogCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDM3NCBsaW5lcyBjaGVja2VkCgpQYXRj
aCAyLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMy80IENoZWNraW5nIGNvbW1pdCBhYzcx
YzJhZjM5NzIgKGh3L2kzODY6IEZhY3Rvcml6ZSBQVkggcmVsYXRlZCBmdW5jdGlvbnMpCldBUk5J
Tkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVl
ZCB1cGRhdGluZz8KIzE4NjogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogZG8gbm90IGlu
aXRpYWxpc2Ugc3RhdGljcyB0byAwIG9yIE5VTEwKIzIxMDogRklMRTogaHcvaTM4Ni9wdmguYzoy
MDoKK3N0YXRpYyBzaXplX3QgcHZoX3N0YXJ0X2FkZHIgPSAwOwoKdG90YWw6IDEgZXJyb3JzLCAx
IHdhcm5pbmdzLCAyODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy80IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgo0LzQgQ2hlY2tpbmcgY29tbWl0IDhlYmU1NDBjNDQzMCAoaHcvaTM4NjogSW50
cm9kdWNlIHRoZSBtaWNyb3ZtIG1hY2hpbmUgdHlwZSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9y
IGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjc6IApu
ZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IEVycm9yIG1lc3NhZ2VzIHNob3VsZCBub3QgY29u
dGFpbiBuZXdsaW5lcwojMjkxOiBGSUxFOiBody9pMzg2L21pY3Jvdm0uYzoyMjA6CisgICAgICAg
ICAgICBlcnJvcl9yZXBvcnQoInFlbXU6IGVycm9yIHJlYWRpbmcgaW5pdHJkICVzOiAlc1xuIiwK
CkVSUk9SOiBFcnJvciBtZXNzYWdlcyBzaG91bGQgbm90IGNvbnRhaW4gbmV3bGluZXMKIzI5OTog
RklMRTogaHcvaTM4Ni9taWNyb3ZtLmM6MjI4OgorICAgICAgICAgICAgICAgICAgICAgICAgICIo
bWF4OiAlIlBSSXUzMiIsIG5lZWQgJSJQUklkNjQiKVxuIiwKCnRvdGFsOiAyIGVycm9ycywgMSB3
YXJuaW5ncywgNjUzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTA3MDIxMjExMDYuMjgzNzQtMS1zbHBAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0
Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBh
dGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0
byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


