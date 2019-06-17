Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B650AC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EA15208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EA15208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvMC-00034G-Rc
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hculo-00020j-IU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hculn-0003Y7-9P
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:46:12 -0400
Resent-Date: Mon, 17 Jun 2019 12:46:12 -0400
Resent-Message-Id: <E1hculn-0003Y7-9P@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hculk-0003NH-EO; Mon, 17 Jun 2019 12:46:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560789925; cv=none; d=zoho.com; s=zohoarc; 
 b=BHgaBlKmHRzIeSZeIagHCXEdG8xAcZ8Dc1qMJXa19sJWZlEEfs3beq+gKsZGLpRtEJd9g+jupvk5xy73eW4oPSCJlLE7EofSeAfqK8H1iGdNbaQ+xl2//p+6QF+Yp950IWQYY1tLvJETXHRfMcigJVo1l5uge4ZFh3irFYGNJbQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560789925;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=k2T1QyuC1Pp+HHCVRxYTb8cfLIDM3g9/yyq1kW6tPc0=; 
 b=SyRp/bO0F4N602ClWRZub76bC8Scc1VzW/sBwCbNc3Setw87Ix05FfYWSxO6HZU3cAol1D+sCFtEn0pRplzCDFwC8z6XAQWg7i3Vsa2pN4x5za4KgLrqLVakgjYDPVnW9UpO1Qxlp/FWFySrSb/43eyyTJTRJN3RPetH/8zhN+M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560789923529457.1588512216298;
 Mon, 17 Jun 2019 09:45:23 -0700 (PDT)
