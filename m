Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B3EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF312078B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF312078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRcg9-0007c1-Aa
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 10:50:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRcep-00074B-CI; Sun, 11 Oct 2020 10:49:07 -0400
Resent-Date: Sun, 11 Oct 2020 10:49:07 -0400
Resent-Message-Id: <E1kRcep-00074B-CI@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21756)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRcej-0001Fd-2u; Sun, 11 Oct 2020 10:49:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602427724; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bTyzkHQAbsA2ugerkJtw1Or4SKMUi/gC4dF/iXYRJ93TSxKxTOY2NLpEmXY55qj3EBG4iVUVkVo7RoqC71C+PEk6RJKCy+t47LiCDFhQbC6ROBLk4rsiqp2xXklwy97JvAVwCbbL47/aWYdSF2m+qYdm4PYOoLTTb4R7oqWYa4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602427724;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ldvAjP0iu50IwjgmGHKcD92TaMZC74TJ1hVqMsDqQmA=; 
 b=QtelgQ1Zuia1+xROKIZ7kSAn+7LerrUlJ/Yu+F/q+UL3UD8/UAp1SD4KjQEfOFWiP/PqP0SG9aTSPsGWl5uO9xFaQgzJ1kZa7wj742pPa78qy1yogu6+fUwevyNY+1WzWzUM+QMw9i8pqEvP6iBfIevbHyCeU+aF87PunwHy0Zg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602427723170836.7066510673691;
 Sun, 11 Oct 2020 07:48:43 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] Fix some style problems in migration
Message-ID: <160242772152.18344.6831168672718289938@66eaa9a8a123>
In-Reply-To: <1602413863-19513-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yubihong@huawei.com
Date: Sun, 11 Oct 2020 07:48:43 -0700 (PDT)
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
Cc: yubihong@huawei.com, alex.chen@huawei.com, quintela@redhat.com,
 qemu-trivial@nongnu.org, dgilbert@redhat.com, qemu-devel@nongnu.org,
 zhengchuan@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAyNDEzODYzLTE5NTEzLTEt
