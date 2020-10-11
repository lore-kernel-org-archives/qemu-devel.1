Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3E9C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F176208C7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 13:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F176208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRbqb-0004WY-Qa
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 09:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRbjD-0005mk-Tk; Sun, 11 Oct 2020 09:49:35 -0400
Resent-Date: Sun, 11 Oct 2020 09:49:35 -0400
Resent-Message-Id: <E1kRbjD-0005mk-Tk@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRbj4-0001EH-9k; Sun, 11 Oct 2020 09:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602424143; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bC4ogrAPQoQamZHX+aE1NaysSBMRYa5Ey2xnCuaeQEOV/jiPB0+tBwLgHVyAnJtS26/bCDXvBnTuMgqa8OdE2sHnraDZFic/jxdgN/hUrzCez+lvDV7b9jqMnGkWPQYLbvnhERViajQ+1JmNRriZW2siXQuZ5efePqVRJah9Xlk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602424143;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=3L6gL9BE0/+SUMKCbxbueDjgQkt3FlzcZigRLiwbG5w=; 
 b=apmuWIZy5Is3/AmOoluhrLqV2c0yLf4FkhhXzVG4ZFe67g3SuoQQKJ6VjQT1PfG9NbD1zsNMDOddDt8sGGwm85RODi40K5ddqMfZHcwJHFQTELuai4g7ByEIn09d672B5pqKg31RFE6+qL2WhY6zkriK7d6F4lT4mjrtfjBfSaw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602424140307375.7965624433118;
 Sun, 11 Oct 2020 06:49:00 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] Fix some style problems in migration
Message-ID: <160242413872.18344.10233485778459424361@66eaa9a8a123>
In-Reply-To: <1602411429-12043-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yubihong@huawei.com
Date: Sun, 11 Oct 2020 06:49:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 09:49:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAyNDExNDI5LTEyMDQzLTEt
Z2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE2MDI0MTE0
MjktMTIwNDMtMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN1YmplY3Q6IFtQ
QVRDSCB2MSAwLzhdIEZpeCBzb21lIHN0eWxlIHByb2JsZW1zIGluIG1pZ3JhdGlvbgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICAgNGE3YzBiZC4uYjQzM2YyYyAgbWFzdGVyICAgICAtPiBtYXN0ZXIKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNjAyNDExNDI5LTEyMDQzLTEtZ2l0LXNlbmQtZW1h
aWwteXViaWhvbmdAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzE2MDI0MTE0MjktMTIwNDMtMS1naXQt
c2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKMWEyMTNlMSBtaWdyYXRpb246IERlbGV0ZSByZWR1bmRhbnQgc3BhY2VzCjUxNWM4MmYg
bWlncmF0aW9uOiBPcGVuIGJyYWNlICd7JyBmb2xsb3dpbmcgZnVuY3Rpb24gZGVjbGFyYXRpb25z
IGdvIG9uIHRoZSBuZXh0IGxpbmUKZDQ5ZTQ1OCBtaWdyYXRpb246IERvIG5vdCBpbml0aWFsaXNl
IHN0YXRpY3MgYW5kIGdsb2JhbHMgdG8gMCBvciBOVUxMCjc0YTI1ZGUgbWlncmF0aW9uOiBBZGQg
YnJhY2VzIHt9IGZvciBpZiBzdGF0ZW1lbnQKN2RiYjBmZiBtaWdyYXRpb246IE9wZW4gYnJhY2Ug
J3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUgbGluZQo3MzBjOWEyNiBtaWdyYXRp
b246IEFkZCBzcGFjZXMgYXJvdW5kIG9wZXJhdG9yCjYyYzMzOTUgbWlncmF0aW9uOiBEb24ndCB1
c2UgJyMnIGZsYWcgb2YgcHJpbnRmIGZvcm1hdAowNWMxYWY1IG1pZ3JhdGlvbjogRG8gbm90IHVz
ZSBDOTkgLy8gY29tbWVudHMKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21t
aXQgMDVjMWFmNWRiZmNjIChtaWdyYXRpb246IERvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzKQpF
UlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToKIzc6IAogICAgU2lnbmVk
LW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDE2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvOCBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMi84IENoZWNraW5nIGNvbW1pdCA2MmMzMzk1OTFiMTYgKG1pZ3JhdGlvbjog
RG9uJ3QgdXNlICcjJyBmbGFnIG9mIHByaW50ZiBmb3JtYXQpCkVSUk9SOiBzcGFjZSByZXF1aXJl
ZCBhZnRlciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8
eXViaWhvbmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMjQgbGlu
ZXMgY2hlY2tlZAoKUGF0Y2ggMi84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzggQ2hl
Y2tpbmcgY29tbWl0IDczMGM5YTI2NDM0MyAobWlncmF0aW9uOiBBZGQgc3BhY2VzIGFyb3VuZCBv
cGVyYXRvcikKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAK
ICAgIFNpZ25lZC1vZmYtYnk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6
IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA1OSBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzggaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KCjQvOCBDaGVja2luZyBjb21taXQgN2RiYjBmZjI2ZjY2ICht
aWdyYXRpb246IE9wZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUg
bGluZSkKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAg
IFNpZ25lZC1vZmYtYnk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCA5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvOCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKNS84IENoZWNraW5nIGNvbW1pdCA3NGEyNWRlMGVlZDggKG1pZ3Jh
dGlvbjogQWRkIGJyYWNlcyB7fSBmb3IgaWYgc3RhdGVtZW50KQpFUlJPUjogc3BhY2UgcmVxdWly
ZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToKIzc6IAogICAgU2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUg
PHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE4IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDUvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNi84IENo
ZWNraW5nIGNvbW1pdCBkNDllNDU4NmJiNzkgKG1pZ3JhdGlvbjogRG8gbm90IGluaXRpYWxpc2Ug
c3RhdGljcyBhbmQgZ2xvYmFscyB0byAwIG9yIE5VTEwpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBh
ZnRlciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8eXVi
aWhvbmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNi84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo3LzggQ2hlY2tp
bmcgY29tbWl0IDUxNWM4MmZmMDZiNCAobWlncmF0aW9uOiBPcGVuIGJyYWNlICd7JyBmb2xsb3dp
bmcgZnVuY3Rpb24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUpCkVSUk9SOiBzcGFj
ZSByZXF1aXJlZCBhZnRlciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJp
aG9uZyBZdSA8eXViaWhvbmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgOSBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjgvOCBDaGVja2luZyBjb21taXQgMWEyMTNlMTQ1NDkzIChtaWdyYXRpb246IERlbGV0ZSByZWR1
bmRhbnQgc3BhY2VzKQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToK
Izc6IAogICAgU2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC84IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8xNjAyNDExNDI5LTEyMDQzLTEtZ2l0LXNlbmQtZW1haWwteXVi
aWhvbmdAaHVhd2VpLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

