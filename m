Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE52C4363C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8716723A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 21:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8716723A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKTX2-00089V-DZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 17:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKTVr-0007V6-DC; Mon, 21 Sep 2020 17:38:19 -0400
Resent-Date: Mon, 21 Sep 2020 17:38:19 -0400
Resent-Message-Id: <E1kKTVr-0007V6-DC@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKTVo-0005u3-Rp; Mon, 21 Sep 2020 17:38:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600724284; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pngb46SO/BQJXWDfnyNrdu2rYdt44M5yBDnM62WxgehBDfddnpw9BOweGqzrjv3VVcJw9z1iV6Ru1EA/XgctiGl7d0Vvxjx0/V2DPcOfGZXKwSCPhLzFaxwUX/CL4fp58CLhOqJ5kKmy2hc9HwrypZif18G24gsWvGCIZt3CjOo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600724284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6n4qahukW+elT1QPo6yTdztSK+Qa8GNrhU9qAzskCdI=; 
 b=Q2WFpHOAt/xxqcyidWqzeA4fAFICe4bWPBFU+SdwPMlCd0ndmDDe9fxIb5Dkw0fl6ipYbxTj5hI6hexII1nTMwQvZWEvBv2qXFFYV/jbqGbO6iKxAya6BK6cDb1bUsJeNfeDrFeqsl4v7otTBefhkM1DUEPE3wm7qGoYMa45LH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600724283037315.22808888137035;
 Mon, 21 Sep 2020 14:38:03 -0700 (PDT)
Subject: Re: [PATCH 0/6] block/nvme: Map doorbells pages write-only,
 remove magic from nvme_init
Message-ID: <160072428143.23987.9788898676311598209@66eaa9a8a123>
In-Reply-To: <20200921162949.553863-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Mon, 21 Sep 2020 14:38:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:58:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMTE2Mjk0OS41NTM4
NjMtMS1waGlsbWRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTIxMTYyOTQ5LjU1Mzg2
My0xLXBoaWxtZEByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCAwLzZdIGJsb2NrL252bWU6IE1h
cCBkb29yYmVsbHMgcGFnZXMgd3JpdGUtb25seSwgcmVtb3ZlIG1hZ2ljIGZyb20gbnZtZV9pbml0
Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFz
ZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1h
aWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTlj
MjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCmIwZWY4YjcgYmxvY2svbnZtZTogUmVwbGFjZSBtYWdpYyB2YWx1ZSBieSBTQ0FMRV9N
UyBkZWZpbml0aW9uCjE3OTJjNGQgYmxvY2svbnZtZTogVXNlIHJlZ2lzdGVyIGRlZmluaXRpb25z
IGZyb20gJ2Jsb2NrL252bWUuaCcKMzUyYmUwYyBibG9jay9udm1lOiBEcm9wIE5WTWVSZWdzIHN0
cnVjdHVyZSwgZGlyZWN0bHkgdXNlIE52bWVCYXIKN2FhMTg0YSBibG9jay9udm1lOiBSZWR1Y2Ug
SS9PIHJlZ2lzdGVycyBzY29wZQo0YjFlZmZjIGJsb2NrL252bWU6IE1hcCBkb29yYmVsbHMgcGFn
ZXMgd3JpdGUtb25seQo3YWU0NjUzIHV0aWwvdmZpby1oZWxwZXJzOiBQYXNzIHBhZ2UgcHJvdGVj
dGlvbnMgdG8gcWVtdV92ZmlvX3BjaV9tYXBfYmFyKCkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
NiBDaGVja2luZyBjb21taXQgN2FlNDY1MzYzNjlhICh1dGlsL3ZmaW8taGVscGVyczogUGFzcyBw
YWdlIHByb3RlY3Rpb25zIHRvIHFlbXVfdmZpb19wY2lfbWFwX2JhcigpKQoyLzYgQ2hlY2tpbmcg
Y29tbWl0IDRiMWVmZmNmY2QyYiAoYmxvY2svbnZtZTogTWFwIGRvb3JiZWxscyBwYWdlcyB3cml0
ZS1vbmx5KQozLzYgQ2hlY2tpbmcgY29tbWl0IDdhYTE4NGE3NTZkYyAoYmxvY2svbnZtZTogUmVk
dWNlIEkvTyByZWdpc3RlcnMgc2NvcGUpCjQvNiBDaGVja2luZyBjb21taXQgMzUyYmUwYzk3ODY5
IChibG9jay9udm1lOiBEcm9wIE5WTWVSZWdzIHN0cnVjdHVyZSwgZGlyZWN0bHkgdXNlIE52bWVC
YXIpCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNlIGFkZCBh
IGNvbW1lbnQKIzQzOiBGSUxFOiBibG9jay9udm1lLmM6NjkyOgorICAgIHZvbGF0aWxlIE52bWVC
YXIgKnJlZ3M7Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDYyIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDQvNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS82IENoZWNraW5nIGNvbW1p
dCAxNzkyYzRkYTRiYzIgKGJsb2NrL252bWU6IFVzZSByZWdpc3RlciBkZWZpbml0aW9ucyBmcm9t
ICdibG9jay9udm1lLmgnKQo2LzYgQ2hlY2tpbmcgY29tbWl0IGIwZWY4Yjc3NmViMSAoYmxvY2sv
bnZtZTogUmVwbGFjZSBtYWdpYyB2YWx1ZSBieSBTQ0FMRV9NUyBkZWZpbml0aW9uKQo9PT0gT1VU
UFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyMTE2Mjk0
OS41NTM4NjMtMS1waGlsbWRAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

