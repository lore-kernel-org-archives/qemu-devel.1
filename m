Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EB5ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A632084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A632084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0gx-0004Uu-Ks
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJ0ex-0002tX-1v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJ0et-0003hv-J5
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:33:06 -0400
Resent-Date: Fri, 11 Oct 2019 15:33:05 -0400
Resent-Message-Id: <E1iJ0et-0003hv-J5@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJ0et-0003hR-A9; Fri, 11 Oct 2019 15:33:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570822377; cv=none; d=zoho.com; s=zohoarc; 
 b=Wr/qBPevzIID87lpKrk3ETGxDHiWOJx3tGyfCcpl+dl5MHQk9zAd7tEqyH3ZlJT+7xXZZN1f8TcoOYe4XcUZUBQltDbl+gBhgPVqqIUS2DXjY2Mo5/VHhwJu9lNcaNqZd77DqLX1k2E/btavXZiDHmtIz/iiRwr8DvkCglhyX3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570822377;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+ckdu9i5fjrutFWH8kYUSzo2pkdooeJ98ShcglCvxuY=; 
 b=Kcxw1VxZvg2XGYIAfe5SXOiCzYiTPRjrYtx10+Pp5LwuM6YHRywgCCTTl684OmguVxTUOEkojY7NV/+TRSmm9Ka7lmRVIAag9QvfixftF9eJ92Nx7jmIIeMZtY9yoB9X3SWsIapsgXoY1trl0UZ+yyysMY0p9v5IVD/1+IqUwJs=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570822376550662.2415606120051;
 Fri, 11 Oct 2019 12:32:56 -0700 (PDT)
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v5 00/22] target/arm: Implement ARMv8.5-MemTag, system mode
Message-ID: <157082237544.16828.11052040794310930880@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 11 Oct 2019 12:32:56 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMTEzNDc0NC4yNDc3
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY1IDAwLzIyXSB0YXJnZXQvYXJt
OiBJbXBsZW1lbnQgQVJNdjguNS1NZW1UYWcsIHN5c3RlbSBtb2RlClR5cGU6IHNlcmllcwpNZXNz
YWdlLWlkOiAyMDE5MTAxMTEzNDc0NC4yNDc3LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
ZwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJh
c2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxp
bWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1t
YWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3
IGJyYW5jaCAndGVzdCcKMmNiNGFjNiB0YXJnZXQvYXJtOiBBZGQgYWxsb2NhdGlvbiB0YWcgc3Rv
cmFnZSBmb3Igc3lzdGVtIG1vZGUKMDRjOTFiNCB0YXJnZXQvYXJtOiBBZGQgbW11IGluZGV4ZXMg
Zm9yIHRhZyBtZW1vcnkKMWUwZmY5ZCB0YXJnZXQvYXJtOiBDcmVhdGUgdGFnZ2VkIHJhbSB3aGVu
IE1URSBpcyBlbmFibGVkCmI3NTFmYzQgdGFyZ2V0L2FybTogQ2FjaGUgdGhlIFRhZ2dlZCBiaXQg
Zm9yIGEgcGFnZSBpbiBNZW1UeEF0dHJzCjlhYzYwZmQgdGFyZ2V0L2FybTogRW5hYmxlIE1URQo1
MTNiNDI5IHRhcmdldC9hcm06IFNldCBQU1RBVEUuVENPIG9uIGV4Y2VwdGlvbiBlbnRyeQpiMzRm
YWUzIHRhcmdldC9hcm06IEltcGxlbWVudCBkYXRhIGNhY2hlIHNldCBhbGxvY2F0aW9uIHRhZ3MK
ZTgyMTM3OSB0YXJnZXQvYXJtOiBDbGVhbiBhZGRyZXNzIGZvciBEQyBaVkEKYWZmOTBlMSB0YXJn
ZXQvYXJtOiBJbXBsZW1lbnQgdGhlIGFjY2VzcyB0YWcgY2FjaGUgZmx1c2hlcwowY2FlZTJiIHRh
cmdldC9hcm06IEltcGxlbWVudCB0aGUgTERHTSBhbmQgU1RHTSBpbnN0cnVjdGlvbnMKMmI0YTU3
NiB0YXJnZXQvYXJtOiBJbXBsZW1lbnQgdGhlIFNUR1AgaW5zdHJ1Y3Rpb24KOGRjNGFlMiB0YXJn
ZXQvYXJtOiBJbXBsZW1lbnQgTERHLCBTVEcsIFNUMkcgaW5zdHJ1Y3Rpb25zCjJmNGE5ODQgdGFy
Z2V0L2FybTogRGVmaW5lIGFybV9jcHVfZG9fdW5hbGlnbmVkX2FjY2VzcyBmb3IgQ09ORklHX1VT
RVJfT05MWQozYWYwYTU3IHRhcmdldC9hcm06IEltcGxlbWVudCB0aGUgU1VCUCBpbnN0cnVjdGlv
bgpiMjZiOWIwIHRhcmdldC9hcm06IEltcGxlbWVudCB0aGUgR01JIGluc3RydWN0aW9uCjgzNzQ0
ZjMgdGFyZ2V0L2FybTogSW1wbGVtZW50IEFEREcsIFNVQkcgaW5zdHJ1Y3Rpb25zCjQ1NDgxMWQg
dGFyZ2V0L2FybTogSW1wbGVtZW50IHRoZSBJUkcgaW5zdHJ1Y3Rpb24KMzU3MGExNSB0YXJnZXQv
YXJtOiBTdXBwcmVzcyB0YWcgY2hlY2sgZm9yIHNwK29mZnNldAoxNDA5ZmE0IHRhcmdldC9hcm06
IEFkZCBoZWxwZXJfbXRlX2NoZWNrezEsMiwzfQpiYmJkMTJkIHRhcmdldC9hcm06IEFkZCBNVEUg
c3lzdGVtIHJlZ2lzdGVycwpiYWMxYjc0IHRhcmdldC9hcm06IEFkZCByZWdpbWVfaGFzXzJfcmFu
Z2VzCjQ5OGVkYTAgdGFyZ2V0L2FybTogQWRkIE1URV9BQ1RJVkUgdG8gdGJfZmxhZ3MKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMjIgQ2hlY2tpbmcgY29tbWl0IDQ5OGVkYTA2MDM4YiAodGFyZ2V0
L2FybTogQWRkIE1URV9BQ1RJVkUgdG8gdGJfZmxhZ3MpCkVSUk9SOiBzcGFjZXMgcHJvaGliaXRl
ZCBhcm91bmQgdGhhdCAnOicgKGN0eDpXeFcpCiMyMTQ6IEZJTEU6IHRhcmdldC9hcm0vaW50ZXJu
YWxzLmg6OTg2OgorICAgIGJvb2wgdGNtYSAgICAgICA6IDE7CiAgICAgICAgICAgICAgICAgICAg
IF4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjEzIGxpbmVzIGNoZWNrZWQKClBhdGNo
IDEvMjIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMjIgQ2hlY2tpbmcgY29tbWl0IGJh
YzFiNzRmOGVlOSAodGFyZ2V0L2FybTogQWRkIHJlZ2ltZV9oYXNfMl9yYW5nZXMpCjMvMjIgQ2hl
Y2tpbmcgY29tbWl0IGJiYmQxMmQwNjQ3OSAodGFyZ2V0L2FybTogQWRkIE1URSBzeXN0ZW0gcmVn
aXN0ZXJzKQo0LzIyIENoZWNraW5nIGNvbW1pdCAxNDA5ZmE0OTU0Y2EgKHRhcmdldC9hcm06IEFk
ZCBoZWxwZXJfbXRlX2NoZWNrezEsMiwzfSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0
ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzk6IApuZXcgZmls
ZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxOTkgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggNC8yMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo1LzIyIENoZWNraW5n
IGNvbW1pdCAzNTcwYTE1OGZlOGEgKHRhcmdldC9hcm06IFN1cHByZXNzIHRhZyBjaGVjayBmb3Ig
c3Arb2Zmc2V0KQo2LzIyIENoZWNraW5nIGNvbW1pdCA0NTQ4MTFkNWZiZWUgKHRhcmdldC9hcm06
IEltcGxlbWVudCB0aGUgSVJHIGluc3RydWN0aW9uKQo3LzIyIENoZWNraW5nIGNvbW1pdCA4Mzc0
NGYzZWZmYmYgKHRhcmdldC9hcm06IEltcGxlbWVudCBBRERHLCBTVUJHIGluc3RydWN0aW9ucykK
OC8yMiBDaGVja2luZyBjb21taXQgYjI2YjliMGZmOTBkICh0YXJnZXQvYXJtOiBJbXBsZW1lbnQg
dGhlIEdNSSBpbnN0cnVjdGlvbikKOS8yMiBDaGVja2luZyBjb21taXQgM2FmMGE1NzU3MzI4ICh0
YXJnZXQvYXJtOiBJbXBsZW1lbnQgdGhlIFNVQlAgaW5zdHJ1Y3Rpb24pCjEwLzIyIENoZWNraW5n
IGNvbW1pdCAyZjRhOTg0NDYzMzEgKHRhcmdldC9hcm06IERlZmluZSBhcm1fY3B1X2RvX3VuYWxp
Z25lZF9hY2Nlc3MgZm9yIENPTkZJR19VU0VSX09OTFkpCjExLzIyIENoZWNraW5nIGNvbW1pdCA4
ZGM0YWUyZTA4MGQgKHRhcmdldC9hcm06IEltcGxlbWVudCBMREcsIFNURywgU1QyRyBpbnN0cnVj
dGlvbnMpCjEyLzIyIENoZWNraW5nIGNvbW1pdCAyYjRhNTc2OTI4YTYgKHRhcmdldC9hcm06IElt
cGxlbWVudCB0aGUgU1RHUCBpbnN0cnVjdGlvbikKMTMvMjIgQ2hlY2tpbmcgY29tbWl0IDBjYWVl
MmIxOTcyOCAodGFyZ2V0L2FybTogSW1wbGVtZW50IHRoZSBMREdNIGFuZCBTVEdNIGluc3RydWN0
aW9ucykKMTQvMjIgQ2hlY2tpbmcgY29tbWl0IGFmZjkwZTFhYzg4NyAodGFyZ2V0L2FybTogSW1w
bGVtZW50IHRoZSBhY2Nlc3MgdGFnIGNhY2hlIGZsdXNoZXMpCjE1LzIyIENoZWNraW5nIGNvbW1p
dCBlODIxMzc5OTk1NjcgKHRhcmdldC9hcm06IENsZWFuIGFkZHJlc3MgZm9yIERDIFpWQSkKMTYv
MjIgQ2hlY2tpbmcgY29tbWl0IGIzNGZhZTM2YTUyMyAodGFyZ2V0L2FybTogSW1wbGVtZW50IGRh
dGEgY2FjaGUgc2V0IGFsbG9jYXRpb24gdGFncykKMTcvMjIgQ2hlY2tpbmcgY29tbWl0IDUxM2I0
MjkxNGI0ZiAodGFyZ2V0L2FybTogU2V0IFBTVEFURS5UQ08gb24gZXhjZXB0aW9uIGVudHJ5KQox
OC8yMiBDaGVja2luZyBjb21taXQgOWFjNjBmZDcyMjJkICh0YXJnZXQvYXJtOiBFbmFibGUgTVRF
KQoxOS8yMiBDaGVja2luZyBjb21taXQgYjc1MWZjNDQxNWZlICh0YXJnZXQvYXJtOiBDYWNoZSB0
aGUgVGFnZ2VkIGJpdCBmb3IgYSBwYWdlIGluIE1lbVR4QXR0cnMpCjIwLzIyIENoZWNraW5nIGNv
bW1pdCAxZTBmZjlkYWEyNGQgKHRhcmdldC9hcm06IENyZWF0ZSB0YWdnZWQgcmFtIHdoZW4gTVRF
IGlzIGVuYWJsZWQpCjIxLzIyIENoZWNraW5nIGNvbW1pdCAwNGM5MWI0Y2ZlMTggKHRhcmdldC9h
cm06IEFkZCBtbXUgaW5kZXhlcyBmb3IgdGFnIG1lbW9yeSkKMjIvMjIgQ2hlY2tpbmcgY29tbWl0
IDJjYjRhYzYzOGE3NyAodGFyZ2V0L2FybTogQWRkIGFsbG9jYXRpb24gdGFnIHN0b3JhZ2UgZm9y
IHN5c3RlbSBtb2RlKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MTAxMTEzNDc0NC4yNDc3LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
Zy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