In-Reply-To: <20190617150950.5264-1-shmuel.eiderman@oracle.com>
Message-ID: <156078992210.13573.8051164878994897371@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shmuel.eiderman@oracle.com
Date: Mon, 17 Jun 2019 09:45:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [SeaBIOS] [QEMU] [PATCH v3 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, arbel.moshe@oracle.com,
 seabios@seabios.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kevin@koconnor.net, kraxel@redhat.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNzE1MDk1MC41MjY0
LTEtc2htdWVsLmVpZGVybWFuQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNjE3MTUwOTUwLjUyNjQtMS1zaG11
ZWwuZWlkZXJtYW5Ab3JhY2xlLmNvbQpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1NlYUJJT1NdIFtR
RU1VXSBbUEFUQ0ggdjMgMC84XSBBZGQgUWVtdSB0byBTZWFCSU9TIExDSFMgaW50ZXJmYWNlCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+
IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQg
MApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxi
YWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5j
b20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgNWQwZTU2OS4uMDc2MjQzZiAgbWFzdGVyICAgICAt
PiBtYXN0ZXIKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDYxNzE1MDk1MC41MjY0LTEtc2htdWVsLmVp
ZGVybWFuQG9yYWNsZS5jb20gLT4gcGF0Y2hldy8yMDE5MDYxNzE1MDk1MC41MjY0LTEtc2htdWVs
LmVpZGVybWFuQG9yYWNsZS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpmZDEw
OGNkIGhkLWdlby10ZXN0OiBBZGQgdGVzdHMgZm9yIGxjaHMgb3ZlcnJpZGUKNDg5MjRiNCBib290
ZGV2aWNlOiBGV19DRkcgaW50ZXJmYWNlIGZvciBMQ0hTIHZhbHVlcwphNWQ5YzA1IGJvb3RkZXZp
Y2U6IFJlZmFjdG9yIGdldF9ib290X2RldmljZXNfbGlzdAo0YmJkOGIzIGJvb3RkZXZpY2U6IEdh
dGhlciBMQ0hTIGZyb20gYWxsIHJlbGV2YW50IGRldmljZXMKMGMxYTExNiBzY3NpOiBQcm9wYWdh
dGUgdW5yZWFsaXplKCkgY2FsbGJhY2sgdG8gc2NzaS1oZAplNjdjYzY1IGJvb3RkZXZpY2U6IEFk
ZCBpbnRlcmZhY2UgdG8gZ2F0aGVyIExDSFMKNGVlNDVlMSBibG9jazogU3VwcG9ydCBwcm92aWRp
bmcgTENIUyBmcm9tIHVzZXIKMjBjOTU3MCBibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4IHRh
YmJpbmcKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgMjBjOTU3MGM1
MzNkIChibG9jazogUmVmYWN0b3IgbWFjcm9zIC0gZml4IHRhYmJpbmcpCkVSUk9SOiBNYWNyb3Mg
d2l0aCBjb21wbGV4IHZhbHVlcyBzaG91bGQgYmUgZW5jbG9zZWQgaW4gcGFyZW50aGVzaXMKIzU1
OiBGSUxFOiBpbmNsdWRlL2h3L2Jsb2NrL2Jsb2NrLmg6NjU6CisjZGVmaW5lIERFRklORV9CTE9D
S19DSFNfUFJPUEVSVElFUyhfc3RhdGUsIF9jb25mKSAgICAgICAgICAgICAgICAgICAgICBcCisg
ICAgREVGSU5FX1BST1BfVUlOVDMyKCJjeWxzIiwgX3N0YXRlLCBfY29uZi5jeWxzLCAwKSwgICAg
ICAgICAgICAgICAgICBcCisgICAgREVGSU5FX1BST1BfVUlOVDMyKCJoZWFkcyIsIF9zdGF0ZSwg
X2NvbmYuaGVhZHMsIDApLCAgICAgICAgICAgICAgICBcCiAgICAgREVGSU5FX1BST1BfVUlOVDMy
KCJzZWNzIiwgX3N0YXRlLCBfY29uZi5zZWNzLCAwKQoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAzNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjIvOCBDaGVja2luZyBjb21taXQgNGVlNDVlMWFiYTIzIChibG9jazogU3VwcG9ydCBwcm92
aWRpbmcgTENIUyBmcm9tIHVzZXIpCjMvOCBDaGVja2luZyBjb21taXQgZTY3Y2M2NWU1ZTQyIChi
b290ZGV2aWNlOiBBZGQgaW50ZXJmYWNlIHRvIGdhdGhlciBMQ0hTKQo0LzggQ2hlY2tpbmcgY29t
bWl0IDBjMWExMTZjMTJiOCAoc2NzaTogUHJvcGFnYXRlIHVucmVhbGl6ZSgpIGNhbGxiYWNrIHRv
IHNjc2ktaGQpCjUvOCBDaGVja2luZyBjb21taXQgNGJiZDhiM2Y5OWM3IChib290ZGV2aWNlOiBH
YXRoZXIgTENIUyBmcm9tIGFsbCByZWxldmFudCBkZXZpY2VzKQo2LzggQ2hlY2tpbmcgY29tbWl0
IGE1ZDljMDVkZmE3OCAoYm9vdGRldmljZTogUmVmYWN0b3IgZ2V0X2Jvb3RfZGV2aWNlc19saXN0
KQo3LzggQ2hlY2tpbmcgY29tbWl0IDQ4OTI0YjQyZmM3OSAoYm9vdGRldmljZTogRldfQ0ZHIGlu
dGVyZmFjZSBmb3IgTENIUyB2YWx1ZXMpCjgvOCBDaGVja2luZyBjb21taXQgZmQxMDhjZGE0OTgx
IChoZC1nZW8tdGVzdDogQWRkIHRlc3RzIGZvciBsY2hzIG92ZXJyaWRlKQpXQVJOSU5HOiBCbG9j
ayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjI1OiBGSUxF
OiB0ZXN0cy9oZC1nZW8tdGVzdC5jOjk4MDoKKyAgICAgICAgICAgICAgICAgICAgICAgInNraXBw
aW5nIGhkLWdlby9vdmVycmlkZS8qIHRlc3RzIik7Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fybmlu
Z3MsIDU5MyBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTA2MTcxNTA5NTAuNTI2NC0xLXNobXVlbC5laWRlcm1hbkBvcmFjbGUuY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