Z2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE2MDI0MTM4
NjMtMTk1MTMtMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN1YmplY3Q6IFtQ
QVRDSCB2MSAwLzhdIEZpeCBzb21lIHN0eWxlIHByb2JsZW1zIGluIG1pZ3JhdGlvbgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8xNjAyNDExNDI5LTEyMDQz
LTEtZ2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzE2MDI0MTE0
MjktMTIwNDMtMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tCiAtIFt0YWcgdXBk
YXRlXSAgICAgIHBhdGNoZXcvMTYwMjQxMzMyMS0yMjI1Mi0xLWdpdC1zZW5kLWVtYWlsLXl1Ymlo
b25nQGh1YXdlaS5jb20gLT4gcGF0Y2hldy8xNjAyNDEzMzIxLTIyMjUyLTEtZ2l0LXNlbmQtZW1h
aWwteXViaWhvbmdAaHVhd2VpLmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE2MDI0
MTM4NjMtMTk1MTMtMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tIC0+IHBhdGNo
ZXcvMTYwMjQxMzg2My0xOTUxMy0xLWdpdC1zZW5kLWVtYWlsLXl1Ymlob25nQGh1YXdlaS5jb20K
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplNTQwODgzIG1pZ3JhdGlvbjogRGVsZXRl
IHJlZHVuZGFudCBzcGFjZXMKYmE5OTFhYiBtaWdyYXRpb246IE9wZW4gYnJhY2UgJ3snIGZvbGxv
d2luZyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgZ28gb24gdGhlIG5leHQgbGluZQozM2NjOTkyIG1p
Z3JhdGlvbjogRG8gbm90IGluaXRpYWxpc2Ugc3RhdGljcyBhbmQgZ2xvYmFscyB0byAwIG9yIE5V
TEwKY2E0YTYyNSBtaWdyYXRpb246IEFkZCBicmFjZXMge30gZm9yIGlmIHN0YXRlbWVudAo0ZjRj
NjQxIG1pZ3JhdGlvbjogT3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBnbyBvbiB0aGUg
c2FtZSBsaW5lCmFiYmMxOTkgbWlncmF0aW9uOiBBZGQgc3BhY2VzIGFyb3VuZCBvcGVyYXRvcgoz
Mzk1ZTE4IG1pZ3JhdGlvbjogRG9uJ3QgdXNlICcjJyBmbGFnIG9mIHByaW50ZiBmb3JtYXQKNTI4
OTA5YSBtaWdyYXRpb246IERvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IDUyODkwOWFkNzBiMyAobWlncmF0aW9uOiBEbyBu
b3QgdXNlIEM5OSAvLyBjb21tZW50cykKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25l
ZC1vZmYtYnk6CiM3OiAKICAgIFNpZ25lZC1vZmYtYnk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3
ZWkuY29tPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNiBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAxLzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvOCBDaGVja2luZyBjb21taXQg
MzM5NWUxODFjMzlmIChtaWdyYXRpb246IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9y
bWF0KQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToKIzc6IAogICAg
U2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0b3RhbDogMSBl
cnJvcnMsIDAgd2FybmluZ3MsIDI0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKMy84IENoZWNraW5nIGNvbW1pdCBhYmJjMTk5MmFjOTEgKG1pZ3Jh
dGlvbjogQWRkIHNwYWNlcyBhcm91bmQgb3BlcmF0b3IpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBh
ZnRlciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8eXVi
aWhvbmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgNTkgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMy84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo0LzggQ2hlY2tp
bmcgY29tbWl0IDRmNGM2NDE3NjMyNiAobWlncmF0aW9uOiBPcGVuIGJyYWNlICd7JyBmb2xsb3dp
bmcgc3RydWN0IGdvIG9uIHRoZSBzYW1lIGxpbmUpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRl
ciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8eXViaWhv
bmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOSBsaW5lcyBjaGVj
a2VkCgpQYXRjaCA0LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvOCBDaGVja2luZyBj
b21taXQgY2E0YTYyNWZmZTI1IChtaWdyYXRpb246IEFkZCBicmFjZXMge30gZm9yIGlmIHN0YXRl
bWVudCkKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAg
IFNpZ25lZC1vZmYtYnk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEg
ZXJyb3JzLCAwIHdhcm5pbmdzLCAxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA1LzggaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCjYvOCBDaGVja2luZyBjb21taXQgMzNjYzk5MjY0N2JkIChtaWdy
YXRpb246IERvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgYW5kIGdsb2JhbHMgdG8gMCBvciBOVUxM
KQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToKIzc6IAogICAgU2ln
bmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDE2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvOCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKNy84IENoZWNraW5nIGNvbW1pdCBiYTk5MWFiNWVhNjMgKG1pZ3JhdGlv
bjogT3BlbiBicmFjZSAneycgZm9sbG93aW5nIGZ1bmN0aW9uIGRlY2xhcmF0aW9ucyBnbyBvbiB0
aGUgbmV4dCBsaW5lKQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9mZi1ieToK
Izc6IAogICAgU2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5jb20+Cgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy84IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo4LzggQ2hlY2tpbmcgY29tbWl0IGU1NDA4ODNhYmE5
YyAobWlncmF0aW9uOiBEZWxldGUgcmVkdW5kYW50IHNwYWNlcykKRVJST1I6IHNwYWNlIHJlcXVp
cmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAgIFNpZ25lZC1vZmYtYnk6Qmlob25nIFl1
IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA4IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDgvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTYwMjQxMzg2My0x
OTUxMy0xLWdpdC1zZW5kLWVtYWlsLXl1Ymlob25nQGh1YXdlaS5jb20vdGVzdGluZy5jaGVja3Bh
dGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

