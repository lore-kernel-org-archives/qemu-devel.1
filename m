Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603D0C4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389452074D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 09:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389452074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGJlu-0004Bz-EF
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 05:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jGJlI-0003h7-EH
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:52:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jGJlG-0003D8-Og
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 05:52:48 -0400
Resent-Date: Mon, 23 Mar 2020 05:52:48 -0400
Resent-Message-Id: <E1jGJlG-0003D8-Og@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jGJlG-00039g-J7; Mon, 23 Mar 2020 05:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584957149; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EAk7mgztBi4csGhFR99rqrzX1aAgXQ1VU+jQ/+m6t7xZZAhttwzzglnNXpIjiK1VceJVEgbwt5pTbIsM14T2ZNl9WiXTxBH5jteReuHgF0HD8IlrM2KGJIcgKnUJp6QI6kxiV5hqv4nzJhGRIPX/HyHTJEDKkvMJ35G2pdEmUJg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584957149;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=YXGPmcUBSpgv5n/wzzAihEWlqexpi6/37601B4Xw/2A=; 
 b=RUPGuXY5q3vnfHcQw8klGhTHwhM4FkIPS2k6Jp8A6tgQVp0N4j9+QZEnjhTpVctnysZVs97ls9deSCh9avxCnrLPKuc3CkNIqC7stYmhgahPs3cLxsHbZE/OCtdWK9qtvBCgqOGydlG4496y35UrfUxSfaSZW9sH+2wnwGOkUtc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584957147905366.51560484912125;
 Mon, 23 Mar 2020 02:52:27 -0700 (PDT)
In-Reply-To: <20200323084617.1782-1-bbhushan2@marvell.com>
Subject: Re: [PATCH v9 0/9] virtio-iommu: VFIO integration
Message-ID: <158495714567.4794.13061570154282709223@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bbhushan2@marvell.com
Date: Mon, 23 Mar 2020 02:52:27 -0700 (PDT)
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, kevin.tian@intel.com,
 tnowicki@marvell.com, mst@redhat.com, drjones@redhat.com, peterx@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org,
 bharatb.linux@gmail.com, jean-philippe@linaro.org, linuc.decode@gmail.com,
 bbhushan2@marvell.com, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyMzA4NDYxNy4xNzgy
LTEtYmJodXNoYW4yQG1hcnZlbGwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjkgMC85XSB2aXJ0aW8taW9tbXU6IFZGSU8g
aW50ZWdyYXRpb24KTWVzc2FnZS1pZDogMjAyMDAzMjMwODQ2MTcuMTc4Mi0xLWJiaHVzaGFuMkBt
YXJ2ZWxsLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZy
b20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIDliMjZhNjEuLjI5
ZTA4NTUgIG1hc3RlciAgICAgLT4gbWFzdGVyCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcv
MjAyMDAzMjAxNjA2MjIuODA0MC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcgLT4gcGF0
Y2hldy8yMDIwMDMyMDE2MDYyMi44MDQwLTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjhlZWI2MGMgdmlydGlvLWlvbW11OiBhZGQg
aW9tbXUgbm90aWZpZXIgbWVtb3J5LXJlZ2lvbgoxNzZlMDgzIHZpcnRpby1pb21tdTogSW1wbGVt
ZW50IHByb2JlIHJlcXVlc3QKMjIxZjRiYSB2aXJ0aW8taW9tbXU6IGFkZCBpb21tdSByZXBsYXkK
MzAyMTFmZCB2aXJ0aW8taW9tbXU6IENhbGwgaW9tbXUgbm90aWZpZXIgZm9yIGF0dGFjaC9kZXRh
Y2gKODRmMzE2ZCB2aXJ0aW8taW9tbXU6IEFkZCBpb21tdSBub3RpZmllciBmb3IgbWFwL3VubWFw
CjhjYzU1OWYgdmlydGlvLWlvbW11OiBzZXQgc3VwcG9ydGVkIHBhZ2Ugc2l6ZSBtYXNrCmQ0MDYy
YTkgdmZpbzogc2V0IGlvbW11IHBhZ2Ugc2l6ZSBhcyBwZXIgaG9zdCBzdXBwb3J0ZWQgcGFnZSBz
aXplCmNjOTMxMGYgbWVtb3J5OiBBZGQgaW50ZXJmYWNlIHRvIHNldCBpb21tdSBwYWdlIHNpemUg
bWFzawoyYjQzNTU1IGh3L3ZmaW8vY29tbW9uOiBSZW1vdmUgZXJyb3IgcHJpbnQgb24gbW1pbyBy
ZWdpb24gdHJhbnNsYXRpb24gYnkgdmlvbW11Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzkgQ2hl
Y2tpbmcgY29tbWl0IDJiNDM1NTVhMmY2MiAoaHcvdmZpby9jb21tb246IFJlbW92ZSBlcnJvciBw
cmludCBvbiBtbWlvIHJlZ2lvbiB0cmFuc2xhdGlvbiBieSB2aW9tbXUpCjIvOSBDaGVja2luZyBj
b21taXQgY2M5MzEwZjMyZDA2IChtZW1vcnk6IEFkZCBpbnRlcmZhY2UgdG8gc2V0IGlvbW11IHBh
Z2Ugc2l6ZSBtYXNrKQozLzkgQ2hlY2tpbmcgY29tbWl0IGQ0MDYyYTk1M2NlZiAodmZpbzogc2V0
IGlvbW11IHBhZ2Ugc2l6ZSBhcyBwZXIgaG9zdCBzdXBwb3J0ZWQgcGFnZSBzaXplKQo0LzkgQ2hl
Y2tpbmcgY29tbWl0IDhjYzU1OWYwMjVhZSAodmlydGlvLWlvbW11OiBzZXQgc3VwcG9ydGVkIHBh
Z2Ugc2l6ZSBtYXNrKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDg0ZjMxNmQ2ODQyOSAodmlydGlvLWlv
bW11OiBBZGQgaW9tbXUgbm90aWZpZXIgZm9yIG1hcC91bm1hcCkKNi85IENoZWNraW5nIGNvbW1p
dCAzMDIxMWZkYjM2Y2QgKHZpcnRpby1pb21tdTogQ2FsbCBpb21tdSBub3RpZmllciBmb3IgYXR0
YWNoL2RldGFjaCkKNy85IENoZWNraW5nIGNvbW1pdCAyMjFmNGJhMGQxMjUgKHZpcnRpby1pb21t
dTogYWRkIGlvbW11IHJlcGxheSkKOC85IENoZWNraW5nIGNvbW1pdCAxNzZlMDgzNGJjZWUgKHZp
cnRpby1pb21tdTogSW1wbGVtZW50IHByb2JlIHJlcXVlc3QpCkVSUk9SOiBjb2RlIGluZGVudCBz
aG91bGQgbmV2ZXIgdXNlIHRhYnMKIzkzOiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWlvbW11LmM6
NTM5OgorXkl9JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTIy
OiBGSUxFOiBody92aXJ0aW8vdmlydGlvLWlvbW11LmM6NTY4OgorXklicmVhazskCgp0b3RhbDog
MiBlcnJvcnMsIDAgd2FybmluZ3MsIDI1MCBsaW5lcyBjaGVja2VkCgpQYXRjaCA4LzkgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCjkvOSBDaGVja2luZyBjb21taXQgOGVlYjYwYzEyYWNlICh2
aXJ0aW8taW9tbXU6IGFkZCBpb21tdSBub3RpZmllciBtZW1vcnktcmVnaW9uKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMyMzA4NDYxNy4x
NzgyLTEtYmJodXNoYW4yQG1hcnZlbGwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

