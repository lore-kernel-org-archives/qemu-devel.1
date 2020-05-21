Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40428C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 04:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043CC206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 04:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043CC206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbcwM-0001K7-4b
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 00:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbcvY-0000oK-Nu
 for qemu-devel@nongnu.org; Thu, 21 May 2020 00:35:28 -0400
Resent-Date: Thu, 21 May 2020 00:35:28 -0400
Resent-Message-Id: <E1jbcvY-0000oK-Nu@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbcvW-0004lg-Qc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 00:35:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590035708; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OxeqhCKk5evO0uZKKKiYtmu5lGBGEkpHvdrEfAN6pG0UZb115r42epF1i6ptMbgupqG14wUw+toXfFU396qqys9HxhVWBDJ2egffD3CGlSnGLob2ofRg3oWNpklUSAhq+4QUo4Vo5s/k+xeW8hcoZ2D2cq1X6t+IhI6TnbJewEI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590035708;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8NFdN6UA/ZavTDfaWviLuRG8GyssSdCsE4rZArnLagk=; 
 b=BP3UHDO5nPg43t2aB4+XxMFmUvTQUZuaONObnpodIBUS+MVrt+nvjJa0p7q9gv3WAbYwpJaGykRlGV6B61utCtnN8hLJMbGKCoQ3iHg73yAxKb0eiDn2dEwBxW+qpU+Jc248n/8iGe+gK6MpazazwOZ8scfJTtzIs3/h2YRm8ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159003570716410.319184097556558;
 Wed, 20 May 2020 21:35:07 -0700 (PDT)
Message-ID: <159003570554.29084.2558885547986389801@45ef0f9c86ae>
In-Reply-To: <20200521033631.1605-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v8 0/8] pci_expander_brdige:acpi: Support pxb-pcie for ARM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Wed, 20 May 2020 21:35:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 00:11:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMTAzMzYzMS4xNjA1
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MjEwMzM2MzEuMTYwNS0xLW1pYW95dWJvQGh1
YXdlaS5jb20KU3ViamVjdDogW1BBVENIIHY4IDAvOF0gcGNpX2V4cGFuZGVyX2JyZGlnZTphY3Bp
OiBTdXBwb3J0IHB4Yi1wY2llIGZvciBBUk0KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiMDY3
YTEyIHVuaXQtdGVzdDogQWRkIHRoZSBiaW5hcnkgZmlsZSBhbmQgY2xlYXIgZGlmZi5oCjkzYWQw
ZjIgdW5pdC10ZXN0OiBBZGQgdGVzdGNhc2UgZm9yIHB4YgoxYzdiY2IxIHVuaXQtdGVzdDogVGhl
IGZpbGVzIGNoYW5nZWQuCmFkNWZhZmMgYWNwaTogQWxpZ24gdGhlIHNpemUgdG8gMTI4awphMDhj
NjllIGFjcGk6IFJlZmFjdG9yIHRoZSBzb3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1aWxkIHRh
YmxlcyBmb3IgcHhiCmUxYWQ5YTQgYWNwaTogRXh0cmFjdCBjcnMgYnVpbGQgZm9ybSBhY3BpX2J1
aWxkLmMKYzk2ZTBkZSBmd19jZmc6IFdyaXRlIHRoZSBleHRyYSByb290cyBpbnRvIHRoZSBmd19j
ZmcKODg3YWM0OCBhY3BpOiBFeHRyYWN0IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgODg3YWM0ODAzZjA3IChh
Y3BpOiBFeHRyYWN0IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kpCjIvOCBDaGVja2lu
ZyBjb21taXQgYzk2ZTBkZTkwZDdlIChmd19jZmc6IFdyaXRlIHRoZSBleHRyYSByb290cyBpbnRv
IHRoZSBmd19jZmcpCjMvOCBDaGVja2luZyBjb21taXQgZTFhZDlhNDZhM2IwIChhY3BpOiBFeHRy
YWN0IGNycyBidWlsZCBmb3JtIGFjcGlfYnVpbGQuYykKNC84IENoZWNraW5nIGNvbW1pdCBhMDhj
NjllYTRlYTkgKGFjcGk6IFJlZmFjdG9yIHRoZSBzb3VyY2Ugb2YgaG9zdCBicmlkZ2UgYW5kIGJ1
aWxkIHRhYmxlcyBmb3IgcHhiKQo1LzggQ2hlY2tpbmcgY29tbWl0IGFkNWZhZmNmMGVlNSAoYWNw
aTogQWxpZ24gdGhlIHNpemUgdG8gMTI4aykKNi84IENoZWNraW5nIGNvbW1pdCAxYzdiY2IxMzRi
ZjUgKHVuaXQtdGVzdDogVGhlIGZpbGVzIGNoYW5nZWQuKQo3LzggQ2hlY2tpbmcgY29tbWl0IDkz
YWQwZjIxNDhjMCAodW5pdC10ZXN0OiBBZGQgdGVzdGNhc2UgZm9yIHB4YikKOC84IENoZWNraW5n
IGNvbW1pdCBiMDY3YTEyNjNlYjYgKHVuaXQtdGVzdDogQWRkIHRoZSBiaW5hcnkgZmlsZSBhbmQg
Y2xlYXIgZGlmZi5oKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBk
b2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxMzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CgpFUlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBm
b2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90
aCB0ZXN0cy9kYXRhL2FjcGkvdmlydC9EU0RULnB4YiBhbmQgdGVzdHMvcXRlc3QvYmlvcy10YWJs
ZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBmb3VuZAoKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQg
ZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvZGF0YS9hY3BpL3ZpcnQvRFNEVC5w
eGIgYW5kIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggZm91bmQK
CnRvdGFsOiAyIGVycm9ycywgMSB3YXJuaW5ncywgMSBsaW5lcyBjaGVja2VkCgpQYXRjaCA4Lzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTIxMDMzNjMxLjE2MDUtMS1taWFveXVib0BodWF3
ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

