Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEA8C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DCA82073A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCA82073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8sx-0002Ls-KG
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kS8pA-0006yS-Gt; Mon, 12 Oct 2020 21:09:56 -0400
Resent-Date: Mon, 12 Oct 2020 21:09:56 -0400
Resent-Message-Id: <E1kS8pA-0006yS-Gt@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kS8p8-0001E3-1W; Mon, 12 Oct 2020 21:09:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602551384; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GVhUGxueUwtRT6ROUK7scVnl/oSYgEoGEGreM1ZZkWYHae0l8t9NixBwA1FQImA38anhpY8q68zLXeAA22M4OuRyd+UxFQmjSuGMW55Tqc/hBERQ4wsBXARwirEVqV6eFdy1fFhmpgYr7x73qGM5lysYK5LOkrCSBVwA3G1qmuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602551384;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yDGS2TFzl7+fRSQXBV+nM+Pzv8gwWxs3l9aOUSxwjnQ=; 
 b=hxzjhEqHkG8QrqeElaEWBj0HelEu2IcoWR0H+Vb3bu0BKirXlYD7M1/LyxvTE5ciWe315Ky3FeRKnnLLnncvPDZ63o2GBpw+Kfem43k0eArwLw/Osrsjz6JfOMKmEQAJUB0HajawJre0w+2yEVkyofR2PyBrH18mqcHv2xyvGH8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602551382926323.4279109242839;
 Mon, 12 Oct 2020 18:09:42 -0700 (PDT)
Subject: Re: [PATCH] hw/core/qdev-properties: Fix pci bus range in
 set_pci_host_devaddr()
Message-ID: <160255138139.18344.1015598257686866587@66eaa9a8a123>
In-Reply-To: <20201012225831.72920-1-kherman@inbox.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kherman@inbox.lv
Date: Mon, 12 Oct 2020 18:09:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 21:09:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, kherman@inbox.lv, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAxMjIyNTgzMS43Mjky
MC0xLWtoZXJtYW5AaW5ib3gubHYvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAxMjIyNTgzMS43MjkyMC0x
LWtoZXJtYW5AaW5ib3gubHYKU3ViamVjdDogW1BBVENIXSBody9jb3JlL3FkZXYtcHJvcGVydGll
czogRml4IHBjaSBidXMgcmFuZ2UgaW4gc2V0X3BjaV9ob3N0X2RldmFkZHIoKQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0
ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9q
ZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTAxMjEyNDUwNi4zNDA2
OTA5LTEtcGhpbG1kQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMTAxMjEyNDUwNi4zNDA2OTA5
LTEtcGhpbG1kQHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTAx
MjIyNTgzMS43MjkyMC0xLWtoZXJtYW5AaW5ib3gubHYgLT4gcGF0Y2hldy8yMDIwMTAxMjIyNTgz
MS43MjkyMC0xLWtoZXJtYW5AaW5ib3gubHYKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0
JwoyYjg4ZjBjIGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzOiBGaXggcGNpIGJ1cyByYW5nZSBpbiBz
ZXRfcGNpX2hvc3RfZGV2YWRkcigpCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogTWlzc2lu
ZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDgg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IDJiODhmMGM0MWMwNyAoaHcvY29yZS9xZGV2LXByb3BlcnRp
ZXM6IEZpeCBwY2kgYnVzIHJhbmdlIGluIHNldF9wY2lfaG9zdF9kZXZhZGRyKCkpIGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRl
ZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMjAxMDEyMjI1ODMxLjcyOTIwLTEta2hlcm1hbkBpbmJveC5sdi90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

