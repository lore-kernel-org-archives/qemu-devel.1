Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE3FC4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985E32371F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985E32371F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKpvi-0002Dz-MC
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKpYx-0005hZ-Qt; Tue, 22 Sep 2020 17:10:59 -0400
Resent-Date: Tue, 22 Sep 2020 17:10:59 -0400
Resent-Message-Id: <E1kKpYx-0005hZ-Qt@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kKpYv-0005ma-7H; Tue, 22 Sep 2020 17:10:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600809038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MMAJ2GOqo+IfSsDMiptCurjliTIZze6igdP9iHtximsaHAX5sv9OAHcNPItVts3AP2ARhkeipRnEWtOgko0nCrmsBfUx8T8x9iT8I4gWhL/C8T06P81lTixU+8BsiQpWBE0m3HFwpr0c+edij1WGMLM2Y/l/6UdT+ihk5Av5CJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600809038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NIxmDzwFWBQDSPRZSd4HeNTzVEzr5SrUxJFc1WikTb8=; 
 b=Qis0GUXmahucFvrQ6kz8Io5yVXAqK3/3p+NjdVegwrZNl4dzlsnl9oZusF+bmGwY3sVqipoaMUz6nlaMCzewadCC1UrVN1WX9lK60xsIRM2oCowpfv419QupBFdUuYoBqbT81za2Vjqj50b2OIjBy2xKhjdppNzcVbzAs8R52/0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160080903753299.33392506457972;
 Tue, 22 Sep 2020 14:10:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
Message-ID: <160080903566.7431.16479285468818631518@66eaa9a8a123>
In-Reply-To: <20200922161611.2049616-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Tue, 22 Sep 2020 14:10:37 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 17:10:52
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
Cc: kwolf@redhat.com, thuth@redhat.com, sheepdog@lists.wpkg.org,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, namei.unix@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMjE2MTYxMS4yMDQ5
NjE2LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwOTIyMTYxNjExLjIw
NDk2MTYtMS1iZXJyYW5nZUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzJdIGJsb2Nr
OiBkZXByZWNhdGUgdGhlIHNoZWVwZG9nIGRyaXZlcgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMmMxMTYzNSBibG9j
azogZGVwcmVjYXRlIHRoZSBzaGVlcGRvZyBibG9jayBkcml2ZXIKYWEzZDU0YyBibG9jazogZHJv
cCBtb2RlcmF0ZWQgc2hlZXBkb2cgbWFpbGluZyBsaXN0IGZyb20gTUFJTlRBSU5FUlMgZmlsZQoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCBhYTNkNTRjZmEyOGYgKGJs
b2NrOiBkcm9wIG1vZGVyYXRlZCBzaGVlcGRvZyBtYWlsaW5nIGxpc3QgZnJvbSBNQUlOVEFJTkVS
UyBmaWxlKQoyLzIgQ2hlY2tpbmcgY29tbWl0IDJjMTE2MzU1ODU3OSAoYmxvY2s6IGRlcHJlY2F0
ZSB0aGUgc2hlZXBkb2cgYmxvY2sgZHJpdmVyKQpFUlJPUjogZG8gbm90IGluaXRpYWxpc2Ugc3Rh
dGljcyB0byAwIG9yIE5VTEwKIzU0OiBGSUxFOiBibG9jay9zaGVlcGRvZy5jOjI0NzoKKyAgICBz
dGF0aWMgYm9vbCB3YXJuZWQgPSBmYWxzZTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
NzEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDky
MjE2MTYxMS4yMDQ5NjE2LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

